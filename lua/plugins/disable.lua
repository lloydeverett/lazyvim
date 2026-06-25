return {
  { "folke/dashboard-nvim", enabled = false },
  { "folke/noice.nvim", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {
        enabled = false,
      },
      dashboard = {
        enabled = false,
      },
      indent = {
        scope = { enabled = false }, -- Disables the animated scope line
      },
      scroll = {
        enabled = false,
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    enabled = false,
  },
}
