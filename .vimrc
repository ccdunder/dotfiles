" Sources:
" * http://amix.dk/vim/vimrc.html

" Protips:
" * Regenerate helptags (after a plugin install)
" 	:helptags ~/.vim/doc

set nocompatible
set encoding=utf8
set nomodeline

" ------------------------------------------------------------------------------
" Vundles:
" ------------------------------------------------------------------------------
filetype off
set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" Visual UI additions
Bundle 'Lokaltog/vim-powerline'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'tomtom/quickfixsigns_vim'
Bundle 'trailing-whitespace'
Bundle 'IndexedSearch'
Bundle 'sjl/gundo.vim'
Bundle 'majutsushi/tagbar'
Bundle 'kien/rainbow_parentheses.vim'

" Colors
Bundle 'BusyBee'
Bundle 'northland.vim'
Bundle 'Color-Sampler-Pack'
Bundle 'hexHighlight.vim'

" Commands
Bundle 'tpope/vim-eunuch'

" Automatic input helpers
Bundle 'tpope/vim-surround'
Bundle 'argtextobj.vim'
Bundle 'The-NERD-Commenter'
Bundle 'othree/xml.vim'

" Completion
Bundle 'SuperTab-continued.'
"Bundle 'AutoComplPop'
Bundle 'YankRing.vim'
"Bundle 'Shougo/neocomplcache' " vim's builtin completion is good enough
"Bundle 'Raimondi/delimitMate' " trying newer auto-pairs instead
Bundle 'jiangmiao/auto-pairs'
Bundle 'msanders/snipmate.vim'

" Interfile navigation
Bundle 'CCTree'
Bundle 'The-NERD-tree'
"Bundle 'wincent/Command-T'
"Bundle 'kien/ctrlp.vim'
"Bundle 'LustyJuggler'
"Bundle 'LustyExplorer'
Bundle 'FuzzyFinder'
Bundle 'project.tar.gz'
Bundle 'bufexplorer.zip'

" UI movement
Bundle 'ZoomWin'
Bundle 'godlygeek/tabular'
Bundle 'mileszs/ack.vim'
Bundle 'milkypostman/vim-togglelist'
Bundle 'xolox/vim-session'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-unimpaired'

" Mappings
Bundle 'cscope_macros.vim'

" Language support:
"Bundle 'bash-support.vim' "Too many useless leader commands
Bundle 'scrooloose/syntastic'
Bundle 'javacomplete'
Bundle 'cdunder/android-javacomplete'
Bundle 'cdunder/JavaImp.vim--Lee'

" Syntax checking:
Bundle 'tomtom/checksyntax_vim'

" VCS:
Bundle 'vcscommand.vim'
" :DiffReview & :PatchReview
Bundle 'junkblocker/patchreview-vim'
" Improved Diffing
Bundle 'sjl/splice.vim'

" Support
Bundle 'tpope/vim-repeat'
" dependency of FuzzyFinder
Bundle 'L9'

" ------------------------------------------------------------------------------
" Autocmds:
" ------------------------------------------------------------------------------
set autoread
filetype plugin indent on

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd! BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif
autocmd! BufWrite * FixWhitespace

" ------------------------------------------------------------------------------
" Backup:
" ------------------------------------------------------------------------------
set backup
set backupdir=~/.vim/.backup
" Put all swap files in RAM
set directory=/tmp/vim
" Persistent undo
set undofile
set undodir=~/.vim/.undo
" Command line history
set history=50

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" ------------------------------------------------------------------------------
"
" ------------------------------------------------------------------------------

if has('mouse')
  set mouse=a
endif

if &t_Co > 2 || has("gui_running")
	set guifont=MenloforPowerline\ 9
	set printfont=MenloforPowerline\ 9
	command! FontMenu set guifont=*
	syntax on
endif

"syntax highlight shell scripts as per POSIX,
"not the original Bourne shell which very few use
let g:is_posix=1

" ------------------------------------------------------------------------------
" Searches:
" ------------------------------------------------------------------------------
" do incremental searching
set incsearch
" highlight searches
set hlsearch
" Clear previous hlsearch
nnoremap <silent> <leader>/ :noh<cr>
set ignorecase " Ignore case when searching
set smartcase " Overrides ignorecase if search includes uppercase letters
" Use regex in searches
set magic
" Use even truer regexes (nonvim)"
nnoremap / /\v
vnoremap / /\v
" Search/replace globally inline
" :s_flags=g
set gdefault

