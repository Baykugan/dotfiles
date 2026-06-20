-- User

hl.bind("CTRL + SUPER + Slash", hl.dsp.exec_cmd("xdg-open ~/.config/illogical-impulse/config.json"))
hl.bind("CTRL + SUPER + ALT + Slash", hl.dsp.exec_cmd("xdg-open ~/.config/hypr/custom/keybinds.conf"))

-- Power button → session menu
hl.bind(
  "XF86PowerOff",
  hl.dsp.global("quickshell:sessionToggle"),
  { description = "System: Toggle session menu" }
)

hl.bind(
  "XF86PowerOff",
  hl.dsp.exec_cmd("qs -c $qsConfig ipc call TEST_ALIVE || pkill wlogout || wlogout -p layer-shell")
)

-- hl.bind( "XF86PowerOff", hl.dsp.exec_cmd("qs -c $qsConfig ipc call TEST_ALIVE || pkill wlogout || wlogout -p layer-shell"), { description = "Session menu fallback" } )
hl.bind( "CTRL + SUPER + SHIFT + ALT + L", hl.dsp.exec_cmd("lizard"), { description = "Other: Play LIZARD sound clip" } )

hl.bind(
  "ALT + TAB",
  hl.dsp.exec_cmd("~/.config/hypr/custom/scripts/alttab-cycle-copy-state.lua"),
  { description = "Window: Cycle active window" }
)

-- Examples kept disabled:
-- hl.bind("SUPER + P", hl.dsp.exec_cmd("~/.config/hypr/custom/scripts/toggle-display.sh"))
hl.bind("CTRL + Space", hl.dsp.global("menu.kando.Kando:hypr-menu"))
-- hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("hyprctl switchxkblayout at-translated-set-2-keyboard next"))
-- hl.bind("SUPER + SHIFT + SPACE", hl.dsp.exec_cmd("hyprctl switchxkblayout at-translated-set-2-keyboard prev"))

hl.bind("CTRL+SUPER+ALT+Slash", hl.dsp.exec_cmd("xdg-open ~/.config/hypr/custom/keybinds.lua"), {description = "Edit user keybinds"} )
