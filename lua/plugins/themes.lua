return {
  -- { 'sainnhe/gruvbox-material',
  --      config = function(_, _)
  --          vim.g.gruvbox_material_background = 'medium'
  --      end,
  -- },
  {
    "sainnhe/everforest",
    config = function(_, _)
      vim.g.everforest_background = "hard"
    end,
  },
  { "jpwol/thorn.nvim" },
  {
    "everviolet/nvim",
    lazy = false,
    name = "evergarden",
    opts = {
      theme = {
        variant = "fall",
        accent = "green",
      },
      editor = {
        transparent_background = true,
      },
    },
    config = function(_, opts)
      require("evergarden").setup(opts)
      vim.cmd("colorscheme evergarden")
    end,
  },
}
