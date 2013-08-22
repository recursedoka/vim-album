" Vim filetype plugin
" Language:      Album
" Maintainer:    recursedoka <recursedoka@gmail.com>
" URL:		 http://github.com/recursedoka/vim-album

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

" Copy-paste from ftplugin/lisp.vim
setl comments=:;
setl define=^\\s*[def\\k*
setl formatoptions-=t
setl iskeyword+=+,-,*,/,%,<,=,>,:,$,?,!,@-@,94
setl lisp
setl commentstring=;%s

" make comments behaviour like in c.vim
" e.g. insertion of ;;; and ;; on normal "O" or "o" when staying in comment
setl comments^=:;;;,:;;,sr:#\|,mb:\|,ex:\|#
setl formatoptions+=croql

let b:undo_ftplugin = "setlocal comments< define< formatoptions< iskeyword< lispwords< lisp< commentstring<"
