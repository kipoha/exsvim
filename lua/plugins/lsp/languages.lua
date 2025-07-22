local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require("lspconfig")


local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  local keymap = vim.keymap.set

  keymap('n', 'gd', vim.lsp.buf.definition, opts)
  keymap('n', 'gD', vim.lsp.buf.declaration, opts)
  keymap('n', 'gr', require('telescope.builtin').lsp_references, opts)
  keymap('n', 'gi', vim.lsp.buf.implementation, opts)
  keymap('n', 'K', vim.lsp.buf.hover, opts)
  keymap('n', '<leader>rn', vim.lsp.buf.rename, opts)
  keymap('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  keymap('n', '<leader>de', vim.diagnostic.open_float, opts)
  keymap('n', '[d', vim.diagnostic.goto_prev, opts)
  keymap('n', ']d', vim.diagnostic.goto_next, opts)
  keymap('n', '<leader>dq', vim.diagnostic.setloclist, opts)
  keymap('n', '<leader>lf', function()
    vim.lsp.buf.format({ timeout_ms = 2000 })
  end, opts)
end




-- lspconfig.pyright.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
-- })
-- lspconfig.ruff.setup {
--   on_attach = on_attach,
--   capabilities = capabilities
-- }
--
require('lspconfig').pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    pyright = { disableOrganizeImports = true },
  },
})

require('lspconfig').ruff.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    settings = {
      lint = { run = "onType" },
      fixAll = true,
      organizeImports = true,
    },
  },
})

lspconfig.elixirls.setup({
  on_attach = on_attach,
  cmd = { "elixir-ls" },
  -- settings = {
  --   elixirLS = {
  --     dialyzerEnabled = true,
  --     fetchDeps = true,
  --     enableTestLenses = true,
  --     suggestSpecs = true,
  --   },
  -- },
  capabilities = capabilities,
})

lspconfig.lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})


lspconfig.cssls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.html.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.ast_grep.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.dockerls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.yamlls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.docker_compose_language_service.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.jsonls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
