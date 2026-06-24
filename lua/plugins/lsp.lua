return {
    {
        "williamboman/mason.nvim",
        opts = {},
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "clangd",       -- C
                "jdtls",        -- Java
                "pyright",      -- Python
                "gopls",        -- Go
                "hls",          -- Haskell
            },
            automatic_installation = true,
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local on_attach = function(_, bufnr)
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
                end

                map("gd", vim.lsp.buf.definition, "Go to definition")
                map("gD", vim.lsp.buf.declaration, "Go to declaration")
                map("gr", vim.lsp.buf.references, "Find references")
                map("gi", vim.lsp.buf.implementation, "Go to implementation")
                map("K", vim.lsp.buf.hover, "Hover documentation")
                map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
                map("<leader>ca", vim.lsp.buf.code_action, "Code action")
                map("<leader>f", vim.lsp.buf.format, "Format file")
                map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
                map("]d", vim.diagnostic.goto_next, "Next diagnostic")
                map("<leader>d", vim.diagnostic.open_float, "Show diagnostic")
            end

            local servers = { "clangd", "pyright", "gopls", "hls" }
            for _, server in ipairs(servers) do
                lspconfig[server].setup({ on_attach = on_attach, capabilities = capabilities })
            end

            -- jdtls has its own setup via nvim-jdtls (recommended for Java)
            -- but basic lspconfig setup works for simple use cases
            lspconfig.jdtls.setup({ on_attach = on_attach, capabilities = capabilities })
        end,
    },
}
