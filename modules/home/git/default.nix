{
  lib,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.git;
in
{
  options.${namespace}.git.enable = mkEnableOption "Git";

  config = mkIf cfg.enable {
    # basic configuration of git, please change to your own
    programs.git = {
      enable = true;
      userName = "Benoit DE RANCOURT";
      userEmail = "b2rancourt@gmail.com";
    };
  };
}
