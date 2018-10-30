{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; ([
    aspell
    awscli
    cachix
    curl
    coreutils
    direnv
    emacs
    fasd
    fzf
    gist
    gitAndTools.hub
    gitFull
    git-secret
    global
    gnumake
    gnupg
    # hoverfly
    ix
    jq
    nixUnstable
    pinentry
    ripgrep
    scripts
  ]
  ++ lib.optionals stdenv.isLinux [
    acpi
    arandr
    autorandr
    blueman
    bluez
    cabal2nix
    docker
    docker_compose
    dunst
    feh
    firefox
    haskellPackages.xmobar
    haskellPackages.xmonad
    haskellPackages.xmonad-contrib
    haskellPackages.xmonad-extras
    haskellPackages.yeganesh
    htop
    iw
    keybase
    keybase-gui
    libnotify
    lightum
    powertop
    rofi
    rofi-emoji
    rofi-pass
    rofi-wifi-menu
    scrot
    spotify
    stalonetray
    unclutter-xfixes
    wirelesstools
    xclip xsel
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-dropbox-plugin
    xfce.thunar_volman
    xfce.xfce4_power_manager
    xorg.libXrandr
    xorg.xbacklight
    xorg.xcursorthemes
    xorg.xf86inputkeyboard
    zeal
  ]
  ++ lib.optionals stdenv.isDarwin [
    chunkwm.border
    chunkwm.core
    chunkwm.ffm
    chunkwm.tiling
    skhd
    Dash
    Docker
    Spotify
  ]) ++ [ haskellEnv ];
}
