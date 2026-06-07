return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = {
      "lua_ls",
      "ruby_lsp",
      "html",
      "vtsls",
      "cssls",
      "eslint",
      "tailwindcss",
    },
    automatic_installation = true,
    automatic_enable = false,
  },
  depedencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig"
  },
}
