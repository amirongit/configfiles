call plug#begin('~/.vim/plugged')
Plug 'maralla/completor.vim'
Plug 'dense-analysis/ale'
Plug 'ap/vim-css-color'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'wincent/terminus'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'chriskempson/base16-vim'
Plug 'jaredgorski/spacecamp'
Plug 'nanotech/jellybeans.vim'
call plug#end()

" ALE
" disable sign colors
highlight clear ALEErrorSign
highlight clear ALEWarningSign
" functions
" warnings in statusbar
function! LinterStatus() abort
    let l:counts=ale#statusline#Count(bufnr(''))
    let l:all_errors=l:counts.error + l:counts.style_error
    let l:all_non_errors=l:counts.total - l:all_errors
    return l:counts.total == 0 ? '[0W 0E]' : printf(
    \   '[%dW %dE]',
    \   all_non_errors,
    \   all_errors
    \)
endfunction
" variables
" disable ale on vim start
let g:ale_lint_on_enter=0
" linters
let g:ale_linters={'python': ['pycodestyle'], 'javascript': ['eslint']}
" ALE fix options
let g:ale_fixers={'*': ['remove_trailing_lines', 'trim_whitespace']}
" apply ALE fixers when saving a file
let g:ale_fix_on_save=1
" error sign
let g:ale_sign_error='!'
" warning sign
let g:ale_sign_warning='?'
" message format
let g:ale_echo_msg_format='[%linter%] %s [%severity%]'
" enable linting while typing
let g:ale_lint_on_text_changed=1

" GITGUTTER
" reduce updatetime
set updatetime=100
" functions
" modified, removed or added lines in statusbar
function! GitStatus()
    let [a,m,r]=GitGutterGetHunkSummary()
    return printf('[+%d ~%d -%d]', a, m, r)
endfunction
" variables
" add sign for git gutter
let g:gitgutter_sign_added='+'
" modified sign for git gutter
let g:gitgutter_sign_modified='~'
let g:gitgutter_sign_modified_removed='~'
" removed sign for gitgutter
let g:gitgutter_sign_removed='-'
let g:gitgutter_sign_removed_first_line='-'
" disable git gutter key maps
let g:gitgutter_map_keys=0
" avoid git gutter to change sign column bg colors
let g:gitgutter_set_sign_backgrounds=1

" COMPLETOR
" open preview windows in bottom
set splitbelow
" variables
" node with tern installed
let g:completor_node_binary='/usr/bin/node'
" python interpreter with jedi installed on it
let g:completor_python_binary='/usr/bin/python'
" path to clang binary
let g:completor_clang_binary='/usr/bin/clang'
" completor options
let g:completor_complete_options='menuone,noselect,preview'
"
let g:completor_def_split='tab'
" keymaps
" docstring or docs for a function
noremap  <leader>doc  :call completor#do('doc')<CR>
" jump to defenition of a function
nnoremap <leader>def  :call completor#do('definition')<CR>
" moving between auto completion suggestions with Tab and Shift Tab
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" TERMINUS
" variables
" disable cursor shape changing in modes (Terminus)
let g:TerminusCursorShape=0

" INDENTLINE
" variables
" indent guid char
let g:indentLine_char='┆'
" enable showing leading spaces
" let g:indentLine_leadingSpaceEnabled=1
" leading spaces char
" let g:indentLine_leadingSpaceChar='·'
" toggle indentline
nnoremap <leader>ind  :IndentLinesToggle<CR>

" FZF.VIM
" keymaps
" recently opened files
nnoremap <leader>his  :History!<CR>
" files tracking by git
nnoremap <leader>gfi  :GFiles!<CR>
" git status
nnoremap <leader>sta  :GFiles!?<CR>
" lines of all buffers
nnoremap <leader>lin  :Lines!<CR>
" tags
nnoremap <leader>tag  :Tags!<CR>
" commits
nnoremap <leader>com  :Commits!<CR>

" GLOBAL
" keymaps
" swap selected lines above or under
xnoremap K          :move '<-2<CR>gv-gv
xnoremap J          :move '>+1<CR>gv-gv
" resize windows
nnoremap <Down>   :resize +2<CR>
nnoremap <Up>     :resize -2<CR>
nnoremap <Left>   :vertical resize +2<CR>
nnoremap <Right>  :vertical resize -2<CR>
" disable these keys
nnoremap q          <NOP>
nnoremap Q          <NOP>
nnoremap J          <NOP>
nnoremap K          <NOP>
" move to left or right tab
nnoremap H          gT
nnoremap L          gt
" toggle rtl mode
nnoremap <leader>rtl  :set rl!<CR>
" file explorer in horizental split
nnoremap <leader>sex  :Sexplore<CR>
" file explorer in vertical split
nnoremap <leader>vex  :Vexplore<CR>
" file explorer in new tab
nnoremap <leader>tex  :Texplore<CR>
" file explorer in active window
nnoremap <leader>exp  :Explore<CR>
" opened files history
nnoremap <leader>pas  :set paste<CR>
" toggle searching highlight
nnoremap <leader>hls  :set hlsearch!<CR>
" execute active buffer code
autocmd FileType python map <buffer> <leader>run  :w<CR>:exec '!clear; /usr/bin/time -f "\n\%C : \%e" python' shellescape(@%, 1)<cr>
autocmd FileType javascript map <buffer> <leader>run  :w<CR>:exec '!clear; /usr/bin/time -f "\n\%C : \%e" node' shellescape(@%, 1)<cr>
autocmd FileType sh map <buffer> <leader>run  :w<CR>:exec '!clear; /usr/bin/time -f "\n\%C : \%e" bash' shellescape(@%, 1)<cr>
" options
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
set noswapfile
" encoding method
set encoding=utf-8
" force vim to use 256 based colors
set t_Co=256
" enable code folding
set foldmethod=indent
" set vim to fold only 2 levels of indents
" set foldnestmax=2
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
" colors
" enable syntax highlighting
syntax on
" necessery for base256 colorschemes
let base16colorspace=256
" setting colorscheme
colorscheme jellybeans
" same bg color for gutter
highlight SignColumn ctermbg=bg
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
" call LinterStatus func
set statusline +=%{LinterStatus()}
" call GitStatus func
set statusline +=%{GitStatus()}
