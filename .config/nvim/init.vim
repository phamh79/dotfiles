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

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
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
Plug 'patstockwell/vim-monokai-tasty'
Plug 'gruvbox-community/gruvbox'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
set termguicolors
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
"
" Clean search (highlight)
nnoremap <silent> <ESC><ESC> :noh<cr>"
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
" json
autocmd FileType json syntax match Comment +\/\/.\+$+

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

" coc-nvim start
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



" coc-vim end
"vim auto format

let g:user_emmet_mode='a'
let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings= {
    \ 'javascript.jsx' : {
    \ 'extends': 'jsx',
    \ },
\}

let g:go_auto_sameids = 1
let g:go_auto_info = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_hightlight_fields = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:go_fmt_command = "goimports"
"gotests
let g:gotests_bin = $HOME.'/go/bin/gotests'

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

  if g:VIM_COLOR_SCHEME ==# 'monokai'
    " Lazy load theme in
    colorscheme vim-monokai-tasty
  endif


  if g:VIM_COLOR_SCHEME ==# 'gruvbox'
    set background=dark
    colorscheme gruvbox
    let g:gruvbox_contrast_dark = 'hard'
  endif

  if g:VIM_COLOR_SCHEME ==# 'gruvbox-light'
    set background=light
    colorscheme gruvbox
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

let g:fugitive_gitlab_domains = ['https://gitlab.id.vin', 'https://github.com']

" let g:vimspector_enable_mappings = 'VISUAL_STUDIO'


let g:vimspector_enable_mappings = 'HUMAN'

"always show statusline
set laststatus=2
"modifiedflag, charcount, filepercent, filepath
set statusline=%=%m\ %c\ %P\ %f

