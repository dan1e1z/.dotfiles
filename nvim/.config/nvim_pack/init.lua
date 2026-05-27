-- 1. Create a table containing all your plugin URLs
local plugins = {
	"https://github.com/rose-pine/neovim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/christoomey/vim-tmux-navigator",
	"https://github.com/saghen/blink.cmp",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/cbochs/grapple.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/folke/neoconf.nvim",
	"https://github.com/folke/neodev.nvim",
	"https://github.com/mistweaverco/kulala.nvim",
	"https://github.com/williamboman/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/nvim-mini/mini.ai",
	"https://github.com/echasnovski/mini.surround",
	"https://github.com/folke/noice.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/brenoprata10/nvim-highlight-colors",
	"https://github.com/mfussenegger/nvim-lint",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/folke/trouble.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/windwp/nvim-ts-autotag",
	"https://github.com/mrjones2014/smart-splits.nvim",
	"https://github.com/folke/snacks.nvim",
	"https://github.com/roobert/tailwindcss-colorizer-cmp.nvim",
	"https://github.com/folke/todo-comments.nvim",
	"https://github.com/folke/ts-comments.nvim",
	"https://github.com/machakann/vim-highlightedyank",
	"https://github.com/RRethy/vim-illuminate",
	"https://github.com/nvim-lua/plenary.nvim",
}

-- 2. Instead of vim.pack.add(), loop and use vim.pack.del()
for _, plugin_url in ipairs(plugins) do
	pcall(vim.pack.del, plugin_url)
end
