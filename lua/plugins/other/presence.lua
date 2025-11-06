-- require("presence").setup({
--   auto_update        = true,
--   neovim_image_text  = "Vim",
--   main_image         = "vim",
--   enable_line_number = false,
--   show_time          = false,
--   workspace_text     = "Working on Project",
--   buttons            = {
--     { label = "GitHub", url = "https://github.com/kipoha" }
--   },
-- })
require("cord").setup({
  build = ":Cord update",
})
