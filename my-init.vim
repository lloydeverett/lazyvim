" leader config
" nnoremap <SPACE> <Nop>
" let mapleader = " "
" let maplocalleader = "\\"

" adjust defaults
set nocompatible
filetype plugin on
syntax on
set scrolloff=5
set relativenumber
set nu rnu
set expandtab autoindent tabstop=4 shiftwidth=4
set hidden
set nowrap
set noswapfile
set undofile
set undodir=~/.local/share/nvim/undo/
set ssop-=options
set ssop-=folds
set listchars=tab:,nbsp:~
set list
set fillchars=eob:\ 
set noshowmode
set shortmess+=I
set signcolumn=yes:2
set numberwidth=4
" aunmenu PopUp.How-to\ disable\ mouse
" aunmenu PopUp.-2-

" terminal keymappings
lua require('mylua.terminals')

" evaluate lua file shortcut
" lua <<EOF
" vim.keymap.set("n", "<leader>gl", function()
"     vim.cmd("luafile " .. vim.fn.expand("<cWORD>"))
" end, { noremap = true })
" EOF

" like gf but create file if it doesn't exist
" lua <<EOF
" vim.keymap.set("n", "<leader>gf", function()
"     local word = vim.fn.expand("<cWORD>")
"
"     if string.sub(word, 1, 2) == "./" then
"         word = vim.fn.expand("%:p:h") .. string.sub(word, 2)
"     end
"
"     vim.cmd("e " .. word)
" end, { noremap = true })
" EOF

" swap between buffers with <leader><leader>
nnoremap <leader><leader> <C-^>

" clear search highlight with esc
nnoremap <silent> <Esc> :noh<CR><Esc>

" normal mode in terminal via esc
tnoremap <Esc> <C-\><C-n>
tnoremap <C-Esc> <Esc>

" shortcut for :put call
" nnoremap <leader>H :put=execute('hi')

" cursorline
lua <<EOF
vim.api.nvim_create_autocmd({ "FocusGained", "WinEnter", "BufEnter" }, {
    callback = function()
        vim.o.cursorline = true
    end,
})
vim.api.nvim_create_autocmd({ "FocusLost", "WinLeave", "BufLeave" }, {
    callback = function()
        vim.o.cursorline = false
    end,
})
EOF

" don't replace register by default when pasting in visual mode
xnoremap p P

" update buffer when file changes
set autoread
au CursorHold * checktime

" folding
set foldmethod=indent
set foldlevelstart=99
autocmd FileType markdown setlocal foldlevelstart=99

" auto-close terminals when shell exits
autocmd TermClose * execute 'bdelete!'

" custom highlights
" lua require('config.highlights')

" custom winbar
" lua require('config.winbar')

" custom vimwiki conceal + syntax highlight rules
" set conceallevel=2
" set concealcursor=ncv
" fun s:vimwiki()
"     syn match todoCheckbox '\v(\s+)?(-|\*)\s\[\s\]'hs=e-4 conceal cchar=
"     syn match todoCheckbox '\v(\s+)?(-|\*)\s\[X\]'hs=e-4 conceal containedin=todoDone cchar=
"     syn match todoDone '\v(\s+)?(-|\*)\s\[X\].*$' contains=VimwikiItalic,VimwikiBold
"     syn match todoCheckbox '\v(\s+)?(-|\*)\s\[-\]'hs=e-4 conceal cchar=󰅘
"     syn match todoCheckbox '\v(\s+)?(-|\*)\s\[\.\]'hs=e-4 conceal cchar=⊡
"     syn match todoCheckbox '\v(\s+)?(-|\*)\s\[o\]'hs=e-4 conceal cchar=⬕
"     syn match todoCheckbox '\v(\s+)?(-|\*)\s\[/\]'hs=e-4 conceal cchar=
"
"     syn match VimwikiHeader1Setext "=" conceal cchar=═ containedin=VimwikiHeader1 contained
"     syn match VimwikiHeader2Setext "-" conceal cchar=─ containedin=VimwikiHeader2 contained
"
"     syn match TodoDateMonth '\d\d\d\d-\d\d[^-]'he=e-1
"
"     set conceallevel=2
"     set concealcursor=ncv
" endfun
" augroup ft_vimwiki
"   autocmd!
"   autocmd Syntax vimwiki call s:vimwiki()
" augroup end

" cmp keybindings
" lua <<EOF
" local function configure_mappings(mapping, cmp)
"     mapping['<C-e>'] = cmp.mapping.abort()
"     -- mapping['<C-b>'] = cmp.mapping.scroll_docs(-4)
"     -- mapping['<C-f>'] = cmp.mapping.scroll_docs(4)
"     -- mapping['<C-Space>'] = cmp.mapping.complete()
"     -- mapping['<Down>'] = cmp.mapping.select_next_item()
"     -- mapping['<Up>'] = cmp.mapping.select_prev_item()
"     mapping['<Down>'] = cmp.mapping(function(fallback)
"       if cmp.visible() then
"         cmp.select_next_item()
"       else
"         fallback()
"       end
"     end, { 'i', 'c' })
"     mapping['<Up>'] = cmp.mapping(function(fallback)
"       if cmp.visible() then
"         cmp.select_prev_item()
"       else
"         fallback()
"       end
"     end, { 'i', 'c' })
"     mapping['<Tab>'] = cmp.mapping(function(fallback)
"       if cmp.visible() then
"         -- select = true forces it to confirm the currently highlighted item
"         cmp.confirm({ select = true })
"       else
"         fallback()
"       end
"     end, { 'i', 'c' })
"     return mapping
" end
" local cmp = require('cmp')
" local current_config = cmp.get_config()
" configure_mappings(current_config.mapping, cmp)
" cmp.setup(current_config)
" cmp.setup.cmdline({ '/', '?' }, {
"     mapping = cmp.mapping.preset.cmdline(configure_mappings({}, cmp)),
"     sources = {
"         { name = 'buffer' }
"     }
" })
" -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
" cmp.setup.cmdline(':', {
"     mapping = cmp.mapping.preset.cmdline(configure_mappings({}, cmp)),
"     sources = cmp.config.sources({
"         { name = 'path' }
"     }, {
"         { name = 'cmdline' }
"     }),
"     matching = { disallow_symbol_nonprefix_matching = false }
" })
" EOF

