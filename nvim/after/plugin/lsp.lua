local lsp = require('lsp-zero')

lsp.preset("recommended")

require('mason').setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    },
    border = "rounded",
  }
})
require('mason-lspconfig').setup({
  ensure_installed = {
    "ts_ls",
    "eslint",
    "rust_analyzer",
  },
  handlers = {
    lsp.default_setup,
  },
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-Space>'] = cmp.mapping.confirm({ select = true }),
  ['<C-y>'] = cmp.mapping.complete()
})

cmp.setup({
  mapping = cmp_mappings,
  window = {
    completion = cmp.config.window.bordered({
      border = 'rounded' -- Add rounded borders to the completion window
    }),
    documentation = cmp.config.window.bordered({
      border = 'rounded' -- Add rounded borders to the documentation window
    }),
    hover = cmp.config.window.bordered({
      border = 'rounded' -- Add rounded borders to the hover window
    })
  }
})


lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  --	vim.keymap.set("n", "<leader>vd", function() vim.diagnostics,open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostics.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostics.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

-- Customize diagnostic signs
vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })


lsp.setup()
