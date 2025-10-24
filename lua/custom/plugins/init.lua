-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      local extensions = require 'harpoon.extensions'
      harpoon:setup {}
      harpoon:extend(extensions.builtins.command_on_nav 'normal! zt')

      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end)
      vim.keymap.set('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      vim.keymap.set('n', '<C-j>', function()
        harpoon:list():select(1)
      end)
      vim.keymap.set('n', '<C-f>', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '<C-h>', function()
        harpoon:list():select(3)
      end)
      vim.keymap.set('n', '<C-g>', function()
        harpoon:list():select(4)
      end)
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
    config = function()
      require('ibl').setup()
    end,
  },
  -- {
  --   'copilotlsp-nvim/copilot-lsp',
  --   init = function()
  --     vim.g.copilot_nes_debounce = 500
  --     vim.lsp.enable 'copilot'
  --     vim.keymap.set('n', '<tab>', function()
  --       require('copilot-lsp.nes').apply_pending_nes()
  --     end)
  --   end,
  -- },
  {
    'folke/trouble.nvim',
    -- for default options, refer to the configuration section for custom setup.
    config = function()
      local trouble = require 'trouble'
      trouble.setup { focus = true }
      vim.keymap.set('n', '<leader>tc', function()
        -- Get all items from Trouble
        local items = trouble.get_items()

        -- Convert to quickfix format
        local qf_items = {}
        for _, item in ipairs(items) do
          table.insert(qf_items, {
            filename = item.filename,
            lnum = item.lnum,
            col = item.col,
            text = item.text,
            buf = item.buf,
          })
        end
        trouble.close()

        -- Set quickfix list
        vim.fn.setqflist(qf_items)
        vim.cmd [[botright copen]]
      end)
    end,
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        theme = require('lualine.themes._tokyonight').get(),
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { { 'filename', path = 1 } },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        winbar = {
          lualine_c = {
            {
              'navic',
              color_correction = 'dynamic',
              navic_opts = nil,
              draw_empty = true,
            },
          },
        },
        inactive_winbar = {
          lualine_c = {
            {
              'navic',
              color_correction = 'dynamic',
              navic_opts = nil,
              draw_empty = true,
            },
          },
        },
      }
    end,
  },
  {
    'SmiteshP/nvim-navic',
    requires = 'neovim/nvim-lspconfig',
    opts = { highlight = true },
  },
  {
    'supermaven-inc/supermaven-nvim',
    config = function()
      require('supermaven-nvim').setup {
        keymaps = {
          accept_word = '<C-l>',
        },
        condition = function()
          local filename = vim.fn.expand '%:t'
          if filename:match '.env$' then
            return true
          end
          return false
        end,
      }
    end,
  },
  {
    'mistweaverco/kulala.nvim',
    opts = {
      global_keymaps = true,
      ui = {
        split_direction = 'horizontal',
      },
    },
  },
  {
    'lervag/vimtex',
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = 'sioyek'
    end,
  },
  {
    'let-def/texpresso.vim',
  },
  {
    'Vigemus/iron.nvim',
    config = function()
      local iron = require 'iron.core'
      iron.setup {
        config = {
          -- Whether a repl should be discarded or not
          scratch_repl = true,
          -- Your repl definitions come here
          repl_definition = {
            R = {
              -- Can be a table or a function that
              -- returns a table (see below)
              command = { 'R' },
            },
            r = {
              -- Can be a table or a function that
              -- returns a table (see below)
              command = { 'R' },
            },
            quarto = {
              command = { 'R' },
            },
          },
          -- How the repl window will be displayed
          -- See below for more information
          repl_open_cmd = require('iron.view').split.vertical.botright '40%',
        },
        -- iron doesn't set keymaps by default anymore.
        -- You can set them here or manually add keymaps to the functions in iron.core
        keymaps = {
          send_motion = '<localleader>R',
          visual_send = '<localleader>r<cr>',
          send_file = '<localleader>rf<cr>',
          send_line = '<localleader>rl',
          send_paragraph = '<localleader>rp',
          send_until_cursor = '<localleader>rU<cr>',
          -- send_mark = "<localleader>rm",
          -- mark_motion = "<localleader>mc",
          -- mark_visual = "<localleader>mc",
          -- remove_mark = "<localleader>md",
          cr = '<localleader>rA<cr>',
          interrupt = '<localleader>r<space>',
          exit = '<localleader>rQ',
          clear = '<localleader>rC',
        },
        -- If the highlight is on, you can change how it looks
        -- For the available options, check nvim_set_hl
        highlight = false,
        ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
      }

      -- iron also has a list of commands, see :h iron-commands for all available commands
      vim.keymap.set('n', '<localleader>rS', '<cmd>IronRepl<cr>', { desc = '[R]EPL [S]tart' })
      vim.keymap.set('n', '<localleader>rR', '<cmd>IronRestart<cr>', { desc = '[R]EPL [R]estart' })
      vim.keymap.set('n', '<localleader>rF', '<cmd>IronFocus<cr>', { desc = '[R]EPL [F]ocus' })
      vim.keymap.set('n', '<localleader>rH', '<cmd>IronHide<cr>', { desc = '[R]EPL [H]ide' })
    end,
  },
}
