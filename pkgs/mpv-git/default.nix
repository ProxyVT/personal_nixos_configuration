let
  pkgs = import <nixpkgs> {};
in
{ pkgs }:
pkgs.callPackage ./mpv-git.nix {}


