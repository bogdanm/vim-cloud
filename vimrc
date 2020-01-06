"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" required
set nocompatible
filetype off

""" set the runtime path to include Vundle and initialize it
if has('win32')
    set rtp+=~/vimfiles/bundle/Vundle.vim/
    call vundle#begin('~/vimfiles/bundle/')
else
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
endif

""" Vundle
Plugin 'VundleVim/Vundle.vim'            " let Vundle manage Vundle

""" General plugins
Plugin 'Lokaltog/vim-easymotion'         " jump anywhere quickly
Plugin 'ntpeters/vim-better-whitespace'  " highlight unwanted whitespaces
Plugin 'sjl/badwolf'                     " color scheme
Plugin 'tpope/vim-commentary'            " easily comment lines out
Plugin 'mhinz/vim-startify'              " start screen

""" required
call vundle#end()
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configurations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:EasyMotion_smartcase = 1                       " smart case as in vim
let g:EasyMotion_keys = 'asdghklqwertyuiopzxcvbnmfj' " layout-friendly

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Appearance and behaviour
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" syntax highlighting
syntax on                               " syntax highlighting

""" lines
set number                              " show line numbers
set cursorline                          " show current line

""" status bar
set laststatus=2                        " persistent status bar
set ruler                               " show column number

""" fix backspaces 'bug'
set backspace=indent,eol,start          " backspace for special cases

""" color scheme
if !has('win32')
    set t_Co=256                        " 256 colors
endif
try
    colorscheme badwolf                 " colorscheme
catch /^Vim\%((\a\+)\)\=:E185/          " fallback
    colorscheme elflord                 " just happens at first installation
endtry

""" tabs
set shiftwidth=4                        " shift width
set tabstop=4                           " tab width
set softtabstop=4                       " tab width in insert mode
set expandtab                           " tabs are spaces

""" search
set incsearch                           " incremental search
set hlsearch                            " highlight matches
set smartcase                           " case smartly-insensitive search

""" parenthesis matching highlighting
set showmatch                           " highlight matching {[()]}

""" show special characters
set listchars=tab:>-,trail:~,extends:>,precedes:<
set list

""" briefly jump to matching bracket
set showmatch

""" no backups
set nobackup
set nowritebackup

""" disable annoying audio bell
set noeb vb t_vb=

""" better completion for file names
set wildmode=longest,list,full
set wildmenu

""" buffer behaviour
set hidden

""" UTF-8 encoding (needed by YCM)
set encoding=utf-8

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" easy switching between buffers
nmap <C-H> <C-W>h
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l
nmap <C-Q> <C-W>q

""" Avoid turning the keyboard into tiny pieces of dead plastic
command! WQ wq
command! Wq wq
command! W w
command! Q q
command! Qa qa
command! QA qa

""" easymotion
nmap <Space> <Plug>(easymotion-bd-w)

""" toggle between incremental and non-incremental search with F5
map <F5> :set hls!<bar>set hls?<CR>

""" strip unneeded whitespace with F6
map <F6> :StripWhitespace<CR>

""" switch between paste/nopaste modes
map <F7> :set paste!<bar>set paste?<CR>

