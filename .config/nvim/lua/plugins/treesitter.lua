require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
		"dockerfile",
		"go",
		"html",
		"javascript",
		"json",
		"latex",
		"lua",
		"make",
		"markdown",
		"python",
		"rust",
		"toml",
		"vim",
		"yaml",
	},
	sync_install = false,
	highlight = { enable = true },
})
