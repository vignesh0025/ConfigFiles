function! Test() abort
lua << EOF
    for k in pairs(package.loaded) do if string.match(k, 'my.plugin') then package.loaded[k] = nil end end
    require('my-plugin')()
EOF
endfunction

function! Start() abort
new
augroup Start
    autocmd!
    autocmd BufUnload <buffer> echom "test"
    autocmd BufDelete <buffer> echom "BufDelete"
    autocmd BufWipeout <buffer> echom "BufWipeout"
augroup END
" bd!
bwipeout
endfunction

nmap <F6> :call Start()<CR>
