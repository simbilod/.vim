syntax on
set nocompatible
filetype indent plugin on

" Pathogen
execute pathogen#infect('bundle/{}')

set backspace=eol,indent,start
set autoindent
set smartindent

" don't highlight the last search upon startup
set viminfo="h"

" Stay within 80 column limit, jackass
set colorcolumn=81

" Stop vim from beeping all the time
set vb

" Writing in Vim too!
autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en tw=80
autocmd BufRead,BufNewFile *.tex setlocal spell spelllang=en tw=80
set spelllang=en

" Tabs to spaces
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab

"Tell if you are in insert mode
set showmode

"match parenthesis, i.e. ) with ( and } with {
set showmatch

"ignore case when doing searches
set ignorecase
set smartcase

"tell how many lines have been changed
set report=0

set wildmode=longest,list

" Numb3rs!!
set number
set relativenumber

" Change colorscheme 
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

" Latex Stuff
set grepprg=grep\ -nH\ $*

let g:tex_flavor='latex'

" FILE EXPLORER!!
autocmd vimenter * NERDTree

:inoremap jk <Esc>

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  let isfirst = 1
  let words = []
  for word in split(a:cmdline)
    if isfirst
      let isfirst = 0  " don't change first word (shell command)
    else
      if word[0] =~ '\v[%#<]'
        let word = expand(word)
      endif
      let word = shellescape(word, 1)
    endif
    call add(words, word)
  endfor
  let expanded_cmdline = join(words)
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:  ' . a:cmdline)
  call setline(2, 'Expanded to:  ' . expanded_cmdline)
  call append(line('$'), substitute(getline(2), '.', '=', 'g'))
  silent execute '$read !'. expanded_cmdline
  1
endfunction
