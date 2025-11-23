-- Custom Snacks Picker Example
-- https://github.com/folke/snacks.nvim/pull/1019

return {
	"folke/snacks.nvim",
	opts = {
		picker = {
			enabled = true,
			sources = {
				files = { ignored = true, hidden = true },
			},
			include = { ".env" },
			exclude = {
				".git",
				"node_modules",
			},
		},
	},

	keys = {

		-- find
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>fh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Pages",
		},
		{
			"<leader>fk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>fd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},

		-- undo history
		{
			"<leader>u",
			function()
				Snacks.picker.undo()
			end,
			desc = "Undo History",
		},

		-- git
		{
			"<leader>gb",
			function()
				Snacks.picker.git_branches()
			end,
			desc = "Git Branches",
		},
		{
			"<leader>gl",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git Log",
		},
		{
			"<leader>gs",
			function()
				Snacks.picker.git_status()
			end,
			desc = "Git Status",
		},
		{
			"<leader>gS",
			function()
				Snacks.picker.git_stash()
			end,
			desc = "Git Stash",
		},
		{
			"<leader>gd",
			function()
				Snacks.picker.git_diff()
			end,
			desc = "Git Diff (Hunks)",
		},

		-- gh
		{
			"<leader>gi",
			function()
				Snacks.picker.gh_issue()
			end,
			desc = "GitHub Issues (open)",
		},
		{
			"<leader>gI",
			function()
				Snacks.picker.gh_issue({ state = "all" })
			end,
			desc = "GitHub Issues (all)",
		},
		{
			"<leader>gp",
			function()
				Snacks.picker.gh_pr()
			end,
			desc = "GitHub Pull Requests (open)",
		},
		{
			"<leader>gP",
			function()
				Snacks.picker.gh_pr({ state = "all" })
			end,
			desc = "GitHub Pull Requests (all)",
		},

		-- LSP
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Goto Definition",
		},
		{
			"gD",
			function()
				Snacks.picker.lsp_declarations()
			end,
			desc = "Goto Declaration",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},
		{
			"gi",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "Goto Implementation",
		},
	},

	-- config = function()
	-- 	-- Replace builtin telescope Live Grep with TJ Multi Filter Grep
	-- 	-- https://github.com/tjdevries/advent-of-nvim/blob/master/nvim/lua/config/telescope/multigrep.lua
	-- 	require("util.multigrep").setup()
	-- end,
}

-- Non-Live Mode: fzf
-- https://junegunn.github.io/fzf/search-syntax/
--
-- Token	       Match type	                              Description
-- sbtrkt	       fuzzy-match	                              Items that include sbtrkt characters in that order
-- 'wild	       exact-match (quoted)	                      Items that include wild
-- 'wild'	       exact-boundary-match (quoted both ends)	  Items that include wild at word boundaries
-- ^music	       prefix-exact-match	                      Items that start with music
-- .mp3$	       suffix-exact-match	                      Items that end with .mp3
-- !fire	       inverse-exact-match	                      Items that do not include fire
-- !^music	       inverse-prefix-exact-match	              Items that do not start with music
-- !.mp3$	       inverse-suffix-exact-match	              Items that do not end with .mp3

-- Live Mode: rg (regex by default)
-- https://docs.rs/regex/1.12.2/regex/#syntax
--
-- Token / Pattern      Match type                           Description
-- music                regex-substring                       Items containing “music”
-- ^music               prefix-regex                          Items starting with “music”
-- music$               suffix-regex                          Items ending with “music”
-- \.mp3$               literal-suffix-regex                  Items ending with .mp3 (dot escaped)
-- fire                 regex-substring                       Items containing “fire”
-- ^(?!music)           inverse-prefix-regex                  Items not starting with “music”
-- (?!.*fire)           inverse-regex                         Items not containing “fire”
-- ^.*music.*\.mp3$     combined-regex                        Items containing “music” and ending with .mp3
-- ^(?!.*\.log$).*$     inverse-suffix-regex                  Items not ending with .log

-- Examples (Live) --AGRS
-- search with single extensions: test -- -t=cpp-- search with multiple extensions: test -- -g={*.h,*.c,*.cpp}
