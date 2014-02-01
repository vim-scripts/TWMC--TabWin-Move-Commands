" File:         autoload/TWMC.vim
" Description:  TWMC: Tab/Win Move Commands for vim.
" Author:       yssl <http://github.com/yssl>
" License:      

" script variable

" Tabcmd functions
fun! TWMC#Tabcmd(arg)
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
	call s:JumpToTab(g:twmc_prevtabnr)
endfun

fun! s:CloseTab()
	let prevtabnr = g:twmc_prevtabnr
	if prevtabnr > tabpagenr()
		let prevtabnr = prevtabnr - 1
	endif

	tabclose

	if g:twmc_restore_prevfocus==1
		call s:JumpToTab(prevtabnr)
	endif
endfun

fun! s:JumpToTab(tabnum)
	exec 'tabnext' a:tabnum
endfun

" WincmdEx functions
fun! TWMC#WincmdEx(arg)
	if a:arg==#'q'
		call s:CloseWin()
	elseif a:arg==#'m'
		call s:ToggleMaxWin()
	else
		exec 'wincmd' a:arg
	endif
endfun

fun! s:CloseWin()
	let prevwinnr = g:twmc_prevwinnr
	if prevwinnr > winnr()
		let prevwinnr = prevwinnr - 1
	endif

	quit

	if g:twmc_restore_prevfocus==1
		call s:JumpToWin(prevwinnr)
	endif
endfun

fun! s:JumpToWin(winnum)
	exec a:winnum.'wincmd w'
endfun

fun! s:ToggleMaxWin()
	if exists('s:origsizecmd')
		exec s:origsizecmd
		unlet s:origsizecmd
	elseif winnr('$')>1
		let s:origsizecmd = winrestcmd()
		resize
		vert resize
	endif
endfun
