let mapleader=","

call plug#begin('~/.vim/plugged')

" auto complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" syntax highlight
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

" Go
Plug 'fatih/vim-go'
Plug 'buoto/gotests-vim'

" debug
Plug 'puremourning/vimspector'

" linters
Plug 'dense-analysis/ale'

" helpers
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jiangmiao/auto-pairs'

" markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'rhysd/git-messenger.vim'

" code comment
Plug 'tpope/vim-commentary'

"fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"theme
Plug 'sainnhe/gruvbox-material'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

"gruvbox-material
if has('termguicolors')
  set termguicolors
endif
set background=light
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_enable_italic = 1
" let g:gruvbox_material_transparent_background = 1
let g:gruvbox_material_diagnostic_line_highlight = 1
let g:gruvbox_material_better_performance = 1
colorscheme gruvbox-material

"set cursorline
set lazyredraw
" always use system clipboard
"set clipboard=unnamedplus

" backspace does not delete line
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

" Go mapping
" disable vim-go :GoDef short cut (gd)
 " this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
"go lang
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap gf :GoFillStruct<cr>
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
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

"vim-go settings
let g:go_auto_sameids = 1
let g:go_auto_info = 1
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

let g:vimspector_enable_mappings = 'HUMAN'

" treesitter settings
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
  },
}
EOF

" code folding
set foldlevel=99
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
nmap <C-h> :foldclose<CR> 
nmap <C-l> :foldopen<CR>
nmap <C-j> :set foldlevel=99<CR>
nmap <C-k> :set foldlevel=0<CR>
