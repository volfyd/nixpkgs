{ lib, stdenvNoLibs, buildPackages
, gcc, glibc
, libiberty
}:

let
  gccConfigureFlags = gcc.cc.configureFlags ++ [
    "--build=${stdenvNoLibs.buildPlatform.config}"
    "--host=${stdenvNoLibs.buildPlatform.config}"
    "--target=${stdenvNoLibs.hostPlatform.config}"

    "--disable-bootstrap"
    "--disable-multilib" "--with-multilib-list="
    "--enable-languages=c"

    "--disable-fixincludes"
    "--disable-intl"
    "--disable-lto"
    "--disable-libatomic"
    "--disable-libbacktrace"
    "--disable-libcpp"
    "--disable-libssp"
    "--disable-libquadmath"
    "--disable-libgomp"
    "--disable-libvtv"
    "--disable-vtable-verify"

    "--with-system-zlib"
  ] ++ lib.optional (stdenvNoLibs.hostPlatform.libc == "glibc")
       "--with-glibc-version=${glibc.version}";

in stdenvNoLibs.mkDerivation (finalAttrs: {
  pname = "libgcc";
  inherit (gcc.cc) src version;

  outputs = [ "out" "dev" ];

  strictDeps = true;
  depsBuildBuild = [ buildPackages.stdenv.cc ];
  nativeBuildInputs = [ libiberty ];
  buildInputs = [ glibc ];

  postUnpack = ''
    mkdir -p ./build
    buildRoot=$(readlink -e "./build")
  '';

  postPatch =
    gcc.cc.passthru.forceLibgccToBuildCrtStuff
    + ''
      sourceRoot=$(readlink -e "./libgcc")
    '';

  hardeningDisable = [ "pie" ];

  preConfigure =
  ''
    # Drop in libiberty, as external builds are not expected
    cd "$buildRoot"
    (
      mkdir -p build-${stdenvNoLibs.buildPlatform.config}/libiberty/
      cd build-${stdenvNoLibs.buildPlatform.config}/libiberty/
      ln -s ${buildPackages.libiberty}/lib/libiberty.a ./
    )
    mkdir -p "$buildRoot/gcc"
    cd "$buildRoot/gcc"
    (
      # We "shift" the tools over to fake platforms perspective from the previous stage.
      export AS_FOR_BUILD=${buildPackages.stdenv.cc}/bin/$AS_FOR_BUILD
      export CC_FOR_BUILD=${buildPackages.stdenv.cc}/bin/$CC_FOR_BUILD
      export CPP_FOR_BUILD=${buildPackages.stdenv.cc}/bin/$CPP_FOR_BUILD
      export CXX_FOR_BUILD=${buildPackages.stdenv.cc}/bin/$CXX_FOR_BUILD
      export LD_FOR_BUILD=${buildPackages.stdenv.cc.bintools}/bin/$LD_FOR_BUILD

      export AS=$AS_FOR_BUILD
      export CC=$CC_FOR_BUILD
      export CPP=$CPP_FOR_BUILD
      export CXX=$CXX_FOR_BUILD
      export LD=$LD_FOR_BUILD

      export AS_FOR_TARGET=${stdenvNoLibs.cc}/bin/$AS
      export CC_FOR_TARGET=${stdenvNoLibs.cc}/bin/$CC
      export CPP_FOR_TARGET=${stdenvNoLibs.cc}/bin/$CPP
      export LD_FOR_TARGET=${stdenvNoLibs.cc.bintools}/bin/$LD

      # We define GENERATOR_FILE so nothing bothers looking for GNU GMP.
      export NIX_CFLAGS_COMPILE_FOR_BUILD+=' -DGENERATOR_FILE=1'

      "$sourceRoot/../gcc/configure" ${lib.concatStringsSep " " gccConfigureFlags}

      # We remove the `libgcc.mvar` deps so that the bootstrap xgcc isn't built.
      sed -e 's,libgcc.mvars:.*$,libgcc.mvars:,' -i Makefile

      make \
        config.h \
        libgcc.mvars \
        tconfig.h \
        tm.h \
        options.h \
        insn-constants.h \
        insn-modes.h
    )
    mkdir -p "$buildRoot/gcc/include"

    # Preparing to configure + build libgcc itself
    mkdir -p "$buildRoot/gcc/${stdenvNoLibs.hostPlatform.config}/libgcc"
    cd "$buildRoot/gcc/${stdenvNoLibs.hostPlatform.config}/libgcc"
    configureScript=$sourceRoot/configure
    chmod +x "$configureScript"

    export AS_FOR_BUILD=${buildPackages.stdenv.cc}/bin/$AS_FOR_BUILD
    export CC_FOR_BUILD=${buildPackages.stdenv.cc}/bin/$CC_FOR_BUILD
    export CPP_FOR_BUILD=${buildPackages.stdenv.cc}/bin/$CPP_FOR_BUILD
    export CXX_FOR_BUILD=${buildPackages.stdenv.cc}/bin/$CXX_FOR_BUILD
    export LD_FOR_BUILD=${buildPackages.stdenv.cc.bintools}/bin/$LD_FOR_BUILD

    export AS=${stdenvNoLibs.cc}/bin/$AS
    export CC=${stdenvNoLibs.cc}/bin/$CC
    export CPP=${stdenvNoLibs.cc}/bin/$CPP
    export CXX=${stdenvNoLibs.cc}/bin/$CXX
    export LD=${stdenvNoLibs.cc.bintools}/bin/$LD

    export AS_FOR_TARGET=${stdenvNoLibs.cc}/bin/$AS_FOR_TARGET
    export CC_FOR_TARGET=${stdenvNoLibs.cc}/bin/$CC_FOR_TARGET
    export CPP_FOR_TARGET=${stdenvNoLibs.cc}/bin/$CPP_FOR_TARGET
    export LD_FOR_TARGET=${stdenvNoLibs.cc.bintools}/bin/$LD_FOR_TARGET
  '';

  configurePlatforms = [ "build" "host" ];
  configureFlags = [
    "cross_compiling=true"
    "--disable-gcov"
    "--with-glibc-version=${glibc.version}"
  ];

  makeFlags = [ "MULTIBUILDTOP:=../" ];

  postInstall = ''
    moveToOutput "lib/gcc/${stdenvNoLibs.hostPlatform.config}/${finalAttrs.version}/include" "$dev"
    mkdir -p "$out/lib" "$dev/include"
    ln -s "$out/lib/gcc/${stdenvNoLibs.hostPlatform.config}/${finalAttrs.version}"/* "$out/lib"
    ln -s "$dev/lib/gcc/${stdenvNoLibs.hostPlatform.config}/${finalAttrs.version}/include"/* "$dev/include/"
  '';
})
