-- OLD
-- return {
-- 	"nvim-treesitter/nvim-treesitter",
-- 	build = ":TSUpdate",
-- 	config = function()
-- 		local config = require("nvim-treesitter.configs")
-- 		config.setup({
-- 			auto_install = true,
-- 			highlight = { enable = true },
-- 			indent = { enable = true },
-- 		})
-- 	end,
-- }

-- return {
-- 	"nvim-treesitter/nvim-treesitter",
-- 	lazy = false,
-- 	build = ":TSUpdate",
-- 	config = function()
-- 		local treesitter = require("nvim-treesitter")
-- 		treesitter.setup()
-- 		treesitter.install({ "java", "c", "lua", "vim", "vimdoc", "query", "javascript", "typescript", "html" })
--
-- 		vim.api.nvim_create_autocmd("FileType", {
-- 			pattern = { "java", "c", "lua", "vim", "vimdoc", "query", "javascript", "typescript", "html" },
-- 			callback = function()
-- 				-- syntax highlighting, provided by Neovim
-- 				vim.treesitter.start()
-- 				-- folds, provided by Neovim (I don't like folds)
-- 				-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- 				-- vim.wo.foldmethod = 'expr'
-- 				-- indentation, provided by nvim-treesitter
-- 				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
-- 			end,
-- 		})
-- 	end,
-- }

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
	opts = {
		indent = { enable = true },
		highlight = { enable = true },
		folds = { enable = true },
		endwise = { enable = true },
		ensure_installed = {
			"java",
			"c",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"javascript",
			"typescript",
			"html",
		},
	},
	dependencies = {
		{ "nvim-mini/mini.ai", event = { "BufReadPre", "BufNewFile" }, opts = {} }, -- for q (quotes), b (brackets), t (tags)
	},
	config = function(_, opts)
		local ts = require("nvim-treesitter")

		for _, parser in ipairs(opts.ensure_installed) do
			pcall(ts.install, parser)
		end

		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				pcall(vim.treesitter.start)
			end,
		})
	end,
}
