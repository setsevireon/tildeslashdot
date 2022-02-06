require("nvim-lsp-installer").on_server_ready(function(server)
	local opts = {}
	local status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

	if status then
		opts.capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
	end

	-- (optional) Customize the options passed to the server
	-- if server.name == "tsserver" then
	--     opts.root_dir = function() ... end
	-- end
	if server.name == "sumneko_lua" then
		opts.settings = {
			Lua = {
				diagnostics = {
					globals = { "vim", "use", "awesome", "client", "root", "screen" },
				},
				workspace = {
					library = {
						["/usr/share/nvim/runtime/lua"] = true,
						["/usr/share/nvim/runtime/lua/lsp"] = true,
						["/home/linuxbrew/.linuxbrew/share/nvim/runtime/lua"] = true,
						["/home/linuxbrew/.linuxbrew/share/nvim/runtime/lua/lua"] = true,
						["/usr/share/awesome/lib"] = true,
					},
				},
			},
		}
	end
	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)
