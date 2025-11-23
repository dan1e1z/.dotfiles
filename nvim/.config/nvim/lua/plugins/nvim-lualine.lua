-- return {
-- 	"nvim-lualine/lualine.nvim",
-- 	dependencies = { "folke/noice.nvim", "nvim-tree/nvim-web-devicons" },
-- 	config = function()
-- 		require("lualine").setup({
-- 			sections = {
-- 				lualine_x = {
-- 					{
-- 						require("noice").api.status.command.get,
-- 						cond = require("noice").api.status.command.has,
-- 						color = { fg = "#ff9e64" },
-- 					},
-- 					{
-- 						require("noice").api.status.mode.get,
-- 						cond = require("noice").api.status.mode.has,
-- 						color = { fg = "#ff9e64" },
-- 					},
-- 				},
-- 				lualine_b = {
-- 					"grapple",
-- 				},
-- 			},
-- 		})
-- 	end,
-- }

return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"folke/noice.nvim",
		"folke/trouble.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	opts = function(_, opts)
		opts.sections = opts.sections or {}

		local trouble = require("trouble")
		local symbols = trouble.statusline({
			mode = "lsp_document_symbols",
			groups = {},
			title = false,
			filter = { range = true },
			format = "{kind_icon}{symbol.name:Normal}",
			hl_group = "lualine_c_normal",
		})

		opts.sections.lualine_c = opts.sections.lualine_c or {}
		table.insert(opts.sections.lualine_c, 1, {
			symbols.get,
			cond = symbols.has,
		})

		opts.sections.lualine_x = opts.sections.lualine_x or {}
		table.insert(opts.sections.lualine_x, {
			require("noice").api.status.command.get,
			cond = require("noice").api.status.command.has,
			color = { fg = "#ff9e64" },
		})
		table.insert(opts.sections.lualine_x, {
			require("noice").api.status.mode.get,
			cond = require("noice").api.status.mode.has,
			color = { fg = "#ff9e64" },
		})

		opts.sections.lualine_b = {
			"grapple",
		}
	end,
}
