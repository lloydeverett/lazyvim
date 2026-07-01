return {
  {
    "declancm/cinnamon.nvim",
    lazy = false,
    opts = {},
    config = function(_, opts)
      if not vim.g.neovide then
        local cinnamon = require("cinnamon")
        cinnamon.setup(opts)
        vim.keymap.set("n", "<C-U>", function()
          cinnamon.scroll("<C-U>")
        end)
        vim.keymap.set("n", "<C-D>", function()
          cinnamon.scroll("<C-D>")
        end)
        -- vim.keymap.set("n", "{", function() cinnamon.scroll("{", { mode = "window" }) end)
        -- vim.keymap.set("n", "}", function() cinnamon.scroll("}", { mode = "window" }) end)
        vim.keymap.set("n", "G", function()
          cinnamon.scroll("G", { mode = "window", max_delta = { time = 250 } })
        end)
        vim.keymap.set("n", "gg", function()
          cinnamon.scroll("gg", { mode = "window", max_delta = { time = 250 } })
        end)
      end
    end,
  },
  {
    "jake-stewart/multicursor.nvim",
    lazy = false,
    branch = "1.0",
    config = function(_, _)
      local mc = require("multicursor-nvim")
      mc.setup()
      -- Add or skip cursor above/below the main cursor.
      vim.keymap.set({ "n", "x" }, "<up>", function()
        mc.lineAddCursor(-1)
      end)
      vim.keymap.set({ "n", "x" }, "<down>", function()
        mc.lineAddCursor(1)
      end)
      vim.keymap.set({ "n", "x" }, "<C-k>", function()
        mc.lineAddCursor(-1)
      end)
      vim.keymap.set({ "n", "x" }, "<C-j>", function()
        mc.lineAddCursor(1)
      end)
      vim.keymap.set({ "n", "x" }, "<leader><up>", function()
        mc.lineSkipCursor(-1)
      end)
      vim.keymap.set({ "n", "x" }, "<leader><down>", function()
        mc.lineSkipCursor(1)
      end)
      -- Add or skip adding a new cursor by matching word/selection
      vim.keymap.set({ "n", "x" }, "<C-n>", function()
        mc.matchAddCursor(1)
      end)
      vim.keymap.set({ "n", "x" }, "<C-s>", function()
        mc.matchSkipCursor(1)
      end)
      vim.keymap.set({ "n", "x" }, "<C-S-N>", function()
        mc.matchAddCursor(-1)
      end)
      vim.keymap.set({ "n", "x" }, "<C-S-S>", function()
        mc.matchSkipCursor(-1)
      end)
      -- Add and remove cursors with control + left click.
      vim.keymap.set("n", "<c-leftmouse>", mc.handleMouse)
      vim.keymap.set("n", "<c-leftdrag>", mc.handleMouseDrag)
      vim.keymap.set("n", "<c-leftrelease>", mc.handleMouseRelease)
      -- Disable and enable cursors.
      vim.keymap.set({ "n", "x" }, "<c-q>", mc.toggleCursor)
      -- Mappings defined in a keymap layer only apply when there are
      -- multiple cursors. This lets you have overlapping mappings.
      mc.addKeymapLayer(function(layerSet)
        -- Select a different cursor as the main one.
        layerSet({ "n", "x" }, "<left>", mc.prevCursor)
        layerSet({ "n", "x" }, "<right>", mc.nextCursor)
        -- Delete the main cursor.
        layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)
        -- Enable and clear cursors using escape.
        layerSet("n", "<esc>", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)
      -- Customize how cursors look.
      vim.api.nvim_set_hl(0, "MultiCursorCursor", { reverse = true })
      vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
      vim.api.nvim_set_hl(0, "MultiCursorSign", { link = "SignColumn" })
      vim.api.nvim_set_hl(0, "MultiCursorMatchPreview", { link = "Search" })
      vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { reverse = true })
      vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      vim.api.nvim_set_hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end,
  },
  { "chomosuke/term-edit.nvim", lazy = false, opts = {
    prompt_end = "%% ",
  } },
  {
    "tzachar/local-highlight.nvim",
    lazy = false,
    dependencies = {
      "folke/snacks.nvim", -- for animation support
    },
    opts = {
      -- file_types = {"python", "cpp"}, -- If this is given only attach to this
      -- OR attach to every filetype except:
      disable_file_types = { "markdown", "vimwiki" },
      hlgroup = "LocalHighlight",
      cw_hlgroup = nil,
      -- Whether to display highlights in INSERT mode or not
      insert_mode = false,
      min_match_len = 1,
      max_match_len = math.huge,
      highlight_single_match = true,
      animate = {
        enabled = true,
        easing = "linear",
        duration = {
          step = 10, -- ms per step
          total = 100, -- maximum duration
        },
      },
      debounce_timeout = 200,
    },
  },
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit" }, -- Lazy-load on fugitive commands
  },
  {
    "sindrets/diffview.nvim",
    lazy = false,
    config = {
      default_args = {
        DiffviewOpen = { "--imply-local" },
        DiffviewFileHistory = { "--pin-local" },
      },
    },
  },
  {
    "yannvanhalewyn/jujutsu.nvim",
    lazy = false,
    config = function()
      require("jujutsu-nvim").setup({
        diff_preset = "diffview",
        keymap = {
          m = { cmd = "describe", desc = "Edit description" },
        },
      })
    end,
  },
}
