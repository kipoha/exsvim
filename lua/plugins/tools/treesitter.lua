require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "python", "html", "css", "elixir" },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
})
