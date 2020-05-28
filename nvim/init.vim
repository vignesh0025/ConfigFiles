"Custom {{{
let g:python3_host_prog='/home/vignesh/PY3/bin/python'
" open new split panes to right and below
set splitright
set splitbelow

set noshowmode  " hide the mode (airline will show instead)

set termguicolors  " true color support
set guioptions=  " remove scrollbars, etc

" start scrolling when near the last line/col
set scrolloff=1
set sidescrolloff=5

autocmd FileType python map <buffer> <F5> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F5> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '>-2<CR>gv=gv

nnoremap <leader>o o<esc>k
nnoremap <leader>O O<esc>j

" I'm bad at typing.
:command! Q q
:command! W w
:command! WQ wq
:command! Wq wq

" nav to begin and end of line (rather than buffer) with H/L
nnoremap H ^
nnoremap L $

" Read changes from file system
set autoread

" Got this from https://github.com/neoclide/coc.nvim
set updatetime=300
set shortmess+=c

" Don't pass messages to |ins-completion-menu|.
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Show PUM for wild card menu eg. :e <TAB>
set wildoptions=pum
" }}}

" vim-plug {{{
call plug#begin()

Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'

Plug 'ryanoasis/vim-devicons'
Plug 'unblevable/quick-scope'
Plug 'fedorenchik/qt-support.vim'

" Tmux Navigator
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux'

" syntax highlighting
Plug 'peterhoeg/vim-qml'
Plug 'artoj/qmake-syntax-vim'
Plug 'octol/vim-cpp-enhanced-highlight'

" auto complete
"Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clangd-completer' }
" Plug 'davidhalter/jedi-vim' " Used by YouCompleteMe
" Plug 'ervandew/supertab' " Just Tab Autocompletion

" For using clangd-format with C/CPP
Plug 'chiel92/vim-autoformat'

Plug 'nvie/vim-flake8' " pip install flake8 and <F7> key to check py file
Plug 'SirVer/ultisnips' " snippers are shown for you automatically with [snip]. Use ctrl+y
Plug 'honza/vim-snippets' " Works with ultisnips to provide a list

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'dkprice/vim-easygrep'

" note
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'


" editing
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-repeat'

" better statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" git management plugin
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'bfredl/nvim-ipy'

"Plug 'gabrielelana/vim-markdown'
"Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

Plug 'michaeljsmith/vim-indent-object'

Plug 'jackguo380/vim-lsp-cxx-highlight'

Plug 'vhdirk/vim-cmake'
Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'

"" Remap for do codeAction of selected region
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()
" }}} vim-plug

" Airline {{{
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
" }}}

" QT Console {{{
command! -nargs=0 RunQtConsole call jobstart("jupyter qtconsole --ConsoleWidget.font_size=15 --style solarized-dark --JupyterWidget.include_other_output=True")

let g:ipy_celldef = '^##' " regex for cell start and end

nmap <silent> <leader>jqt :RunQtConsole<Enter>
nmap <silent> <leader>jk :IPython<Space>--existing<Space>--no-window<Enter>
nmap <silent> <leader>jc <Plug>(IPy-RunCell)
nmap <silent> <leader>ja <Plug>(IPy-RunAll)
" }}}

" Cpp Enhanced Highlighting {{{
let g:cpp_class_scope_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
" }}}

" Flake8 {{{
let g:flake8_show_in_gutter=1
let g:flake8_show_in_file=1
" }}}

