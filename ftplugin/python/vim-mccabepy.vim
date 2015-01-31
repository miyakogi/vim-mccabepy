scriptencoding utf-8

function! g:MccabePy()
	let l:filepath = expand('%')

	let s:min_complexity = 10
	if exists('b:mccabepy_min_complexity')
		let s:min_complexity = b:mccabepy_min_complexity
	elseif exists('g:mccabepy_min_complexity')
		let s:min_complexity = g:mccabepy_min_complexity
	endif

	let l:cmd = 'python -m mccabe --min ' . s:min_complexity . ' ' . l:filepath

	let l:mccabe_msg = system(l:cmd)

	if match(l:mccabe_msg, 'No module named mccabe') > 0
		echohl ErrorMsg
		echon "Module 'mccabe' is not installed.\nPlease install it, by executing 'pip install mccabe'. "
		echohl
		return
	endif

	let l:mccabe_msg = substitute(l:mccabe_msg, "[()\"',]", '', 'g')
	let l:mccabe_msg = substitute(l:mccabe_msg, ': ', ':', 'g')
	let mccabe_list = split(l:mccabe_msg, '\n')
	let b:loc_list = []
	try
		for loc_line in mccabe_list
			let loc_item_list = split(loc_line, '\[: \]')
			let l:loc_item = {}
			let l:loc_item.type = 'W'
			let l:loc_item.filename = l:filepath
			let l:loc_item.lnum = loc_item_list[0]
			let l:cpl_num = loc_item_list[3]
			let l:loc_item.text =  loc_item_list[2] . ' (' . l:cpl_num . ')'
			call add(b:loc_list, l:loc_item)
		endfor
	catch /^Vim\%((\a\+)\)\=:E/
		echohl ErrorMsg
		echon ' - McCabe check Error - '
		echohl
		return
	endtry

	call setloclist(0, b:loc_list)

	if len(b:loc_list) > 0
		call s:loc_open()
	else
		call s:loc_close()
		hi MccabePyGreen term=reverse ctermfg=white ctermbg=green guifg=#fefefe guibg=#00cc00 gui=bold
		echohl MccabePyGreen
		echon ' - McCabe check OK - '
		echohl
	endif
endfunction

function! s:loc_open()
	let loc_open_cmd = 'lopen'
	if exists('g:mccabepy_loc_open_cmd')
		let loc_open_cmd = g:mccabepy_loc_open_cmd
	endif
  call s:loc_close()
	execute loc_open_cmd
endfunction

function! s:loc_close()
	let loc_close_cmd = 'lclose'
	if exists('g:mccabepy_loc_close_cmd')
		let loc_close_cmd = g:mccabepy_loc_close_cmd
	endif
	execute loc_close_cmd
endfunction

command! MccabePy call g:MccabePy()
