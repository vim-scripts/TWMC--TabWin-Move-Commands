" File:         plugin/Tabcmd.vim
" Description:  Tab management commands similar to `:wincmd` of vim.
" Author:       yssl <http://github.com/yssl>
" License:      

if exists("g:loaded_tabcmd") || &cp
	finish
endif
let g:loaded_tabcmd	= 1
let s:keepcpo           = &cpo
set cpo&vim
"""""""""""""""""""""""""""""""""""""""""""""

" global variable
if !exists('g:tabcmd_restore_prevfocus')
	let g:tabcmd_restore_prevfocus = 1
endif
if !exists('g:tabcmd_prevtabnr')
	let g:tabcmd_prevtabnr = tabpagenr()
endif
if !exists('g:tabcmd_prevwinnr')
	let g:tabcmd_prevwinnr = tabpagenr()
endif

" commands
command! -nargs=1 Tabcmd call Tabcmd#Tabcmd(<f-args>)
command! TabcmdCloseWin call Tabcmd#CloseWin()

" autocmd
augroup TabcmdAutoCmds
	autocmd!
	autocmd TabLeave * call s:OnTabLeave() 
	autocmd WinLeave * call s:OnWinLeave() 
augroup END

" functions
fun! s:OnTabLeave()
	let g:tabcmd_prevtabnr = tabpagenr()
endfun
fun! s:OnWinLeave()
	let g:tabcmd_prevwinnr = winnr()
endfun

"""""""""""""""""""""""""""""""""""""""""""""
let &cpo= s:keepcpo
unlet s:keepcpo
