let
    moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
    nixpkgs = import <nixpkgs> { overlays = [ moz_overlay ]; };
    rustStableChannel = nixpkgs.latest.rustChannels.stable.rust.override {
        extensions = [
            "rust-src"
            "rustc-dev"
            "rust-std"
            "rust-analysis"
            "rls-preview"
            "rust-analyzer-preview"
            "clippy-preview"
            "rustfmt-preview"
            "llvm-tools-preview"
        ];
    };
in
with nixpkgs;
stdenv.mkDerivation {
    name = "moz_overlay_shell";
    buildInputs = [
        rustStableChannel
        aoc-cli
    ];
    nativeBuildInputs = [
        nixpkgs.openssl.dev
    ];
}
