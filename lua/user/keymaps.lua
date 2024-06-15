vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local v = vim.keymap.set
		local opts = { buffer = ev.buf }
		v('n', '<leader>gd', vim.lsp.buf.definition, opts)
		v('n', '<leader>gD', vim.lsp.buf.declaration, opts)
		v('n', '<leader>gi', vim.lsp.buf.implementation, opts)
		v('n', '<leader>gr', vim.lsp.buf.references, opts)
		v('n', '<leader>gtd', vim.lsp.buf.type_definition, opts)
		v('n', '<leader>rn', vim.lsp.buf.rename, opts)
		v('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		v('n', 'K', vim.lsp.buf.hover, opts)
	end,
})
