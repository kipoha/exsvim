vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.isdirectory(".git") == 1 then
      vim.cmd("Gitsigns toggle_current_line_blame")
    end
  end,
})

