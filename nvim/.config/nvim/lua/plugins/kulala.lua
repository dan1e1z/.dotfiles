-- return {}

vim.filetype.add({
	extension = {
		["http"] = "http",
	},
})

return {
	"mistweaverco/kulala.nvim",
	ft = { "http", "rest" },

	opts = {
		global_keymaps = false,
		debug = true,
	},

	config = function(_, opts)
		local kulala = require("kulala")
		kulala.setup(opts)

		local map = vim.keymap.set
		map("n", "<leader>rr", function()
			kulala.run()
		end, { desc = "Kulala: Run Request" })
		map("n", "<leader>rt", function()
			kulala.toggle_view()
		end, { desc = "Kulala: Toggle View" })
		map("n", "[R", function()
			kulala.jump_prev()
		end, { desc = "Kulala: Prev Request" })
		map("n", "]R", function()
			kulala.jump_next()
		end, { desc = "Kulala: Next Request" })
	end,
}
