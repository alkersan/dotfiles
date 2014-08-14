" vim:fdm=marker

"Vim-Plug {{{
call plug#begin('~/.vim/plugged')

Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-endwise'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rking/ag.vim'
Plug 'qpkorr/vim-bufkill'
Plug 'takac/vim-hardtime'
Plug 'Lokaltog/vim-easymotion'
Plug 'airblade/vim-rooter'
Plug 'sjl/gundo.vim'
Plug 'danro/rename.vim'
Plug 'xolox/vim-misc'
Plug 'godlygeek/tabular'
Plug 'gorodinskiy/vim-coloresque'
Plug 'tsukkee/unite-tag'
Plug 'Shougo/unite-outline'
Plug 'osyo-manga/unite-quickfix'
Plug 'groenewege/vim-less'
Plug 'gre/play2vim'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'krisajenkins/vim-pipe'
Plug 'krisajenkins/vim-postgresql-syntax'

call plug#end()
"}}}

" Settings {{{
" Don't unload buffer when it is abandoned
set hidden

" Don't wrap lines
set nowrap

" Tab are 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Remove the vim's safety net
set nobackup
set nowritebackup
set noswapfile

" Allow the cursor to go to 'invalid' places
set virtualedit=all

" Whet the page starts to scroll, keep the cursor 3 lines from the top
" and 3 lines from the bottom
set scrolloff=3

" Enable mouse
set mouse=a
" Hide mouse pointer while typing
set mousehide

" Show line numbers
set number
" Try relative line numbering
set relativenumber

" By defult disalbe search highlighting
set nohlsearch

" Draw line at the end of maximum logical text column
set colorcolumn=100
" But don't force wrapping to that width
set textwidth=0
set wrapmargin=0

" I hate that damned beeping
set visualbell

" Types of files to ignore when autocompletiong things
set wildignore+=*.o,*.class,*.git,*.svn,*.class

" Let :help be the K program to search for Keywords
set keywordprg=:help

" Set minimum of gui elements (Autoselect, console dialogs, tabs)
set guioptions=ac
" Set my favorite font for gui
" Use different format for Linux GTK and OSX
if has("gui_gtk2")
  set guifont=Hermit\ Medium\ 11
else
  set guifont=Hermit\ Medium:h13
endif

" Let yank\delete\put to clipboard
set clipboard=unnamed
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

" Using my favorite color scheme
set background=dark
colorscheme xoria256

" To fix indentation problem on pasting
" manually toggle paste-mode
set pastetoggle=<F2>

" Same as default except 'u' option
set complete=.,w,b,t

" Make wide characters double width
" set ambiwidth=double

" Change the leader key from \ to ,
let mapleader=","
let maplocalleader=" "

" Reveal hidden symbols
set listchars=tab:▸\ ,eol:¬
nmap <leader>l :set list!<CR>

" Get rid of error on closing buffer with unsaved change
set confirm

let g:netrw_dirhistmax=0
let g:netrw_liststyle=3

"}}}

" Mappings and staff {{{
" Strip all trailing whitespaces in current file
nnoremap <silent> <leader>W :%s/\s\+$//e<CR>:let @/=''<CR>

" Map for Silver Searcher
nnoremap <leader>a :Ag

" Quickly edit/reload .vimrc/.bashrc/.zshrc
nnoremap <silent> <leader>ev :tabnew $MYVIMRC<CR>
nnoremap <silent> <leader>so :source $MYVIMRC<CR>
nnoremap <silent> <leader>eb :tabnew ~/.bashrc<CR>
nnoremap <silent> <leader>ez :tabnew ~/.zshrc<CR>

" Lets make window navigation easier
nmap <silent> <C-H> :wincmd h<CR>
nmap <silent> <C-J> :wincmd j<CR>
nmap <silent> <C-K> :wincmd k<CR>
nmap <silent> <C-L> :wincmd l<CR>

