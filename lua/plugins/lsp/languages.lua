local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require("lspconfig")

vim.diagnostic.config({
  virtual_text = {
    spacing = 2,
    prefix = "",
  },
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
})
vim.lsp.inlay_hint.enable(true)

local orig = vim.lsp.util.open_floating_preview

function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  opts.max_width = opts.max_width or 80
  return orig(contents, syntax, opts, ...)
end

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

  vim.keymap.set('n', '<leader>lr', function()
    vim.cmd('LspRestart')
  end, { desc = "Reload LSP" })
end


vim.lsp.config("ty", {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ty = {
      configurationFile = "/home/kipoha/.config/ty/ty.toml"
    },
  },
})
vim.lsp.enable("ty")


vim.lsp.config("ruff", {
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
vim.lsp.enable("ruff")

vim.lsp.config("elixirls", {
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

vim.lsp.config("lua_ls", {
  on_attach = on_attach,
  capabilities = capabilities,
})


vim.lsp.config("cssls", {
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config("html", {
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config("ast_grep", {
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config("dockerls", {
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config("yamlls", {
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config("docker_compose_language_service", {
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config("jsonls", {
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config("qmlls", {
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config("sqlls", {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "sql", "plsql" },
})

vim.lsp.config("sqls", {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "sql", "plsql" },
})
