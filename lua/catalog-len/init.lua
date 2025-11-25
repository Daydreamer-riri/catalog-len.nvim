local M = {}

---@param opts? catalog-len.Config
function M.setup(opts)
  require("catalog-len.config").setup(opts)
end

return M
