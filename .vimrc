" Encode
set encoding=UTF-8

" Only for nvim
if !has('nvim')
  set ttymouse=xterm2
endif

" enable plugin, indent
filetype plugin on

"set nowrap
syntax enable

" Basic settings {{{

" Avoid automatic indentation
autocmd InsertLeave *
      \ if &paste | set nopaste mouse=a | echo 'nopaste' | endif |
    \ if &l:diff | diffupdate | endif


" Fastest way to move buffer
nnoremap <silent><Left> :bp<CR>
nnoremap <silent><Right> :bn<CR>
nnoremap <silent><C-Space> :call BufferDeleteExceptFiler()<CR>

" Move with Ctrl+jkhl in insert mode
" imap <C-k> <Up>
" imap <C-j> <Down>
" imap <C-h> <Left>
" imap <C-l> <Right>

function! BufferDeleteExceptFiler()
  if (&filetype !=# 'defx')
    bd!
  endif
endfunction

if !has('gui_running')
  augroup term_vim_c_space
    autocmd!
    autocmd VimEnter * map <Nul> <C-Space>
    autocmd VimEnter * map! <Nul> <C-Space>
  augroup END
endif

" gui configuration
hi Visual cterm=reverse
hi Search cterm=reverse ctermfg=yellow
hi VertSplit ctermbg=NONE guibg=NONE

" Spell configuration
hi clear SpellBad
hi clear SpellCap
hi clear SpellLocal
hi SpellBad cterm=underline ctermfg=LightBlue
hi SpellCap cterm=underline ctermfg=LightBlue
hi SpellLocal cterm=underline ctermfg=LightBlue

" 画面表示の設定
set ruler          " カーソルの位置表示を行う
set number         " 行番号を表示する
set cursorline     " カーソル行の背景色を変える
"set cursorcolumn   " カーソル位置のカラムの背景色を変える
set laststatus=2   " ステータス行を常に表示
set cmdheight=2    " メッセージ表示欄を2行確保
set showmatch      " 対応する括弧を強調表示
set helpheight=999 " ヘルプを画面いっぱいに開く
set list           " 不可視文字を表示"
set showmode       " モードを表示"

" 不可視文字の表示記号指定
set listchars=tab:>\ ,trail:~

" カーソル移動関連の設定
set backspace=indent,eol,start " Backspaceキーの影響範囲に制限を設けない
set whichwrap=b,s,h,l,<,>,[,]  " 行頭行末の左右移動で行をまたぐ
set scrolloff=8                " 上下8行の視界を確保
set sidescrolloff=16           " 左右スクロール時の視界を確保
set sidescroll=1               " 左右スクロールは一文字づつ行う

" ファイル処理関連の設定
set confirm    " 保存されていないファイルがあるときは終了前に保存確認
set hidden     " 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set autoread   "外部でファイルに変更がされた場合は読みなおす
set nobackup   " ファイル保存時にバックアップファイルを作らない
set noswapfile " ファイル編集中にスワップファイルを作らない

" 検索/置換の設定
set hlsearch   " 検索文字列をハイライトする
set incsearch  " インクリメンタルサーチを行う
set ignorecase " 大文字と小文字を区別しない
set smartcase  " 大文字と小文字が混在した言葉で検索を行った場合に限り、大文字と小文字を区別する
set wrapscan   " 最後尾まで検索を終えたら次の検索で先頭に移る
set gdefault   " 置換の時 g オプションをデフォルトで有効にする

" タブ/インデントの設定
set expandtab     " タブ入力を複数の空白入力に置き換える
set tabstop=4     " 画面上でタブ文字が占める幅
set shiftwidth=4  " 自動インデントでずれる幅
set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent    " 改行時に前の行のインデントを継続する
set smartindent   " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する

" 動作環境との統合関連の設定
set clipboard=unnamed,unnamedplus " OSのクリップボードをレジスタ指定無しで Yank, Put 出来るようにする
set mouse=a " マウスの入力を受け付ける
set shellslash " Windows でもパスの区切り文字を / にする

" インサートモードから抜けると自動的にIMEをオフにする
set iminsert=0
set imsearch=-1

" コマンドラインの設定
set wildmenu wildmode=list:longest,full " コマンドラインモードでTABキーによるファイル名補完を有効にする
set history=10000                       " コマンドラインの履歴を10000件保存する

" ビープの設定
set visualbell t_vb= "ビープ音すべてを無効にする
set noerrorbells "エラーメッセージの表示時にビープを鳴らさない

set virtualedit=block
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
  set undolevels=1000
endif
autocmd BufRead,BufNewFile *.md spelllang=en_us spell
autocmd BufRead,BufNewFile *.tex spelllang=en_us spell

" 検索
nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR> " カーソル下の単語をハイライトする


" Flags {{{
let s:use_dein = 1
" }}}

" FileType {{{
au BufRead,BufNewFile,BufReadPre *.swift set filetype=swift
au BufNewFile,BufRead *.ts set filetype=typescript
au BufNewFile,BufRead *.tsx set filetype=typescript
"}}}


" Indentation settings {{{
au Filetype html setlocal ts=2 sts=2 sw=2
au Filetype ruby setlocal ts=2 sts=2 sw=2 et
au Filetype css setlocal ts=4 sw=4 sts=0
au FileType javascript setlocal ts=2 sw=2 et
" }}}

" }}}

" Dein Scripts {{{
let s:vimdir = $HOME . '/.vim'
let s:dein_dir = s:vimdir . '/dein'
let s:dein_github = s:dein_dir . '/repos/github.com'
let s:dein_repo_name = "Shougo/dein.vim"
let s:dein_repo_dir = s:dein_github . '/' . s:dein_repo_name
let s:rsense_dir = $HOME . '/.rbenv/shims/rsense'
let g:ale_completion_enabled = 1

"  Install dein automatically
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

if &compatible
  set nocompatible
endif

let &runtimepath = &runtimepath . "," . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#add('Shougo/dein.vim')

  " Plugin async loader
  call dein#add('Shougo/vimproc.vim', {
        \ 'build' : {
        \     'windows' : 'tools\\update-dll-mingw',
        \     'cygwin' : 'make -f make_cygwin.mak',
        \     'mac' : 'make -f make_mac.mak',
        \     'unix' : 'make -f make_unix.mak',
        \    },
        \ })

  " Completion
  call dein#add('prabirshrestha/async.vim')
  call dein#add('prabirshrestha/vim-lsp')
  call dein#add('Shougo/echodoc.vim')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('honza/vim-snippets')

  " Linter
  call dein#add('w0rp/ale')

  " Funny plugins
  call dein#add('ashisha/image.vim')
  call dein#add('osyo-manga/vim-nyaaancat')

  " Syntax highlight
  call dein#add('pangloss/vim-javascript')
  call dein#add('mxw/vim-jsx')
  call dein#add('maxmellon/vim-jsx-pretty')
  call dein#add('posva/vim-vue')
  call dein#add('leafgarland/typescript-vim')
  call dein#add('Quramy/tsuquyomi', {'rev': 'db073bb'})
  call dein#add('octol/vim-cpp-enhanced-highlight')
  call dein#add('numirias/semshi')
  call dein#add('editorconfig/editorconfig-vim')

  " Statusline
  call dein#add('ryanoasis/vim-devicons')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')

  " Filer
  call dein#add('sh8/defx-icons', {'rev': 'AvailableXterm256'})
  call dein#add('kristijanhusak/defx-git')
  call dein#add('Shougo/defx.nvim')

  " Git
  call dein#add('airblade/vim-gitgutter')
  call dein#add('tpope/vim-fugitive')

  " Util
  call dein#add('tomtom/tcomment_vim')
  call dein#add('vim-scripts/YankRing.vim')
  call dein#add('rhysd/accelerated-jk')
  call dein#add('thinca/vim-quickrun')
  call dein#add('wlangstroth/vim-racket')
  call dein#add('godlygeek/tabular')
  call dein#add('iamcco/markdown-preview.nvim', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd'],
					\ 'build': 'cd app & npm install' })
  call dein#add('malithsen/trello-vim')
  call dein#add('beckorz/previm', {'rev': 'update-libraries'})
  call dein#add('daeyun/vim-matlab')
  call dein#add('scrooloose/nerdtree')
  call dein#add('majutsushi/tagbar')
  call dein#add('easymotion/vim-easymotion')


  " Colorization
  call dein#add('vim-scripts/AnsiEsc.vim')
  " call dein#add('bronson/vim-trailing-whitespace')
  call dein#add('chrisbra/Colorizer')

  " Colorscheme
  call dein#add('flazz/vim-colorschemes')
  call dein#add('sff1019/vim-brogrammer-theme')
  call dein#add('sff1019/vim-joker')

  " FZF
  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })

  " LATEX
  call dein#add('lervag/vimtex')

  call dein#end()
