set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

call plug#begin('~/.nvim/plugged')

" Make sure you use single quotes
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'hdima/python-syntax'
Plug 'hynek/vim-python-pep8-indent'
Plug 'janko-m/vim-test'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'jiangmiao/auto-pairs'
Plug 'machakann/vim-highlightedyank'
Plug 'machakann/vim-sandwich'
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-grepper'
Plug 'mileszs/ack.vim'
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-sleuth'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'easymotion/vim-easymotion'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim', {'branch': 'main'}
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'ActivityWatch/aw-watcher-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Initialize plugin system
call plug#end()
lua require('config')

set nocompatible      " We're running Vim, not Vi!

set visualbell

" hack to make the cursor move to the right whne using autopairs
autocmd VimEnter,BufEnter,BufWinEnter * silent! iunmap <buffer> <M-">

au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx

set guifont=Hack_Nerd_Font:h12

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set background=dark
colorscheme gruvbox
let g:airline_theme = 'gruvbox'

let g:user_emmet_leader_key=','


syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let python_highlight_all = 1


map <C-n> :NERDTreeToggle<CR>
map <C-p> <cmd>Telescope find_files<CR>
map <C-o> <cmd>Telescope buffers<CR>
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

set number
set relativenumber
set noswapfile

:filetype indent on
:set smartindent
:set smartcase
:set ignorecase

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" fugitive git bindings
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gc :Git commit -v -q<CR>
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

nnoremap <leader>fw :Telescope grep_string<CR>
nnoremap <leader>fs :Telescope live_grep<CR>

" ctag mapping
nnoremap <leader>. :CtrlPTag<cr>

let $FZF_DEFAULT_COMMAND = 'ag -g ""'

let test#strategy = 'dispatch'
let test#javascript#jest#executable = 'yarn test'
let test#javascript##jest#file_pattern='.+\.(e2e|spec|test).ts$'

nnoremap <leader>tn :TestNearest<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>ts :TestSuite<CR>

nmap <silent> gd <Plug>(coc-definition)
nnoremap <silent> K :call <SID>show_documentation()<CR>
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction


let $FZF_DEFAULT_COMMAND = 'ag -g ""'


" completion presets
" set completeopt=menuone,noinsert,noselect
"
set completeopt=menuone
"" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-y>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


