noremap <script> <buffer> <silent> ]]
		\ :call <SID>NextSection(1, 0, 0)<cr>
noremap <script> <buffer> <silent> [[
		\ :call <SID>NextSection(1, 1, 0)<cr>
noremap <script> <buffer> <silent> ][
		\ :call <SID>NextSection(2, 0, 0)<cr>
noremap <script> <buffer> <silent> []
		\ :call <SID>NextSection(0, 1, 0)<cr>

vnoremap <script> <buffer> <silent> ]]
		\ :<c-u>call <SID>NextSection(1, 0, 1)<cr>
vnoremap <script> <buffer> <silent> [[
		\ :<c-u>call <SID>NextSection(1, 1, 1)<cr>
vnoremap <script> <buffer> <silent> ][
		\ :<c-u>call <SID>NextSection(2, 0, 1)<cr>
vnoremap <script> <buffer> <silent> []
		\ :<c-u>call <SID>NextSection(0, 1, 1)<cr>


function! s:NextSection(level, backwards, visual)
	if a:visual
		normal! gv
	endif

	let curLnum = line('.') 

	let curItem = s:FindCurItemIndent(curLnum)
	let curBorder = s:FindCurChapterBorder(curItem[0],curItem[1])

	if a:level == 0
		if curItem[1] == 0
			execute "silent normal! " . curItem[0] . "G"
		else
			execute "silent normal! " . curBorder[0] . "G"
		endif
		if foldclosed(line('.')) != -1
			execute "silent normal! zo"
		endif
		return
	elseif a:level == 2
		let flag = ''
		let stopline = curBorder[1]
		let startline = stopline
		let tarIndent = curItem[1] + &shiftwidth
	else
		let tarIndent = curItem[1]
		if a:backwards
			let flag = 'b'
			let stopline = curBorder[0]
			let startline = curBorder[1]
		else
			let flag = ''
			let stopline = curBorder[1]
			let startline = curBorder[0]
		endif
	endif

	let pattern = '\v^\s{' . tarIndent .'}(\=|-)\w*(\=|-).*\(.*\):\s*$'

	let result = search(pattern, flag, stopline) 
	if result == 0 && startline != stopline
		execute "silent normal! " . startline . "G"
		silent call search(pattern, flag, stopline) 
	endif

	if foldclosed(line('.')) != -1
		execute "silent normal! zo"
	endif

endfunction

function! s:FindCurItemIndent(lnum)

	if a:lnum == 1
		return [1, indent(a:lnum)]
	endif

	let curLnum = a:lnum

	while(curLnum > 1)
		if getline(curLnum) =~# '\v^\s*(\=|-)\w*(\=|-).*\(.*\):\s*$'
			return [curLnum, indent(curLnum)]
		endif
		let curLnum -= 1
	endwhile

	return [1, indent(1)]

endfunction

function! s:FindCurChapterBorder(lnum, indent)

	if a:indent == 0
		return [1, line('$')]
	endif

	let upIndent = a:indent - &shiftwidth

	let pattern = '\v^\s{' . upIndent .'}\=\w*\=.*\(.*\):\s*$' 

	if a:lnum == 1
		let upBorder = 1
	else
		let upBorder = search(pattern, 'bnW')
		if upBorder == 0
			let upBorder = 1
		endif
	endif

	let downBorder = search(pattern, 'nW')
	if downBorder == 0
		let downBorder = line('$')
	endif

	return [upBorder, downBorder]

endfunction