endif
" }}}

" Plugin settings {{{

filetype plugin indent on

" accelerated-jk
if dein#tap('accelerated-jk')
  nmap j <Plug>(accelerated_jk_gj)
  nmap k <Plug>(accelerated_jk_gk)
endif

" ale
if dein#tap('ale')
  let g:ale_swift_swiftlint_executable = 'swiftlint'
  let g:ale_swift_swiftlint_options = ''

  let g:ale_linters = {
        \   'javascript': ['eslint'],
        \}
  let g:ale_fixers = {
        \   'javascript': ['eslint'],
        \}
  let g:ale_fix_on_save = 1
endif

" Colorizer
if dein#tap('Colorizer')
  autocmd BufNewFile,BufRead *.css,*.scss,*.html,*.htm  :ColorHighlight!
endif

" neosnippet.vim
if dein#tap('neosnippet.vim')
  " Plugin key-mappings.
  " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>     <Plug>(neosnippet_expand_target)

  " SuperTab like snippets behavior.
  " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
  "imap <expr><TAB>
  " \ pumvisible() ? "\<C-n>" :
  " \ neosnippet#expandable_or_jumpable() ?
  " \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

  " For conceal markers.
  if has('conceal')
    set conceallevel=2 concealcursor=niv
  endif

  " Enable snipMate compatibility feature.
  let g:neosnippet#enable_snipmate_compatibility = 1

  " Tell Neosnippet about the other snippets
  let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
