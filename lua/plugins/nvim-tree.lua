return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("nvim-tree").setup({
            view = {
                width = 30,
                side = "left",
            },
            renderer = {
                group_empty = true,
                icons = {
                    show = {
                        file = true,
                        folder = true,
                        folder_arrow = true,
                    },
                },
            },
            filters = {
                dotfiles = false,
            },
        })

        vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })
        vim.keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>", { desc = "Reveal current file in tree" })
    end,
}
