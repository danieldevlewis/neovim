return {
  "lewis6991/gitsigns.nvim",
  opts = {
    signs = {
      add          = { text = "+" },
      change       = { text = "~" },
      delete       = { text = "_" },
      topdelete    = { text = "‾" },
      changedelete = { text = "~" },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      vim.keymap.set("n", "]h", gs.next_hunk, { buffer = bufnr })
      vim.keymap.set("n", "[h", gs.prev_hunk, { buffer = bufnr })
      vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { buffer = bufnr })
      vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { buffer = bufnr })
      vim.keymap.set("n", "<leader>hb", gs.blame_line, { buffer = bufnr })
    end,
  },
}
