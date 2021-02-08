let s:loadReq = "set filetype=req| "
let s:loadReq = s:loadReq . "edit ++ff=dos | "
let s:loadReq = s:loadReq . "write"

augroup filetype_req
	autocmd!
	autocmd BufNewFile,BufRead *.req execute s:loadReq
augroup END

