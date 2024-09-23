{
  lib,
  pkgs,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.cura;
in
{
  options.${namespace}.cura.enable = mkEnableOption "Ultimaker Cura";

  config = mkIf cfg.enable {
    home.packages = [
      (pkgs.appimageTools.wrapType2 {
        name = "cura";
        src = pkgs.fetchurl {
          url = "https://github.com/Ultimaker/Cura/releases/download/5.8.0/UltiMaker-Cura-5.8.0-linux-X64.AppImage";
          sha256 = "1s1cakmj97w3j1xf0jvh7g3m6r40s26hbfa4s2y7bqx8xw0xb20j";
        };
      })
    ];
    home.file.".icons/cura-icon.png" = {
      source = pkgs.fetchurl {
        url = "https://github.com/Ultimaker/Cura/blob/3707158b033e033c9f62e1ceaef91aa56bbf45a8/resources/images/cura-icon.png?raw=true";
        sha256 = "sha256:0b4zwby81q3h0cvwhmj3isg170xzflik2qjzs1p35wvkzbl1mkz0";
      };
    };
    xdg.desktopEntries.cura = {
      name = "Cura";
      exec = "cura";
      terminal = false;
      type = "Application";
      icon = "cura-icon.png";
      categories = [ "Utility" ];
    };
  };
}
