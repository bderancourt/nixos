{
  lib,
  pkgs,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.vscode;
in
{
  options.${namespace}.vscode.enable = mkEnableOption "Visual Studio Code";

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
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
        "nix.serverSettings" = {
          "nixd" = {
            "formatting" = {
              "command" = [ "nixfmt" ];
            };
          };
        };
      };
    };
  };
}
