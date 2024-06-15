return {
	{ "neovim/nvim-lspconfig", dependencies = {
		'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline', 'hrsh7th/nvim-cmp',
		'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip'
	}, ft = {'c', 'cpp' }, config = function()
		local cmp = require('cmp')

		cmp.setup({snippet = {
			expand = function(args)
				require('luasnip').lsp_expand(args.body)
			end
		}, window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered()
		}, mapping = cmp.mapping.preset.insert({
			['<C-b>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-space'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping.abort(),
			['<cr>'] = cmp.mapping.confirm({select=true}),
			[ '<tab>' ] = cmp.mapping.select_next_item(cmp_select),
			[ '<s-tab>' ] =
			cmp.mapping.select_prev_item(cmp_select),
		}), sources = cmp.config.sources({
			{ name = 'nvim_lsp' },
			{ name = 'luasnip' }
		}, {
			{ name = 'buffer' }
		})})
		local c = require('cmp_nvim_lsp').default_capabilities()
		require('lspconfig').clangd.setup({
			capabilities = c
		})
	end }
}
