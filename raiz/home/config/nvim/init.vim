" Opções
set background=dark
set clipboard+=unnamedplus
set completeopt=noinsert,menuone,noselect
set cursorline
set hidden
set inccommand=split
set mouse=a
set linebreak

" set number
set splitbelow splitright
set title
set ttimeoutlen=0
set wildmenu

"Tabs size
set expandtab
set shiftwidth=2
set tabstop

filetype plugin indent on
syntax on
set t_Co=256

call plug#begin()
  " Aparência
  Plug 'vim-airline/vim-airline'
  Plug 'ryanoasis/vim-devicons'

  "Utilidades
  Plug 'jiangmiao/auto-pairs'
  Plug 'ap/vim-css-color'
  Plug 'preservim/nerdtree'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'tag' :'0.1.0' }
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'vimwiki/vimwiki'

  "Formatação
  Plug 'plasticboy/vim-markdown'
  Plug 'morhetz/gruvbox'
  Plug 'preservim/vim-pencil'
  Plug 'junegunn/goyo.vim' 
call plug#end()

colorscheme gruvbox

"Configurações Airline
let g:airline_theme ='gruvbox'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#wordcount#enabled = 1
let g:airline_sextion_x = '%{PencilMode()}'

"NerdTree
let NERDTreeShowHidden = 1

"Vim Markdown
let g:text_conceal = ''
let g:vim_markdown_math = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_fenced_languages = ['tsx=typescriptreact']

" VimWiki
let g:vimwiki_list = [{'path': '~/vimwiki'}]

"Atalhos

nnoremap <C-q> :q<CR>
nnoremap <C-s> :w!<CR>
nnoremap <F3> :NERDTreeToggle<CR>
nnoremap <F4> :sp<CR>:terminal<CR>
nnoremap <S-Tab> gT
nnoremap <Tab> gt
nnoremap <silent> <S-t> :tabnew<CR>
nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<CR>
nnoremap <F5> :VimwikiDiaryGenerateLinks<CR> 
