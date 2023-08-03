-- Pull in the wezterm API
local wezterm = require 'wezterm';

-- This table will hold the configuration.
local config =  {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
-- 自分の好きなテーマ探す https://wezfurlong.org/wezterm/colorschemes/index.html
config.color_scheme = "OneHalfDark"
-- config.color_scheme = "Solarized Dark (Gogh)"
-- config.color_scheme = "GruvboxDark"
-- config.color_scheme = "Darcula (base16)"
config.font = wezterm.font_with_fallback{
    "Noto Sans Mono CJK JP"
    "Noto Color Emoji"
    "JetBrains Mono"
} -- 自分の好きなフォントいれる
config.use_ime = true -- wezは日本人じゃないのでこれがないとIME動かない
config.font_size = 11.0
config.hide_tab_bar_if_only_one_tab = true
config.adjust_window_size_when_changing_font_size = false
config.key_map_preference = 'Mapped'
config.enable_csi_u_key_encoding = true
config.initial_cols = 160
config.initial_rows = 48


local act = wezterm.action
config.keys = {
    -- ctrl+shift+f move one ward forward in insert mode
    { key = 'f', mods = 'CTRL|SHIFT', action = act.SendKey {
        key = 'RightArrow', mods = 'CTRL',}, },
    -- { key = 'f', mods = 'CTRL|SHIFT', action = act.SendString '[1;5C' },
    -- ctrl+shift+b move one ward backword in insert mode
    { key = 'b', mods = 'CTRL|SHIFT', action = act.SendKey {
        key = 'LeftArrow', mods = 'CTRL',}, },
    -- { key = 'b', mods = 'CTRL|SHIFT', action = act.SendString '[1;5D' },
    { key = 'i', mods = 'CTRL', action = act.SendKey { key = 'Tab',}, },
    { key = '[', mods = 'CTRL', action = act.SendKey { key = 'Escape',}, },
    -- { key = '[', mods = 'CTRL', action = act.SendString '' },
    { key = 'raw:134', action = act.SendString '^[[25~' },
    { key = 'raw:108', action = act.SendString '^[[26~' },
}

return config

