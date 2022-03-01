local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use "kyazdani42/nvim-web-devicons" -- Custom Icons
  use "kyazdani42/nvim-tree.lua" -- FileTree
  use "akinsho/bufferline.nvim" -- Shows the name of files open -- "shift h l" move from left to right
  use "moll/vim-bbye"
  use "nvim-lualine/lualine.nvim" -- The bottom bar for info/ Not sure if it looks correct
  use "akinsho/toggleterm.nvim" -- 'ctl \'  Toggles the terminal
  use "ahmedkhalf/project.nvim" -- Find projects
  use "lewis6991/impatient.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use "goolord/alpha-nvim"   -- Custom Home page
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use "folke/which-key.nvim"    -- Learn Custom key maps
  use { "metakirby5/codi.vim",   --  Scratch-Pad - I need to read on this
          cmd = "Codi",}
  use "folke/lsp-colors.nvim"


  -- Colorschemes
  use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  use "lunarvim/darkplus.nvim" -- The stock colorscheme from Chris
  use "folke/tokyonight.nvim" -- AWESOME THEME
  use "catppuccin/nvim" -- Nice complete themes.
  use "projekt0n/github-nvim-theme" -- Awesome themes with several different looks
  use "rafamadriz/neon" -- Cool neon theme
  use 'glepnir/zephyr-nvim' -- Dark BG / with yellow teal FG

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- Path completions
  use "hrsh7th/cmp-cmdline" -- Cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- Snippet completions
  use "hrsh7th/cmp-nvim-lsp" -- Language Server Protocol
  use "hrsh7th/cmp-nvim-lua"


  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use  {
      "ray-x/lsp_signature.nvim",
      event = "BufRead",
      config = function()
        require "lsp_signature".setup()
      end
      }

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-media-files.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter", --Treesitter does the language highlighting and other things.
    run = ":TSUpdate",
  }
  use "JoosepAlviste/nvim-ts-context-commentstring" -- adding context to treesitter
  use "p00f/nvim-ts-rainbow" -- adding color
  use "nvim-treesitter/playground" -- awesome for looking to see whats inside

  -- Git
  use "lewis6991/gitsigns.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
