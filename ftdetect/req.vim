let s:loadReq = "set filetype=req expandtab| "
let s:loadReq = s:loadReq . "edit ++ff=dos | "
let s:loadReq = s:loadReq . "retab | "
let s:loadReq = s:loadReq . "write"

augroup filetype_req
	autocmd!
	autocmd BufNewFile,BufRead *.req execute s:loadReq
augroup END

