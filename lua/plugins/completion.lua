return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "default",
      -- Add Enter to accept the currently selected completion item
      ["<Tab>"] = { "accept", "fallback" },
    },
  },
}
