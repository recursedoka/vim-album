" Vim syntax file
" Language:	Album
" Maintainer:	recursedoka <recursedoka@gmail.com>

" Suggestions and bug reports are solicited by the author.

" Initializing:

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case ignore

" Fascist highlighting: everything that doesn't fit the rules is an error...

syn match	albumError	![^ \t{}\[\]";]*!
syn match	albumError	"]"
syn match albumError  "}"

" Quoted and backquoted stuff
syn region albumQuoted matchgroup=Delimiter start="['`]" end=![ \t\{\}\[\]";]!me=e-1 contains=ALLBUT,albumStruc,albumSyntax,albumFunc

syn region albumQuoted matchgroup=Delimiter start="['`]\[" matchgroup=Delimiter end="\]" contains=ALLBUT,albumStruc,albumSyntax,albumFunc

syn region albumStrucRestricted matchgroup=Delimiter start="\[" matchgroup=Delimiter end="\]" contains=ALLBUT,albumStruc,albumSyntax,albumFunc

syn region albumUnquote matchgroup=Delimiter start="," end=![ \t\[\]{}";]!me=e-1 contains=ALLBUT,albumStruc,albumSyntax,albumFunc

syn region albumUnquote matchgroup=Delimiter start=",\[" end="]" contains=ALL

syn region albumUnquote matchgroup=Delimiter start=",{" end="}" contains=ALL

if version < 600
  set iskeyword=33,35-39,42-58,60-90,94,95,97-122,126,_
else
  setlocal iskeyword=33,35-39,42-58,60-90,94,95,97-122,126,_
endif

"Special Forms
syn keyword albumSyntax fn extend if begin def set! @

"Standard Forms
syn keyword albumFunc let zap!

" ... so that a single + or -, inside a quoted context, would not be
" interpreted as a number (outside such contexts, it's a albumFunc)

syn match	albumDelimiter	!\.[ \t\[\]{}";]!me=e-1
syn match	albumDelimiter	!\.$!
" ... and a single dot is not a number but a delimiter

" This keeps all other stuff unhighlighted, except *stuff*

syn match	albumOther	,[a-z!$%&*/:<=>?^_~+@#%-][-a-z!$%&*/:<=>?^_~0-9+.@#%]*,
syn match	albumError	,[a-z!$%&*/:<=>?^_~+@#%-][-a-z!$%&*/:<=>?^_~0-9+.@#%]*[^-a-z!$%&*/:<=>?^_~0-9+.@ \t\[\]{}";]\+[^ \t\[\]{}";]*,

" ... a special identifier

syn match	albumGlobal ,\*[-a-z!$%&*/:<=>?^_~0-9+.@]\+\*[ \t\[\]{}";],me=e-1
syn match	albumGlobal ,\*[-a-z!$%&*/:<=>?^_~0-9+.@]\+\*$,
syn match	albumError  ,\*[-a-z!$%&*/:<=>?^_~0-9+.@]*\*[^-a-z!$%&*/:<=>?^_~0-9+.@ \t\[\]{}";]\+[^ \t\[\]{}";]*,

" Non-quoted lists
syn region albumStruc matchgroup=Delimiter start="\[" matchgroup=Delimiter end="\]" contains=ALL
syn region albumStruc matchgroup=Delimiter start="{" matchgroup=Delimiter end="}" contains=ALL

" Simple literals:
syn region albumString start=+\%(\\\)\@<!"+ skip=+\\[\\"]+ end=+"+ contains=@Spell

" Comments:
syn match	albumComment	";.*$" contains=@Spell

" Writing out the complete description of Scheme numerals without
" using variables is a day's work for a trained secretary...
syn match	albumOther	![+-][ \t\[\]{}";]!me=e-1
syn match	albumOther	![+-]$!

" This is a useful lax approximation:
syn match	albumNumber	"[-#+.]\=[0-9][-#+/0-9a-f@i.boxesfdl]*"
syn match	albumError	![-#+0-9.][-#+/0-9a-f@i.boxesfdl]*[^-#+/0-9a-f@i.boxesfdl \t\[\]{}";][^ \t\[\]{}";]*!

syn match	albumBoolean	"nil"

syn match	albumCharacter	"#"
syn match	albumCharacter	"#."
syn match albumError	!#.[^ \t\[\]{}";]\+!
syn match	albumCharacter	"#space"
syn match	albumError	!#space[^ \t\[\]{}";]\+!
syn match	albumCharacter	"#newline"
syn match	albumError	!#newline[^ \t\[\]{}";]\+!
syn match albumCharacter "#x[0-9a-fA-F]\+"
syn match	albumCharacter	"#\%(return\|tab\)"

" anything limited by |'s is identifier
syn match albumOther "|[^|]\+|"

" Synchronization and the wrapping up...

syn sync match matchPlace grouphere NONE "^[^ \t]"
" ... i.e. synchronize on a line that starts at the left margin

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_album_syntax_inits")
  if version < 508
    let did_album_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink albumSyntax    Statement
  HiLink albumFunc      Function

  HiLink albumString    String
  HiLink albumCharacter Character
  HiLink albumNumber    Number

  HiLink albumDelimiter Delimiter
  HiLink albumGlobal    Constant

  HiLink albumComment   Comment
  HiLink albumError     Error

  HiLink albumQuoted    Constant
  HiLink albumUnquoted  Constant
  HiLink albumSplicing  Constant
  delcommand HiLink
endif

let b:current_syntax = "album"

let &cpo = s:cpo_save
unlet s:cpo_save