" Toggle search highligting
nnoremap <silent> <leader>n :<C-u>set hlsearch!<CR>

" Make the current file executable
"nmap ,x :w<cr>:!chmod 755 %<cr>:e<cr>

" When forgot to sudo before editing, use this trick
" Taken from Steve Losh http://stevelosh.com/blog/2010/09/coming-home-to-vim
cmap w!! write !sudo tee % >/dev/null

" Change directory to $HOME/.vim when editing .vimrc
" Useful for Unite, because index of the whole $HOME dir is too large
augroup vimrc_enter
  autocmd!
  autocmd BufEnter .vimrc :lcd $HOME/.vim
augroup END

augroup zshrc_enter
  autocmd!
  autocmd BufEnter .zshrc :lcd $HOME/dotfiles
augroup END

" Automatically equalize windows if vim was resized
au VimResized * exe "normal! \<c-w>="

" Under linux this one-liner opens the URL under the cursor
nnoremap <leader>o :silent !xdg-open <C-R>=escape("<C-R><C-F>", "#?&;\|%")<CR>&<CR>

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
"}}}

" Plugins {{{
" HardTime {{{
let g:hardtime_default_on = 0
let g:hardtime_allow_different_key = 1
nnoremap <silent> <leader>H :<C-u>HardTimeToggle<CR>
"}}}
" Airline {{{
let g:airline_powerline_fonts=1
let g:airline_theme='badwolf'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#tabline#enabled = 1
 let g:airline#extensions#tabline#left_sep = ''
 let g:airline#extensions#tabline#left_alt_sep = ''
"}}}
" Unite {{{
call unite#custom#profile('default', 'context', {
      \ 'start_insert':1,
      \ 'winheight':15,
      \ 'winwidth':48,
      \ 'direction':'botright',
      \ 'prompt':'» ',
      \ 'prompt_direction':'top',
      \ 'ignorecase':1
      \ })
" call unite#custom#profile('default', 'ignorecase', 1)
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use([ 'sorter_rank' ])
let g:unite_force_overwrite_statusline = 0
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nocolor --nogroup --hidden --ignore .git --ignore .svn --ignore .class'
let g:unite_source_grep_recursive_opt = ''
let g:unite_source_history_yank_enable = 1
let g:unite_source_file_rec_max_cache_files = 0
let g:unite_source_rec_async_command = 'ag --follow --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .class
      \ --ignore target
      \ --ignore .lib-src
      \ -g ""'

" Menus {{{
let g:unite_source_menu_menus = {}
" prefix key for menus
nnoremap [menu] <Nop>
nmap <localleader> [menu]
" menu with all Unite menus
nnoremap <silent>[menu]m :Unite -silent -no-start-insert menu<CR>

" files {{{
let g:unite_source_menu_menus.files = {
      \'description': '         files & dirs               ⌘ [space]f' }
let g:unite_source_menu_menus.files.command_candidates = [
      \['▷ search file recursive            ⌘ ,f',
        \'Unite file_rec'],
      \['▷ search MRU files                 ⌘ ,r',
        \'Unite file_mru'],
      \['▷ edit new file',
        \'Unite file/new'],
      \['▷ search directory',
        \'Unite directory'],
      \['▷ search MRU directory',
        \'Unite directory_mru'],
      \['▷ search directories recusively',
        \'Unite directory_rec'],
      \['▷ create new directory',
        \'Unite directory/new'],
      \['▷ change working directory',
        \'Unite -default-action=lcd directory'],
      \['▷ get current working directory',
        \'Unite output:pwd'],
      \['▷ save as root                     ⌘ :w!!',
        \'execute "write !sudo tee % > /dev/null"'],
      \]

nnoremap <silent>[menu]f :Unite -silent -no-start-insert menu:files<CR>
" }}}
" grep {{{
let g:unite_source_menu_menus.grep = {
      \'description': '          search files               ⌘ [space]s' }