" ------------------------------------------------------------------------------
" VisualMode:
" ------------------------------------------------------------------------------
" Automatically search only in a visual selection when one is made
vnoremap ? :s/\%V

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Convenient command! to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		\ | wincmd p | diffthis
endif

" Color scheme
set background=dark
colorscheme herald
" Favs: inkpot, jellybeans, pyte, solarized, wombat, zenburn
" busybee, northland, darkZ, herald

" Edit vimrc
nnoremap <silent> <leader>v :e ~/.vimrc<CR>
"nnoremap <silent> <leader>v :OpenSession vimrc<CR>

"When vimrc is edited, reload it
autocmd! BufWritePost .vimrc source ~/.vimrc
autocmd BufWritePost .vimrc call Pl#Load()

" Turn on WiLd menu
set wildmenu
set wildignore+=*.o,*.obj,.git,CVS,*.pyc
set wildignorecase
" Complete longest common string, then list alternatives.
set wildmode=longest,list

"set tm=4000 " timeout when waiting for commands to 500 ms
set notimeout

set autoindent
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4

" ------------------------------------------------------------------------------
" Windows:
" ------------------------------------------------------------------------------
" Moving windows
"TODO"nnoremap <silent> <C-S-J> :wincmd J<CR>
"TODO"nnoremap <silent> <C-S-K> :wincmd K<CR>
"TODO"nnoremap <silent> <C-S-H> :wincmd H<CR>
"TODO"nnoremap <silent> <C-S-L> :wincmd L<CR>
" Moving between windows
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-l> :wincmd l<CR>
" Previous Window
"TODO"nnoremap <silent> <C-'> :wincmd p<CR>
" Close window
nnoremap <C-c> :wincmd c<CR>
nnoremap <Leader>bd :BD<CR>

nnoremap <silent> <C-s> :split<CR>
nnoremap <silent> <C-v> :vsplit<CR>
"TODO"nnoremap <silent> <C-=> :wincmd =<CR>
" Remap blockwise-visual so we don't lose it
vnoremap <silent> V <C-v>

" Moving between buffers
nnoremap <right> :bp<cr>
nnoremap <left> :bn<cr>

" ------------------------------------------------------------------------------
" Copy Paste Clipboard:
" ------------------------------------------------------------------------------
" Pastemode
set pastetoggle=<F2>
" Show YankRing
nnoremap <leader>p :YRShow<CR>
" Yank to and from X clipboard ("*)
set clipboard+=unnamed
" Yank entire:%y< buffer
nnoremap gy :%y<cr>
" Select previously pasted text
let g:yankring_paste_using_g = 0
nnoremap gp `[v`]
" Cycle through registers after pasting
let g:yankring_replace_n_pkey = '<up>'
let g:yankring_replace_n_nkey = '<down>'

" ------------------------------------------------------------------------------
" Statusline:
" ------------------------------------------------------------------------------
" Add extra stat output to status line (e.g. # of lines selected)
set showcmd
" Always show statusline
set laststatus=2
" Fancy Powerline symbols
let g:Powerline_symbols='fancy'
if exists('g:Powerline_loaded')
	set noshowmode
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abbreviations:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Cope:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""nnoremap <leader>n :cn<cr>
""nnoremap <leader>p :cp<cr>

" ------------------------------------------------------------------------------
" Cscope
" ------------------------------------------------------------------------------
if has('cscope')
  set cscopetag cscopeverbose

  "if has('quickfix')
  "  set cscopequickfix=s-,c-,d-,i-,t-,e-
  "endif

  "cnoreabbrev csa cs add
  "cnoreabbrev csf cs find
  "cnoreabbrev csk cs kill
  "cnoreabbrev csr cs reset
  "cnoreabbrev css cs show
  "cnoreabbrev csh cs help

  command! -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src

  " C-Space x2 for cscope find
  "nnoremap <C-Space> :cs find s <C-R>=expand("<cword>")<CR><CR>
endif

" ------------------------------------------------------------------------------
" CWD:
" ------------------------------------------------------------------------------
map <leader>cd :cd %:p:h<cr>
""set autochdir
" Search recursively up for tags
set tags=./tags;
" Don't have ctrlp manage the working path
let g:ctrlp_working_path_mode = 0

