-- base
require("core.options")
require("core.main")
require("core.lazy.config")
require("core.keymap.main")


-- theme
require("core.theme")


-- config
require("plugins.tools.nvim-tree")
require("plugins.tools.git")
require("plugins.tools.windsurf")
require("plugins.tools.buffeline")
require("plugins.tools.indent")
require("plugins.tools.lualine")
require("plugins.tools.telescope")
require("plugins.tools.comment")
require("plugins.tools.treesitter")


-- lsp
require("plugins.lsp.config")
require("plugins.lsp.languages")


-- other config
require("plugins.other.presence")
require("plugins.other.mason")
require("plugins.other.dashboard")
