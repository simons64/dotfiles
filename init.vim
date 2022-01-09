set runtimepath^=~/.vim 
let &packpath = &runtimepath

colors desert

syntax on


" Set <tab> to 2 spaces
set ts=2 sw=2

" Search dir recursivly
set path+=**

" Display finds + tab complete
set wildmenu
" Now :b to switch and :ls to list open buffers


" TAG JUMPING:
" Create tags file
command! MakeTags !ctags -R .

" ^] to jump to tag
" g^] for ambiguois tags
" ^t to jump back

" AUTOCOMPLETE: built in by default
" - ^x^n for JUST this file
" - ^x^f for filenames
" - ^x^] tags
" - ^n for anything specified by 'complete' option

" Use ^n and ^p to go back and forth in suggestions list

" FILE BROWSER: 
"let g:netrw_banner=0       "disable banner
"let g:netrw_browse_split=4 "open in prior window
"let g:netrw_altv=1         "open splits to the right
"let g:netrw_liststyle=3    "tree view
"let g:netrw_list_hide=netrw_gitignore#Hide()
"let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'


" edit a folder to open file browser
" ^v ^t split or tab
" :help netrw-brows-maps

" SNIPPETS:
" Read a Template and paste it:

nnoremap ,html :-read $HOME/.vim/.skeleton.html<CR>3jwf>a
" first n is normal mode ...

set showmode
set showcmd

" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set number
set relativenumber

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a

" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>


