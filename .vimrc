call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Valloric/YouCompleteMe'
Plug 'tpope/vim-surround'
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'mileszs/ack.vim'
Plug 'maksimr/vim-jsbeautify'
Plug 'jiangmiao/auto-pairs'
Plug 'janko-m/vim-test'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'cakebaker/scss-syntax.vim'
Plug 'w0rp/ale'
Plug 'tomlion/vim-solidity'
Plug 'posva/vim-vue'

" Initialize plugin system
call plug#end()
set nocompatible      " We're running Vim, not Vi!
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
set completeopt-=preview
au Filetype javascript set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
au Filetype scss set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
au Filetype html set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
au Filetype ruby set tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab

map <c-f> :call JsBeautify()<cr>
map <C-n> :NERDTreeToggle<CR>
map <C-p> :Files<CR>
map <C-o> :Buffers<CR>
map <C-t> :terminal<CR>
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-H> <C-W>h<C-W>_
map <C-L> <C-W>l<C-W>_
nmap <silent><leader>ft <Plug>RunFileTest
nmap <silent><leader>nt <Plug>RunNearestTest
nmap <silent><leader>lt <Plug>RunLastTest
nmap <silent><leader>ct <Plug>CloseTestBuffer

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

let g:syntastic_javascript_eslint_exec='$(npm bin)/eslint'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1

set number
set relativenumber
set noswapfile

:filetype indent on
:set filetype=html
:set smartindent

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" fugitive git bindings
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gt :Gcommit -v -q %:p<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <leader>gp :Ggrep<Space>
nnoremap <leader>gm :Gmove<Space>
nnoremap <leader>gb :Git branch<Space>
nnoremap <leader>go :Git checkout<Space>
nnoremap <leader>gps :Dispatch! git push<CR>
nnoremap <leader>gpl :Dispatch! git pull<CR>

" ctag mapping
nnoremap <leader>. :CtrlPTag<cr>

" for vim-js to allow on regular .js files
let g:jsx_ext_required = 0

let $FZF_DEFAULT_COMMAND = 'ag -g ""'

let test#strategy = 'neovim'
nmap <Plug>CloseTestBuffer :call CloseBuffer("bundle exec rspec")<CR>
nmap <Plug>RunFileTest :call RunTest("TestFile")<CR>
nmap <Plug>RunNearestTest :call RunTest("TestNearest")<CR>
nmap <Plug>RunlastTest :call RunTest("TestLast")<CR>

"autocmd BufWritePost */omni-th/app/* call RunTest("TestFile")

function! CloseBuffer(buffername)
    let bnr = bufnr(a:buffername)
    let wnr = bufwinnr('%')
    if bnr > 0
        :exe "bdelete!" . " " . bnr
        :exe wnr . "wincmd w"
    endif
endfunction

function! RunTest(test)
    call CloseBuffer("bundle exec rspec")
    let wnr = bufwinnr('%')
    :exe a:test
    :stopinsert
    :exe "res 20"
    :exe "normal G"
    if wnr > 0
        :exe wnr . "wincmd w"
    endif
endfunction
