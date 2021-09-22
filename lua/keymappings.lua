local M = {}
local Log = require("core.log")

local generic_normal = { noremap = true, silent = true }

local generic_opts = {
  insert_mode       = generic_normal,
  normal_mode       = generic_normal,
  visual_mode       = generic_normal,
  visual_block_mode = generic_normal,
  command_mode      = generic_normal,
  term_mode         = { silent = true },
}

local mode_adapters = {
    insert_mode       = "i",
    normal_mode       = "n",
    term_mode         = "t",
    visual_mode       = "v",
    visual_block_mode = "x",
    command_mode      = "c",
}

-- Append key mappings to lunarvim's defaults for a given mode
-- @param keymaps the table of key mappings containing a list per mode (normal_mode ..)
function M.append_to_defaults(keymaps)
    for mode, mappings in pairs(keymaps) do
        for k, v in ipairs(mappings) do
            lvim.keys[mode][k] = v
        end
    end
end

-- set key mappings individually
-- @param mode the keymap mode, can be one of the keys of mode_adapters
-- @param key The of keymap
-- @param cal can be form as a mapping ot tuple of mapping and user defined opt
function M.set_keymaps(mode, key, val)
    local opt = generic_opts[mode] and generic_opts[mode] or generic_normal
    if type(val) == "table" then
        opt = val[2]
        val = val[1]
    end
    vim.api.nvim_set_keymap(mode, key, val, opt)
end

-- Load key mappings for a given mode
-- @param mode the keymap mode, can be one of the keys of mode_adapters
-- @param keymaps the list of key mappings
function M.load_mode(mode,keymaps)
    mode = mode_adapters[mode] and mode_adapters[mode] or mode
    for k,v in pairs(keymaps) do
        M.set_keymaps(mode, k, v)
    end
end

-- Load key mappingd for all provided modes
-- @param keymaps A list of key mappings for each mode
function M.load(keymaps)
    for mode, mapping in pairs(keymaps) do
        M.load_mode(mode, mapping)
    end
end

function M.config()
    lvim.keys = {
        --@usage change or add keymappings for insert mode
        insert_mode = {
            -- "jk" for quitting insert mode
            ["jk"] = "<ESC>",
            -- "kj" for quitting insert mode
            ["kj"] = "<ESC>",
            -- "jj" for quitting insert mode
            ["jj"] = "<ESC>",
            -- get easy access to exit insert and start a new line
            ["<C-o>"] = "<ESC>o",
            -- Move current line / block with Alt-j/k ala vscode
            ["<A-j>"] = "<ESC>:m .+1<CR>==gi",
            -- Move current line / block with Alt-j/k ala vscode
            ["<A-k>"] = "<ESC>:m .-2<CR>==gi",
            --navigation
            ["<A-Up"] = "<C-\\><C-N><C-w>k",
            ["<A-Down"] = "<C-\\><C-N><C-w>k",
            ["<A-Left"] = "<C-\\><C-N><C-w>k",
            ["<A-Right"] = "<C-\\><C-N><C-w>k",
            -- navigate tab completion with <c-j> and <c-k>
            -- runs conditionally
            ["<C-j>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true }},
            ["<C-k>"] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true }},
        },

        -- @usage change or add keymappings for normal mode
        normal_mode = {
            -- Better window movement
            ["<C-h>"] = "<C-w>h",
            ["<C-j>"] = "<C-w>j",
            ["<C-k>"] = "<C-w>k",
            ["<C-l>"] = "<C-w>l",

            -- Resize with arrows
            ["<C-Up>"]    = ":resize - 2<CR>",
            ["<C-Down>"]  = ":resize + 2<CR>",
            ["<C-Left>"]  = ":vertical resize - 2<CR>",
            ["<C-Right>"] = ":vertical resize + 2<CR>",

            -- Move current line / block with Alt-j/k a la vscode.
            ["<A-j>"] = ":m .+1<CR>==",
            ["<A-k>"] = ":m .-2<CR>==",

            -- quick move and save
            ["S"] = ":w<CR>",
            ["Q"] = ":q<CR>",
            ["K"] = "5k",
            ["J"] = "5j",
            ["H"] = "0",
            ["L"] = "$",

            -- replace
            ["\\s"] = ":%//g<left><left>",

            -- Tab switch buffer
            ["<TAB>"] = ":bnext<CR>",
            ["<S-TAB>"] = ":bprevious<CR>",

            -- QuickFix
            ["]q"] = ":cnext<CR>",
            ["[q"] = ":cprev<CR>",
            ["<C-1>"] = ":call QuickFixToggle()<CR>",
            -- run code
            ["<F22>"] = ":call CompileAndRun()<CR>",

        },

        -- @usage change or add keymappings for terminal mode
        term_mode = {
            --Terminal window navigation
            ["<C-h>"] = "<C-\\><C-N><C-w>h",
            ["<C-j>"] = "<C-\\><C-N><C-w>j",
            ["<C-k>"] = "<C-\\><C-N><C-w>k",
            ["<C-l>"] = "<C-\\><C-N><C-w>l",
        },

        -- @usage change or add keymappings for visual mode
        visual_mode = {

            ["K"] = "5k",
            ["J"] = "5j",
            -- Better indenting
            ["<"] = "<gv",
            [">"] = ">gv",

            -- ["p"] = '"0p'
            -- ["p"] = '"0p'
        },

        --@usage change or add keymappings for visual mode
        visual_block_mode = {

            -- Move current line / block with Alt-j/k ala vscode.
            ["A-j"] = ":m >+1<CR>gv-gv",
            ["A-K"] = ":m <-2<CR>gv-gv",
        },

        -- @usage change or add keymappings for command mode
        command_mode = {
            --navigate tab completion with <c-j> and <c-k>
            --runs conditionally
            ["<C-j>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true }},
            ["<C-k>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true }},
        },
    }

    if vim.fn.has("mac") == 1 then
        lvim.keys.normal_mode["<A-Up>"] = lvim.keys.normal_mode["<C-Up>"]
        lvim.keys.normal_mode["<A-Down>"] = lvim.keys.normal_mode["<C-Down>"]
        lvim.keys.normal_mode["<A-Left>"] = lvim.keys.normal_mode["<C-Left>"]
        lvim.keys.normal_mode["<A-Right>"] = lvim.keys.normal_mode["<C-Right>"]
        Log:debug("Activated mac keymappings")
    end
end

function M.print(mode)
    print("List of LunarVim's default keymappings (not including which-key)")
    if mode then
        print(vim.inspect(lvim.keys[mode]))
    else
        print(vim.inspect(lvim.keys))
    end
end

function M.setup()
    vim.g.mapleader = (lvim.leader == "space" and " ") or lvim.leader
    M.load(lvim.keys)
end

return M
