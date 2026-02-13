return {
  'princejoogie/dir-telescope.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = function()
    require("telescope").load_extension("dir")

    vim.keymap.set("n", "<leader>fgd", "<cmd>Telescope dir live_grep<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>ffd", "<cmd>Telescope dir find_files<CR>", { noremap = true, silent = true })
  end
}
