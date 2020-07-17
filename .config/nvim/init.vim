" *******************************
" PLUGINS ***********************
" *******************************
call plug#begin("~/.vim/plugged")
  Plug 'dracula/vim'
  Plug 'scrooloose/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
"  Plug 'rbong/vim-crystalline'
  Plug 'sheerun/vim-polyglot'
  Plug 'mhinz/vim-startify'
call plug#end()

" *******************************
" CUSTOM CONFIGS ****************
" *******************************

" GENERAL ************************* 
" Absolute line numbers
"set number

" Hybrid line number
:set number relativenumber
:set nu rnu

" Case insensitive searching
set ignorecase
set smartcase

" No wrapping of text
set nowrap           " do not automatically wrap on load
set formatoptions-=t " do not automatically wrap text when typing

" Remove search highlighting on second <Enter>
nnoremap <silent> <CR> :noh<CR><CR>

" Make yanking/deleting operations automatically copy to system clipboard
set clipboard=unnamedplus

" Set default tab size
set sts=2
set ts=2
set sw=2

" THEME ************************* 
if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme dracula

" NERDTree ***********************
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = '%#NonText#'
" Automaticaly close nvim if NERDTree is only thing left open
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

" TERMINAL ***********************
" open new split panes to right and below
set splitright
set splitbelow
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://zsh
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>
" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" FUZZY SEARCH *******************
nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

" VIM STATUS LINE ****************
" set tabline=%!crystalline#bufferline()
set showtabline=2
" set noshowmode
set noruler
set laststatus=0
set noshowcmd

" START SCREEN *******************
let g:startify_lists = [
  \ { 'type': 'files',     'header': ['   Recent']            },
  \ { 'type': 'dir',       'header': ['   Recent '. getcwd()] },
  \ { 'type': 'sessions',  'header': ['   Sessions']       },
  \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
  \ { 'type': 'commands',  'header': ['   Commands']       },
  \ ]

let g:ascii = [
  \ "   __    _ __    __    _     _ __    __    _ ",
  \ "  / /__ (_) /__ / /__ (_)___(_) /__ / /__ (_)",
  \ " /  '_// /  '_//  '_// / __/ /  '_//  '_// / ",
  \ "/_/\\_\\/_/_/\\_\\/_/\\_\\/_/_/ /_/_/\\_\\/_/\\_\\/_/  ",
  \ " "
  \]

let g:startify_custom_header =
  \ 'startify#pad(g:ascii + startify#fortune#boxed())'
