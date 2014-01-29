# Tabcmd

Tabcmd is a vim plugin for tab management commands similar to `:wincmd` of vim.
It provides additional features to move focus to the previously focused tab or window when a tab or window is closed.

## Usage

In vim normal mode, you can just type `:Tabcmd {arg}` (similar to `:wincmd {arg}`).  
List of available `{arg}` is:

{arg} | Tabcmd | wincmd (for comparison)
---   | --- | ---
**h** | Go to the left tab page. | Move cursor to the window left of current one.
**l** | Go to the right tab page. | Move cursor to the window right of current one.
**W** | Go to the left tab page. Wraps around from the first to the last one. | Move cursor to window below/right of the current one. If there is no window below or right, go to top-left window.
**w** | Go to the right tab page. Wraps around from the last to the first one.  | Move cursor to window above/left of the current one. If there is no window above or left, go to bottom-right window.
**t** | Go to the first tab page. | Move cursor to top-left window.
**b** | Go to the last tab page. | Move cursor to bottom-right window.
**p** | Go to the previous tab page. | Go to the previous window.
**q** | Close current tab page and move focus to previously focused one. | Quit current window.
**n** | Open a new tab page with an empty window, after the current tab page. | Create a new window and start editing an empty file in it.
**o** | Close all other tab pages. | Make the current window the only one on the screen. All other windows are closed.

An additional command:

**:TabcmdCloseWin**  
Close current window and move focus to previously focused one.
You can use this command instead of `ctrl-w q` or `:wincmd q`.

## Recommended Key Mappings

Tabcmd does not provide default key mappings to keep your key mappings clean.
Instead, I suggest convinient key mappings what I'm using now.
You can add them to your .vimrc if you want.
Of course, you can modify it as you want.

```
function! s:nnoreicmap(option, shortcut, command)
	execute 'nnoremap '.a:option.' '.a:shortcut.' '.a:command
	execute 'imap '.a:option.' '.a:shortcut.' <Esc>'.a:shortcut
	execute 'cmap '.a:option.' '.a:shortcut.' <Esc>'.a:shortcut
endfunction

call s:nnoreicmap('','<A-H>',':Tabcmd h<CR>')
call s:nnoreicmap('','<A-L>',':Tabcmd l<CR>')
call s:nnoreicmap('','<A-P>',':Tabcmd p<CR>')
call s:nnoreicmap('','<A-Q>',':Tabcmd q<CR>')
call s:nnoreicmap('','<A-N>',':Tabcmd n<CR>')

call s:nnoreicmap('','<A-h>',':wincmd h<CR>')
call s:nnoreicmap('','<A-j>',':wincmd j<CR>') 
call s:nnoreicmap('','<A-k>',':wincmd k<CR>')
call s:nnoreicmap('','<A-l>',':wincmd l<CR>')
call s:nnoreicmap('','<A-q>',':TabcmdCloseWin<CR>')
call s:nnoreicmap('','<A-p>',':wincmd p<CR>')
call s:nnoreicmap('','<A-n>',':wincmd n<CR>')
```

I've define the function `s:nnoreicmap()` to map for normal, insert and command-line modes simultaneously,
and installed ![vim-fixkey](https://github.com/drmikehenry/vim-fixkey) plugin to use alt-key mappings.
`<A-H>` means alt+shift+h.
