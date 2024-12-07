return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")

      -- Ensure servers are installed
      mason_lspconfig.setup({
        ensure_installed = { "pyright", "tsserver", "clangd" },
      })

      -- Basic LSP server setup
      local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true }
        local keymap = vim.api.nvim_buf_set_keymap
        -- Keybindings for LSP
        keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
        keymap(bufnr, "n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
        keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
        keymap(bufnr, "n", "<leader>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
      end

      -- Add individual server configurations
      lspconfig.pyright.setup({ on_attach = on_attach })
      lspconfig.tsserver.setup({ on_attach = on_attach })
      lspconfig.clangd.setup({ on_attach = on_attach })
    end,
  },
}
