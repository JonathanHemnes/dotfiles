
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'jelera/vim-javascript-syntax'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Valloric/YouCompleteMe'
Plug '/vim-syntastic/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'kien/ctrlp.vim'
Plug 'maksimr/vim-jsbeautify'

" Initialize plugin system
call plug#end()
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

map <c-f> :call JsBeautify()<cr>
map <C-n> :NERDTreeToggle<CR>

set number
set wildignore+=**/node_modules
set noswapfile 

let g:syntastic_javascript_eslint_exec='$(npm bin)/eslint'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


let g:ctrlp_custom_ignore = 'node_modules'


:filetype indent on
:set filetype=html
:set smartindent
