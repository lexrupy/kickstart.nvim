return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {
    --[[ things you want to change go here]]
  },
  config = function()
    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new { cmd = 'lazygit', hidden = true, direction = 'float' }

    function _lazygit_toggle()
      lazygit:toggle()
    end

    vim.api.nvim_set_keymap('n', '<leader>gg', '<cmd>lua _lazygit_toggle()<CR>',
      { noremap = true, silent = true, desc = 'LazyGit' })
  end,
}
