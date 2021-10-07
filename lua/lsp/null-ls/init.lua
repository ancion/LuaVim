local M = {}

local Log = require "core.log"
local formatters = require "lsp.null-ls.formatters"
local linters = require "lsp.null-ls.linters"

-- TODO: for linters and formatters with spaces and '-' replace with '_'
function M.setup()
  local ok, null_ls = pcall(require, "null-ls")
  if not ok then
    Log:error "Missing null-ls dependency"
    return
  end

  null_ls.config()
  require("lspconfig")["null-ls"].setup {}

  for _, filetype in pairs(lvim.lang) do
    if filetype.formatters then
      formatters.setup(filetype.formatters, filetype)
    end
    if filetype.linters then
      linters.setup(filetype.linters, filetype)
    end
  end
end

return M
