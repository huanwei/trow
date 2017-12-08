with import <nixpkgs> {};
let
  date = "2017-11-15";
  rust-nightly = mozilla.rustChannels.rustChannelOf { date = date; channel = "nightly"; };
in
# rustPlatform.buildRustPackage rec {
stdenv.mkDerivation rec {
  name = "lycaon";
  env = buildEnv { name = name; paths = buildInputs; };
  # src = ./.;
  # cargoSha256 = "0q68qyl2h6i0qsz82z840myxlnjay8p1w5z7hfyr8fqp7wgwa9cx";
  buildInputs = [
    pkgconfig
    rust-nightly.rust

    cmake
    perl
    go

    # for .proto generation
    # protobuf

    # dev
    rustfmt
    valgrind
  ];

  configurePhase = ''true'';

  buildPhase = ''
    cargo build -vv
  '';


  shellHook = ''
    echo Rust Nightly: ${date}
  '';
}
