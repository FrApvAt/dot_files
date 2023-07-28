#!/usr/bin/env lua

-- Plugin manager (Lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


-- Plug-ins
require("lazy").setup({
	{
	-- LSP
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspLog" },
    event = { "BufRead" },
    --[[
    config = function()
      require "user.config.lsp.setup"
    end,
    ]]
	  },
      {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall" },
    event = { "WinNew", "WinLeave", "BufRead" },
    --[[
    config = function()
      require "user.config.mason"
    end,
    ]]
  },
  { "williamboman/mason-lspconfig.nvim" },

    -- completion
  { "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "<CurrentMajor>.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp" ,
	requires = { "luasnip-snippets", }
  },

  { "saadparwaiz1/cmp_luasnip" },
  { "molleweide/luasnip-snippets.nvim" },

  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-cmdline"},
  { "hrsh7th/cmp-path" },

  {'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
    },

    --REPL
  { 'milanglacier/yarepl.nvim', config = true },

  --color
  { "folke/tokyonight.nvim", lazy = false,
  priority = 1000, opts = {},},

  -- { "rktjmp/lush.nvim" }, -- required by zenbones
  -- { "mcchrish/zenbones.nvim" }

  --etc
  { "nvim-tree/nvim-web-devicons", opt = true }, -- requred by lualine
  { "nvim-lualine/lualine.nvim" },

  {"kdheepak/tabline.nvim"},

  { "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate", },

  -- { "iamcco/markdown-preview.nvim" } gui required

  { "Pocco81/auto-save.nvim",
	config = function()
		 require("auto-save").setup {
			-- your config goes here
			-- or just leave it empty :)
			debounce_delay = 1350,
		 }
	end,
 }

})


-- Options
-- vim.o.helplang = 'ja,en'
vim.o.helplang = 'en'
-- vim.o.number = true
vim.o.title = true
vim.o.showmatch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.wrapscan = true
vim.o.splitright = true
vim.o.termguicolors = true
vim.o.hidden = true
vim.o.updatetime = 300
vim.bo.expandtab = true
vim.bo.autoindent = true
vim.bo.smartindent = true
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.autoread = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes'
vim.wo.cursorline = true
vim.cmd 'set clipboard+=unnamedplus'

-- color
require("tokyonight").setup({
         style = "moon",
         styles = {
             comments = { italic = false }, 
         },
 })
vim.cmd [[colorscheme tokyonight]]
-- vim.cmd "colorscheme tokyobones"
-- vim.cmd "colorscheme onehalfdark"

-- Keybindings
vim.g.mapleader = ','

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

vim.keymap.set("i", "<C-S>", "<C-D>")
vim.keymap.set("i", "<C-A>", "<Home>")
vim.keymap.set("i", "<C-E>", "<End>")
vim.keymap.set("i", "<C-D>", "<Del>")
vim.keymap.set("i", "<C-B>", "<Left>")
vim.keymap.set("i", "<C-F>", "<Right>")
vim.keymap.set("i", "<C-K>", "<C-O>D")


-- vim.o.cedit = "<C-O>" I have no idea how to do it
vim.cmd 'set cedit=<C-O>'
vim.keymap.set("c", "<C-S>", "<C-D>")
vim.keymap.set("c", "<C-A>", "<Home>")
vim.keymap.set("c", "<C-E>", "<End>")
vim.keymap.set("c", "<C-D>", "<Del>")
vim.keymap.set("c", "<C-B>", "<Left>")
vim.keymap.set("c", "<C-F>", "<Right>")
-- vim.keymap.set("c", "<C-K>", "<Esc>lC")
vim.keymap.set("c", "<C-K>", "<C-\\>e(strpart(getcmdline(), 0, getcmdpos() - 1))<CR>")

vim.keymap.set("n", "\\", ",")
vim.keymap.set("n", "Y", "y$")
vim.keymap.set("n", "b", "<C-B>")
vim.keymap.set("n", "<C-B>", "b")
vim.keymap.set("n", "<Space>", "<C-F>")
vim.keymap.set("n", "]b", ":bnext<CR>")
vim.keymap.set("n", "[b", ":bprevious<CR>")
vim.keymap.set("n", "<C-:>", "")
--- keymaps for yarepl
vim.keymap.set("n", "<Leader>s", ":REPLSendMotion<CR>}") -- send paragraph to rpel

-- autocmd
vim.api.nvim_create_autocmd('TermOpen', {
	command = "startinsert"
})


--etc
require('lualine').setup()
require('tabline').setup()
require('nvim-treesitter.configs').setup({
--  auto_install = true, --230727 auto_install was disabled because of autocmd error
  highlight = {
    enable = true,
  },
})

-- lsp
-- require'lspconfig'.pyright.setup{}

-- lsp-config
-- Setup language servers.
local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}
lspconfig.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
    ['Lua'] = { diagnostics = { globals = {'vim'} } },
  },
}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<Leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<Leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<Leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- mason
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers {
  function (server_name)
    require("lspconfig")[server_name].setup {
      on_attach = on_attach
    }
  end,
}


-- 補完

-- lspのハンドラーに設定
capabilities = require("cmp_nvim_lsp").default_capabilities()

-- lspの設定後に追加
vim.opt.completeopt = "menu,menuone,noselect"

local luasnip = require "luasnip"
local cmp = require"cmp"
cmp.setup({
  snippet = {
    expand = function(args)
        require'luasnip'.lsp_expand(args.body)
        -- vim.fn["vsnip#anonymous"](args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-I>"] = cmp.mapping(function(fallback)
	        if cmp.visible() then
			cmp.select_next_item()
		elseif luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		elseif has_words_before() then
			cmp.complete()
		else
			fallback()
		end
	end, { "i", "s" } ),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  })
})



-- yarepl
require('yarepl').setup{

    wincmd = 'vertical 80 split'
}



-- snipets
-- require("luasnip.loaders.from_snipmate").load({ include = { "c" } }) -- Load only python snippets
return function()

    -- local luasnip = require("luasnip")

    -- be sure to load this first since it overwrites the snippets table.
    luasnip.snippets = require("luasnip-snippets").load_snippets()

end
