let mapleader=","

call plug#begin('~/.vim/plugged')

" auto complete
Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'


Plug 'neovim/nvim-lspconfig'

" syntax highlight
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

" Go
Plug 'fatih/vim-go'
Plug 'buoto/gotests-vim'

" Java
Plug 'mfussenegger/nvim-jdtls'

"
" debug
" Plug 'puremourning/vimspector'

" helpers
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jiangmiao/auto-pairs'
Plug 'dense-analysis/ale'
Plug 'kevinhwang91/nvim-bqf'

Plug 'ThePrimeagen/vim-be-good'
Plug 'ray-x/lsp_signature.nvim'

"editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'


" markdown
Plug 'npxbr/glow.nvim', {'do': ':GlowInstall', 'branch': 'main'}

" git
Plug 'tpope/vim-rhubarb'
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
Plug 'morhetz/gruvbox'


" Plug 'ryanoasis/vim-devicons'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

"gruvbox
if has('termguicolors')
  set termguicolors
endif
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_statusline_style = 'original'
let g:gruvbox_material_better_performance = 1
let g:gruvbox_material_palette = 'original'
colorscheme gruvbox-material
set background=dark

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
" must be after syntax enable
highlight LineNr guifg=#4fa64b
set ruler
set encoding=utf-8
set fileencoding=utf-8


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
nnoremap <Leader>w :Rg <C-R><C-W><Cr>
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

" builtin git
nmap <leader>gs :G<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gj :diffget //3<CR>

" nvim-compe
set completeopt=menuone,noselect
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.luasnip = v:true
let g:compe.source.emoji = v:true
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

lua <<EOF
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn['vsnip#available'](1) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn['vsnip#jumpable'](-1) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

EOF

" Go mapping
" disable vim-go :GoDef short cut (gd)
 " this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
"go lang
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap gfs :GoFillStruct<cr>
autocmd FileType go nmap gat :GoAddTags<cr>

"vim-go settings
let g:go_auto_sameids = 0
let g:go_auto_info = 0
let g:go_fmt_command = "goimports"
"gotests
let g:gotests_bin = $HOME.'/go/bin/gotests'

"show white chars
set list
" set lcs=tab:\|\  "
" set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣


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

" code folding
set foldlevel=99
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
nmap <C-h> :foldclose<CR> 
nmap <C-l> :foldopen<CR>
nmap <C-j> :set foldlevel=99<CR>
nmap <C-k> :set foldlevel=0<CR>

" java language specific
if has('nvim-0.5')
  augroup lsp
    au!
    au FileType java lua require('jdtls').start_or_attach({cmd = {'java-lsp.sh'}})
  augroup end
endif
autocmd FileType java nnoremap <space>ca <Cmd>lua require('jdtls').code_action()<CR>
autocmd FileType java nnoremap <space>r <Cmd>lua require('jdtls').code_action(false, 'refactor')<CR>
autocmd FileType java nnoremap gD <Cmd>lua vim.lsp.buf.declaration()<CR>
autocmd FileType java nnoremap gd <Cmd>lua vim.lsp.buf.definition()<CR>
autocmd FileType java nnoremap K <Cmd>lua vim.lsp.buf.hover()<CR>
autocmd FileType java nnoremap gi <Cmd>lua vim.lsp.buf.implementation()<CR>
autocmd FileType java nnoremap gr <Cmd>lua vim.lsp.buf.references()<CR>
autocmd FileType java nnoremap ic <Cmd>lua vim.lsp.buf.incoming_calls()<CR>



" lspconfig settings
lua << EOF
require'lspconfig'.pyright.setup{}
require'lspconfig'.gopls.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.diagnosticls.setup{}
require "lsp_signature".setup{
bind = true, -- This is mandatory, otherwise border config won't get registered.
handler_opts = {
    border = "single"
    }
}


local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyright", "rust_analyzer", "tsserver", "gopls", "diagnosticls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

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


