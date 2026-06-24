return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    opts = {
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
            "lua",
            "tsx",
            "typescript",
            "php",
            "query",
            "java",
            "c",
            "python",
            "go",
            "haskell",
        },
        auto_install = false,
    },
}
