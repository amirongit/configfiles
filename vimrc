call plug#begin('~/.vim/plugged')
Plug 'chriskempson/base16-vim'
Plug 'jaredgorski/spacecamp'
Plug 'nanotech/jellybeans.vim'
Plug 'mhinz/vim-startify'
call plug#end()


" STARTIFY
" functions
" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction
" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction
" variables
" custom ascii art for header
let g:ascii = [
      \ '            __',
      \ '    .--.--.|__|.--------.',
      \ '    |  |  ||  ||        |',
      \ '     \___/ |__||__|__|__|',
      \ '    '
      \]
" custom header
let g:startify_custom_header = g:ascii
" startify appearance
let g:startify_lists = [
        \ { 'type': 'files',     'header': ['    Most Recent Files']            },
        \ { 'type': 'dir',       'header': ['    Most Recent Files in '. getcwd()] },
        \ { 'type': function('s:gitModified'),  'header': ['    Modified Files In Git Repo']},
        \ { 'type': function('s:gitUntracked'), 'header': ['    Untracked Files In Git Repo']},
        \ ]
" limt number of files shown
let g:startify_files_number=5

" GLOBAL
" keymaps
" swap selected lines above or under
xnoremap <silent>K          :move '<-2<CR>gv-gv
xnoremap <silent>J          :move '>+1<CR>gv-gv
" resize windows
nnoremap <silent><Down>   :resize +2<CR>
nnoremap <silent><Up>     :resize -2<CR>
nnoremap <silent><Left>   :vertical resize +2<CR>
nnoremap <silent><Right>  :vertical resize -2<CR>
" disable these keys
nnoremap Q          <NOP>
nnoremap J          <NOP>
nnoremap K          <NOP>
" move to left or right tab
nnoremap H          gT
nnoremap L          gt
" toggle rtl mode
nnoremap <silent><leader>rtl  :set rl!<CR>
" open a terminal tab
nnoremap <silent><leader>ter  :tab term<CR>
" file explorer in horizental split
nnoremap <silent><leader>sex  :Sexplore<CR>
" file explorer in vertical split
nnoremap <silent><leader>vex  :Vexplore<CR>
" file explorer in new tab
nnoremap <silent><leader>tex  :Texplore<CR>
" file explorer in active window
nnoremap <silent><leader>exp  :Explore<CR>
" opened files history
nnoremap <silent><leader>pas  :set paste<CR>
" toggle searching highlight
nnoremap <silent><leader>hls  :set hlsearch!<CR>
" execute active buffer code
autocmd FileType python map <buffer> <leader>run  :w<CR>:exec '!clear && python' shellescape(@%, 1)<CR>
autocmd FileType javascript map <buffer> <leader>run  :w<CR>:exec '!clear && node' shellescape(@%, 1)<CR>
" options
" display EOL
set listchars=eol:$,trail:⋅
set list
" relative line numbers
set number relativenumber
" always show the 3 lines bottom of cursor
set scrolloff=3
" activate vim options
set nocp
" set soft tabs to be 4 spaces
set tabstop=4
" convert my tabs to spaces
set expandtab
" I am once again asking for my tabs to be 4 spaces
set softtabstop=4
" set indents to be 4 spaces
set shiftwidth=4
" this is required by some colorschemes to be dark
set background=dark
" ignore case sensetivity when searching
set ignorecase
" highlight when I start searching
set incsearch
" Avoid swap files
" set noswapfile
" encoding method
set encoding=utf-8
" force vim to use 256 based colors
set t_Co=256
" enable code folding
set foldmethod=indent
" disable folding when I open vim
set nofoldenable
" force status bar to show
set laststatus=2
"disable menu bar
set guioptions-=m
"disable toolbar
set guioptions-=T
"disable scrollbar
set guioptions-=r
" make SignColumn visible
set signcolumn=yes
" colors
" enable syntax highlighting
syntax on
" necessery for base256 colorschemes
" let base16colorspace=256
" setting colorscheme
colorscheme jellybeans
" same bg color for gutter
highlight clear SignColumn
highlight clear LineNr
" when openning a file, go to the same line where I left
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif


" STATUSBAR
" so $VIMRUNTIME/syntax/hitest.vim
" run above command and choose a color from the generated file
set statusline +=%#String#
" mode
set statusline +=\[%{mode()}]
" file path
set statusline +=\[%F]
" readonly flag
set statusline +=\%r
" modified flag
set statusline +=\%m
" second half (right side)
set statusline +=%=
" second half color
set statusline +=%#Title#
" column number
set statusline +=\[%v]
" file type
set statusline +=\[%Y]
