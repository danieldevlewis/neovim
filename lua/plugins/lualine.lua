return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      sections = {
        lualine_b = {
          'branch',
          {
            'diagnostics',
            sources = {'nvim_diagnostic'},
            symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '},
            colored = true,
            update_in_insert = false,
          },
        },
      }
    }
  end,
}
