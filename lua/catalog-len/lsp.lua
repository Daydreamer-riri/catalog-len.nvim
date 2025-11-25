local M = {}

---@param server_path string
function M.setup(server_path)
  vim.lsp.config["catalog_ls"] = {
    cmd = { "node", server_path, "--stdio" },
    filetypes = { "json", "yaml" },
    root_markers = { { "pnpm-workspace.yaml" }, ".git" },
  }

  vim.lsp.enable("catalog_ls")
end

return M