let g:unite_source_menu_menus.grep.command_candidates = [
      \['▷ silver searcher                  ⌘ <F3>',
        \'Unite grep:.'],
      \]
nnoremap <silent>[menu]s :Unite -silent -no-start-insert menu:grep<CR>
" }}}
" buffers, tabs & windows {{{
let g:unite_source_menu_menus.nav = {
      \'description': '           buffers, tabs & windows    ⌘ [space]n' }
let g:unite_source_menu_menus.nav.command_candidates = [
      \['▷ buffers',
        \'Unite buffer'],
      \['▷ tabs',
        \'Unite tab'],
      \['▷ windows',
        \'Unite window'],
      \['▷ new vertical split',
        \'vsplit'],
      \['▷ new horizontal split',
        \'split'],
      \]
nnoremap <silent>[menu]n :Unite -silent -no-start-insert menu:nav<CR>
" }}}
" neobundle menu {{{
let g:unite_source_menu_menus.neobundle = {
      \'description': '     neobundle operations       ⌘ [space]b',
    \}
let g:unite_source_menu_menus.neobundle.command_candidates = [
    \['▷ neobundle',
        \'Unite neobundle'],
    \['▷ neobundle log',
        \'Unite neobundle/log'],
    \['▷ neobundle lazy',
        \'Unite neobundle/lazy'],
    \['▷ neobundle update',
        \'Unite neobundle/update'],
    \['▷ neobundle search',
        \'Unite neobundle/search'],
    \['▷ neobundle install',
        \'Unite neobundle/install'],
    \['▷ neobundle check',
        \'Unite -no-empty output:NeoBundleCheck'],
    \['▷ neobundle docs',
        \'Unite output:NeoBundleDocs'],
    \['▷ neobundle clean',
        \'NeoBundleClean'],
    \['▷ neobundle rollback',
        \'exe "NeoBundleRollback" input("plugin: ")'],
    \['▷ neobundle list',
        \'Unite output:NeoBundleList'],
    \['▷ neobundle direct edit',
        \'NeoBundleExtraEdit'],
    \]
nnoremap <silent>[menu]b :Unite -silent -no-start-insert menu:neobundle<CR>
" }}}
" outline {{{
let g:unite_source_menu_menus.outline = {
      \'description': '       show source outline        ⌘ [leader]o' }
" }}}
"}}}

nnoremap <leader>f :<C-u>Unite -start-insert -no-split file_rec/async<CR>
nnoremap <leader><space> :<C-u>Unite -start-insert buffer<CR>
nnoremap <leader>r :<C-u>Unite -no-start-insert -no-split file_mru<CR>
nnoremap <leader>y :<C-u>Unite -no-start-insert -no-split history/yank<CR>
nnoremap <F3>      :<C-u>Unite -start-insert grep:.<CR>
"}}}
" EasyMotion {{{
" Replaces usual s / ? search with advanced
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
nmap s <Plug>(easymotion-s)
"}}}
" Rooter {{{
let g:rooter_manual_only = 1
"}}}
" Gundo {{{
nnoremap <F5> :<C-u>GundoToggle<CR>
let g:gundo_preview_bottom = 1
let g:gundo_close_on_revert = 1
"}}}
" NERDTree {{{
nmap <C-n> :NERDTreeToggle<CR>
" }}}
" {{{ Tagbar
nmap <F8> :TagbarToggle<CR>
" }}}
" {{{ VimPipe
let g:vimpipe_invoke_map='<leader>m'
let g:vimpipe_close_map='<leader>p'
augroup sql_enter
  autocmd!
  autocmd FileType sql :let b:vimpipe_command="psql --host=localhost postgres"
  autocmd FileType sql :let b:vimpipe_filetype="postgresql"
augroup END
augroup scala_enter
  autocmd!
  autocmd FileType scala :let b:vimpipe_command="scalac"
  " autocmd FileType scala :let b:vimpipe_filetype=""
augroup END
" }}}
"}}}
