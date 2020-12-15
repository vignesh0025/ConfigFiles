require('telescope').setup{}

-- TODO: Look into documentation and more changes and keymaps are possible
local result = vim.api.nvim_exec(
[[
nnoremap <C-n> <cmd>lua require'telescope.builtin'.find_files{}<CR>
]],
true)

-- let mytext = 'hello world'

-- function! MyFunction(text)
--     echo a:text
-- endfunction

-- call MyFunction(mytext)

-- print(result)
