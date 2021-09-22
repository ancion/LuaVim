local M = {}
local utils = require("utils")

M.load_options = function()
    local default_options = {
        backup = false,                   -- create a backup file
        clipboard = "unnamedplus",        -- allows neovim to access the system clipboard
        cmdheight = 1,                    -- command line to display message
        colorcolumn = "99999",            -- fixes indentline for now
        completeopt = { "menuone", "noselect" },
        conceallevel = 0,                 -- so that `` is visible in markdown for now
        fileencoding = "utf-8",           -- the encoding written to a file
        foldmethod = "manual",            -- folding, set to "expr" for treesitter based folding
        foldexpr = "",                    -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
        guifont = "monospace:h17",        -- the font used in graphical neovim applications
        hidden = true,                    -- required to keep multiple buffers and open multiple buffers
        hlsearch = true,                  -- highlight all matched on previous search patterns
        ignorecase = true,                -- ignore case in search patterns
        mouse = "a",                      -- allow mouse to be used in neovim
        pumheight = 20,                   -- pup up menu height
        showmode = false,                 -- we don't need to see thing like "INSERT" anymore
        showtabline = 2,                  -- always show tabs
        smartcase = true,                 -- smart case
        smartindent = true,               -- make indenting smarter again
        splitbelow = true,                -- force all horizontal splits to below current window
        splitright = true,                -- force all vertical splits  to right of current window
        swapfile = false,                 -- creates a swapfile
        termguicolors = true,             -- set term gui colors (most terminals support this)
        timeoutlen = 300,                 -- time to wait for a mapped sequence to complete(in milliseconds)
        title = true,                     -- set the title of window to the value of titlestring
        -- opt.titlestring = "%<%F%=%l/%L" - nvim -- what the title of the window will be set to
        undodir = utils.join_paths(get_cache_dir(),"undo"), -- set an undo directory
        undofile = true,                  -- enable persistent undo
        updatetime = 300,                 -- faster completion
        writebackup = false,              -- if a file is being edited by another program(or was written to file while editing with another program),it is not allowed to be edited
        expandtab = true,                 -- convert tabs to spaces
        shiftwidth = 2,                   -- the number of spaces inserted for each indentation
        tabstop = 2,                      -- insert 2 spaces for a tab
        cursorline = true,                -- highlight the current line
        number = true,                    -- set numbered lines
        relativenumber = true,            -- set relative numbered lines
        numberwidth = 4,                  -- set number column width to 2 { default 4 }
        signcolumn = "yes",               -- always show the sign column, otherwise it would shift the text each time
        wrap = false,                     -- display lines as one long line
        spell = false,                    -- whether check letter
        spelllang = "en",                 -- check language
        scrolloff = 8,                    -- keep viewport top-bottom 8 lines
        sidescrolloff = 8,                -- keep viewport left-right 8 lines
    }

    --- SETTINGS ---
    vim.opt.shortmess:append "c"

    for k, v in pairs(default_options) do
        vim.opt[k] = v
    end
end


M.load_commands = function()
    local cmd = vim.cmd
    if lvim.line_wrap_cursor_movement then
        cmd "set whichwrap+=<,>,[,],h,l"
    end

    if lvim.transparent_window then
        cmd "au ColorScheme * hi Normal ctermbg=none guibg=none"
        cmd "au ColorScheme * hi SignColumn ctermbg=none guibg=none"
        cmd "au ColorScheme * hi NormalNC ctermbg=none guibg=none"
        cmd "au ColorScheme * hi MsgArea ctermbg=none guibg=none"
        cmd "au ColorScheme * hi TelescopeBorder ctermbg=none guibg=none"
        cmd "au ColorScheme * hi NvimTreeNormal ctermbg=none guibg=none"
        cmd "au Colorscheme * hi Pmenu ctermbg=none guibg=none"
        cmd "au Colorscheme * hi PmenuSel ctermbg=cyan ctermfg=black guibg=cyan guifg=black"
        cmd "au Colorscheme * hi NormalFloat ctermbg=none guibg=none"
        cmd "let &fcs='eob: '"
    end
end

return M
