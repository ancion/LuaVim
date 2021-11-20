local M = {}

local Log = require "core.log"
-- local formatters = require "lsp.null-ls.formatters"
-- local linters = require "lsp.null-ls.linters"

function M:setup()
  local status_ok, null_ls = pcall(require, "null-ls")
  if not status_ok then
    Log:error "Missing null-ls dependency"
    return
  end

  null_ls.config(lvim.lsp.null_ls.config)
  local default_opts = require("lsp").get_common_opts()
  if vim.tbl_isempty(lvim.lsp.null_ls.setup or {}) then
    lvim.lsp.null_ls.setup = default_opts
  end
  -- for filetype, config in pairs(lvim.lang) do
  --   if not vim.tbl_isempty(config.formatters) then
  --     formatters.setup(config.formatters, filetype)
  --   end
  --   if not vim.tbl_isempty(config.linters) then
  --     linters.setup(config.linters, filetype)
  --   end
  -- end
  require("lspconfig")["null-ls"].setup(lvim.lsp.null_ls.setup)
end

return M
