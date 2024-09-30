{
  pkgs,
  ...
}:
{
  bderancourt = {
    cura.enable = true;
    vscode.enable = true;
    gnome-custom.enable = true;
    git.enable = true;
    bash.enable = true;
  };

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    # gnome
    gnome3.dconf-editor
    gnome3.gnome-boxes
    gnomeExtensions.vitals
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.appindicator
    gnomeExtensions.bing-wallpaper-changer
    gnomeExtensions.tiling-assistant
    gnomeExtensions.dash-to-dock

    # useful software
    keepassxc
    onedrive
    onedrivegui
    sublime
    vlc
    lact
    gimp
    terminator
    libreoffice
    molotov

    # cli
    ncdu
    fd # https://github.com/sharkdp/fd
    unzip
    cloc
    wget
    curl
    lm_sensors
    usbutils
    pciutils
    btop
    nvme-cli

    # nix
    nixd
    nixfmt-rfc-style
    nh

    # language-servers
    nodePackages.bash-language-server
    nodePackages.yaml-language-server

    # java
    jdk21
  ];

  home.sessionVariables = {
    FLAKE = "$HOME/nixos";
  };

  programs.firefox.enable = true;
  programs.ranger.enable = true;

}
