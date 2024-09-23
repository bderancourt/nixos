{
  pkgs,
  ...
}:
{
  bderancourt = {
    cura.enable = true;
    vscode.enable = true;
    gnome-custom.enable = true;
  };

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    # gnome
    gnome3.dconf-editor
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
    (lshw.override { withGUI = true; })

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

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Benoit DE RANCOURT";
    userEmail = "b2rancourt@gmail.com";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    #bashrcExtra = ''
    #  export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
    #'';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      k = "kubectl";
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    };
  };

  programs.firefox.enable = true;
  programs.ranger.enable = true;

}
