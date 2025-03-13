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
set statusline+=%3.3c\ :%7.7l\ /%7.7L 		" col : linea (total lineas)
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


"colorscheme elflord
colorscheme darkblue
set number

"-- Plugins -----
"
"Reload the file or restart Vim, then you can,
"
":PlugInstall to install the plugins
":PlugUpdate to install or update the plugins
":PlugDiff to review the changes from the last update
":PlugClean to remove plugins no longer in the list
"
call plug#begin('~/.vim/plugged')

" Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular', {'for': 'markdown'}
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'ironcamel/vim-script-runner', {'for': ['sh', 'tcl']}
Plug 'preservim/nerdtree'
Plug 'w0rp/ale'

call plug#end()

"configure ALE plugin for shellchecks
" Enable ALE
let g:ale_linters = { 'sh': ['shellcheck'], }

" Enable ALE linting on save and on text change
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'always'

" Use ALE for fixing issues
let g:ale_fixers = { 'sh': ['shellcheck'], }

" Enable ALE fixing on save
let g:ale_fix_on_save = 1

"configure script_runner plugin for tcl
let g:script_runner_tcl = 'tclsh'

"configure NERDTree plugin  (examples in https://github.com/preservim/nerdtree)
"https://github.com/preservim/nerdtree/blob/master/doc/NERDTree.txt
" Start NERDTree and put the cursor back in the other window.
"autocmd VimEnter * NERDTree | wincmd p
" Start NERDTree when Vim is started without file arguments.
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
" Exit Vim if NERDTree is the only window remaining in the only tab. (vim8)
"autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it. (vim8)
"autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" show lines of files in NERDTree (very slow)
"let g:NERDTreeFileLines = 1
" hotkeys for NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>nc :NERDTreeClose<CR>
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
nnoremap <leader>nr :NERDTreeRefreshRoot<CR>
