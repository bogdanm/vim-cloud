if has('win32')
    source ~/_vimrc
    au GUIEnter * simalt ~x
else
    source ~/.vimrc
    set guifont=DejaVuSansMonoForPowerline\ Nerd\ Font\ Book
endif
set guioptions-=T
