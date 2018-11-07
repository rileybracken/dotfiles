"====================
" VUNDLE
"====================
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" General
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'janko-m/vim-test'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'tommcdo/vim-exchange'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'gfontenot/vim-xcode'
Plugin 'SirVer/ultisnips'

" Syntax
Plugin 'digitaltoad/vim-pug'
Plugin 'neoclide/vim-jsx-improve'
Plugin 'othree/html5.vim'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'tikhomirov/vim-glsl'
Plugin 'elixir-lang/vim-elixir'
Plugin 'heavenshell/vim-jsdoc'
Plugin 'altercation/vim-colors-solarized'
Plugin 'prettier/vim-prettier'
Plugin 'flowtype/vim-flow'
Plugin 'w0rp/ale'

" Colorschemes
Plugin 'rafi/awesome-vim-colorschemes'

call vundle#end()

"====================
" SETTINGS
"====================
" Colors
syntax enable
set background=dark
colorscheme hybrid
let g:airline_theme='hybrid'
set t_Co=256

set backspace=2

filetype on
filetype indent on
filetype plugin on

set autoindent
set t_Co=256
set background=dark
set nobackup
set backspace=start,indent,eol
set tabstop=2
set softtabstop=2
set shiftwidth=2
set number
retab
set expandtab
set noswapfile
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" Format markdown to autowrap and call out spelling errors
au BufRead,BufNewFile *.md setlocal spell textwidth=60

set laststatus=2
set listchars=tab:▸\ ,eol:¬
set relativenumber
set ruler
set splitbelow
set splitright

set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.

" Highlight 100th column
set colorcolumn=100

" Ignore case for fast-typed commands.
command Q q
command Set set
command W w
command WQ wq
command Wq wq

"====================
" SYNTAX
"====================
autocmd BufRead,BufNewFile *.jbuilder set filetype=ruby
autocmd BufRead,BufNewFile *.xaml :set filetype=xml
autocmd BufRead,BufNewFile *.conf set filetype=json
autocmd BufNewFile,BufRead *.region,*.item,*.list,*.block set filetype=html.mustache syntax=mustache

" SquareSpace templates
autocmd BufRead,BufNewFile *.block set filetype=html
autocmd BufRead,BufNewFile *.item set filetype=html
autocmd BufRead,BufNewFile *.list set filetype=html
autocmd BufRead,BufNewFile *.conf set filetype=javascript

" 4 spaces for iOS indentation
autocmd BufRead *.swift set ts=4 et sw=4 sts=4
autocmd BufRead *.h set ts=4 et sw=4 sts=4
autocmd BufRead *.m set ts=4 et sw=4 sts=4
autocmd BufRead *.cpp set ts=4 et sw=4 sts=4
autocmd BufRead *.c set ts=4 et sw=4 sts=4

"====================
" SNIPPETS
"====================
let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0
let g:UltiSnipsExpandTrigger           = '<tab>'
let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<s-tab>'
let g:ycm_key_list_select_completion   = ['<C-j>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']
:command! -nargs=1 -range SuperRetab <line1>,<line2>s/\v%(^ *)@<= {<args>}/\t/g

let g:jsx_ext_required = 0

"====================
" flow
"====================
" let g:flow#autoclose = 1

"====================
" SEARCH
"====================
set incsearch
set hlsearch
set ignorecase
set smartcase

let g:jsx_ext_required = 0

function! FindAllMultipleCursors( type )
  " Yank the (w)ord under the cursor into reg z. If we (were) in visual mode,
  " use gv to re-select the last visual selection first
  if a:type == "v"
    norm! gv"zy
  else
    norm! "zyiw
  endif

  " Find how many occurrences of this word are in the current document, see
  " :h count-items. Redirect the output to register x silently otherwise it
  " spits out the search output
  redir @x | silent execute "%s/\\v" . @z . "/&/gn" | redir END

  " Get the first word in output ("n of n matches") which is count. Split
  " on non-word chars because output has linebreaks
  let s:count = split( @x, '\W' )[ 0 ]

  if s:count > 15
    call inputsave()
    let s:yn = input('There are ' . s:count . ' matches, and MultipleCurors is slow. Are you sure? (y/n) ')
    call inputrestore()
    redraw
    if s:yn != "y"
      echo "Aborted FindAllMultipleCursors."
      return
    endif
  endif

  execute "MultipleCursorsFind " . @z
endfunction

autocmd BufWritePre * :%s/\s\+$//e

nnoremap <leader>fa :call FindAllMultipleCursors("")<cr>
vnoremap <leader>fa :call FindAllMultipleCursors("v")<cr>

"======================
" LEADERS
"======================
let mapleader = ","

command! E Explore

map <Leader>h :nohlsearch<cr>
map <Leader>p :set paste<CR><esc>"*]p:set nopaste<cr>
map <Leader>ra :%s/
map <Leader>w <C-w>w
map <Leader>gw :!git add . && git commit -m 'WIP' && git push<cr>
map <Leader>e :Explore<cr>
map <Leader>gn :e ~/Dropbox (Underbelly)/notes<cr>
map <Leader>gj :e ~/Dropbox (Underbelly)/notes/journal/<C-r>=strftime("%Y-%m-%d") . '.md'<cr><cr>
map <Leader>gtf :vsp <C-R>=expand('%:p:h') . '/'<CR><cr>
map <Leader>gts :vsp <C-R>=expand('%:p:h') . '/styles.js'<CR><cr>
map <Leader>gtt :vsp <C-R>=expand('%:p:h') . '/__tests__/index.js'<CR><cr>
map <Leader>gtn :vsp <C-R>=expand('%:p:h') . '/__tests__/__snapshots__/index.js.snap'<CR><cr>
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tc :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>

map <C-J> <C-W>J
map <C-K> <C-W>K
map <C-H> <C-W>H
map <C-L> <C-W>L
map <C-c> "*y

set wildignore+=*/_bundle/*

set statusline+=%#warningmsg#
set statusline+=%*

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"====================
" Search
"====================
set grepprg=ag

"====================
" NerdCommenter
"====================
let g:NERDSpaceDelims = 1

"====================
" unimpaired
"====================
" Bubble single lines
nmap <C-k> [e
nmap <C-j> ]e
" Bubble multiple lines
vmap <C-k> [egv
vmap <C-j> ]egv

"====================
" ctrlp
"====================
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

"====================
" Prettier
"====================
let g:ale_fix_on_save = 1

let g:ale_linters = {
\  'javascript': ['flow', 'eslint']
\}

let g:ale_fixers = {
\  'javascript': ['prettier'],
\  'yaml': ['prettier']
\}

let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_echo_msg_format = '%linter%: %s [%severity%]'
