local cmp = require("cmp")
local lspkind = require('lspkind')
local luasnip = require("luasnip")

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {
    border = "rounded",
  }
)

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

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = true }),

    ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp", priority = 100, keyword_length = 1 },
    { name = "buffer",   priority = 100, keyword_length = 1 },
    { name = "luasnip",  priority = 90,  keyword_length = 1 },
    { name = "path",     priority = 70,  keyword_length = 1 },
  }),
  completion = {
    autocomplete = {
      cmp.TriggerEvent.TextChanged
    },
  },
  -- mapping = cmp.mapping.preset.insert({
  --   ['<CR>'] = cmp.mapping.confirm({ select = false }),  -- Настройка клавиши Enter
  -- }),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require("lspconfig")

-- lspconfig.pyright.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
-- })
-- lspconfig.ruff.setup {
--   on_attach = on_attach,
--   capabilities = capabilities
-- }
-- Pyright для автодополнения, hover и анализа
require('lspconfig').pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    pyright = { disableOrganizeImports = true },
    python = { analysis = {
      ignore = { "*" },  -- Отключаем линтинг в pyright
    }},
  },
})

-- Ruff LSP для линтинга, автофиксов и порядочного импорта
require('lspconfig').ruff.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    settings = {
      lint = { run = "onType" },  -- Диагностика при вводе
      fixAll = true,
      organizeImports = true,
    },
  },
})

lspconfig.elixirls.setup({
  on_attach = on_attach,
  cmd = { "elixir-ls" },
  settings = {
    elixirLS = {
      dialyzerEnabled = true,
      fetchDeps = true,
      enableTestLenses = true,
      suggestSpecs = true,
    },
  },
  capabilities = capabilities,
})

lspconfig.lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

require("nvim-autopairs").setup({})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
