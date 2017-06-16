"====================
" VUNDLE
"====================
  set nocompatible
  filetype off

  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()

  Plugin 'VundleVim/Vundle.vim'
  Plugin 'mhartington/oceanic-next'
  Plugin 'honza/vim-snippets'
  Plugin 'mxw/vim-jsx'
  Plugin 'isRuslan/vim-es6'
  Plugin 'tpope/vim-fugitive'
  Plugin 'pangloss/vim-javascript'
  Plugin 'othree/html5.vim'
  Plugin 'hail2u/vim-css3-syntax'
  Plugin 'jelera/vim-javascript-syntax'
  Plugin 'tpope/vim-surround'
  Plugin 'rking/ag.vim'
  Plugin 'ctrlpvim/ctrlp.vim'
  Plugin 'facebook/vim-flow'
  Plugin 'tikhomirov/vim-glsl'
  Plugin 'altercation/vim-colors-solarized'
  Plugin 'guns/xterm-color-table.vim'
  Plugin 'vim-airline/vim-airline'
  Plugin 'vim-airline/vim-airline-themes'
  Plugin 'elixir-lang/vim-elixir'
  Plugin 'scrooloose/syntastic'
  Plugin 'scrooloose/nerdcommenter'
  Plugin 'trevordmiller/nova-vim'
  Plugin 'reedes/vim-colors-pencil'
  Plugin 'janko-m/vim-test'
  Plugin 'shawncplus/Vim-toCterm'
  Plugin 'digitaltoad/vim-pug'

  call vundle#end()
  filetype plugin indent on

"====================
" SETTINGS
"====================

  colorscheme OceanicNext
  let g:airline_theme='oceanicnext'

  set t_Co=256
  set backspace=2
  syntax on
  filetype indent on
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
  autocmd BufRead,BufNewFile *.md setlocal spell

  set laststatus=2
  set listchars=tab:▸\ ,eol:¬
  set relativenumber
  set ruler
  set splitbelow
  set splitright

"====================
" SYNTAX
"====================
  autocmd BufRead,BufNewFile *.jbuilder set filetype=ruby
  autocmd BufRead,BufNewFile *.xaml :set filetype=xml
  autocmd BufRead,BufNewFile *.conf set filetype=json
  autocmd BufNewFile,BufRead *.region,*.item,*.list,*.block set filetype=html.mustache syntax=mustache

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
" CtrlP
"====================
  "Change the default mapping and the default command to invoke CtrlP:
  let g:ctrlp_map = '<c-p>'
  let g:ctrlp_cmd = 'CtrlP'
  let g:ctrlp_working_path_mode = 'ra'
  let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist|_build)|(\.(swp|ico|git|svn))$'

"====================
" flow
"====================
  let g:flow#autoclose = 1

"====================
" SEARCH
"====================
  set incsearch
  set hlsearch
  set ignorecase
  set smartcase

  let g:jsx_ext_required = 0

  " The Silver Searcher
  if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
  else
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  endif

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
  nmap <silent> <leader>tn :TestNearest<CR>
  nmap <silent> <leader>tc :TestFile<CR>
  nmap <silent> <leader>ta :TestSuite<CR>
  nmap <silent> <leader>tl :TestLast<CR>
  nmap <silent> <leader>tv :TestVisit<CR>

  map <C-J> <C-W>J
  map <C-K> <C-W>K
  map <C-H> <C-W>H
  map <C-L> <C-W>L

  set wildignore+=*/_bundle/*

  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  function! SyntasticESlintChecker()
    let l:npm_bin = ''
    let l:eslint = 'eslint'

    if executable('npm')
      let l:npm_bin = split(system('npm bin'), '\n')[0]
    endif

    if strlen(l:npm_bin) && executable(l:npm_bin . '/eslint')
      let l:eslint = l:npm_bin . '/eslint'
    endif

    let b:syntastic_javascript_eslint_exec = l:eslint
  endfunction

  let g:syntastic_javascript_checkers = ["eslint"]
  autocmd FileType javascript :call SyntasticESlintChecker()

  let g:syntastic_always_populate_loc_list = 0
  let g:syntastic_auto_loc_list = 0
  let g:syntastic_check_on_open = 0
  let g:syntastic_check_on_wq = 0
  let g:syntastic_javascript_checkers = ['eslint']
  let syntastic_mode_map = { 'passive_filetypes': ['html', 'scss'] }

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
" Prettier
"====================
  autocmd FileType javascript set formatprg=prettier\ --stdin

"====================
" NerdCommenter
"====================
  let g:NERDSpaceDelims = 1
