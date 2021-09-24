-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

--[[-----------------------------------------------------------------------------------------
  general settings
--]]-----------------------------------------------------------------------------------------
lvim.format_on_save = true
lvim.lint_on_save = true


--[[-----------------------------------------------------------------------------------------
   colorscheme
--]]-----------------------------------------------------------------------------------------
lvim.colorscheme = "dracula"


--[[-----------------------------------------------------------------------------------------
  keymappings [view all the defaults by pressing <leader>Lk]
--]]-----------------------------------------------------------------------------------------
lvim.leader = "space"


--[[-----------------------------------------------------------------------------------------
  add your own keymapping
--]]-----------------------------------------------------------------------------------------
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"


--[[-----------------------------------------------------------------------------------------
  unmap a default keymapping
--]]-----------------------------------------------------------------------------------------
-- lvim.keys.normal_mode["<C-Up>"] = ""


--[[-----------------------------------------------------------------------------------------
  edit a default keymapping
--]]-----------------------------------------------------------------------------------------
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"


--[[ ----------------------------------------------------------------------------------------
  Change Telescope navigation to use j and k for navigation and n and p for history
  in both input and normal mode.
--]] ----------------------------------------------------------------------------------------
-- lvim.builtin.telescope.on_config_done = function()
--   local actions = require "telescope.actions"
--   -- for input mode
--   lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = actions.move_selection_next
--   lvim.builtin.telescope.defaults.mappings.i["<C-k>"] = actions.move_selection_previous
--   lvim.builtin.telescope.defaults.mappings.i["<C-n>"] = actions.cycle_history_next
--   lvim.builtin.telescope.defaults.mappings.i["<C-p>"] = actions.cycle_history_prev
--   -- for normal mode
--   lvim.builtin.telescope.defaults.mappings.n["<C-j>"] = actions.move_selection_next
--   lvim.builtin.telescope.defaults.mappings.n["<C-k>"] = actions.move_selection_previous
-- end


--[[-----------------------------------------------------------------------------------------
   Use which-key to add extra bindings with the leader-key prefix
--]]-----------------------------------------------------------------------------------------
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnosticss" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnosticss" },
-- }


--[[-----------------------------------------------------------------------------------------
   TODO: User Config for predefined plugins
   After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
--]]-----------------------------------------------------------------------------------------
lvim.builtin.dashboard.active = {}
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0


--[[-----------------------------------------------------------------------------------------
  if you don't want all the parsers change this to a table of the ones you want
--]]-----------------------------------------------------------------------------------------
--lvim.builtin.treesitter.ensure_installed = {}
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true


--[[-----------------------------------------------------------------------------------------
  generic LSP settings
  you can set a custom on_attach function that will be used for all the language servers
  See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
--]]-----------------------------------------------------------------------------------------
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end


--[[-----------------------------------------------------------------------------------------
  you can overwrite the null_ls setup table (useful for setting the root_dir function)
--]]-----------------------------------------------------------------------------------------
-- lvim.lsp.null_ls.setup = {
--   root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules"),
-- }
------------------------------------------
-- or if you need something more advanced
-- lvim.lsp.null_ls.setup.root_dir = function(fname)
--   if vim.bo.filetype == "javascript" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
--       or require("lspconfig/util").path.dirname(fname)
--   elseif vim.bo.filetype == "php" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "composer.json")(fname) or vim.fn.getcwd()
--   else
--     return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or require("lspconfig/util").path.dirname(fname)
--   end
-- end
------------------------------------------------------------------------------
-- set a formatter if you want to override the default lsp one (if it exists)
-- lvim.lang.python.formatters = {
--   {
--     exe = "black",
--     args = {}
--   }
-- }
-------------------------------
-- set an additional linter
-- lvim.lang.python.linters = {
--   {
--     exe = "flake8",
--     args = {}
--   }
-- }


--[[-----------------------------------------------------------------------------------------
  Additional More Plugins
--]]-----------------------------------------------------------------------------------------
lvim.plugins = {
    {
        "ray-x/lsp_signature.nvim",
        config = function()
            require("lsp_signature").on_attach()
        end,
        event = "InsertEnter",
    },
    {
        "ray-x/guihua.lua",
        run = "cd lua/fzy && make",
    },
    {
        "ray-x/navigator.lua",
        config = function()
            require("navigator").setup({
                debug = false, -- log output, set to true and log path: ~/.local/share/nvim/gh.log
                code_action_icon = " ",
                width = 0.75, -- max width ratio (number of cols for the floating window) / (window width)
                height = 0.4, -- max list window height, 0.3 by default
                preview_height = 0.35, -- max height of preview windows
                border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- border style, one of 'none', 'single', 'double', 'shadow',
                -- or a list of chars which defines the border,
                on_attach = function(client, bufnr)
                    --
                end,
                default_mapping = true,        -- set to false you will remap every key
                treesitter_analysis = true,    -- treesitter variable context
                transparency = 80,             -- 0~100 blur the main window, 100: full parentcy
                lspinstall = true,             -- set to true if you would like use the lsp installed by lspinstall
            })
        end,
    },
    {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup()
      end,
    },
    { "folke/tokyonight.nvim" },
    { "Mofiqul/dracula.nvim" },
    { "overcache/NeoSolarized" },
}


--[[-----------------------------------------------------------------------------------------
  Autocommands (https://neovim.io/doc/user/autocmd.html)
--]]-----------------------------------------------------------------------------------------
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