endif


" echodoc.vim
if dein#tap('echodoc.vim')
  set noshowmode
  let g:echodoc#enable_at_startup = 1
  let g:echodoc#enable_force_overwrite = 1
endif

" fzf.vim
if dein#tap('fzf.vim')
  command! -bang -nargs=* Rg
        \ call fzf#vim#grep(
        \   'rg -g "!node_modules/*" --column --line-number  --no-heading --color=always '.shellescape(<q-args>), 0,
        \   fzf#vim#with_preview(
        \      {'options': '--exact --delimiter : --nth 3.. --preview "rougify {2..-1} | head -'.&lines.'"'}, 'right:50%'))
  nnoremap <silent> <C-t> :call Fzf_dev()<CR>
  nnoremap ,g :Rg<CR>

  function! Fzf_dev()
    let l:fzf_files_options = '--preview "rougify {2..-1} | head -'.&lines.'"'

    function! s:files()
      let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
      return s:prepend_icon(l:files)
    endfunction

    function! s:prepend_icon(candidates)
      let l:result = []
      for l:candidate in a:candidates
        let l:filename = fnamemodify(l:candidate, ':p:t')
        let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
        call add(l:result, printf('%s %s', l:icon, l:candidate))
      endfor

      return l:result
    endfunction

    function! s:edit_file(item)
      let l:pos = stridx(a:item, ' ')
      let l:file_path = a:item[pos+1:-1]
      execute 'silent e' l:file_path
    endfunction

    call fzf#run({
          \ 'source': <sid>files(),
          \ 'sink':   function('s:edit_file'),
          \ 'options': '-m ' . l:fzf_files_options,
          \ 'down':    '40%' })
  endfunction
endif

" vim-lsp
if dein#tap('vim-lsp')
  let g:lsp_log_verbose = 1
  let g:lsp_log_file = expand('~/vim-lsp.log')


  if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript'],
        \ })
  endif

  if executable('cquery')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'cquery',
        \ 'cmd': {server_info->['cquery']},
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
        \ 'initialization_options': { 'cacheDirectory': '/tmp/cquery/cache' },
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
        \ })
  endif

