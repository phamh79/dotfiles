let mapleader=","

call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
"Plug 'tpope/vim-sensible'
"Plug 'junegunn/seoul256.vim'
" code
Plug 'fatih/vim-go'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'buoto/gotests-vim'
Plug 'puremourning/vimspector'
"Plug 'chr4/nginx.vim'
" linters
Plug 'w0rp/ale'
" helpers
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/goyo.vim'
"Plug 'chiel92/vim-autoformat'
"Plug 'psliwka/vim-smoothie'
"Plug 'yuttie/comfortable-motion.vim'

"Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
"Plug 'ekalinin/dockerfile.vim'

"git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'rhysd/git-messenger.vim'
Plug 'tpope/vim-commentary'
Plug 'shumphrey/fugitive-gitlab.vim'
"fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"coc.vim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"theme
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'haishanh/night-owl.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'joshdick/onedark.vim'
Plug 'jacoborus/tender.vim'
Plug 'nlknguyen/papercolor-theme'
Plug 'gruvbox-community/gruvbox'
Plug 'owickstrom/vim-colors-paramount'
Plug 'ryanoasis/vim-devicons'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
set termguicolors
let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'

"set cursorline
set lazyredraw
" always use system clipboard
"set clipboard=unnamedplus

" backspace does not delete line break
set backspace=2 " make backspace work like most other programs
" search
set smartcase
set ignorecase

set number
set relativenumber
syntax on
syntax enable
set encoding=utf-8
set fileencoding=utf-8
" set nohlsearch
"
" Clean search (highlight)
nnoremap <silent> <ESC><ESC> :noh<cr>"
"keep 8 lines below
set scrolloff=8
filetype plugin indent on    " required
set nomodeline
set hidden
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set linebreak
set showbreak=↪
"set spell
" 2 spaces indent for yaml files
"autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 expandtab
" json
autocmd FileType json syntax match Comment +\/\/.\+$+

"set guifont=Fira\ Code\ Retina\ 11
"let ayucolor="mirage"
"color ayu

"move block
" vnoremap J :m '>+1<CR>gv=gv
" vnoremap K :m '<-2<CR>gv=gv

nmap <C-e> :e#<CR>
nmap ' :Buffers<CR>
nnoremap <leader>d "_dd
"fzf
nnoremap <Leader>f :Files<Cr>
nnoremap <Leader>t :Rg<Cr>
let $FZF_DEFAULT_COMMAND='rg --hidden --no-ignore -l ""'

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden --column --line-number --no-heading --color=always ' 
  \  . (len(<q-args>) > 0 ? <q-args> : '""'), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)


"replace current word by copied word
nnoremap <leader>raw "_dawhp
"go lang
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
" vim git gutter
nmap [h <Plug>(GitGutterNextHunk)
nmap ]h <Plug>(GitGutterPrevHunk)
" Better tabbing
" vnoremap < <gv
" vnoremap > >gv
":verbose imap <tab>
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()
" Use<cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" disable vim-go :GoDef short cut (gd)
 " this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> I <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> go :CocList outline<Cr>
" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)



map <Leader>] :bprevious<CR>
map <Leader>[] :bnext<CR>

"vim auto format
"let g:python3_host_prog='/usr/bin/python'

let g:user_emmet_mode='a'
let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings= {
    \ 'javascript.jsx' : {
    \ 'extends': 'jsx',
    \ },
\}



"" Set this variable to 1 to fix files when you save them.
"let g:ale_fixers = {
"      \   '*': ['remove_trailing_lines', 'trim_whitespace'],
"      \   'css': ['prettier', 'stylelint'],
"      \   'javascript': ['eslint', 'prettier'],
"      \   'python': ['isort', 'black'],
"      \   'HTML': ['HTMLHint', 'proselint'],
"      \   'go': ['gofmt'],
"      \   'ruby': ['rubocop'],
"      \}
"let g:ale_fix_on_save = 1
" let g:go_auto_sameids = 1
" let g:go_auto_info = 1
" let g:go_highlight_structs = 1
" let g:go_highlight_interfaces = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_build_constraints = 1
" let g:go_highlight_extra_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
" let g:go_highlight_types = 1
" let g:go_hightlight_fields = 1
" let g:go_highlight_generate_tags = 1
" let g:go_highlight_variable_declarations = 1
" let g:go_highlight_variable_assignments = 1
let g:go_fmt_command = "goimports"
"gotests
let g:gotests_bin = '/home/phucph4/go/bin/gotests'
set updatetime=100

"show white chars
set list
set lcs=tab:\|\  "
" nerdCommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1

" NERDTree
:nnoremap <C-g> :NERDTreeToggle<CR>

:set mouse=a
let g:NERDTreeMouseMode=3
let g:NERDTreeShowHidden=1
map <leader>q :NERDTreeFind<cr>

" functions
function SwitchColorScheme(name)
  let g:VIM_COLOR_SCHEME = a:name
  call ColorScheme()
endfunction

