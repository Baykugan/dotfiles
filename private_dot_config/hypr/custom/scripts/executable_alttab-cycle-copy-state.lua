#!/usr/bin/env lua

local function need(cmd)
  local ok = os.execute("command -v " .. cmd .. " >/dev/null 2>&1")
  if ok ~= true and ok ~= 0 then
    io.stderr:write("Missing dependency: " .. cmd .. "\n")
    os.exit(1)
  end
end

local function sh(cmd)
  local handle = io.popen(cmd)
  if not handle then
    error("Failed to run: " .. cmd)
  end

  local output = handle:read("*a")
  local ok = handle:close()

  if ok ~= true and ok ~= 0 then
    error("Command failed: " .. cmd)
  end

  return output
end

local function q(s)
  return "'" .. tostring(s):gsub("'", "'\\''") .. "'"
end

need("hyprctl")
need("jq")

local old_json = sh("hyprctl activewindow -j")
local old_addr = sh("printf %s " .. q(old_json) .. " | jq -r '.address'"):gsub("%s+$", "")
local old_state = sh("printf %s " .. q(old_json) .. " | jq -r '.fullscreen // 0'"):gsub("%s+$", "")

-- move focus first
os.execute("hyprctl dispatch cyclenext >/dev/null")

local new_json = sh("hyprctl activewindow -j")
local new_addr = sh("printf %s " .. q(new_json) .. " | jq -r '.address'"):gsub("%s+$", "")

-- clear the old window's fullscreen/maximized state
os.execute("hyprctl dispatch focuswindow " .. q("address:" .. old_addr) .. " >/dev/null")
os.execute("hyprctl dispatch fullscreenstate 0 0 set >/dev/null")

-- focus the new window and apply the old state to it
os.execute("hyprctl dispatch focuswindow " .. q("address:" .. new_addr) .. " >/dev/null")
os.execute("hyprctl dispatch fullscreenstate " .. old_state .. " " .. old_state .. " set >/dev/null")
