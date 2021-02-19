function! textreq#indent#get_indent(lnum)
	if a:lnum == 1
		return 0
	endif

	let curlnum = a:lnum

	while (curlnum > 1) 
		let curlnum -= 1
		if getline(curlnum) !~# "^\s*$"
			if !exists("firstNoemLineNumber")
				let firstNoemLineNumber = curlnum
				let firstNoemLineIndent = indent(curlnum)
			endif
			if (getline(curlnum) =~# '\v^\s*(\=|-)\w*(\=|-).*\(.*\):\s*$')
				let lastHeadIndent = indent(curlnum)
				break
			endif
		elseif curlnum == 1
			let firstNoemLineIndent = 0
			let lastHeadIndent = 0
		endif
	endwhile

	if (a:lnum - firstNoemLineNumber) > 1
		if exists("lastHeadIndent")
			return lastHeadIndent
		else
			return firstNoemLineIndent
		endif
	elseif getline(a:lnum - 1) =~# ".*:\s*$"
		return firstNoemLineIndent + &shiftwidth
	else
		return firstNoemLineIndent
	endif
endfunction




