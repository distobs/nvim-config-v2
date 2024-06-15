return {
	{ "neovim/nvim-lspconfig", dependencies = {
		'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline', 'hrsh7th/nvim-cmp',
		'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip',
		'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim'
	}, ft = {'c', 'cpp', 'lua', 'python', 'html', 'css', 'javascript',
	'htmldjango' }, config = function()
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

		require("mason").setup()
		require("mason-lspconfig").setup()

		local langservers = {
			'clangd', 'html', 'cssls', 'jinja_lsp', 'tsserver',
			'pyright', 'lua_ls'
		}

		local c = require('cmp_nvim_lsp').default_capabilities()

		for _,server in pairs(langservers) do
			require('lspconfig')[server].setup({
				capabilities = c,
				on_attach = function(client)
					local csc = client.server_capabilities
					csc.semanticTokensProvider = nil
				end
			})
		end

		require'lspconfig'.lua_ls.setup {
			on_init = function(client)
				local vlf = vim.loop.fs_stat
				local ccl = client.config.settings.Lua
				local tde = vim.tbl_deep_extend

				local path = client.workspace_folders[1].name
				if vlf(path..'/.luarc.json') or
					vlf(path..'/.luarc.jsonc') then return
				end

				ccl = tde('force', ccl, {
					runtime = {
						version = 'LuaJIT'
					},
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME
						}
					}
				})
			end,
			settings = {
				Lua = {
					diagnostics = {
						globals =
							{ 'vim', 'cmp_select'}
					}
				}
			}
		}
	end }
}
