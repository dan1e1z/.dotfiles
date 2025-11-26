return {
	"williamboman/mason.nvim",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	cmd = "Mason",
	event = "BufReadPre",

	opts = {
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	},

	config = function(_, opts)
		require("mason").setup(opts)

		local mason_tool_installer = require("mason-tool-installer")
		mason_tool_installer.setup({
			ensure_installed = {
				-- Formatters
				"prettier",
				"stylua",
				"isort",
				"black",
				"eslint_d",

				-- Linters
				"eslint_d",
				"pylint",
			},
		})
	end,
}
