set nocompatible
behave mswin

let mapleader="-"
let maplocalleader="."

"filetype on
filetype plugin indent on
syntax on
"colorscheme torte
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
"set number
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


" status line {{{
function! Sl_encoding()
	if &fileencoding == ""
		if &encoding != ""
			return "[" . &encoding . "]"
		else
			return "[--]"
		endif
	else
		return "[" . &fileencoding . "]"
	endif
endfunction

function! Sl_fileformat()
	if &fileformat == ""
		return "[--]"
	else
		return "[" . &fileformat . "]"
	endif

endfunction

"set statusline=%.30t\ 				" filename
"set statusline=%.30f\ 				" relative path filename
"set statusline=%.30F\ 				" full path filename
set statusline=%.30f\ 	 			" relative path filename
set statusline+=%m\ 				" modificado?
set statusline+=%r\ 				" solo lectura?
set statusline+=%= 				" escribir en borde derecho
set statusline+=%y\ 				" tipo de fichero 
set statusline+=%.10{Sl_encoding()}\ 		" encoding
set statusline+=%.7{Sl_fileformat()}\ 		" file format
set statusline+=B-%2.2n\ 			" numero de buffer
set statusline+=%3.3c\ :%6.6l\ /%6.6L 		" col : linea (total lineas)
" }}}

" mappings {{{
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>n :setlocal number!<cr>

" ejecuta el contenido del buffer asumiendo que es vimscript
nnoremap <leader>xb :%y<cr>:@"<cr>	
nnoremap <leader>sb :vsplit _scratch_<cr>:setlocal buftype=nofile<cr>:setlocal filetype=vim<cr>

" format xml file with xmllint (only useful if xmllint installed)
nnoremap <leader>fx :%!xmllint --format --recover -<CR>  
" block line as header 
nnoremap <leader>fl z<cr>:split<cr>:resize 1<cr><c-w>w

" }}}

" autocommands {{{
autocmd BufWritePre,BufRead *.xml :normal gg=G
autocmd BufWritePre,BufRead *.html :normal gg=G
"augroup filetype_html
"    autocmd!
"    autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
"augroup END
" }}}