function! ColorScheme()
  if g:VIM_COLOR_SCHEME ==# 'night-owl'
    " Lazy load theme in
    colorscheme night-owl
  endif


  if g:VIM_COLOR_SCHEME ==# 'monokai'
    " Lazy load theme in
    colorscheme vim-monokai-tasty
  endif

  if g:VIM_COLOR_SCHEME ==# 'nord'
    " Lazy load theme in
    let g:nord_underline = 1
    let g:nord_italic_comments = 1
    let g:nord_italic = 1
    let g:nord_cursor_line_number_background = 1
    colorscheme nord
  endif

  if g:VIM_COLOR_SCHEME ==# 'ayu-light'
    colorscheme ayu
    let g:ayucolor="light"
    set background=light
  endif

   if g:VIM_COLOR_SCHEME ==# 'ayu'
    colorscheme ayu
    set background=dark
    let g:ayucolor="mirage"
  endif

  if g:VIM_COLOR_SCHEME ==# 'dracula'
    colorscheme dracula
    set background=dark
  endif

  if g:VIM_COLOR_SCHEME ==# 'tender'
    colorscheme tender
  endif

  if g:VIM_COLOR_SCHEME ==# 'onedark'
    colorscheme onedark
    set background=dark
  endif

  if g:VIM_COLOR_SCHEME ==# 'papercolor-light'
    set background=light
    colorscheme PaperColor
  endif

  if g:VIM_COLOR_SCHEME ==# 'gruvbox'
    set background=dark
    colorscheme gruvbox
  endif

  if g:VIM_COLOR_SCHEME ==# 'gruvbox-light'
    set background=light
    colorscheme gruvbox
  endif

  if g:VIM_COLOR_SCHEME ==# 'solarized-light'
    let g:solarized_termcolors = 256
    set background=light
    colorscheme solarized
  endif


  if g:VIM_COLOR_SCHEME ==# 'solarized-dark'
    syntax enable
    set background=dark
    set t_Co=16
    colorscheme solarized
  endif

  if g:VIM_COLOR_SCHEME ==# 'paramount-light'
    set background=light
    colorscheme paramount
  endif


  if g:VIM_COLOR_SCHEME ==# 'paramount-dark'
    set background=dark
    colorscheme paramount
  endif

endfunction
" Defaults
:call SwitchColorScheme("gruvbox")

"respect vim colorscheme
function! s:update_fzf_colors()
  let rules =
  \ { 'fg':      [['Normal',       'fg']],
    \ 'bg':      [['Normal',       'bg']],
    \ 'hl':      [['Comment',      'fg']],
    \ 'fg+':     [['CursorColumn', 'fg'], ['Normal', 'fg']],
    \ 'bg+':     [['CursorColumn', 'bg']],
    \ 'hl+':     [['Statement',    'fg']],
    \ 'info':    [['PreProc',      'fg']],
    \ 'prompt':  [['Conditional',  'fg']],
    \ 'pointer': [['Exception',    'fg']],
    \ 'marker':  [['Keyword',      'fg']],
    \ 'spinner': [['Label',        'fg']],
    \ 'header':  [['Comment',      'fg']] }
  let cols = []
  for [name, pairs] in items(rules)
    for pair in pairs
      let code = synIDattr(synIDtrans(hlID(pair[0])), pair[1])
      if !empty(name) && code > 0
        call add(cols, name.':'.code)
        break
      endif
    endfor
  endfor
  let s:orig_fzf_default_opts = get(s:, 'orig_fzf_default_opts', $FZF_DEFAULT_OPTS)
  let $FZF_DEFAULT_OPTS = s:orig_fzf_default_opts .
        \ empty(cols) ? '' : (' --color='.join(cols, ','))
endfunction

augroup _fzf
  autocmd!
  autocmd ColorScheme * call <sid>update_fzf_colors()
augroup END

let g:fugitive_gitlab_domains = ['https://gitlab.id.vin']

" let g:vimspector_enable_mappings = 'VISUAL_STUDIO'

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
"" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END


let g:vimspector_enable_mappings = 'HUMAN'

" Status Line Custom
let g:currentmode={
    \ 'n'  : 'Normal',
    \ 'no' : 'Normal·Operator Pending',
    \ 'v'  : 'Visual',
    \ 'V'  : 'V·Line',
    \ '^V' : 'V·Block',
    \ 's'  : 'Select',
    \ 'S'  : 'S·Line',
    \ '^S' : 'S·Block',
    \ 'i'  : 'Insert',
    \ 'R'  : 'Replace',
    \ 'Rv' : 'V·Replace',
    \ 'c'  : 'Command',
    \ 'cv' : 'Vim Ex',
    \ 'ce' : 'Ex',
    \ 'r'  : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!'  : 'Shell',
    \ 't'  : 'Terminal'
    \}

set laststatus=2
set noshowmode
set statusline=
set statusline+=%0*\ %n\                                 " Buffer number
set statusline+=%1*\ %<%F%m%r%h%w\                       " File path, modified, readonly, helpfile, preview
set statusline+=%3*│                                     " Separator
set statusline+=%2*\ %Y\                                 " FileType
set statusline+=%3*│                                     " Separator
set statusline+=%2*\ %{''.(&fenc!=''?&fenc:&enc).''}     " Encoding
set statusline+=\ (%{&ff})                               " FileFormat (dos/unix..)
set statusline+=%=                                       " Right Side
set statusline+=%2*\ col:\ %02v\                         " Colomn number
set statusline+=%3*│                                     " Separator
set statusline+=%1*\ ln:\ %02l/%L\ (%3p%%)\              " Line number / total lines, percentage of document
set statusline+=%0*\ %{ModeCurrent()}\ 
" Function: return current mode
" abort -> function will abort soon as error detected
function! ModeCurrent() abort
    let l:modecurrent = mode()
    " use get() -> fails safely, since ^V doesn't seem to register
    " 3rd arg is used when return of mode() == 0, which is case with ^V
    " thus, ^V fails -> returns 0 -> replaced with 'V Block'
    let l:modelist = toupper(get(g:currentmode, l:modecurrent, 'V·Block '))
    let l:current_status_mode = l:modelist
    return l:current_status_mode
endfunction


