"-----------------------------------------------------
" VUNDLE
"-----------------------------------------------------

" Turn off vi compatibility
  set nocompatible
  set encoding=utf8
  filetype off
  set rtp+=~/.vim/bundle/vundle/
  call vundle#rc()

" Plugin manager
  Plugin 'gmarik/vundle'

" Plugins
  Plugin 'vim-airline/vim-airline'
  Plugin 'vim-airline/vim-airline-themes'
  Plugin 'scrooloose/nerdtree'
  Plugin 'Xuyuanp/nerdtree-git-plugin'
  Plugin 'tpope/vim-fugitive'
  Plugin 'markcornick/vim-terraform'
  Plugin 'pearofducks/ansible-vim'

" Plugin config
  " Airline
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts = 1
    let g:airline_theme = 'term'
    let g:airline_section_y = []

  " Nerdtree git
    let g:NERDTreeIndicatorMapCustom = {
        \ "Untracked" : "?"
        \ }

" Finalise
  filetype plugin indent on

"-----------------------------------------------------
" MAPPINGS
"-----------------------------------------------------

  map <C-Right>   :next<CR>
  map <C-Left>    :prev<CR>
  map <S-Right>   :wnext<CR>
  map <S-Left>    :wprev<CR>

  map <F2>        :NERDTreeToggle<CR>
  map <F3>        <C-W><C-W>
  map <F5>        :w<CR>
  map <F9>        :edit!<CR>
  map <F10>       :set paste!<CR>
  map <F12>       :set number!<CR>

"-----------------------------------------------------
" GENERAL
"-----------------------------------------------------

" System
  filetype plugin on
  syntax on
  set backspace=indent,eol,start
  set t_Co=256

" Tabs
  set expandtab
  set shiftwidth=2
  set softtabstop=2

" Search
  set hlsearch
  set incsearch
  set smartcase
  set ignorecase

" Layout
  set number
  set laststatus=2
  set noshowmode

"-----------------------------------------------------