endif

" previm
if dein#tap('previm')
  let g:previm_open_cmd = 'open -a Google\ Chrome'
endif

" quickrun
if dein#tap('quickrun')
  let g:quickrun_config = {}
endif

"tsuquyomi
if dein#tap('tsuquyomi')
  autocmd InsertLeave,TextChanged,BufWritePost *.ts,*.tsx call tsuquyomi#asyncGeterr()
  let g:tsuquyomi_use_vimproc = 0
  let g:tsuquyomi_disable_quickfix = 1
endif

" vim-airline
if dein#tap('vim-airline')
  " let g:airline_theme='murmur'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#fnamemod = ':t'
  let g:airline#extensions#tabline#left_sep = "\uE0B0 "
  let g:airline#extensions#tabline#left_alt_sep = ' '
  let g:airline_left_sep = "\uE0B0 "
  let g:airline_right_sep = "\uE0B2"
endif

" vim-cpp-enhanced-highlight
if dein#tap('vim-cpp-enhanced-highlight')
  let g:cpp_class_scope_highlight = 1
  let g:cpp_member_variable_highlight = 1
  let g:cpp_class_decl_highlight = 1
  let g:cpp_experimental_template_highlight = 1
  let g:cpp_concepts_highlight = 1
endif

" defx.nvim
if dein#tap('defx.nvim')
  autocmd FileType defx call s:defx_my_settings()
    function! s:defx_my_settings() abort
     " Define mappings
      nnoremap <silent><buffer><expr> o
      \ defx#is_directory() ?
      \ defx#do_action('open_tree') :
      \ defx#do_action('multi', ['drop', 'quit'])
      nnoremap <silent><buffer><expr> l
      \ defx#is_directory() ?
      \ defx#do_action('open_tree') :
      \ defx#do_action('multi', ['drop', 'quit'])
      nnoremap <silent><buffer><expr> h
     \ defx#do_action('close_tree')
      nnoremap <silent><buffer><expr> c
     \ defx#do_action('copy')
      nnoremap <silent><buffer><expr> C
     \ defx#do_action('open')
      nnoremap <silent><buffer><expr> m
     \ defx#do_action('move')
      nnoremap <silent><buffer><expr> p
     \ defx#do_action('paste')
      nnoremap <silent><buffer><expr> K
     \ defx#do_action('new_directory')
      nnoremap <silent><buffer><expr> N
     \ defx#do_action('new_file')
      nnoremap <silent><buffer><expr> d
     \ defx#do_action('remove')
      nnoremap <silent><buffer><expr> r
     \ defx#do_action('rename')
      nnoremap <silent><buffer><expr> x
     \ defx#do_action('execute_system')
      nnoremap <silent><buffer><expr> yy
     \ defx#do_action('yank_path')
      nnoremap <silent><buffer><expr> .
     \ defx#do_action('toggle_ignored_files')
      nnoremap <silent><buffer><expr> ~
     \ defx#do_action('cd')
      nnoremap <silent><buffer><expr> <Space>
     \ defx#do_action('toggle_select') . 'j'
      nnoremap <silent><buffer><expr> *
     \ defx#do_action('toggle_select_all')
      nnoremap <silent><buffer><expr> j
     \ line('.') == line('$') ? 'gg' : 'j'
      nnoremap <silent><buffer><expr> k
     \ line('.') == 1 ? 'G' : 'k'
      nnoremap <silent><buffer><expr> <C-l>
     \ defx#do_action('redraw')
      nnoremap <silent><buffer><expr> <C-g>
     \ defx#do_action('print')
      nnoremap <silent><buffer><expr> cd
     \ defx#do_action('change_vim_cwd')
    endfunction

    call defx#custom#option('_', {
	      \ 'columns': 'mark:indent:icons:filename:type',
	      \ })

    " It's weird...
    " autocmd VimEnter * call timer_start(0, { tid -> execute('Defx -split=vertical -winwidth=30 -direction=topleft')})
    map <silent> <C-\> :Defx -toggle -split=vertical -winwidth=30 -direction=topleft -resume<CR>
endif

