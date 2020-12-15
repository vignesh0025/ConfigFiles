-- local lsp_status = require('lsp-status')
-- lsp_status.register_progress()

local nvim_lsp = require('nvim_lsp')

local on_attach_vim = function(client)
    require'diagnostic'.on_attach()
    require'completion'.on_attach()
    -- lsp_status.on_attach(client)
end

local sumneko_attach = function(client)
    require'diagnostic'.on_attach(client)
    require'completion'.on_attach(client)
end

nvim_lsp.pyls.setup({
    on_attach=on_attach_vim,
    -- callbacks = lsp_status.extensions.pyls_ms.setup(),
    settings = { python = { workspaceSymbols = { enabled = true }}},
    -- capabilities = lsp_status.capabilities
    })

nvim_lsp.clangd.setup({
    on_attach=on_attach_vim,
    -- callbacks = lsp_status.extensions.clangd.setup(),
    init_options = {
        clangdFileStatus = true
    },
    -- capabilities = lsp_status.capabilities
})

require'nvim_lsp'.texlab.setup{
    on_attach=on_attach_vim,
}

-- require('nlua.lsp.nvim').setup(nvim_lsp, {on_attach=on_attach_vim})
-- https://github.com/tjdevries/nlua.nvim
-- Look the above URL for more information
nvim_lsp.sumneko_lua.setup({
   enable = true,
   on_attach=sumneko_attach,
   -- See schema here:
   -- https://raw.githubusercontent.com/sumneko/vscode-lua/master/setting/schema.json
   -- Eg here: https://github.com/tjdevries/nlua.nvim/blob/master/lua/nlua/lsp/nvim.lua
   settings = {
      Lua = {
         runtime = {
            version = "LuaJIT",
            path = vim.split(package.path, ";")
         },
         completion = {keywordSnippet = "Disable"},
         diagnostics = {
            enable = true,
            globals = {
               "vim",
               "describe",
               "it",
               "before_each",
               "after_each"
            }
         },
         workspace = {
            library = {
               -- [vim.fn.expand("$VIMRUNTIME/lua")] = true,
               [vim.fn.expand("~/build/neovim/src/nvim/lua")] = true,
            }
         }
      },
   },
})


-- let g.completion_enable_snippet = 'UltiSnips'
-- Eq to vim.api.nvim_set_var('completion_enable_snippet', 'UltiSnips')
vim.g.completion_enable_snippet = 'UltiSnips'

-- let g:diagnostic_enable_virtual_text = 1
vim.g.diagnostic_enable_virtual_text  = 1

-- let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
vim.g.completion_matching_strategy_list  = {'exact', 'substring', 'fuzzy'}

require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",     -- one of "all", "language", or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {"rust" },  -- list of language that will be disabled
  },
}

testfn = function()
   -- vim.api.nvim_buf_get_lines()
end

testfn()

-- a = function()
   -- return lsp_status.status()
-- end

-- call airline#parts#define_function('foo', 'v:lua.a')
-- vim.fn['airline#parts#define_function']('foo', 'v:lua.a')

-- let g:airline_section_y = airline#section#create_right(['ffenc','foo'])
-- vim.g.airline_section_y = vim.fn['airline#section#create_right']({'ffenc','foo'})
