if has('win32')
    source ~/_vimrc
else
    source ~/.vimrc
endif
set guioptions-=T
if has('win32')
    au GUIEnter * simalt ~x
else
    set lines=160 columns=240
endif
