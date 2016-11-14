if has('win32')
    source ~/_vimrc
    set guifont=Consolas:h10
    au GUIEnter * simalt ~x
else
    source ~/.vimrc
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ Mono\ Plus\ Pomicons\ 9
endif
set guioptions-=T
