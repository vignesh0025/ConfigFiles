lua << EOF
    a = require("vd-plugin")
EOF

function! ChangeTheme() abort
  lua for k in pairs(package.loaded) do if k:match('vd%-plugin') then package.loaded[k] = nil end end
  lua a.init()
endfunction

function! Check() abort
  lua for k in pairs(package.loaded) do if k:match('vd%-plugin') then package.loaded[k] = nil end end
endfunction

noremap <silent> <F5> :call ChangeTheme()<CR>
