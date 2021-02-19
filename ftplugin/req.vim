" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1

setlocal foldmethod=indent

nnoremap <buffer> ]r :silent! call search('-\<\(Requ\\|Annotation\\|Duplicate\\|Irrelevant\\|Requ Ref\)\>-')<cr>
nnoremap <buffer> [r :silent! call search('-\<\(Requ\\|Annotation\\|Duplicate\\|Irrelevant\\|Requ Ref\)\>-','b')<cr>
nnoremap <buffer> ]t :silent! call search('=\<Title\>=')<cr>
nnoremap <buffer> [t :silent! call search('=\<Title\>=','b')<cr>

abbreviate <buffer> tt =Title= (ReqID_Temp_65535):<c-left><c-left><c-left><left>
abbreviate <buffer> ano -Annotation- (ReqID_Temp_65535):
abbreviate <buffer> req -Requ- (ReqID_Temp_65535):
abbreviate <buffer> dup -Duplicate- (ReqID_Temp_65535):
abbreviate <buffer> irr -Irrelevant- (ReqID_Temp_65535):
abbreviate <buffer> rqr -Requ Ref- (ReqID_Temp_65535):
abbreviate <buffer> si SN_IN_
abbreviate <buffer> sio SN_OUT_
abbreviate <buffer> ri RET_IN_
abbreviate <buffer> ro RET_OUT_

let b:undo_ftplugin = "setlocal foldmethod< cindent<"
