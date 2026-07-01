return {
  {
    "nvim-mini/mini.nvim",
    lazy = false,
    opts = {},
    config = function(_, _)
      local MiniTrailspace = require("mini.trailspace")
      MiniTrailspace.setup({})

      local MiniStatusline = require("mini.statusline")
      MiniStatusline.setup({})
      local default_section_fileinfo = MiniStatusline.section_fileinfo
      local function rfind(str, pattern)
        local i = str:len()
        while i > 0 do
          if str:sub(i, i) == pattern then
            return i
          end
          i = i - 1
        end
        return nil
      end
      MiniStatusline.section_fileinfo = function(args)
        -- remove file size from fileinfo result
        local default_result = default_section_fileinfo(args)
        local index = rfind(default_result, " ")
        local result

        if index ~= nil then
          result = default_result:sub(1, index - 1)
        else
          result = default_result
        end

        return result
      end
      MiniStatusline.section_diff = function()
        return ""
      end
      local conflicts_timer_callback = function()
        local job = vim.fn.jobstart({ "/bin/bash", "-c", "find $HOME/sync/wiki | grep sync-conflict-" }, {
          on_stdout = function(job_id, data, event)
            -- ignore
          end,
          on_exit = function(job_id, code, event)
            vim.g.sync_conflicts_found = code == 0
          end,
        })
      end
      conflicts_timer_callback()
      MiniStatusline.section_location = function(_)
        local result = "%l|%v"
        local prepend_str = ""

        -- prepend timer icon when using virtualtimer
        local buf = vim.api.nvim_get_current_buf()
        if _G.virtualtimer ~= nil and _G.virtualtimer.timer_id_for_buf[buf] ~= nil then
          prepend_str = prepend_str .. "[]"
        end

        -- prepend sync conflicts marker if global is set
        if vim.g.sync_conflicts_found then
          prepend_str = prepend_str .. "[󰈽]"
        end

        if prepend_str ~= "" then
          result = prepend_str .. " " .. result
        end

        return result
      end
      local conflicts_timer = vim.fn.timer_start(
        5 * 60 * 1000,
        conflicts_timer_callback,
        { ["repeat"] = -1 } -- -1 means infinite repeat
      )
      local default_section_git = MiniStatusline.section_git
      MiniStatusline.section_git = function(args)
        local result = default_section_git(args)
        result = result:gsub("%( ", "(")
        result = result:gsub(" %)", ")")
        return result
      end

      -- local MiniTabline = require("mini.tabline")
      -- MiniTabline.setup({ tabpage_section = "right" })
      -- local default_make_tabline_string = MiniTabline.make_tabline_string
      -- MiniTabline.make_tabline_string = function()
      --   return os.date("  %H:%M") .. " " .. default_make_tabline_string()
      -- end

      local MiniHipatterns = require("mini.hipatterns")
      MiniHipatterns.setup({
        highlighters = {
          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = MiniHipatterns.gen_highlighter.hex_color(),
        },
      })

      local MiniFiles = require("mini.files")
      MiniFiles.setup({
        mappings = {
          close = "<ESC>",
          go_in = "l",
          go_in_plus = "L",
          go_out = "h",
          go_out_plus = "H",
          mark_goto = "'",
          mark_set = "m",
          reset = "<BS>",
          reveal_cwd = "@",
          show_help = "g?",
          synchronize = "=",
          trim_left = "<",
          trim_right = ">",
        },
      })

      local MiniPick = require("mini.pick")
      MiniPick.setup({})
      vim.keymap.set("n", "<leader>b", function()
        MiniPick.builtin.buffers()
      end)
      vim.keymap.set("n", "<leader>f", function()
        MiniPick.builtin.files()
      end)
      vim.keymap.set("n", "<leader>/", function()
        MiniPick.builtin.grep_live()
      end)
      vim.keymap.set("n", "<leader>h", function()
        MiniPick.builtin.help()
      end)
      local function char_from_reference_line(str)
        local index = string.find(str, " ")
        if index == nil then
          error("could not split on space in reference line")
        end
        return string.sub(str, 1, index - 1)
      end
      local function pick_from_reference(path)
        local selection = MiniPick.builtin.cli(
          { command = { "cat", path } },
          { source = { choose = function() end, name = "Symbols" } }
        )
        if selection == nil then
          return
        end
        vim.api.nvim_put({ char_from_reference_line(selection) }, "c", true, true)
      end
      local REFERENCE_DIR = os.getenv("HOME") .. "/dotfiles/reference/"
      vim.keymap.set("n", "<leader>se", function()
        pick_from_reference(REFERENCE_DIR .. "emojis.txt")
      end)
      vim.keymap.set("n", "<leader>sn", function()
        pick_from_reference(REFERENCE_DIR .. "nerdfont.txt")
      end)
      vim.keymap.set("n", "<leader>ss", function()
        pick_from_reference(REFERENCE_DIR .. "symbols.txt")
      end)
      vim.keymap.set("n", "<leader>sc", function()
        pick_from_reference(REFERENCE_DIR .. "cool.txt")
      end)

      local MiniVisits = require("mini.visits")
      MiniVisits.setup({})
      vim.keymap.set("n", "<leader>.", function()
        MiniVisits.select_path("")
      end)

      local MiniAlign = require("mini.align")
      MiniAlign.setup({})

      local MiniSplitjoin = require("mini.splitjoin")
      MiniSplitjoin.setup({})

      local MiniNotify = require("mini.notify")
      MiniNotify.setup({})

      -- local MiniColors = require("mini.colors")
      -- MiniColors.setup({})

      -- local MiniGit = require("mini.git")
      -- MiniGit.setup({})

      -- local MiniDiff = require('mini.diff')
      -- MiniDiff.setup({
      --     view = {
      --         style = 'sign',
      --         signs = { add = '▒', change = '▒', delete = '▒' },
      --         priority = 100,
      --     },
      -- })
      -- vim.keymap.set("n", "``", function()
      --     MiniDiff.toggle_overlay()
      -- end)

      -- local MiniClue = require('mini.clue')
      -- MiniClue.setup({
      --     triggers = {
      --         -- Leader triggers
      --         { mode = 'n', keys = '<Leader>' },
      --         { mode = 'x', keys = '<Leader>' },
      --         -- Built-in completion
      --         { mode = 'i', keys = '<C-x>' },
      --         -- `g` key
      --         { mode = 'n', keys = 'g' },
      --         { mode = 'x', keys = 'g' },
      --         -- Marks
      --         { mode = 'n', keys = "'" },
      --         { mode = 'n', keys = '`' },
      --         { mode = 'x', keys = "'" },
      --         { mode = 'x', keys = '`' },
      --         -- Registers
      --         { mode = 'n', keys = '"' },
      --         { mode = 'x', keys = '"' },
      --         { mode = 'i', keys = '<C-r>' },
      --         { mode = 'c', keys = '<C-r>' },
      --         -- Window commands
      --         { mode = 'n', keys = '<C-w>' },
      --         -- `z` key
      --         { mode = 'n', keys = 'z' },
      --         { mode = 'x', keys = 'z' },
      --     },
      --     clues = {
      --         -- Enhance this by adding descriptions for <Leader> mapping groups
      --         MiniClue.gen_clues.builtin_completion(),
      --         MiniClue.gen_clues.g(),
      --         MiniClue.gen_clues.marks(),
      --         MiniClue.gen_clues.registers(),
      --         MiniClue.gen_clues.windows(),
      --         MiniClue.gen_clues.z(),
      --     },
      -- })
    end,
  },
}
