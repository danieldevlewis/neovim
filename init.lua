vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = false

-- Do I really need swapfiles?
vim.o.swapfile = true
vim.o.directory = vim.fn.expand("~/.local/state/nvim/swap//")
-- Backup
vim.o.backup = true
vim.o.backupdir= vim.fn.expand("~/.local/state/nvim/swap//")
-- Some applications work better like this
vim.o.backupcopy = "yes"
-- Persistent undo
vim.o.undofile = true
vim.o.undodir = vim.fn.expand("~/.local/state/nvim/undo//")

-- Better?
vim.o.updatetime = 1000

vim.o.number = true
vim.o.mouse = 'a'

vim.o.showmode = false

-- Generally ignore case
vim.o.ignorecase = true
-- Unless capital letters are included
vim.o.smartcase = true

-- Signcolumn on
vim.o.signcolumn = 'yes'

vim.o.wrap = false
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.smartindent = true

-- Character representations
vim.o.list = true
vim.opt.listchars = { tab = '→ ', nbsp = '␣' }

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>f", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Allow for accidental holding shift while saving and exiting
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("Qa", "qa", {})

-- Make Y consistent
vim.keymap.set("n", "Y", "y$", { noremap = true })

-- Make U redo
vim.keymap.set("n", "U", "<C-r>", { noremap = true, silent = true })

vim.api.nvim_set_hl(0, "IndentOdd",  { bg = "#002b36" }) -- base02
vim.api.nvim_set_hl(0, "IndentEven", { bg = "#073642" }) -- base03

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup(
  "plugins",
  {
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "solarized" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
  }
)

vim.opt.spell = true
vim.opt.spelllang = { "en_gb" }
vim.api.nvim_set_hl(0, "SpellBad", { underline = true, strikethrough = false })

vim.api.nvim_set_hl(0, "TrailingSpaces", { bg = "#dc322f" })
local trailing_group = vim.api.nvim_create_augroup("TrailingSpacesHighlight", { clear = true })
vim.api.nvim_create_autocmd({"InsertEnter"}, {
  group = trailing_group,
  callback = function()
    -- Remove highlighting when entering insert mode
    if vim.g.trailing_match then
      pcall(function ()
        vim.fn.matchdelete(vim.g.trailing_match or 0)
      end)
      vim.g.trailing_match = nil
    end
  end,
})
vim.api.nvim_create_autocmd({"InsertLeave"}, {
  group = trailing_group,
  callback = function()
    -- Re-add highlighting when leaving insert mode or opening a buffer
    vim.g.trailing_match = vim.fn.matchadd("TrailingSpaces", [[\s\+$]])
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"NvimTree", "help", "terminal"},
  callback = function()
    vim.fn.matchdelete(vim.fn.matchadd("TrailingSpaces", [[\s\+$]]))
  end
})

vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)

vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = { current_line = true },
  signs = true,       -- Show symbols in gutter
  underline = true,   -- Keep underlines
  update_in_insert = false, -- Don't show in insert mode
  severity_sort = true,
})

vim.lsp.config('*', {
  root_markers = { '.git' },
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } }
    }
  }
})

vim.lsp.enable('lua_ls')
vim.lsp.enable('ruby_lsp')
vim.lsp.enable('eslint')
vim.lsp.enable('html')
vim.lsp.enable('vtsls')
