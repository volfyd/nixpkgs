{ lib, stdenv, fetchurl, fetchFromGitHub, autoreconfHook, cmake, wrapQtAppsHook, pkg-config, qmake
, curl, grantlee, libgit2, libusb-compat-0_1, libssh2, libxml2, libxslt, libzip, zlib
, qtbase, qtconnectivity, qtlocation, qtsvg, qttools, qtwebkit, libXcomposite
, bluez
}:

let
  version = "4.9.10";

  subsurfaceSrc = (fetchFromGitHub {
    owner = "Subsurface";
    repo = "subsurface";
    rev = "v${version}";
    sha256 = "12ndhjplz3cwndwzhfc959dc0i6rm2qf3v2d8n9kba8nj63iblfs";
    fetchSubmodules = true;
  });

  libdc = stdenv.mkDerivation {
    pname = "libdivecomputer-ssrf";
    inherit version;

    src = subsurfaceSrc;
    sourceRoot = "source/libdivecomputer";

    nativeBuildInputs = [ autoreconfHook ];

    buildInputs = [ zlib ];

    enableParallelBuilding = true;

    meta = with lib; {
      homepage = "http://www.libdivecomputer.org";
      description = "A cross-platform and open source library for communication with dive computers from various manufacturers";
      maintainers = with maintainers; [ mguentner ];
      license = licenses.lgpl21;
      platforms = platforms.all;
    };
  };

  googlemaps = stdenv.mkDerivation rec {
    pname = "googlemaps";

    version = "2018-06-02";

    src = fetchFromGitHub {
      owner = "vladest";
      repo = "googlemaps";
      rev = "54a357f9590d9cf011bf1713589f66bad65e00eb";
      sha256 = "159kslp6rj0qznzxijppwvv8jnswlfgf2pw4x8ladi8vp6bzxnzi";
    };

    nativeBuildInputs = [ qmake ];

    buildInputs = [ qtbase qtlocation libXcomposite ];

    dontWrapQtApps = true;

    pluginsSubdir = "lib/qt-${qtbase.qtCompatVersion}/plugins";

    installPhase = ''
      mkdir -p $out $(dirname ${pluginsSubdir}/geoservices)
      mkdir -p ${pluginsSubdir}/geoservices
      mv *.so ${pluginsSubdir}/geoservices
      mv lib $out/
    '';

    enableParallelBuilding = true;

    meta = with lib; {
      inherit (src.meta) homepage;
      description = "QtLocation plugin for Google maps tile API";
      maintainers = with maintainers; [ orivej ];
      license = licenses.mit;
      platforms = platforms.all;
    };
  };

in stdenv.mkDerivation {
  pname = "subsurface";
  inherit version;

  src = subsurfaceSrc;

  buildInputs = [
    libdc googlemaps
    curl grantlee libgit2 libssh2 libusb-compat-0_1 libxml2 libxslt libzip
    qtbase qtconnectivity qtsvg qttools qtwebkit
    bluez
  ];

  nativeBuildInputs = [ cmake wrapQtAppsHook pkg-config ];

  cmakeFlags = [
    "-DLIBDC_FROM_PKGCONFIG=ON"
    "-DNO_PRINTING=OFF"
  ];

  passthru = { inherit version libdc googlemaps; };

  meta = with lib; {
    description = "A divelog program";
    longDescription = ''
      Subsurface can track single- and multi-tank dives using air, Nitrox or TriMix.
      It allows tracking of dive locations including GPS coordinates (which can also
      conveniently be entered using a map interface), logging of equipment used and
      names of other divers, and lets users rate dives and provide additional notes.
    '';
    homepage = "https://subsurface-divelog.org";
    license = licenses.gpl2;
    maintainers = with maintainers; [ mguentner ];
    platforms = platforms.all;
  };
}
