-- ~/.config/hypr/hyprland.lua

-- UNSET – must match exactly
hl.gesture({ fingers = 3, direction = "pinch", action = "unset" })
hl.gesture({ fingers = 3, direction = "swipe", action = "unset" })
hl.gesture({ fingers = 4, direction = "horizontal", action = "unset" })
hl.gesture({ fingers = 4, direction = "up", action = "unset" })
hl.gesture({ fingers = 4, direction = "down", action = "unset" })

hl.gesture({ fingers = 4, direction = "swipe", action = "move" })
hl.gesture({ fingers = 3, direction = "pinch", action = "fullscreen", mode = "maximize" })
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

hl.gesture({
  fingers = 3,
  direction = "down",
  action = function()
    hl.exec_cmd("/home/Enki/.config/hypr/custom/scripts/workspace_by_10 up")
  end,
})

hl.gesture({
  fingers = 3,
  direction = "up",
  action = function()
    hl.exec_cmd("/home/Enki/.config/hypr/custom/scripts/workspace_by_10 down")
  end,
})

hl.config({
  input = {
    kb_layout = "us,us,us,no",
    kb_variant = ",dvorak,dvp,",
    kb_options = "grp:win_space_toggle",

    touchpad = {
      clickfinger_behavior = false,
      disable_while_typing = false,
      -- natural_scroll = false,
    },
  },

  misc = {
    disable_autoreload = false,
  },
})
