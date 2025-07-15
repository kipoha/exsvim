require("bufferline").setup()

vim.keymap.set("n", "<leader>x", ":bd<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
