//brew install the_silver_searcher
//brew install fzf

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'jelera/vim-javascript-syntax'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Valloric/YouCompleteMe'
Plug '/vim-syntastic/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'mileszs/ack.vim'
Plug 'maksimr/vim-jsbeautify'
Plug 'jiangmiao/auto-pairs'
Plug 'janko-m/vim-test'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sensible'

" Initialize plugin system
call plug#end()
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set completeopt-=preview

map <c-f> :call JsBeautify()<cr>
map <C-n> :NERDTreeToggle<CR>
map <C-p> :Files<CR>
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-H> <C-W>h<C-W>_
map <C-L> <C-W>l<C-W>_

nmap <silent> <leader>t :TestNearest<CR>

let g:syntastic_javascript_eslint_exec='$(npm bin)/eslint'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set number
set noswapfile

:filetype indent on
:set filetype=html
:set smartindent

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
