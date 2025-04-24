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
      require('lualine').setup { theme = require('lualine.themes._tokyonight').get() }
    end,
  },
}
