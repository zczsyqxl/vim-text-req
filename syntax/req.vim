if exists("b:current_syntax")
	finish
endif


let s:cpo_save = &cpo
set cpo&vim

" syntax keyword reqHead REQ_Title  
" syntax keyword reqItem #Ano REQ_Req REQ_Irr REQ_Dup REQ_Rqr 
syntax keyword reqValue TRUE FALASE

syntax region reqHeadText  matchgroup=reqHead oneline start=/=\<Title\>=/ end=/(/me=s-1 
syntax region reqId matchgroup=reqIdBrace oneline start=/(/ end=/):\e*$/ 
syntax region reqString matchgroup=reqString start=+\(^\|\W\+\)"+ skip=+\\"+ end=+"+ 

syntax match reqItem /-\(Annotation\|Requ\|Irr\|Irrelevant\|Duplicate\|Requ Ref\)-/
syntax match reqSignal /\<\(RET\|SN\)_\(IN\|OUT\)_\w\+/
syntax match reqMacro /\<\u\+_\u\+[0-9A-Z_]*\>/

hi def link reqHead Statement
hi def link reqItem Statement
hi def link reqHeadText Title
hi def link reqId Comment
hi def link reqIdBrace Statement
hi def link reqSignal Identifier
hi def link reqMacro Type
hi def link reqString String
hi def link reqValue String

let &cpo = s:cpo_save
unlet s:cpo_save

let b:current_syntax = "req"
