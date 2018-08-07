set syntax=python
color badwolf
call SyntaxRange#Include("'''", "'''", 'javascript', 'NonText')
call SyntaxRange#Include("'''md", "'''", 'markdown', 'NonText')
" stolen from wombat:
hi pythonFunction     ctermfg=192     cterm=none      guifg=#cae982   gui=none
hi pythonKeyword      ctermfg=111     cterm=none      guifg=#88b8f6   gui=none
hi pythonStatement    ctermfg=111     cterm=none      guifg=#88b8f6   gui=none
hi pythonConstant     ctermfg=173     cterm=none      guifg=#e5786d   gui=none
hi pythonNumber       ctermfg=173     cterm=none      guifg=#e5786d   gui=none
hi pythonPreProc      ctermfg=173     cterm=none      guifg=#e5786d   gui=none
hi pythonFunction     ctermfg=192     cterm=none      guifg=#cae982   gui=none
hi pythonIdentifier   ctermfg=192     cterm=none      guifg=#cae982   gui=none
hi pythonType         ctermfg=186     cterm=none      guifg=#d4d987   gui=none
hi pythonSpecial      ctermfg=229     cterm=none      guifg=#eadead   gui=none
hi pythonString       ctermfg=113     cterm=none      guifg=#95e454   gui=italic
hi pythonComment      ctermfg=246     cterm=none      guifg=#9c998e   gui=italic
hi pythonTodo         ctermfg=101     cterm=none      guifg=#857b6f   gui=italic


