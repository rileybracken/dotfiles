" Vim color file

" First remove all existing highlighting.
set background=light
hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "BlueSmoke"

" Normal should come first
" Orangish hue : #FEF1E0
hi Normalguifg=Grey5 guibg=White

hi Cursorguifg=White guibg=Black
hi lCursorguifg=NONE guibg=Cyan

hi Visualguifg=White guibg=SlateBlue
hi VisualNOSgui=underline,bold

hi Foldedguifg=#808080 guibg=#ECECEC

hi StatusLineNCguifg=Grey75 guibg=NavyBlue
hi VertSplit    guifg=Grey75 guibg=NavyBlue
hi StatusLineguifg=White guibg=NavyBlue gui=None

hi LineNrguifg=#959595 guibg=#ECECEC
hi CursorLineguibg=#FFF4CE

hi DiffAdd       guibg=LightBlue
hi DiffChange    guibg=LightMagenta
hi DiffDelete    gui=bold guifg=Blue guibg=LightCyan
hi DiffText      gui=bold guibg=Red
hi Directory     guifg=Blue
hi ErrorMsg      guibg=White guifg=DarkRed
hi Error         guibg=White guifg=DarkRed
hi FoldColumn    guibg=Grey guifg=DarkBlue
hi IncSearch     gui=reverse
hi ModeMsg       gui=None
hi MoreMsg       gui=None guifg=SeaGreen
hi NonText       gui=bold guifg=gray guibg=white
hi Pmenu         guibg=LightBlue
hi PmenuSel      guifg=White  guibg=DarkBlue
hi Question      gui=bold guifg=SeaGreen
hi Search        guibg=Yellow guifg=NONE
hi SpecialKey    guifg=Blue
hi Title         gui=bold guifg=Magenta
hi WarningMsg    guifg=Red
hi WildMenu      guibg=Yellow guifg=Black

" Syntax highlighting

hi Commentguifg=Grey50
hi Operatorguifg=Cyan4
hi Stringguifg=Red4
hi Constantguifg=Red4
hi Typeguifg=Blue3 gui=None
hi Identifierguifg=Cyan4
hi Functionguifg=Cyan4
hi PreProcguifg=magenta4
hi Specialguifg=magenta4
hi Statementguifg=Blue3 gui=None

" vim: sw=2
