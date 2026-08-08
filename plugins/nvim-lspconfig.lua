return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- 禁用所有 LSP server 默认的 K → hover 绑定
        ["*"] = {
          keys = {
            { "K", false },
          },
        },
        -- ctags-lsp: 指定 ctags 路径，修复 macOS GUI app PATH 继承问题
        ctags_lsp = {
          cmd = { "ctags-lsp", "--ctags-bin", "/opt/homebrew/bin/ctags" },
        },
        -- cspell_ls: 指定 node 路径，修复 macOS GUI app PATH 继承问题
        cspell_ls = {
          cmd = { "/Users/soc/.nvm/versions/node/v22.14.0/bin/node", vim.fn.stdpath("data") .. "/mason/packages/cspell-lsp/node_modules/@vlabo/cspell-lsp/dist/cspell-lsp.js", "--stdio" },
        },
        ruff = {
          enabled = true,
          autostart = true,
          init_options = {
            settings = {
              fixAll = true, -- 启用自动修复
              -- 关键配置：禁用Ruff的Lint 功能
              lint = { enabled = false },
            },
          },
        },
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                diagnosticMode = "openFilesOnly",
              },
            },
          },
        },
      },
    },
  },
}
