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
Plugin 'terryma/vim-multiple-cursors'    " multi-cursors
Plugin 'ctrlpvim/ctrlp.vim'              " fuzzy file search
Plugin 'Lokaltog/vim-easymotion'         " jump anywhere quickly
if has('win32')
    Plugin 'mhinz/vim-signify'           " git diff in sign column
else
    Plugin 'airblade/vim-gitgutter'      " git diff in sign column (doesn't work in Windows)
endif
Plugin 'scrooloose/syntastic'            " syntax checking
Plugin 'ntpeters/vim-better-whitespace'  " highlight unwanted whitespaces
Plugin 'sjl/badwolf'                     " color scheme
Plugin 'scrooloose/nerdtree'             " file and folder structure
Plugin 'vim-airline/vim-airline'         " status bar
Plugin 'vim-airline/vim-airline-themes'  " airline themes
Plugin 'dbakker/vim-projectroot'         " guess project root from file
Plugin 'tpope/vim-commentary'            " easily comment lines out
if !has('win32')
    Plugin 'ryanoasis/vim-devicons'      " cool icons
endif
Plugin 'godlygeek/tabular'               " tabularize things
Plugin 'gabrielelana/vim-markdown'       " proper markdown support
Plugin 'fatih/vim-go'                    " let's GO!
Plugin 'Valloric/YouCompleteMe'          " code completion done right
Plugin 'mhinz/vim-startify'              " start screen

""" required
call vundle#end()
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configurations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:EasyMotion_smartcase = 1                       " smart case as in vim
let g:EasyMotion_keys = 'asdghklqwertyuiopzxcvbnmfj' " layout-friendly

""" ctrlp - basic configuration
let g:ctrlp_map = '<C-p>'                           " mapped to ctrl-P
let g:ctrlp_cmd = 'CtrlPMixed'                      " default command

""" ctrlp - customization
let g_ctrlp_switch_buffer = 'E'                     " re-open existing buffers
let g:ctrlp_tabpage_position = 'ac'                 " new tab after current
let g:ctrlp_show_hidden = 1                         " always show hidden files
let g:ctrlp_max_files = 10000
let g:ctrlp_working_path_mode = 'ra'                " current + version control

""" syntastic - enabled for Python
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1    " Put errors on left side
let g:syntastic_quiet_messages = {'level': 'warnings'}
let g:syntastic_python_checkers = ['python']
let g:syntastic_auto_jump = 1
let g:syntastic_c_checkers = []
let g:syntastic_cpp_checkers = []
let g:syntastic_go_checkers = []

""" signify
if has('win32')
    let g:signify_vcs_list = ['git']
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Replace grep with ag
" From https://robots.thoughtbot.com/faster-grepping-in-vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if executable('ag')
    " Use ag over grep
    set grepprg=ag\ -t\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    if has('unix')
        let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    else
        let g:ctrlp_user_command = 'ag -l --nocolor -g "" %s'
    endif

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif

""" Grep for word under cursor in normal mode
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

""" New command: Ag
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

""" Bind new command to '\' in normal mode
nnoremap \ :Ag<SPACE>

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

""" folding
set foldmethod=syntax                   " fold based on syntax
set foldenable                          " enable folding
set foldlevelstart=10                   " small snippets are unfolded

""" search
set incsearch                           " incremental search
set hlsearch                            " highlight matches
set smartcase                           " case smartly-insensitive search

""" parenthesis matching highlighting
set showmatch                           " highlight matching {[()]}

""" share clipboard with system (may show unwanted behavior)
set clipboard=unnamed                   " system wide clipboard

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

""" powerline
let g:airline_theme='powerlineish'
if !has('win32')
    let g:airline_powerline_fonts = 1
endif
""" enable buffer list
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_nr_show = 1

""" auto-detect file changes (not if in command line window)
""" simple version from https://stackoverflow.com/questions/2490227/how-does-vims-autoread-work/20418591#20418591
""" doesn't work on windows (also, is it really needed?)
if !has('win32')
    au FocusGained,BufEnter * :silent! !
endif

""" mouse interaction (may show unwanted behavior)
set mouse=a                             " mouse can interact

""" project-specific settings (may override default)
function! ProjectSpecificSettings()
    let l:path = expand('%:p')
    let l:root = projectroot#guess(l:path)
    let l:vim_custom = l:root . "/.custom.vim"
    if filereadable(l:vim_custom)
        exec "so " . l:vim_custom
    endif
endfunction

augroup project_specific_settings
    au!
    au BufReadPost,BufNewFile * call ProjectSpecificSettings()
augroup END

""" automatically reload vimrc when changed
augroup reload_vimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC
                \|if has('gui_running') | so $MYGVIMRC | endif
augroup END

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

""" start NERDTree in current dir with F8
nmap <F8> :NERDTreeFind<CR>

""" YCM GoTo
map <F9> :YcmCompleter GoTo<CR>

""" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

""" Switch to alternate file
nnoremap <C-PageUp> :bprev<CR>
nnoremap <C-PageDown> :bnext<CR>
inoremap <C-PageUp> <Esc>:bprev<CR>
inoremap <C-PageDown> <Esc>:bnext<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other key mappings (implicit) and commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" folding
"""     zc: close, zo: open, za: toggle (one level)
"""     zC: close, zO: open, zA: toggle (all folding levels)
"""     zM: close all folds

""" multiple cursors - CTRL+n
"""     more details at https://github.com/terryma/vim-multiple-cursors

""" Tabularize uses the Tabularize command (see http://vimcasts.org/episodes/aligning-text-with-tabular-vim/)

