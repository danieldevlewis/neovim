return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  config = function ()
    require("ibl").setup({
      indent = {
        highlight = {
          "IndentOdd",
          "IndentEven",
        },
        char = ""
      },
      whitespace = {
        highlight = {
          "IndentOdd",
          "IndentEven",
        },
        remove_blankline_trail = true
      },
      scope = { enabled = false },
    })
  end
}
