local M = {}

---@param opts? catalog-len.Config
function M.setup(opts)
  require("catalog-len.config").setup(opts)

  local server_paths = vim.api.nvim_get_runtime_file("catalog-lens-lsp/server.js", false)[1]
  require("catalog-len.lsp").setup(server_paths)
end

return M
