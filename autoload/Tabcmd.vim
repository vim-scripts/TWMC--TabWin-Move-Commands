" File:         autoload/Tabcmd.vim
" Description:  Tab management commands similar to `:wincmd` of vim.
" Author:       yssl <http://github.com/yssl>
" License:      

" script variable

" functions
fun! Tabcmd#Tabcmd(arg)
	if a:arg==#'h'
		call s:LeftTab()
	elseif a:arg==#'l'
		call s:RightTab()
	elseif a:arg==#'p'
		call s:PrevTab()
	elseif a:arg==#'q'
		call s:CloseTab()
	elseif a:arg==#'n'
		tabnew
	elseif a:arg==#'t'
		exec 'tabnext' 1
	elseif a:arg==#'b'
		exec 'tabnext' tabpagenr('$')
	elseif a:arg==#'w'
		tabnext
	elseif a:arg==#'W'
		tabprev
	elseif a:arg==#'o'
		tabonly
	endif
endfun

fun! Tabcmd#CloseWin()
	let prevwinnr = g:tabcmd_prevwinnr
	if prevwinnr > winnr()
		let prevwinnr = prevwinnr - 1
	endif

	quit

	if g:tabcmd_restore_prevfocus==1
		call s:JumpToWin(prevwinnr)
	endif
endfun

fun! s:JumpToWin(winnum)
	exec a:winnum.'wincmd w'
endfun

fun! s:LeftTab()
	if tabpagenr()==1
		return
	endif
	tabprev
endfun

fun! s:RightTab()
	if tabpagenr()==tabpagenr('$')
		return
	endif
	tabnext
endfun

fun! s:PrevTab()
	call s:JumpToTab(g:tabcmd_prevtabnr)
endfun

fun! s:JumpToTab(tabnum)
	exec 'tabnext' a:tabnum
endfun

fun! s:CloseTab()
	let prevtabnr = g:tabcmd_prevtabnr
	if prevtabnr > tabpagenr()
		let prevtabnr = prevtabnr - 1
	endif

	tabclose

	if g:tabcmd_restore_prevfocus==1
		call s:JumpToTab(prevtabnr)
	endif
endfun
