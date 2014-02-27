scriptencoding utf-8

function! g:mccabepy()
	let l:filepath = expand('%')

	let s:min_complexity = 10
	if exists('b:mccabepy_min_complexity')
		let s:min_complexity = b:mccabepy_min_complexity
	elseif exists('g:mccabepy_min_complexity')
		let s:min_complexity = g:mccabepy_min_complexity
	endif

	let l:cmd = 'python -m mccabe --min ' . s:min_complexity . " " . l:filepath

	let l:err_msg = system(l:cmd)

	if match(l:err_msg, 'No module named mccabe') > 0
		echohl ErrorMsg
		echon "Module 'mccabe' is not installed.\nPlease install it, by executing 'pip install mccabe'. "
		echohl
		return
	endif

	let l:err_msg = substitute(l:err_msg, "[()\"',]", "", "g")
	let l:err_msg = substitute(l:err_msg, ": ", ":", "g")
	let err_list = split(l:err_msg, '\n')
	let b:qf_list = []
	try
		for err in err_list
			let err_item_list = split(err, "\[: \]")
			let l:err_item = {}
			let l:err_item.type = 'W'
			let l:err_item.filename = l:filepath
			let l:err_item.lnum = err_item_list[0]
			let l:cpl_num = err_item_list[3]
			let l:err_item.text =  err_item_list[2] . " (" . l:cpl_num . ")"
			call add(b:qf_list, l:err_item)
		endfor
	catch /^Vim\%((\a\+)\)\=:E/
		echohl ErrorMsg
		echon " - McCabe check Error - "
		echohl
		return
	endtry

	call setqflist(b:qf_list)

	if len(b:qf_list) > 0
		call s:open_qfix()
	else
		call s:close_qfix()
		hi MccabePyGreen term=reverse ctermfg=white ctermbg=green guifg=#fefefe guibg=#00cc00 gui=bold
		echohl MccabePyGreen
		echon " - McCabe check OK - "
		echohl
	endif
endfunction

function! s:open_qfix()
	let qfix_command = 'copen'
	if exists('g:mccabepy_qfix_command')
		let qfix_command = g:mccabepy_qfix_command
	endif
	execute qfix_command
endfunction

function! s:close_qfix()
	let qfix_close_command = 'cclose'
	if exists('g:mccabepy_qfix_close_command')
		let qfix_close_command = g:mccabepy_qfix_close_command
	endif
	execute qfix_close_command
endfunction

command! MccabePy call g:mccabepy()
