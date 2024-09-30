{
  lib,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.gnome-custom;
in
{
  options.${namespace}.gnome-custom.enable = mkEnableOption "Gnome customization";

  config = mkIf cfg.enable {
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
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,maximize,close";
      };
      "org/gnome/gnome-system-monitor" = {
        show-dependencies = true;
      };
      "org/gnome/desktop/session" = {
        idle-delay = lib.gvariant.mkUint32 0;
      };
      "org/gtk/gtk4/settings/file-chooser" = {
        show-hidden = true;
      };
      "org/gnome/desktop/sound" = {
        event-sounds = false;
      };
    };
  };
}
