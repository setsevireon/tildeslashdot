vim.cmd [[
				au FileType php setl ai cin et ts=4 sw=4 cc=120
				au FileType php let b:ale_fixers=['php_cs_fixer']
				au FileType php let b:ale_php_phpcs_standard='PSR12'
]]
