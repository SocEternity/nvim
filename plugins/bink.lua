return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "enter",
        ["<CR>"] = { "fallback" },
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      },
      completion = {
        trigger = {
          -- 进入插入模式立即触发补全请求，预热 LSP
          show_on_insert = true,
          -- 退格回到关键词内时重新触发补全
          show_on_backspace_in_keyword = true,
        },
      },
      sources = {
        providers = {
          -- buffer 即时补全给高分，确保输入 1-2 字符就有反馈
          buffer = {
            name = "Buffer",
            module = "blink.cmp.sources.buffer",
            score_offset = 5,
          },
          path = {
            name = "Path",
            module = "blink.cmp.sources.path",
            score_offset = 3,
            opts = {
              trailing_slash = true,
              label_trailing_slash = true,
              show_hidden = false,
            },
          },
        },
        per_filetype = {
          kitty = { "path", "buffer", "snippets" },
          conf = { "path", "buffer", "snippets" },
        },
      },
    },
  },
}
