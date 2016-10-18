if has('win32')
    source ~/_vimrc
    au GUIEnter * simalt ~x
else
    source ~/.vimrc
    set lines=160 columns=240
endif
set guioptions-=T
