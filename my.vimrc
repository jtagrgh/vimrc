execute pathogen#infect()
filetype plugin indent on

set mouse-=a
colo pablo
set background=dark
syntax on
set nowrap
set hlsearch
set laststatus=2
set number
set relativenumber
set ts=3
set sw=3
set autoindent
set expandtab
set cursorline
set ruler
set ignorecase
set smartcase
set nocompatible
set path+=**
set wildmenu
set breakindent
set breakindentopt=shift:2
set showbreak=>> 
nnoremap <silent> ,e :Explore<CR>
nnoremap <silent> ,t :Texplore<CR>
inoremap jk <Esc>
noremap <silent> ,m :marks abcdefghipqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ<CR>:normal! `
noremap <silent> * :let @/= '\<' . expand('<cword>') . '\>' <bar> set hls <cr>
nnoremap <silent> ,h :set hlsearch!<CR>
nnoremap <silent> ,v :e ~/.vimrc<CR>
nnoremap <silent> ,vr :so ~/.vimrc<CR>
nnoremap <silent> ,c :!ctags -R<CR>
nnoremap <silent> ,d :delm A-Z<CR>
nnoremap <silent> ,r :set relativenumber!<CR>
nnoremap <silent> ,w :set wrap!<CR>
nnoremap <silent> cn :cn<CR>
nnoremap <silent> cp :cp<CR>
nnoremap <silent> co :copen<CR>
nnoremap <silent> cx :cclose<CR>
nnoremap <silent> tn :lnext<CR>
nnoremap <silent> tp :lp<CR>
nnoremap <silent> to :lopen<CR>
nnoremap <silent> tx :lclose<CR>

" show current context function name ... idk if this works for anything other
" than c/c++
fun! ShowFuncName()
 let lnum = line(".")
 let col = col(".")
 echohl ModeMsg
 echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
 echohl None
 call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun
map ,f :call ShowFuncName() <CR>

" find files and populate the quickfix list
fun! FindFiles(filename)
   let error_file = tempname()
   silent exe '!find . -name "'.a:filename.'" | xargs file | sed "s/:/:1:/" > '.error_file
   set errorformat=%f:%l:%m
   exe "cfile ". error_file
   copen
   call delete(error_file)
endfun
command! -nargs=1 FindFile call FindFiles(<q-args>)
