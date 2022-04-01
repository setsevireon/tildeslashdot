-- Packer bootstrap
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system {
		'git',
		'clone',
		'--depth',
		'1',
		'https://github.com/wbthomason/packer.nvim',
		install_path,
	}
end

-- Plugins
return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'
	-- Defaults that (hopefully) everyone can agree on
	use 'tpope/vim-sensible'
	-- Pairs
	use 'tpope/vim-endwise'
	use 'jiangmiao/auto-pairs'
	-- Statusline
	use { 'nvim-lualine/lualine.nvim', config = "require('plugins.statusline')" }
	-- Colorscheme
	use { 'sainnhe/sonokai', config = "require('plugins.colorscheme')" }
	-- Sane buffer/window deletion
	use { 'mhinz/vim-sayonara', config = "require('plugins.sayonara')" }
	-- Tree-sitter
	use { 'nvim-treesitter/nvim-treesitter', config = "require('plugins.treesitter')", run = ':TSUpdate' }
	-- Telescope
	use {
		'nvim-telescope/telescope.nvim',
		config = "require('plugins.telescope')",
		requires = 'nvim-lua/plenary.nvim',
	}
	-- Linting and fixing
	use { 'dense-analysis/ale', config = "require('plugins.ale')" }
	-- LSP & Autocompletion
	use 'rust-lang/rust.vim'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/cmp-vsnip'
	use 'hrsh7th/vim-vsnip'
	use 'neovim/nvim-lspconfig'
	use {
		'williamboman/nvim-lsp-installer',
		config = function()
			require 'plugins.lsp'
			require 'plugins.completion'
		end,
		run = function()
			require('nvim-lsp-installer').install 'sumneko_lua'
		end,
	}
end)
