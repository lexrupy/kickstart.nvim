return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup {

      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Next change' })

        map('n', '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Previous change' })

        -- Actions
        map('n', '<leader>gs', gs.stage_hunk, { desc = 'Stage Hunk' })
        map('n', '<leader>gr', gs.reset_hunk, { desc = 'Reset Hunk' })
        map('v', '<leader>gs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'Stage hunk' })
        map('v', '<leader>gr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'Stage hunk' })
        map('n', '<leader>gS', gs.stage_buffer, { desc = 'Stage buffer' })
        map('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'Undo stage hunk' })
        map('n', '<leader>gR', gs.reset_buffer, { desc = 'Reset buffer' })
        map('n', '<leader>gp', gs.preview_hunk, { desc = 'Preview hunk' })
        map('n', '<leader>gb', function()
          gs.blame_line { full = true }
        end, { desc = 'Blame line' })
        map('n', '<leader>gb', gs.toggle_current_line_blame, { desc = 'Blame' })
        map('n', '<leader>gd', gs.diffthis, { desc = 'Diff' })
        map('n', '<leader>gD', function()
          gs.diffthis '~'
        end, { desc = 'Diff this' })
        map('n', '<leader>gtd', gs.toggle_deleted, { desc = 'Toggle deleted' })

        -- Text object
        map({ 'o', 'x' }, 'gih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select hunk' })
      end,
    }
  end,
}
