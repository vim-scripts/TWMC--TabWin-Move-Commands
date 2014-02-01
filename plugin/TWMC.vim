" File:         plugin/TWMC.vim
" Description:  TWMC: Tab/Win Move Commands for vim.
" Author:       yssl <http://github.com/yssl>
" License:      

if exists("g:loaded_twmc") || &cp
	finish
endif
let g:loaded_twmc	= 1
let s:keepcpo           = &cpo
set cpo&vim
"""""""""""""""""""""""""""""""""""""""""""""

" global variable
if !exists('g:twmc_restore_prevfocus')
	let g:twmc_restore_prevfocus = 1
endif
if !exists('g:twmc_prevtabnr')
	let g:twmc_prevtabnr = tabpagenr()
endif
if !exists('g:twmc_prevwinnr')
	let g:twmc_prevwinnr = tabpagenr()
endif

" commands
command! -nargs=1 Tabcmd call TWMC#Tabcmd(<f-args>)
command! -nargs=1 WincmdEx call TWMC#WincmdEx(<f-args>)

" autocmd
augroup TWMCAutoCmds
	autocmd!
	autocmd TabLeave * call s:OnTabLeave() 
	autocmd WinLeave * call s:OnWinLeave() 
augroup END

" functions
fun! s:OnTabLeave()
	let g:twmc_prevtabnr = tabpagenr()
endfun
fun! s:OnWinLeave()
	let g:twmc_prevwinnr = winnr()
endfun

"""""""""""""""""""""""""""""""""""""""""""""
let &cpo= s:keepcpo
unlet s:keepcpo
