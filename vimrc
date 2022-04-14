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
set expandtab
set tags=./.tags;,.tags
" 启用持久性撤销
set undofile
" 编辑历史目录，需确保目录存在
set undodir=~/.vim/undodir
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
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
" 代码补全
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" 配色
Plug 'morhetz/gruvbox'
call plug#end()

" ====== gutentags =======
" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']

" 所生成的数据文件的名称 "
let g:gutentags_ctags_tagfile = '.tags'

" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif

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

let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
                       
" ====== LeaderF =======
" 在 popup 窗口中预览结果
let g:Lf_PreviewInPopup = 1
" 预览代码
let g:Lf_PreviewCode = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {
        \ 'File': 0,
        \ 'Buffer': 0,
        \ 'Mru': 0,
        \ 'Tag': 0,
        \ 'BufTag': 1,
        \ 'Function': 1,
        \ 'Line': 1,
        \ 'Colorscheme': 0,
        \ 'Rg': 0,
        \ 'Gtags': 0
        \}
let g:Lf_RootMarkers = ['.root', '.svn', '.git', '.project']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_CacheDirectory = expand('~/.vim/cache')
" ctrl-p开启文件查询
let g:Lf_ShortcutF = "<c-p>"
" ctrl-l开启buffer查找
let g:Lf_ShortcutB = "<c-l>"
" \ + p 开启函数查询（仅限当前文件）
nnoremap <silent><Leader>p :LeaderfFunction!<CR>
" \ + d 开启tag查找
nnoremap <silent><Leader>d :LeaderfTag<CR>
" 调用 ripgrep 全局查找字符串
nnoremap <Leader>rg :Leaderf rg<Space>

" 使用gtags进行索引查找
" 自动生成gtags
let g:Lf_GtagsAutoGenerate = 1
let g:Lf_Gtagslabel = 'native-pygments'
" \ + f + r 查找当前光标所在字符的所有引用
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump h", expand("<cword>"))<CR><CR>
" \ + f + r 查找当前光标所在字符的所有定义
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump h", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

" ======= coc =======
source /Users/ganxianhui/.vim/coc-rc
" 使用Tab和Shift-Tab选择补全
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" 使用回车确认选择
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" GoTo code navigation.
" 暂不使用，有LeaderF和旧的ctags就够了
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
" 
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

" ======= gruvbox =======
set background=dark
autocmd vimenter * ++nested colorscheme gruvbox