""""""""""""""
" Taglist:
""""""""""""""
let Tlist_Exit_OnlyWindow = 1     " exit if taglist is last window open
let Tlist_Show_One_File = 1       " Only show tags for current buffer
let Tlist_Enable_Fold_Column = 0  " no fold column (only showing one file)

" ----------------------------------------
" GUI configuration:
" ----------------------------------------
" m = Menubar
" T = Toolbar
" t = tearoff menus
" a = autoselect
" A = -"- only for modeless
" c = use console dialogs
" f = foreground
" g = Grey Menu Items
" i = Icon
" v = buttons are vertical
" e = tabs in gui
" This has to be set early
" r = show right scroll bar
" L = show left scrollbar on split
" i = icon
set guioptions=fatig	" turn off gui decorations in gvim

let vimpager_use_gvim=1

" SECURE: Don't parse mode comments in files.
set modelines=0

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

" Presentation ----------------------------------------------------- {{{

" Visual bell on error.
set visualbell

" Improve drawin
set ttyfast

" Split window appears below the current one.
set splitbelow

" Split window appears to the right of the current one.
set splitright

" When line breaking, prefer to do so at the characters in breakat.
set linebreak

" Do not draw while executing macros.
set lazyredraw

" Allow hidden buffers.
set hidden

" Show matching parenthesis.
set showmatch

" Match for 3 tenths of a second.
set matchtime=3

" Show linenumbers in the margin
set ruler

" Pairs to match.
set matchpairs+=<:>

" Print syntax highlighting.
set printoptions+=syntax:y

" Print line numbers.
set printoptions+=number:y

" Use confirmation dialog for stuff like :q that would normally fail
	set confirm

" Line numbers
	"set relativenumber
	set number


" Disable showmarks
"let g:showmarks_enable=0
" }}}

" ------------------------------------------------------------------------------
" Shell scripts (bash,sh,ksh,etc.)
" ------------------------------------------------------------------------------
" automatically give executable permissions if filename is *.sh
au BufWritePost *.sh :!chmod a+x <afile>
" automatically give executable permissions if file begins with #!/bin/*sh
au BufWritePost * if getline(1) =~ "^#!/bin/[a-z]*sh" | silent !chmod a+x <afile> | endif

" ------------------------------------------------------------------------------
" syntastic
" ------------------------------------------------------------------------------
" Do syntax checks when buffers are first loaded
    let g:syntastic_check_on_open=1
" The error window will not be automatically opened when errors are detected, and closed when none are detected.
    let g:syntastic_auto_loc_list=0

" ------------------------------------------------------------------------------
" Gundo
" ------------------------------------------------------------------------------
" Open Gundo
    nnoremap <silent> <leader>u :GundoToggle<CR>

" ------------------------------------------------------------------------------
"
" ------------------------------------------------------------------------------

nnoremap ' `
nnoremap ` '

set shortmess=atI

" ------------------------------------------------------------------------------
" Cursor
" ------------------------------------------------------------------------------

" Turn off cursor blinking
set guicursor=a:blinkon0

" Toggle keeping the cursor vertically centered
set scrolloff=4 " 4 lines of context
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<cr>

" Prevents the cursor more moving back on character on insert mode exit
""inoremap <silent> <Esc> <Esc>`^

" Allow cursor to be positioned anywhere in the window
" during Visual block mode
set virtualedit=block

" Highlight the current line
highlight CursorLine gui=underline guibg=NONE
highlight CursorColumn guibg=#2e2e37
set cursorline
set nocursorcolumn

" Highlight only in the current window
autocmd! WinEnter * setlocal cursorline
autocmd! WinLeave * setlocal nocursorline

" Mapping to toggle cursor highlighting
nnoremap <Leader>c :set cursorline! <CR>

" Move cursor by display lines when wrapping
nnoremap <buffer> <silent> k gk
nnoremap <buffer> <silent> j gj
nnoremap <buffer> <silent> 0 g^
nnoremap <buffer> <silent> $ g$

" ------------------------------------------------------------------------------
" Formatting:
" ------------------------------------------------------------------------------
" See :help fo-table

" No comment leader insert on o key newlines
set formatoptions-=o
" Comment leader insert on <Enter>
set formatoptions+=r

" No autowrap at textwidth
""set formatoptions-=t
" No autowrap at textwidth if line was longer to begin with
set formatoptions+=l

