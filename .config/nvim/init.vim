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
  Plug 'rbong/vim-crystalline'
  Plug 'sheerun/vim-polyglot'
  Plug 'mhinz/vim-startify'
call plug#end()

" *******************************
" CUSTOM CONFIGS ****************
" *******************************

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
" let g:NERDTreeStatusline = ''
let g:NERDTreeStatusline = '%#NonText#'
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
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
  split term://bash
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
function! StatusLine(...)
  return crystalline#mode() . crystalline#right_mode_sep('')
        \ . ' %f%h%w%m%r ' . crystalline#right_sep('', 'Fill') . '%='
        \ . crystalline#left_sep('', 'Fill') . ' %{&ft}[%{&fenc!=#""?&fenc:&enc}][%{&ff}] %l/%L %c%V %P '
endfunction
let g:crystalline_enable_sep = 1
let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_theme = 'default'
set laststatus=2

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
