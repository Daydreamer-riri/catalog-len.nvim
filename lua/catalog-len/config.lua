---@class catalog-len.config: catalog-len.Config
local M = {}

M.ns = vim.api.nvim_create_namespace("catalog-len")

---@class catalog-len.Config
local defaults = {
  -- Enable the plugin
  enabled = true,
  -- Debounce time in milliseconds for virtual text updates
  debounce = 200,
  -- Virtual text style
  virtual_text = {
    prefix = " ",
    hl_group = "Comment",
  },
}

local config = vim.deepcopy(defaults) --[[@as catalog-len.Config]]
M.augroup = vim.api.nvim_create_augroup("catalog-len", { clear = true })

---@param opts? catalog-len.Config
function M.setup(opts)
  config = vim.tbl_deep_extend("force", {}, vim.deepcopy(defaults), opts or {})
end

setmetatable(M, {
  __index = function(_, key)
    return config[key]
  end,
})

return M
