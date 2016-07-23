"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" required
set nocompatible
filetype off

""" set the runtime path to include Vundle and initialize it
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

""" Vundle
Plugin 'gmarik/Vundle.vim'              " let Vundle manage Vundle

""" General plugins
Plugin 'vim-scripts/Gundo'              " visualize vim undo tree
Plugin 'terryma/vim-multiple-cursors'   " multi-cursors
Plugin 'ctrlpvim/ctrlp.vim'             " fuzzy file search
Plugin 'tpope/vim-fugitive'             " git features from within vim
Plugin 'Lokaltog/vim-easymotion'        " jump anywhere quickly
Plugin 'airblade/vim-gitgutter'         " git diff in sign column
Plugin 'scrooloose/syntastic'           " syntax checking
Plugin 'ntpeters/vim-better-whitespace' " highlight unwanted whitespaces
Plugin 'sjl/badwolf'                    " colorscheme
Plugin 'scrooloose/nerdtree'            " file and folder structure
Plugin 'vim-airline/vim-airline'        " status bar
Plugin 'vim-airline/vim-airline-themes' " status bar themes
Plugin 'dbakker/vim-projectroot'        " guess project root from file
Plugin 'clones/vim-cecutil'             " needed by vis
Plugin 'RobertAudi/vis.vim'             " substitute visual blocks
Plugin 'tpope/vim-commentary'           " easily comment lines out
Plugin 'ervandew/supertab'              " tab auto-completion
Plugin 'ryanoasis/vim-devicons'         " cool icons
Plugin 'godlygeek/tabular'              " tabularize things
Plugin 'gabrielelana/vim-markdown'      " proper markdown support
Plugin 'luochen1990/rainbow'            " colour matching parantheses

""" required
call vundle#end()
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configurations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:EasyMotion_smartcase = 1                          " smart case as in vim
let g:EasyMotion_keys = 'asdghklqwertyuiopzxcvbnmfj'    " layout-friendly

""" supertab - prevent unwanted tabs
let g:SuperTabNoCompleteAfter = ['^', ',', '\s', ';', "\'", '"', '>', ')', ':', '/']
let g:SuperTabDefaultCompletionType = "context"

""" ctrlp - basic configuration
let g:ctrlp_map = '<C-p>'                           " mapped to ctrl-P
let g:ctrlp_cmd = 'CtrlP'                           " default command

""" ctrlp - customization
let g_ctrlp_switch_buffer = 'E'                     " re-open existing buffers
let g:ctrlp_tabpage_position = 'ac'                 " new tab after current
let g:ctrlp_show_hidden = 1                         " always show hidden files
let g:ctrlp_max_files = 10000
let g:ctrlp_working_path_mode = 'ra'                " current + version control

""" syntastic - enabled for Python only for now
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1    " Put errors on left side
let g:syntastic_quiet_messages = {'level': 'warnings'}
let g:syntastic_python_checkers = ['python']
let g:syntastic_auto_jump = 1
let g:syntastic_c_checkers = []
let g:syntastic_cpp_checkers = []

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Replace grep with ag
" From https://robots.thoughtbot.com/faster-grepping-in-vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if executable('ag')
    " Use ag over grep
    set grepprg=ag\ -t\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif

""" Grep for word under cursor in normal mode
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

""" New command: Ag
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

""" Bine new command to '\' in normal mode
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
set t_Co=256                            " 256 colors
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

""" use tabs like buffers
"tab sball
"set switchbuf+=usetab,newtab

""" no backups
set nobackup
set nowritebackup

""" disable annoying audio bell
set noeb vb t_vb=

""" better completion for file names
set wildmode=longest,list,full
set wildmenu

""" auto-detect file changes (not if in command line window)
""" simple version from https://stackoverflow.com/questions/2490227/how-does-vims-autoread-work/20418591#20418591
au FocusGained,BufEnter * :silent! !

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

augroup reload_vimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC
                \|if has('gui_running') | so $MYGVIMRC | endif
augroup END

"""""""""""" EXPERIMENTAL

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'
set hidden
" Switch to alternate file
nnoremap <C-PageUp> :bprev<CR>
nnoremap <C-PageDown> :bnext<CR>
inoremap <C-PageUp> <Esc>:bprev<CR>
inoremap <C-PageDown> <Esc>:bnext<CR>
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" easy switching between buffers
nmap <C-H> <C-W>h
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l
nmap <C-Q> <C-W>q

""" re-arrange tab list with ALT-Left and ALT-Right
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

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

""" Simple "session" management - save with F2, load with F3
map <F2> :mksession! ~/vim_session <cr>
map <F3> :source ~/vim_session <cr>

""" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other key mappings (implicit)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" folding
"""     zc: close, zo: open, za: toggle (one level)
"""     zC: close, zO: open, zA: toggle (all folding levels)
"""     zM: close all folds

""" multiple cursors - CTRL+n
"""     more details at https://github.com/terryma/vim-multiple-cursors

