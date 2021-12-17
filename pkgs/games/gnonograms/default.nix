{ lib
, stdenv
, fetchFromGitHub
, vala
, meson
, ninja
, pkg-config
, desktop-file-utils
, appstream
, python3
, shared-mime-info
, wrapGAppsHook
, gtk3
, pantheon
, libgee
, libhandy
}:

stdenv.mkDerivation rec {
  pname = "gnonograms";
  version = "2.0.0";

  src = fetchFromGitHub {
    owner = "jeremypw";
    repo = "gnonograms";
    rev = "v${version}";
    sha256 = "sha256-2uXaybpCAm9cr0o7bqfhgD7mMNPwtv1X/PgnFnSDOl0=";
  };

  postPatch = ''
    patchShebangs meson/post_install.py
  '';

  nativeBuildInputs = [
    vala
    meson
    ninja
    pkg-config
    desktop-file-utils
    appstream
    python3
    shared-mime-info
    wrapGAppsHook
  ];

  buildInputs = [
    gtk3
    pantheon.granite
    libgee
    libhandy
  ];

  meta = with lib; {
    description = "Nonograms puzzle game";
    longDescription = ''
      An implementation of the Japanese logic puzzle "Nonograms" written in
      Vala, allowing the user to:
      * Draw puzzles
      * Generate random puzzles of chosen difficulty
    '';
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ fgaz ];
    homepage = "https://github.com/jeremypw/gnonograms";
    platforms = platforms.all;
  };
}
