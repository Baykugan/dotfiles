#!/usr/bin/env bash
set -euo pipefail

need() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "Missing dependency: $1" >&2
    exit 1
  }
}

need hyprctl
need jq

OLD_JSON="$(hyprctl activewindow -j)"
OLD_ADDR="$(printf '%s\n' "$OLD_JSON" | jq -r '.address')"
OLD_STATE="$(printf '%s\n' "$OLD_JSON" | jq -r '.fullscreen // 0')"

# move focus first
hyprctl dispatch cyclenext >/dev/null

NEW_JSON="$(hyprctl activewindow -j)"
NEW_ADDR="$(printf '%s\n' "$NEW_JSON" | jq -r '.address')"

# clear the old window's fullscreen/maximized state
hyprctl dispatch focuswindow "address:$OLD_ADDR" >/dev/null
hyprctl dispatch fullscreenstate 0 0 set >/dev/null

# focus the new window and apply the old state to it
hyprctl dispatch focuswindow "address:$NEW_ADDR" >/dev/null
hyprctl dispatch fullscreenstate "$OLD_STATE" "$OLD_STATE" set >/dev/null
