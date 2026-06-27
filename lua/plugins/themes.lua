return {
  -- { 'sainnhe/gruvbox-material',
  --      config = function(_, _)
  --          vim.g.gruvbox_material_background = 'medium'
  --      end,
  -- },
  -- {
  --   "sainnhe/everforest",
  --   config = function(_, _)
  --     vim.g.everforest_background = "hard"
  --   end,
  -- },
  -- { "jpwol/thorn.nvim" },
  -- { "AlessandroYorba/Sierra" },
  -- { "jvzjvz/gild.nvim", dependencies = { "rktjmp/lush.nvim" } },
  -- { "srcery-colors/srcery-vim" },
  -- { "gerardbm/vim-atomic" },
  -- { "fcpg/vim-farout" },
  -- { "ptdewey/darkearth-nvim" },
  -- { "AlessandroYorba/Alduin" },
  -- {
  --   "kooparse/vim-color-desert-night",
  --   config = function(_, _)
  --     -- vim.cmd("colorscheme desert-night")
  --     -- vim.cmd("highlight CursorLineNr ctermbg=234 guibg=#002b36 ")
  --     -- vim.cmd("highlight CursorLine ctermbg=234 guibg=#002b36")
  --   end,
  -- },
  {
    "rebelot/kanagawa.nvim",
    config = function(_, _)
      -- vim.cmd("colorscheme kanagawa-dragon")
    end,
  },
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
      vim.cmd("colorscheme evergarden-fall")
      -- vim.cmd("colorscheme evergarden")
    end,
  },
}
