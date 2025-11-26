local M = {}

local function hex_to_rgb(hex)
  hex = hex:gsub("#", "")
  return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
end

local function rgb_to_hex(r, g, b)
  return string.format("#%02X%02X%02X", r, g, b)
end

local function blend_colors(fg_hex, bg_hex, alpha)
  local fr, fg, fb = hex_to_rgb(fg_hex)
  local br, bg, bb = hex_to_rgb(bg_hex)

  local r = math.floor(alpha * fr + (1 - alpha) * br + 0.5)
  local g = math.floor(alpha * fg + (1 - alpha) * bg + 0.5)
  local b = math.floor(alpha * fb + (1 - alpha) * bb + 0.5)

  return rgb_to_hex(r, g, b)
end

local function get_bg()
  local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
  local bg_fallback = vim.api.nvim_get_hl(0, { name = "IncSearch" }).fg

  local bg = normal_bg or bg_fallback or 0x1E1E1E
  return string.format("#%06X", bg)
end

local color_cache = {}

--- Ensure a highlight group exists for the given color.
--- @param color string Hex color code (e.g., "#FF0000")
--- @return string The name of the highlight group
function M.ensure_hl(color)
  if not color_cache[color] then
    local group = "CatalogLensLspHint_" .. color:gsub("#", "")
    local blended_color = blend_colors(color, get_bg(), 0.2)
    vim.api.nvim_set_hl(0, group, { fg = color, bg = blended_color })
    color_cache[color] = group
  end
  return color_cache[color]
end

--- Ensure a foreground-only highlight group exists for the given color.
--- @param color string Hex color code (e.g., "#FF0000")
--- @return string The name of the highlight group
function M.ensure_fg_hl(color)
  local cache_key = color .. "_fg"
  if not color_cache[cache_key] then
    local group = "CatalogLensLspHintFg_" .. color:gsub("#", "")
    vim.api.nvim_set_hl(0, group, { fg = color, bold = true })
    color_cache[cache_key] = group
  end
  return color_cache[cache_key]
end

return M
