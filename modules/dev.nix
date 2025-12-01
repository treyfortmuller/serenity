# Configuration that makes development on-device easier, some git configuration + user setup.

{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.serenity.localDev;
in
{
  options.serenity.localDev = {
    enable = lib.mkEnableOption "configuration local hacking";

    enableVSCodeServer = lib.mkEnableOption "VSCode SSH remote dev";
  };

  config = lib.mkIf cfg.enable {
    services.vscode-server.enable = cfg.enableVSCodeServer;

    programs.git = {
      enable = true;

      config = {
        user = {
          email = "tfortmuller@mac.com";
          name = "Trey Fortmuller";
        };

        pull.rebase = false;
        push.autoSetupRemote = true;
        init.defaultBranch = "master";
        core.editor = "vim";

        alias = {
          # List aliases
          la = "!git config --list | grep -E '^alias' | cut -c 7-";

          # Beautiful one-liner log, last 20 commits
          l = "log --pretty=\"%C(Yellow)%h  %C(reset)%ad (%C(Green)%cr%C(reset))%x09 %C(Cyan)%an %C(reset)%s\" --date=short -20";

          # Most recently checked-out branches
          recent = "!git reflog show --pretty=format:'%gs ~ %gd' --date=relative | grep 'checkout:' | grep -oE '[^ ]+ ~ .*' | awk -F~ '!seen[$1]++' | head -n 10 | awk -F' ~ HEAD@{' '{printf(\"  \\033[33m%s: \\033[37m %s\\033[0m\\n\", substr($2, 1, length($2)-1), $1)}'";

          last = "log -1 HEAD";
          unstage = "reset HEAD --";
          b = "branch --show";
          a = "add";
          c = "commit";
          s = "status -s";
          co = "checkout";
          cob = "checkout -b";
        };
      };
    };
  };
}
