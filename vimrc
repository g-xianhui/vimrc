filetype plugin on
syntax on
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set number
set hlsearch
set list
set listchars=tab:>-
set autoindent
set cindent
set tabstop=4
set shiftwidth=4
set noexpandtab
set tags=./.tags;,.tags
set undodir=~/.undodir
set backspace=indent,eol,start

" 开启man功能
runtime ftplugin/man.vim

" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

call plug#begin()
" vim配色
Plug 'bfrg/vim-cpp-modern'
" 自动tags生成
Plug 'ludovicchabant/vim-gutentags'
" 函数查找、文件查找
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension', 'for': 'cpp' }
Plug 'neoclide/coc.nvim', {'branch': 'release', 'for': 'cpp'}
call plug#end()

" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']

" 所生成的数据文件的名称 "
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 "
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 检测 ~/.cache/tags 不存在就新建 "
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" 配置 ctags 的参数 "
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
                       
" 在 popup 窗口中预览结果
let g:Lf_PreviewInPopup = 1
" 预览代码
let g:Lf_PreviewCode = 1
let g:Lf_RootMarkers = ['.root', '.svn', '.git', '.project']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShortcutF = "<Leader>f"
let g:Lf_ShortcutB = "<Leader>bl"
nnoremap <silent><Leader>p :LeaderfFunction!<CR>
nnoremap <silent><Leader>d :LeaderfTag<CR>
" 调用 ripgrep 查找字符串
nnoremap <Leader>rg :Leaderf rg<Space>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
