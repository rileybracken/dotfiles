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

" Writing
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/limelight.vim'

" Syntax
Plugin 'digitaltoad/vim-pug'
Plugin 'neoclide/vim-jsx-improve'
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'tikhomirov/vim-glsl'
Plugin 'elixir-lang/vim-elixir'
Plugin 'heavenshell/vim-jsdoc'
Plugin 'altercation/vim-colors-solarized'
Plugin 'prettier/vim-prettier'
Plugin 'flowtype/vim-flow'
Plugin 'leafgarland/typescript-vim'
Plugin 'peitalin/vim-jsx-typescript'
Plugin 'w0rp/ale'
Plugin 'jparise/vim-graphql'

" Colorschemes
Plugin 'joshdick/onedark.vim'

call vundle#end()

"====================
" SETTINGS
"====================
" Colors
syntax enable

set backspace=2

filetype on
filetype indent on
filetype plugin on

set autoindent
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

set laststatus=2
set listchars=tab:▸\ ,eol:¬
set relativenumber
set ruler
set splitbelow
set splitright

set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.

function! SynStack()
	if !exists("*synstack")
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

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
au BufRead,BufNewFile *.jbuilder set filetype=ruby
au BufRead,BufNewFile *.xaml :set filetype=xml
au BufRead,BufNewFile *.conf set filetype=json

augroup FiletypeGroup
  autocmd!
  " .ts is a Typescript file
augroup END

"====================
" WRITING
"====================
au BufRead,BufNewFile *.md setlocal spell textwidth=60 linespace=7
au FileType markdown nmap <silent> <leader>f ggVGgq

let g:goyo_width = 75

function! s:goyo_enter()
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

let g:limelight_paragraph_span = 1  " Don't dim one par around the current one
let g:limelight_priority       = -1 " Don't overrule hlsearch
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

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
" Enable syntax highlighting for flow
let g:javascript_plugin_flow = 1
let g:graphql_javascript_tags = ["gql", "graphql", "Relay.QL"]

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
\ 'javascript': ['flow', 'eslint'],
\ 'typescript': ['tsserver', 'tslint'],
\}

let g:ale_fixers = {
\  'javascript': ['prettier'],
\  'typescript': ['prettier'],
\  'yaml': ['prettier'],
\  'markdown': ['prettier']
\}

let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_echo_msg_format = '%linter%: %s [%severity%]'

""""""""""""" Color Schemes """"""""""""""""
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
	if (has("nvim"))
		"For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
		let $NVIM_TUI_ENABLE_TRUE_COLOR=1
	endif
	"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
	"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
	" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
	if (has("termguicolors"))
		set termguicolors
	endif
endif

syntax on
colorscheme onedark

highlight Normal guibg=#21242a
highlight MatchParen guifg=#C678DD guibg=#504066
highlight LineNr    guifg=#151822
highlight CursorLineNr guifg=#56B6C2
highlight Error guifg=#f57373 guibg=#804040
highlight vimError guifg=#f57373 guibg=#804040

hi IndentGuidesEven guibg=#21242a guifg=#1f1f28
hi IndentGuidesOdd guibg=#262a36 guifg=#1f1f28
hi Comment guifg=#4a5158
hi String guifg=#98C379 guibg=#2a2e34

""" browns
" function params: numbers and constants
hi Statement guifg=#907161
hi Conditional guifg=#907161
hi Keyword guifg=#56B6C2
hi Function guifg=#56B6C2

" Yellows
hi Number guifg=#E5C07B
hi Special guifg=#E5C07B
hi Boolean guifg=#E5C07B

" purple
hi CtrlPMatch guifg=#ba9ef7
hi Visual guibg=#364652

" medium red: if else operators
hi Preproc guifg=#e86868
hi Type guifg=#e86868

" Blues
" light blues
hi xmlTagName guifg=#59ACE5
hi xmlTag guifg=#59ACE5

" dark blues
hi xmlEndTag guifg=#2974a1
hi jsxCloseString guifg=#2974a1
hi htmlTag guifg=#2974a1
hi htmlEndTag guifg=#2974a1
hi htmlTagName guifg=#59ACE5
hi jsxAttrib guifg=#1BD1C1

" cyan
hi Constant guifg=#56B6C2
hi typescriptBraces guifg=#56B6C2
hi typescriptEndColons guifg=#56B6C2
hi typescriptRef guifg=#56B6C2
hi typescriptPropietaryMethods guifg=#56B6C2
hi typescriptEventListenerMethods guifg=#56B6C2
hi typescriptFunction guifg=#56B6C2
hi typescriptVars guifg=#56B6C2
hi typescriptParen guifg=#56B6C2
hi typescriptDotNotation guifg=#56B6C2
hi typescriptBracket guifg=#56B6C2
hi typescriptBlock guifg=#56B6C2
hi typescriptJFunctions guifg=#56B6C2
hi typescriptSFunctions guifg=#56B6C2
hi typescriptInterpolationDelimiter guifg=#56B6C2
hi typescriptIdentifier guifg=#907161

" javascript
hi jsParens guifg=#56B6C2
hi jsObjectBraces guifg=#C678DD
hi jsFuncBraces guifg=#56B6C2
hi jsObjectFuncName guifg=#D19A66
hi jsObjectKey guifg=#56B6C2
