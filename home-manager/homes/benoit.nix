{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../modules/default.nix
  ];
  cura.enable = true;

  nixpkgs.config.allowUnfree = true;

  home = {
    stateVersion = "24.05";

    packages = with pkgs; [
      # gnome
      gnome3.dconf-editor
      gnome.seahorse
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

      # nix
      nixd
      nixfmt-rfc-style

      # language-servers
      nodePackages.bash-language-server
      nodePackages.yaml-language-server

      # java
      jdk21
    ];
  };

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

  programs.vscode = {
    enable = true;
    # Extensions
    extensions = with pkgs.vscode-extensions; [
      mhutchie.git-graph
      pkief.material-icon-theme
      oderwat.indent-rainbow
      bierner.markdown-emoji
      bierner.emojisense
      jnoortheen.nix-ide
    ];

    # Settings
    userSettings = {
      "workbench.startupEditor" = "none";
      "explorer.compactFolders" = false;
      # Whitespace
      "files.trimTrailingWhitespace" = true;
      "files.trimFinalNewlines" = true;
      "files.insertFinalNewline" = true;
      "files.autoSave" = "afterDelay";
      "diffEditor.ignoreTrimWhitespace" = false;
      # Other
      "telemetry.telemetryLevel" = "off";
      "update.showReleaseNotes" = false;
      "terminal.integrated.scrollback" = 50000;
      "git.autofetch" = true;
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";
    };
  };

  programs.firefox.enable = true;
  programs.ranger.enable = true;

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "drive-menu@gnome-shell-extensions.gcampax.github.com"
        "window-placement@gnome-shell-extensions.gcampax.github.com"
        "Vitals@CoreCoding.com"
        "clipboard-indicator@tudmotu.com"
        "tiling-assistant@leleat-on-github"
        "BingWallpaper@ineffable-gmail.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "dash-to-dock@micxgx.gmail.com"
      ];
    };
    "org/gnome/shell/extensions/vitals" = {
      hot-sensors = [
        "_processor_usage_"
        "_memory_usage_"
        "_temperature_acpi_thermal zone_"
      ];
      show-battery = true;
    };
    "org/gnome/shell/extensions/dash-to-dock" = {
      always-center-icons = true;
      apply-custom-theme = true;
      show-apps-at-top = true;
    };
    "org/gnome/shell/extensions/tiling-assistant" = {
      tiling-popup-all-workspace = false;
      enable-tiling-popup = false;
    };
    "org/gnome/shell/extensions/clipboard-indicator" = {
      clear-on-boot = true;
      history-size = 5;
    };
    "org/gnome/desktop/interface" = {
      enable-hot-corners = false;
      show-battery-percentage = true;
    };
    "org/gnome/gnome-system-monitor" = {
      show-dependencies = true;
    };
    "org/gnome/desktop/session" = {
      idle-delay = lib.hm.gvariant.mkUint32 0;
    };
    "org/gtk/gtk4/settings/file-chooser" = {
      show-hidden = true;
    };
    "org/gnome/desktop/sound" = {
      event-sounds = false;
    };
  };

}
