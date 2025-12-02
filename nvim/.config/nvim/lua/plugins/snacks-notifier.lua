return {
	"folke/snacks.nvim",
	opts = {
		notifier = {
			enabled = true,
		},
	},

	keys = {
		{
			"<leader>nh",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Notification History",
		},
	},
}
