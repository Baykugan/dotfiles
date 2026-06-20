#!/usr/bin/env fish

#
# ~/.config/fish/functions/cd.fish
# Overrides the cd command to run onefetch on cd into a git repository
#

function cd --wraps=cd --description "cd + show onefetch once per repo"
    builtin cd $argv; or return $status

    # Only proceed if we're inside a git work tree
    command git rev-parse --is-inside-work-tree >/dev/null 2>&1; or begin
        set -g LAST_REPO ""
        return 0
    end

    # Now it's safe to ask for the repo root
    set -l repo_root (command git rev-parse --show-toplevel 2>/dev/null)

    if test "$repo_root" != "$LAST_REPO"
        type -q onefetch; and onefetch
        set -g LAST_REPO "$repo_root"
    end
end
