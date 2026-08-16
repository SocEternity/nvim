-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- be like
-- keymap.set("mode","ur_keymap", "command", {desc = "注释"})

-- <leader>键位改为空格键
vim.g.mapleader = " "

local keymap = vim.keymap

-- ---------- 插入模式 ---------- ---
-- 连续摁`jk`退出插入模式
-- keymap.set("i", "jk", "<ESC>")
keymap.set("i", "jk", "<Esc>")
-- 终端模式同样用 jk 退出
keymap.set("t", "jk", "<C-\\><C-n>")

-- Cmd+V 粘贴（系统剪贴板）
keymap.set("i", "<D-v>", '<C-o>"+p', { desc = "粘贴" })

-- ---------- 视觉模式 ---------- ---
-- 单行或多行移动
-- keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Cmd+V 从系统剪贴板粘贴
keymap.set("n", "<D-v>", '"+p', { desc = "粘贴" })

-- Cmd+C 复制到系统剪贴板
keymap.set("v", "<D-c>", '"+y', { desc = "复制" })

-- ---------- 正常模式 ---------- ---
-- cw 改为 ciw：光标在单词任意位置都能改写整个单词
keymap.set("n", "cw", "ciw", { desc = "改写整个单词" })

-- J / K 向下/上滚动 10 行
keymap.set("n", "J", "10j", { desc = "向下移动10行" })

-- K：全局映射 + 每个 LSP buffer 里强制覆盖 hover
keymap.set("n", "K", "10k", { desc = "向上移动10行" })
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.keymap.set("n", "K", "10k", { buffer = args.buf, desc = "向上移动10行" })
  end,
})

-- 窗口
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "水平新增窗口" }) -- 水平新增窗口
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "垂直新增窗口" }) -- 垂直新增窗口

-- 字符串搜索后的取消高亮
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "字符串搜索后的取消高亮" })

-- 拷贝路径到系统剪贴板
keymap.set("n", "<leader>yf", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("📋 " .. path)
end, { desc = "拷贝当前文件路径" })

keymap.set("n", "<leader>yp", function()
  local dir = vim.fn.expand("%:p:h")
  vim.fn.setreg("+", dir)
  vim.notify("📋 " .. dir)
end, { desc = "拷贝当前文件夹路径" })

-- ---------- undo keymaps ---------- ---
-- keymap.del("n", "<leader>-") -- 取消分屏键

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

-- ---------- 插件 ---------- ---
keymap.set("n", "<D>h", "<C-w>h", { desc = "焦点移到左侧文件树" })
keymap.set("n", "<D>l", "<C-w>l", { desc = "焦点移到右侧Outline" })

-- Twilight
keymap.set("n", "<leader>tw", ":Twilight<CR>", { desc = "开启Twilight专注模式" })

-- yazi
-- k ymap.set("n", "<leader>yi", "<cmd>Yazi<cr>", { desc = "在当前文件中打开yazi" })
-- keymap.set("v", "<leader>yi", "<cmd>Yazi<cr>", { desc = "在当前文件中打开yazi" })
keymap.set("n", "<leader>ya", "<cmd>Yazi cwd<cr>", { desc = "打开nvim工作目录中的文件管理器" })
keymap.set("n", "<leader>yz", "<cmd>Yazi toggle<cr>", { desc = "继续上次yazi会话" })

-- markdownperview
keymap.set("n", "<leader>mm", ":MarkdownPreview<CR>", { desc = "开启Markdown预览" })
keymap.set("n", "<leader>ms", ":MarkdownPreviewStop<CR>", { desc = "关闭Markdown预览" })
keymap.set("n", "<leader>mt", ":MarkdownPreviewToggle<CR>", { desc = "切换Markdown预览" })

-- gf (goto file): 打开光标下的引用文件
-- 内置: gf=当前窗口, <C-w>gf=新标签
keymap.set("n", "<leader>gf", "<C-w>gf", { desc = "新标签打开引用文件" })

-- 浮动终端（桌面中央，用于调试）
keymap.set("n", "<leader>tt", function()
  local term, created = Snacks.terminal.get(nil, {
    win = {
      position = "float",
      width = 0.8,
      height = 0.8,
      row = 0.1,
      col = 0.1,
      enter = true,
      backdrop = false,
      wo = { winblend = 14 },
    },
  })
  if created then
    vim.schedule(function()
      vim.wo[term.win].winblend = 10
      term:focus()
    end)
  else
    term:toggle()
    if term:valid() then
      term:focus()
    end
  end
end, { desc = "切换调试终端（桌面中央）" })
