require("plugins")

local map = require("utils").map

-- Providers
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Settings
vim.o.encoding = "utf-8"
vim.o.showmatch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.smartindent = true
vim.o.hlsearch = true
vim.o.cursorline = true
vim.o.colorcolumn = "80"

-- Mapping
-- leader
vim.g.mapleader = " "
-- switching buffers
map("n", "<leader>j", ":bn<CR>", { silent = true })
map("n", "<leader>k", ":bp<CR>", { silent = true })
