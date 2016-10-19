if has('win32')
    source ~/_vimrc
    set guifont=Consolas:h10
    au GUIEnter * simalt ~x
else
    source ~/.vimrc
    set guifont=DejaVuSansMonoForPowerline\ Nerd\ Font\ Book
endif
set guioptions-=T