" vim-javascript
if dein#tap('vim-javascript')
  let g:javascript_plugin_jsdoc = 1
endif

" vim-jsx-pretty
if dein#tap('vim-jsx-pretty')
  let g:vim_jsx_pretty_colorful_config = 1
endif

" vim-jsx-pretty
if dein#tap('vim-jsx')
  let g:jsx_ext_required = 0
endif

" vim-markdown
if dein#tap('vim-markdown')
  let g:vim_markdown_folding_disabled = 1
endif

" vim-matlab
if dein#tap('vim-matlab')
  let g:matlab_server_split = 'vertical'
  let g:matlab_auto_mappings = 1
  let g:matlab_server_launcher = 'tmux'
endif

" vim-vue
if dein#tap('vim-vue')
  autocmd FileType vue syntax sync fromstart
endif

if dein#tap('vimtex')
  let g:vimtex_latexmk_enabled = 1
  let g:vimtex_quickfix_latexlog = {'default' : 0}
  let g:vimtex_quickfix_autoclose_after_keystrokes = 1
  let g:tex_flavor='platex'
  let g:vimtex_compiler_latexmk_engines = { '_' : '-pdfdvi' }
  let g:vimtex_compiler_latexmk = {
        \ 'backend': 'nvim',
        \ 'background' : 0,
        \ 'build_dir' : '',
        \ 'continuous' : 1,
        \ 'options' : [
        \   '-pdfdvi',
        \   '-verbose',
        \   '-shell-escape',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \}
  let g:tex_conceal = ''
  let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
  let g:vimtex_view_general_options = '@line @pdf @tex'
  let g:vimtex_compiler_progname = 'nvr'
endif

" vim-trailing-whitespace
if dein#tap('vim-trailing-whitespace')
  " Delete whitespace automatically when current file is saved
  autocmd BufWritePre *  call s:StripTrailingWhitespace()
  fun! s:StripTrailingWhitespace()
    " Only strip if the b:noStripeWhitespace variable isn't set
    if exists('b:noStripWhitespace')
      return
    endif
    :FixWhitespace
  endfun
endif

if dein#tap('vim-scripts/YankRing.vim')
  let g:yankring_clipboard_monitor=0
endif

" }}}

" Colorscheme
colorscheme brogrammer

" Check whether plugins should be installed or not
if has('vim_starting') && dein#check_install()
  call dein#install()
endif

" scrooloose/nerdtree
nnoremap <silent> <Leader>e :<C-u>NERDTreeToggle<CR> " バックスペースとeキーでnerdtreeを起動する
let g:NERDTreeWinSize=50 " 表示幅
let g:NERDTreeShowBookmarks=1 " ブックマークを表示
let g:NERDTreeMapUpdir='<C-u>' " 親ディレクトリへ移動
let g:NERDTreeMapOpenSplit='<C-j>' " 下にファイルを開く
let g:NERDTreeMapOpenVSplit='<C-l>' " 左にファイルを開く
let g:NERDTreeQuitOnOpen=1 " ファイルを開いたらNERDTreeを閉じる
let g:NERDTreeShowHidden=1 " 隠しファイルを表示
let g:NERDTreeIgnore=['\.git$', '\.clean$', '\.swp$', '\.bak$', '\~$'] " 非表示ファイル

augroup vimrc_nerdtree
  autocmd!
  " 他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる。
  autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif

  " Tree内では5ずつ移動する
  autocmd FileType nerdtree nnoremap 5j
  autocmd FileType nerdtree nnoremap 5k
augroup END

" vim-gitgutter
nmap <silent> <C-g><C-n> <Plug>GitGutterNextHunk
nmap <silent> <C-g><C-p> <Plug>GitGutterPrevHunk

" majutsushi/tagbar
nnoremap <silent> <Leader>t :<C-u>TagbarToggle<CR>

" easymotion/vim-easymotion
map  <Leader>j <Plug>(easymotion-bd-w)
nmap <Leader>j <Plug>(easymotion-overwin-w)
map <Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader>l <Plug>(easymotion-overwin-line)
map <Leader>k <Plug>(easymotion-bd-f)
nmap <Leader>k <Plug>(easymotion-overwin-f)
