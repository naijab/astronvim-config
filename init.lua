local config = {

  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "nightly", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "main", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    -- remotes = { -- easily add new remotes to track
    --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
    --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
    --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    -- },
  },

  -- Set colorscheme
  colorscheme = "catppuccin",

  -- Override highlight groups in any theme
  highlights = {
    -- duskfox = { -- a table of overrides
    --   Normal = { bg = "#000000" },
    -- },
    default_theme = function(highlights) -- or a function that returns one
      local C = require "default_theme.colors"

      highlights.Normal = { fg = C.fg, bg = C.bg }
      return highlights
    end,
  },

  -- set vim options here (vim.<first_key>.<second_key> =  value)
  options = {
    opt = {
      relativenumber = true, -- sets vim.opt.relativenumber
    },
    g = {
      mapleader = " ", -- sets vim.g.mapleader
    },
  },

  -- Default theme configuration
  default_theme = {
    diagnostics_style = { italic = true },
    -- Modify the color table
    colors = {
      fg = "#abb2bf",
    },
    plugins = { -- enable or disable extra plugin highlighting
      aerial = true,
      beacon = false,
      bufferline = true,
      dashboard = true,
      highlighturl = true,
      hop = false,
      indent_blankline = true,
      lightspeed = false,
      ["neo-tree"] = true,
      notify = true,
      ["nvim-tree"] = false,
      ["nvim-web-devicons"] = true,
      rainbow = true,
      symbols_outline = false,
      telescope = true,
      vimwiki = false,
      ["which-key"] = true,
    },
  },

  -- Disable AstroNvim ui features
  ui = {
    nui_input = true,
    telescope_select = true,
  },

  -- Configure plugins
  plugins = {
    -- Add plugins, the packer syntax without the "use"
    init = {
      {
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
          require("catppuccin").setup {}
        end,
      },
      --https://github.com/iamcco/markdown-preview.nvim
      {
        "iamcco/markdown-preview.nvim",
        config = function ()
          vim.fn["mkdp#util#install"]()
        end
      },
      --https://github.com/simrat39/symbols-outline.nvim
      {
        "simrat39/symbols-outline.nvim"
      }
    },
    -- All other entries override the setup() call for default plugins
    ["null-ls"] = function(config)
      local null_ls = require "null-ls"
      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = {
        -- Set a formatter
        null_ls.builtins.formatting.rufo,
        -- Set a linter
        null_ls.builtins.diagnostics.rubocop,
      }
      -- set up null-ls's on_attach function
      config.on_attach = function(client)
        -- NOTE: You can remove this on attach function to disable format on save
        if client.resolved_capabilities.document_formatting then
          vim.api.nvim_create_autocmd("BufWritePre", {
            desc = "Auto format before save",
            pattern = "<buffer>",
            callback = vim.lsp.buf.formatting_sync,
          })
        end
      end
      return config -- return final config table
    end,
    treesitter = {
      ensure_installed = {
        "astro",
        "bash",
        "c",
        "c_sharp",
        "comment",
        "cpp",
        "css",
        "dart",
        "dockerfile",
        "elixir",
        "fish",
        "go",
        "gomod",
        "graphql",
        "html",
        "java",
        "javascript",
        "jsdoc",
        "json",
        "kotlin",
        "lua",
        "markdown",
        "make",
        "prisma",
        "proto",
        "python",
        "regex",
        "ruby",
        "rust",
        "scss",
        "solidity",
        "sql",
        "svelte",
        "toml",
        "tsx",
        "typescript",
        "vue",
        "yaml",
        "zig"
      },
    },
    ["nvim-lsp-installer"] = {
      ensure_installed = {
        --Angular
        "angularls",
        --Astro
        "astro",
        --Bash
        "bashls",
        --C
        "ccls",
        --C#
        "csharp_ls",
        --C++
        "ccls",
        --Cmake
        "cmake",
        --CSS
        "cssls",
        --Cucumber
        "cucumber_language_server",
        --Dart
        "dartls",
        --Deno
        "denols",
        --Docker
        "dockerls",
        --ESLint
        "eslint",
        --Elixir
        "elixirls",
        --F#
        "fsautocomplete",
        --Golang
        "gopls",
        --Grammarly
        "grammarly",
        --GraphQL
        "graphql",
        --HTML
        "html",
        --Haskell
        "hls",
        --Java"
        "jdtls",
        --Json
        "jsonls",
        --Jsonnet
        "jsonnet_ls",
        --Kotlin
        "kotlin_language_server",
        --Lua
        "sumneko_lua",
        --Markdown
        "marksman",
        --Prisma
        "prismals",
        --Python
        "pyright",
        --Ruby
        "solargraph",
        --Rust
        "rust_analyzer",
        --SQL
        "sqlls",
        --Solidity
        "solang",
        --Style Lint
        "stylelint_lsp",
        --Svelte.js
        "svelte",
        --TOML
        "taplo",
        --Tailwindcss
        "tailwindcss",
        --TypeScript / Javascript
        "tsserver",
        --Vue.js
        "volar",
        --XML
        "lemminx",
        --YAML
        "yamlls",
        --Zig
        "zls"
      },
    },
    packer = {
      compile_path = vim.fn.stdpath "data" .. "/packer_compiled.lua",
    },
  },

  -- LuaSnip Options
  luasnip = {
    -- Add paths for including more VS Code style snippets in luasnip
    vscode_snippet_paths = {},
    -- Extend filetypes
    filetype_extend = {
      javascript = { "javascriptreact" },
    },
  },

  -- Modify which-key registration
  ["which-key"] = {
    -- Add bindings
    register_mappings = {
      -- first key is the mode, n == normal mode
      n = {
        -- second key is the prefix, <leader> prefixes
        ["<leader>"] = {
          -- which-key registration table for normal mode, leader prefix
          -- ["N"] = { "<cmd>tabnew<cr>", "New Buffer" },
        },
      },
    },
  },

  -- CMP Source Priorities
  -- modify here the priorities of default cmp sources
  -- higher value == higher priority
  -- The value can also be set to a boolean for disabling default sources:
  -- false == disabled
  -- true == 1000
  cmp = {
    source_priority = {
      nvim_lsp = 1000,
      luasnip = 750,
      buffer = 500,
      path = 250,
    },
  },

  -- Extend LSP configuration
  lsp = {
    -- enable servers that you already have installed without lsp-installer
    servers = {
      -- "pyright"
    },
    -- easily add or disable built in mappings added during LSP attaching
    mappings = {
      n = {
        -- ["<leader>lf"] = false -- disable formatting keymap
      },
    },

    -- Add overrides for LSP server settings, the keys are the name of the server
    ["server-settings"] = {
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({}))
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  mappings = {
    -- first key is the mode
    n = {
      -- second key is the lefthand side of the map
      ["<C-s>"] = { ":w!<cr>", desc = "Save File" },
    },
    t = {
      -- setting a mapping to false will disable it
      -- ["<esc>"] = false,
    },
  },

  -- This function is run last
  -- good place to configuring augroups/autocommands and custom filetypes
  polish = function()
    -- Set key binding
    -- Set autocommands
    vim.api.nvim_create_augroup("packer_conf", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePost", {
      desc = "Sync packer after modifying plugins.lua",
      group = "packer_conf",
      pattern = "plugins.lua",
      command = "source <afile> | PackerSync",
    })
  end,
}

return config
