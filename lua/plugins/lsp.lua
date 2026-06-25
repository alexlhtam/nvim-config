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
                "ts_ls",        -- TypeScript/JavaScript (tsx)
                "tinymist",     -- Typst 👈 ADDED HERE
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
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Buffer-local keymaps, set when any LSP client attaches.
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(event)
                    local bufnr = event.buf
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
                end,
            })

            -- Shared capabilities for every server (nvim 0.11+ API).
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(event)
                    local bufnr = event.buf
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
                end,
            })

            -- Shared capabilities for every server (nvim 0.11+ API).
            vim.lsp.config("*", { capabilities = capabilities })

            -- Custom targeted settings for Tinymist using the 0.11+ config engine
            vim.lsp.config("tinymist", {
                settings = {
                    -- Automatically build and update your clean PDF target on every file save
                    exportPdf = "onSave",
                    -- Sets the modern "typstyle" formatter to handle your <leader>f command
                    formatterMode = "typstyle",
                    -- Tells the LSP preview to stay neutral so it doesn't conflict with our browser tool
                    preview = {
                        invertColors = "never",
                    }
                }
            })

            -- jdtls has a dedicated plugin (nvim-jdtls) for advanced use,
            -- but the default lspconfig definition works for simple cases.
            local servers = { "clangd", "pyright", "gopls", "hls", "ts_ls", "jdtls", "tinymist" } -- 👈 ADDED HERE
            vim.lsp.enable(servers)
        end,
    },
}
