vim.cmd([[
augroup vimStartup
	autocmd!
	autocmd BufReadPost *
		\ let line = line("'\"")
		\ | if line >= 1 && line <= line("$") && &filetype !~# 'commit'
		\      && index(['xxd', 'gitrebase'], &filetype) == -1
		\ |   execute "normal! g`\""
		\ | endif
augroup END

set matchtime=0 ic nu

" Style/code
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
set ts=8 sw=8 sts=8 cc=80 tw=80
autocmd BufEnter *.html set ts=4 sts=4 sw=4

let g:mapleader=","
"" Window commands
"" Some useful ones:
"" cw + and cw -: increase and decrease window height.
"" cw > and cw <: increase and decrease window width.
"" cw =: make all windows the same height and width.
"" cw H: move current window to the left.
"" cw J: move current window to the bottom.
"" cw K: move current window to the top.
"" cw L: move current window to the right.
"" cw w: go to previous windows.
"" cw b: go to bottom window.
"" cw c: close current window.
"" cw f: split window and edit file under cursor.
"" cw h: go to the left window.
"" cw j: go to the bottom window.
"" cw k: go to the top window.
"" cw l: go to the right window.
map <leader>w <C-w>

"" Buffer commands
map <leader>bn :bn<CR>
map <leader>bp :bp<CR>

"" Movement
map <leader>cd <C-d>
map <leader>cu <C-u>

"" Undo/redo
map <leader>cr <C-r>

"" Buffers
map <leader><leader> :ls<cr>:b<space>

" C indentation and style
set cino=t0,l1,:0
set noexpandtab

" Persistent Undo
let target_path = expand('~/.config/nvim/persistent-undo/')
if !isdirectory(target_path)
    call system('mkdir -p ' . target_path)
endif
let &undodir = target_path
set undofile
set nohlsearch
]])

require("user.lazy")
require("user.keymaps")
