" ********************************************************************
" PLUGINS ************************************************************
" ********************************************************************

call plug#begin("~/.vim/plugged")
  Plug 'dracula/vim'
  Plug 'scrooloose/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
"  Plug 'rbong/vim-crystalline'
  Plug 'itchyny/lightline.vim'
  Plug 'sheerun/vim-polyglot'
  Plug 'mhinz/vim-startify'
	Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
	Plug 'alvan/vim-closetag'
  Plug 'matze/vim-move'
  Plug 'tpope/vim-commentary'
  Plug 'danilamihailov/beacon.nvim'
  Plug 'yardnsm/vim-import-cost', { 'do': 'npm install' }
call plug#end()


" ********************************************************************
" CUSTOM CONFIGS *****************************************************
" ********************************************************************


" GENERAL ************************************************************
" (Re-)source init.vim with F5
nnoremap <F5> :source $MYVIMRC<cr>

" Absolute line numbers
set number

" Hybrid line number
"set number relativenumber
"set nu rnu

" Case insensitive searching
set ignorecase
set smartcase

" No wrapping of text
set linebreak
" set nowrap           " do not automatically wrap on load
" set formatoptions-=t " do not automatically wrap text when typing

" Remove search highlighting on second <Enter> or <Esc>
nnoremap <silent> <CR> :noh<CR><CR>
nnoremap <silent><esc> :noh<return><esc>

" Copy/Paste/Cut
set clipboard=unnamedplus
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif
noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

" Indentation
set smarttab
set expandtab
set autoindent
set sts=2
set ts=2
set sw=2

" Enable using mouse
set mouse=a

" Control-S Save
nmap <C-S> :w<cr>
vmap <C-S> <esc>:w<cr>
imap <C-S> <esc>:w<cr>
" Save + back into insert
" imap <C-S> <esc>:w<cr>a

" Control-C Copy in visual mode
vmap <C-C> y

" Control-V Paste in insert and command mode
imap <C-V> <esc>pa
cmap <C-V> <C-r>0

" Comment
map <A-'> <plug>Commentary


" THEME **************************************************************
if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme dracula


" NERDTree ***********************************************************
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = '%#NonText#'
" Automaticaly close nvim if NERDTree is only thing left open
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

nnoremap <silent> <C-b> :NERDTreeToggle<CR>


" TERMINAL ************************************************************
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

" use Ctrl+hjkl to move between split/vsplit panels
tnoremap <C-A-h> <C-\><C-n><C-w>h
tnoremap <C-A-j> <C-\><C-n><C-w>j
tnoremap <C-A-k> <C-\><C-n><C-w>k
tnoremap <C-A-l> <C-\><C-n><C-w>l
nnoremap <C-A-h> <C-w>h
nnoremap <C-A-j> <C-w>j
nnoremap <C-A-k> <C-w>k
nnoremap <C-A-l> <C-w>l

" close panel with Ctrl+w
tnoremap <C-w> :q <CR>
nnoremap <C-w> :q <CR>


" FUZZY SEARCH *******************************************************
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-c': 'split',
  \ 'ctrl-v': 'vsplit'
  \}
let $FZF_DEFAULT_OPTS='--layout=reverse --margin=1,2 --info=hidden' 


" Keybindings
nnoremap <silent> <C-p> :FindFile<CR>
nnoremap <silent> <A-f> :SearchInAllFiles<cr>

" Commands
command! -bang -nargs=? -complete=dir FindFile call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': '--prompt 🔍'}), <bang>0)
command! -nargs=* -bang SearchInAllFiles call RipgrepFzf(<q-args>, <bang>0)

" Advanced ripgrep integration
" https://github.com/junegunn/fzf.vim/#example-advanced-ripgrep-integration
" --column and --line-number NEEDS to be set or it won't work properly
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--prompt', '🔍', '--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

" Hide status line when fzf is active
autocmd! FileType fzf set laststatus=0 noshowmode noruler | autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" Open FZF in floating window
let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }


" FLOATING WINDOW ***************************************************
function! CreateCenteredFloatingWindow()
    let width = min([&columns - 4, max([80, &columns - 30])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    let win1 = nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    let win2 = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
    " Close border-window AND buffer window on <Esc>
    " https://www.reddit.com/r/neovim/comments/ekzhme/help_wanted_changing_keymap_for_floating_window/
    tnoremap <silent> <buffer> <Esc> <C-\><C-n><CR>:bw!<CR>
endfunction

function! ToggleTerm(cmd)
    if empty(bufname(a:cmd))
        call CreateCenteredFloatingWindow()
        call termopen(a:cmd, { 'on_exit': function('OnTermExit') })
    else
        bwipeout!
    endif
endfunction

function! OnTermExit(job_id, code, event) dict
    if a:code == 0
        bwipeout!
    endif
endfunction

" Cool programs started in floting window
nnoremap <silent> <F1> :call ToggleTerm('lazygit')<CR> i
nnoremap <silent> <F2> :call ToggleTerm('htop')<CR> i
nnoremap <silent> <F3> :call ToggleTerm('zsh')<CR> i

" VIM STATUS LINE ***************************************************
" set tabline=%!crystalline#bufferline()
" set showtabline=2
set noshowmode
" set noruler
set laststatus=2
" set noshowcmd
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'right': [ ['lineinfo'] ],
      \   'left': [ ['filename'] ]
      \ }
      \ }


" START SCREEN ******************************************************
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


" VIM CLOSE TAG *****************************************************
let g:closetag_filenames = '*.html,*.js,*.tsx'
let g:closetag_xhtml_filenames = '*.xml,*.js,*.tsx'
let g:closetag_filetypes = 'html,js,tsx'
let g:closetag_xhtml_filetypes = 'xml,js,tsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'


" COC AUTO COMPLETE SUGGESTION WITH <TAB> ***************************
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" IMPORT COST *******************************************************
" Trigger :ImportCost when buffer is updated
augroup import_cost_auto_run
  autocmd!
  autocmd InsertLeave *.js,*.jsx,*.ts,*.tsx ImportCost
  autocmd BufEnter *.js,*.jsx,*.ts,*.tsx ImportCost
  autocmd CursorHold *.js,*.jsx,*.ts,*.tsx ImportCost
augroup END