" COC.NVIM {{{
"if &runtimepath =~? 'plugged/neoclide'
    let g:coc_global_extensions = [
          \'coc-ultisnips',
          \'coc-snippets',
          \'coc-marketplace',
          \'coc-lists',
          \'coc-gitignore',
          \'coc-git',
          \'coc-explorer',
          \'coc-actions',
          \'coc-python',
          \'coc-json',
          \'coc-cmake',
          \'coc-clangd'
          \]

    function! s:cocActionsOpenFromSelected(type) abort
        execute 'CocCommand actions.open ' . a:type
    endfunction
    xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
    nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>
    function! s:show_documentation()
        if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
        else
            call CocAction('doHover')
        endif
    endfunction

    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
                \ pumvisible() ? "\<C-n>" :
                \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
                \ <SID>check_back_space() ? "\<TAB>" :
                \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " <CR> - select the first completion item and confirm the completion when no item has been selected
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    " Highlight the symbol and its references when holding the cursor.
    autocmd! CursorHold * call CocActionAsync('highlight')

    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)

    " Formatting selected code.
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup mygroup
        autocmd!
        " Update signature help on jump placeholder.
        autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Applying codeAction to the selected region.
    " Example: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap keys for applying codeAction to the current line.
    nmap <leader>ac  <Plug>(coc-codeaction)

    " Apply AutoFix to problem on the current line.
    nmap <space>f  <Plug>(coc-fix-current)

    " Map function and class text objects
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)

    " Use CTRL-S for selections ranges.
    " Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
    nmap <silent> <C-s> <Plug>(coc-range-select)
    xmap <silent> <C-s> <Plug>(coc-range-select)

    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')

    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Mappings using CoCList:
    " Show all diagnostics.
    nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions.
    nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    " Install Extensions.
    nnoremap <silent> <space>m  :<C-u>CocList marketplace<cr>
    " Show commands.
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document.
    nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols.
    nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list.
    nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

    " Key-Maps for coc-ultisnips """"""""""""""""""""""""""""""""""""
    " ***** <C-j> ******** is the right place for everything
    " Use <C-l> for trigger snippet expand.
    " imap <C-l> <Plug>(coc-snippets-expand)

    " <C-j> is the right place for everything
    " Use <C-j> for select text for visual placeholder of snippet.
    " vmap <C-j> <Plug>(coc-snippets-select)

    " Use <C-j> for jump to next placeholder, it's default of coc.nvim
    let g:coc_snippet_next = '<c-l>'

    " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
    let g:coc_snippet_prev = '<c-h>'

    " Use <C-j> for both expand and jump (make expand higher priority.)
    "imap <C-j> <Plug>(coc-snippets-expand-jump)
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    " coc-explorer
    nmap <C-n> :CocCommand explorer<CR>

"endif
" }}}

" UltiSnips {{{
let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
let g:UltiSnipsListSnippets        = "<c-k>" "List possible snippets based on current file
let g:UltiSnipsUsePythonVersion = 3
" }}}

" FZF {{{
let g:rg_command = 'rg --vimgrep -S'
" Make FZF use rg. THis makes it extremely fast
let $FZF_DEFAULT_COMMAND = 'rg -l --smart-case ""'

" THis is for :Rg command
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --colors "path:fg:190,220,255" --colors "line:fg:128,128,128" --smart-case '.shellescape(<q-args>), 1, { 'options': '--color hl:123,hl+:222' }, 0)

"
if &runtimepath =~? 'fzf.vim'
    augroup hide_fzf_statusline
        autocmd! FileType fzf
        autocmd  FileType fzf set laststatus=0 noruler
                    \| autocmd BufLeave <buffer> set laststatus=2 ruler
    augroup END

    " Jump to existing window if possible
    let g:fzf_buffers_jump = 1

    nnoremap <c-p> :Files<CR>
    let g:fzf_action = {
                \ 'ctrl-t': 'tab split',
                \ 'ctrl-s': 'split',
                \ 'ctrl-v': 'vsplit'
                \}

    " mappings
    " nnoremap <C-f> :BLines<CR>
    nnoremap <C-b> :Buffers<CR>
    nnoremap <C-c> :Commands<CR>

    " don't highlight the current line and selection column
    let g:fzf_colors = {'bg+': ['bg', 'Normal']}
endif
" }}}

" {{{ colorscheme
if &runtimepath =~? 'plugged/gruvbox'
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    syntax enable                " enable syntax processing
    set background=dark

    let g:gruvbox_italic = 1
    let g:gruvbox_sign_column='bg0'
    let g:airline_theme='gruvbox'

    colorscheme gruvbox  " must come after gruvbox_italic

    " match the fold column colors to the line number column
    " must come after colorscheme gruvbox
    highlight clear FoldColumn
    highlight! link FoldColumn LineNr
endif
" }}}

" Spaces & Tabs {{{
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line
" }}} Spaces & Tabs

" Clipboard {{{
set clipboard+=unnamedplus
" }}}

" UI Config {{{
set hidden
set number                   " show line number
set showcmd                  " show command in bottom bar
set cursorline               " highlight current line
set wildmenu                 " visual autocomplete for command menu
set wildignore=".git/*,.clangd/*"
set showmatch                " highlight matching brace
set laststatus=2             " window will always have a status line
set nobackup
set noswapfile

" For Plugin Quick Scope
" Trigger a highlight in the appropriate direction when pressing these keys:

" let &colorcolumn="80,".join(range(119,999),",")
" }}}

" Search {{{
set incsearch       " search as characters are entered
set nohlsearch        " highlight matches
set ignorecase      " ignore case when searching
set smartcase       " ignore case if search pattern is lower case
" case-sensitive otherwise

" fix italics with tmux
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

" faster exiting from insert mode (-noremap to allow for abbrevs to work)
imap jj <Esc>

"-------------------------------- Navigation ---------------------------------"
set mouse=a  " let the mouse wheel scroll page, etc

" set Rg as the grep command
if executable('rg')
    " Note we extract the column as well as the file and line number
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
    "set grepformat=%f:%l:%c%m
endif
" }}}

" Folding {{{
set foldenable
set foldlevelstart=10  " default folding level when buffer is opened
set foldnestmax=10     " maximum nested fold
set foldmethod=syntax  " fold based on indentation
" }}} Folding

" Leader & Mappings {{{
let mapleader=","   " leader is comma

" edit/reload vimrc
nmap <leader>ev :e $MYVIMRC<CR>
nmap <leader>sv :so $MYVIMRC<CR>

nmap <leader>et :e ~/.tmux.conf<CR>
nmap <leader>ez :e ~/.zshrc<CR>

" better ESC
inoremap jj <esc>

" fast save and close
nmap <leader>w :w<CR>
nmap <leader>x :x<CR>
nmap <leader>q :q<CR>
nnoremap <leader>Q :only<CR>

" move up/down consider wrapped lines
nnoremap j gj
nnoremap k gk

" fix indentation for entire file which we usually do
nnoremap <leader>i mzgg=G`z<CR>

" turn off search highlights
nnoremap <leader><space> :nohlsearch<CR>

" move through grep results
" nmap <silent> <right> :cnext<CR>
" nmap <silent> <left> :cprev<CR>

" buffers
nnoremap <tab> :bn<CR>
nnoremap <s-tab> :bp<CR>
nnoremap <leader>bd :bd<CR>

" Buffer navigation
nnoremap <F3> :buffers<CR>:buffer<Space>
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>



" split navigation
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>
nnoremap <c-h> <c-w><c-h>

" Fast header source switch
" https://stackoverflow.com/questions/6639863/vim-split-unless-open
" This is one of the most interesting vim mapping. It opens the header/src
" in new split if not open or if open, switches it it automatically
function! MySplit( fname )
    let bufnum=bufnr(expand(a:fname))
    let winnum=bufwinnr(bufnum)
    if winnum != -1
        " Jump to existing split
        exe winnum . "wincmd w"
    else
        " Make new split as usual
        exe "vsplit " . a:fname
    endif
endfunction
" map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
command! -nargs=1 VSplit :call MySplit("<args>")
map <F4> :VSplit %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
"cabbrev split Split

" turn terminal to normal mode with escape
" tnoremap <Esc> <C-\><C-n>

" Inbuild Terminal
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

" open terminal on ctrl+;
" uses zsh instead of bash
function! OpenTerminal()
  split term://zsh
  resize 10
endfunction

nnoremap <c-\> :call OpenTerminal()<CR>

" }}}

" NERDTree mappings {{{
" map <C-n> :NERDTreeToggle<CR>
" let NERDTreeShowHidden=1
" let NERDTreeIgnore = ['\.pyc$', '__pycache__']
" }}}

" Clang-format Auto save {{{
" Use clang-format -style=google -dump-config > .clang-format to dump config
" (NOTE: Other styles such as llv, firefox, firefox and all exist. check its
" documentation)

" autocmd FileType *.h,*.cc,*.cpp nnoremap <leader>i :Autoformat<CR>
" autocmd FileType *.h,*.cc,*.cpp vnoremap <leader>i :Autoformat<CR>
" autocmd FileType *.h,*.cc,*.cpp nnoremap == v$:Autoformat<CR>
" autocmd FileType *.h,*.cc,*.cpp vnoremap = :echo "test"<CR>

" " Set the default format tools
autocmd FileType cpp set formatprg=clang-format
autocmd FileType cmake set formatprg=clang-format

"autocmd FileType *.h,*.cc,*.cpp vnoremap = :Autoformat<CR>

" }}}

" Functions {{{
" trailing whitespace
match ErrorMsg '\s\+$'
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction
autocmd BufWritePre * :call TrimWhiteSpace()
" }}}
