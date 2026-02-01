return {
  "maxmx03/solarized.nvim",
  lazy = false,     -- load immediately
  priority = 1000,  -- make sure it loads before others
  config = function()
    vim.o.termguicolors = true
    vim.cmd.colorscheme("solarized")
  end,
}
