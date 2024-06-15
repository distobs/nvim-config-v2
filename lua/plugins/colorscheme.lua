return {
	{ "ellisonleao/gruvbox.nvim", config = function()
		require('gruvbox').setup{contrast = "hard"}
		vim.cmd('colo gruvbox')
	end }
}
