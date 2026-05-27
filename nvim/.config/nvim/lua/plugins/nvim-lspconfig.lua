return {
	"neovim/nvim-lspconfig",
	dependencies = { "williamboman/mason-lspconfig.nvim" },
	config = function()
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		vim.lsp.config("*", { capabilities = capabilities })

		vim.lsp.handlers["$/progress"] = function() end

		local servers = {
			"tailwindcss",
			"vtsls",
			"html",
			"cssls",
			"jsonls",
			"lua_ls",
			"pyright",
			"clangd",
			"gopls",
			"emmet_language_server",
		}

		require("mason-lspconfig").setup({
			ensure_installed = servers,
		})

		vim.lsp.config("tailwindcss", {})
		vim.lsp.config("vtsls", {})
		vim.lsp.config("html", {})
		vim.lsp.config("cssls", {})
		vim.lsp.config("jsonls", {})
		vim.lsp.config("lua_ls", {})
		vim.lsp.config("pyright", {})
		vim.lsp.config("clangd", {})

		vim.lsp.config("gopls", {
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			root_markers = { "go.work", "go.mod", ".git" },
		})

		vim.lsp.config("emmet_language_server", {})

		vim.lsp.enable(servers)

		vim.keymap.set("n", "D", vim.lsp.buf.hover, { desc = "LSP Hover" })
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })
		vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, { desc = "Open Diagnostic Float" })
	end,
}
