set nocompatible
filetype on
"filetype plugin indent on
syntax on
colorscheme torte
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set number
set showcmd
set ignorecase
set smartcase
set hlsearch
"set incsearch

set showmatch 	" jump to matching when typing (as %)
"set mps+=<:>		" add < > to matchpairs

"set autowrite
"set hidden
"set mouse=a
"set background=dark

map fx :%!xmllint --format --recover -<CR>  " format xml file with xmllint
map fl z<cr>:split<cr>:resize 1<cr><c-w>w   " block line as header 

