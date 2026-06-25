-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- load our custom init file
local current_file = debug.getinfo(1, "S").source:sub(2)
local current_dir = vim.fs.dirname(current_file)
vim.cmd("source " .. current_dir .. "/my-init.vim")
