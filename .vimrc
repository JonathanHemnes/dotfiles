call plug#begin('~/.nvim/plugged')

" Make sure you use single quotes
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'alfredodeza/pytest.vim'
Plug 'airblade/vim-gitgutter'
Plug 'cakebaker/scss-syntax.vim'
Plug 'cespare/vim-toml'
Plug 'editorconfig/editorconfig-vim'
Plug 'hdima/python-syntax'
Plug 'hynek/vim-python-pep8-indent'
Plug 'janko-m/vim-test'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'jiangmiao/auto-pairs'
Plug 'ludovicchabant/vim-gutentags'
Plug 'machakann/vim-highlightedyank'
Plug 'machakann/vim-sandwich'
Plug 'maksimr/vim-jsbeautify'
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-grepper'
Plug 'mileszs/ack.vim'
Plug 'morhetz/gruvbox'
Plug 'mxw/vim-jsx'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Initialize plugin system
call plug#end()

set nocompatible      " We're running Vim, not Vi!

" hack to make the cursor move to the right whne using autopairs
autocmd VimEnter,BufEnter,BufWinEnter * silent! iunmap <buffer> <M-">

set guifont=Hack_Nerd_Font:h12

set background=dark
colorscheme gruvbox
let g:airline_theme = 'gruvbox'

let g:user_emmet_leader_key=','
let g:ale_python_yapf_use_global=1

syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use K to show documentation in preview window nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

autocmd BufWritePre * :%s/\s\+$//e

set completeopt-=preview
au Filetype javascript set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
au Filetype scss set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
au Filetype html set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
au Filetype ruby set tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab
au Filetype python set tabstop=4 softtabstop=4 expandtab shiftwidth=4 smarttab autoindent

let python_highlight_all = 1

let g:ale_fixers = {'python': ['yapf', 'isort']}

map <c-f> :call JsBeautify()<cr>
map <C-n> :NERDTreeToggle<CR>
map <C-p> :Files<CR>
map <C-o> :Buffers<CR>
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-H> <C-W>h<C-W>_
map <C-L> <C-W>l<C-W>_
nmap <silent><leader>ft <Plug>RunFileTest
nmap <silent><leader>nt <Plug>RunNearestTest
nmap <silent><leader>lt <Plug>RunLastTest
nmap <silent><leader>ct <Plug>CloseTestBuffer

nmap <silent><leader>cc :CocCommand<CR>

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

set number
set relativenumber
set noswapfile

:filetype indent on
:set filetype=html
:set smartindent
:set smartcase
:set ignorecase

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

nnoremap <leader>gg :Grepper<CR>

" ctag mapping
nnoremap <leader>. :CtrlPTag<cr>

" for vim-js to allow on regular .js files
let g:jsx_ext_required = 0

let $FZF_DEFAULT_COMMAND = 'ag -g ""'

let test#strategy = 'dispatch'
let test#python#pytest#executable = 'docker exec sb_web_test_1 pytest'
let test#python#runner = 'pytest'
let test#python#filename_modifier = ':'
function! DockerPytestTransform(cmd) abort
  return substitute(a:cmd, 'shredbetter/', '', '')
endfunction

nnoremap <leader>tn :TestNearest<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>ts :TestSuite<CR>

let g:test#custom_transformations = {'docker_pytest': function('DockerPytestTransform')}
let g:test#transformation = 'docker_pytest'

let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" gutentags setup stuff
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git']
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ ]
let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ '*/tests/*',
      \ 'build',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'compiled',
      \ 'docs',
      \ 'example',
      \ 'bundle',
      \ 'vendor',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]