" Whitespace doesn't extend a paragraph
set formatoptions-=w

" Where it makes sense, remove a comment leader when joining lines
set formatoptions+=j

" Don't break a line after a one-letter word
set formatoptions+=1

set textwidth=80
"set colorcolumn=80

" Wrap lines
set wrap

" Show ↪ at the beginning of wrapped lines.
let &showbreak=nr2char(8618).' '

" Go to prev or next line when moving left and right at beginning or eol
set whichwrap+=<,>,h,l

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Make listchars prettier
set listchars=tab:▸\ ,eol:¬

" CommandT ------------------------------------------------------------------------------
"let g:CommandTMatchWindowReverse=1

" FuzzyFinder ------------------------------------------------------------
let g:fuf_patternSeparator=' '
nnoremap <silent> <Leader>e :FufCoverageFile<CR>
nnoremap <silent> <Leader>B :FufBuffer<CR>

" Misc. Plugins ------------------------------------------------------------------------------
map <silent> <F2> :NERDTreeToggle<cr>
let g:session_autosave='no'

" LustyJuggler ------------------------------------------------------------------------------
let g:LustyJugglerDefaultMappings = 0
"nnoremap <silent> <Leader>b :LustyJuggler<CR>

" LustyExplorer ------------------------------------------------------------------------------
let g:LustyExplorerDefaultMappings = 0
":LustyFilesystemExplorer [optional-path]
":LustyFilesystemExplorerFromHere
":LustyBufferExplorer
":LustyBufferGrep"noremap <silent> <Leader>e :LustyFilesystemExplorer<CR>

" BufExplorer ------------------------------------------------------------------------------
nnoremap <silent> <Leader>b :BufExplorer<CR>
let g:bufExplorerShowRelativePath=1
let g:bufExplorerShowUnlisted=1

" Tagbar ------------------------------------------------------------------------------
nnoremap <silent> <Leader>t :TagbarOpen fj<CR>
nnoremap <silent> <Leader>T :TagbarOpenAutoClose<CR>
let g:tagbar_autoshowtag = 1
autocmd! VimEnter * nested :call tagbar#autoopen(1)

" ------------------------------------------------------------------------------
" CommandWindow (cmdwin)
" ------------------------------------------------------------------------------
" Start CommandWindow in insertmode
""autocmd CmdwinEnter [:/?]  startinsert
" Escape closes commandwindow
autocmd! CmdwinEnter [:/?]  nnoremap <buffer> <Esc> <C-c><C-c>
nnoremap ; :
vnoremap ; :
"nnoremap : q:
"vnoremap : q:
noremap , ;

" ------------------------------------------------------------------------------
" Command mode:
" ------------------------------------------------------------------------------
" double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:p:~')<cr>

" Don't close window, when deleting a buffer
command! BD call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" ------------------------------------------------------------------------------
" DelimitMate:
" ------------------------------------------------------------------------------
let delimitMate_expand_cr = 1

" ------------------------------------------------------------------------------
" Code_completion:
" ------------------------------------------------------------------------------
set completeopt=longest,menuone
set omnifunc=syntaxcomplete#Complete
let g:SuperTabDefaultCompletionType="context"

autocmd! Filetype java setlocal omnifunc=javacomplete#Complete
"autocmd Filetype java call SuperTabSetDefaultCompletionType("<C-X><C-O>")

autocmd! FileType c setlocal textwidth=80 |
			\ nnoremap <C-CR> :cs find g <C-R>=expand("<cword>")<CR><CR> |
			\ set colorcolumn=80

" ------------------------------------------------------------------------------
" Grep:
" ------------------------------------------------------------------------------
" Use ack instead of grep
set grepprg=ack\ --nogroup\ --column
set grepformat=%f:%l:%c:%m

nnoremap <leader>a :Ack

command! JavaCPSet call JavaCPSet()
function! JavaCPSet()
	if !exists("$CLASSPATH")
		let $CLASSPATH="."
	endif
	let $CLASSPATH.=system("find $(pwd) -name '*.jar' -type f -printf ':%p\n' | sort -u | tr -d '\n'")
endfunction

" TODO:
" toggle colors of strings and comments between high and low contrast

" ------------------------------------------------------------------------------
" RainbowParentheses:
" ------------------------------------------------------------------------------
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
nnoremap <leader>r :RainbowParenthesesToggleRainbow

