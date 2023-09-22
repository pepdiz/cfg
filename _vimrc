" system vimrc {{{
" la misma configuracion que $VIM/_vimrc
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '\"' . arg1 . '\"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '\"' . arg2 . '\"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '\"' . arg3 . '\"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '\"' . $VIMRUNTIME . '\diff\"'
      let eq = '\"\"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '\" ', '') . '\diff\"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
" }}}

" mi configuracion {{{
set encoding=utf-8
set fileencodings=utf-8,default,latin1,cp1252
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
set laststatus=2
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
set statusline=%1*\ %n\ %*			" numero de buffer
set statusline+=%4*%<%F\ %* 			" relative path filename
set statusline+=%2*%m\ %*       		" modificado?
set statusline+=%1*%r\ %*			" solo lectura?
set statusline+=%= 				" escribir en borde derecho
set statusline+=%3*%y\ %*			" tipo de fichero 
set statusline+=%5*%.10{Sl_encoding()}\ %*	" encoding
set statusline+=%5*%.7{Sl_fileformat()}\ %*	" file format
set statusline+=%1*%3c%V\ :\ %-.5l%*%2*/%-L\ %*	" col : linea (total lineas)

hi User1 guifg=#eea040 guibg=#222222
hi User2 guifg=#dd3333 guibg=#222222
hi User3 guifg=#ff66ff guibg=#222222
hi User4 guifg=#a0ee40 guibg=#222222
hi User5 guifg=#eeee40 guibg=#222222


" version 2 ------------------------------------------------------------
"set statusline=
"set statusline+=%7*\[%n]                                  "buffernr
"set statusline+=%1*\ %<%F\                                "File+path
"set statusline+=%2*\ %y\                                  "FileType
"set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
"set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
"set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..) 
"set statusline+=%5*\ %{&spelllang}\%{HighlightSearch()}\  "Spellanguage & Highlight on?
"set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
"set statusline+=%9*\ col:%03c\                            "Colnr
"set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly? Top/bot.
"function! HighlightSearch()
  "if &hls
    "return 'H'
  "else
    "return ''
  "endif
"endfunction
"hi User1 guifg=#ffdad8  guibg=#880c0e
"hi User2 guifg=#000000  guibg=#F4905C
"hi User3 guifg=#292b00  guibg=#f4f597
"hi User4 guifg=#112605  guibg=#aefe7B
"hi User5 guifg=#051d00  guibg=#7dcc7d
"hi User7 guifg=#ffffff  guibg=#880c0e gui=bold
"hi User8 guifg=#ffffff  guibg=#5b7fbb
"hi User9 guifg=#ffffff  guibg=#810085
"hi User0 guifg=#ffffff  guibg=#094afe

" version 3 ------------------------------------------------------------
"set statusline=
"set statusline +=%1*\ %n\ %*            "buffer number
"set statusline +=%5*%{&ff}%*            "file format
"set statusline +=%3*%y%*                "file type
"set statusline +=%4*\ %<%F%*            "full path
"set statusline +=%2*%m%*                "modified flag
"set statusline +=%1*%=%5l%*             "current line
"set statusline +=%2*/%L%*               "total lines
"set statusline +=%1*%4v\ %*             "virtual column number
"set statusline +=%2*0x%04B\ %*          "character under cursor
"hi User1 guifg=#eea040 guibg=#222222
"hi User2 guifg=#dd3333 guibg=#222222
"hi User3 guifg=#ff66ff guibg=#222222
"hi User4 guifg=#a0ee40 guibg=#222222
"hi User5 guifg=#eeee40 guibg=#222222


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

" allow using cursor keys in visual mode
vnoremap <left> h
vnoremap <down> j
vnoremap <up> k
vnoremap <right> l

" }}}

" autocommands {{{
autocmd BufWritePre,BufRead *.xml :normal gg=G
autocmd BufWritePre,BufRead *.html :normal gg=G
"augroup filetype_html
"    autocmd!
"    autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
"augroup END
" }}}

" }}}
