-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  api.config.mappings.default_on_attach(bufnr)

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set('n', 'l', api.node.open.edit, opts("Open"))
  vim.keymap.set('n', 'f', api.node.open.vertical, opts("Open: Vertical Split"))
  vim.keymap.set('n', 'h', api.node.navigate.parent, opts("Close Directory or Go Up"))
end


require("nvim-tree").setup({
  git = {
    enable = true,
  },
  on_attach = on_attach,
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    side = "right",
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  -- update_cwd = false,
})

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
