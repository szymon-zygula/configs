-- Encoding
vim.opt.encoding = 'utf-8'

-- Lazy redraw (faster macros)
vim.opt.lazyredraw = true

-- Persistent undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('$HOME/.local/share/nvim/undo')
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

-- Disable swap files
vim.opt.swapfile = false

-- Leave 5 line ahead while scrolling
vim.opt.scrolloff = 5

-- Search case
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Tabs as 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Do not hide anything (like quotes in JSON)
vim.opt.conceallevel = 0
vim.g.vim_json_conceal = 0
vim.g.tex_conceal = 0

-- Spellcheck
local text_filetypes = 'markdown,md,html,htm,text,tex'
local spellcheck_group = vim.api.nvim_create_augroup('spellcheck', {clear = true})
vim.api.nvim_create_autocmd({'FileType'}, {
    pattern = text_filetypes,
    group = spellcheck_group,
    command = 'setlocal spell spelllang=en,pl',
})

-- Folding
vim.optfoldmethod = 'indent'
vim.optnofoldenable = true


-- Line wrapping
vim.opt.wrap = false
local wrapping_group = vim.api.nvim_create_augroup('wrapping', {clear = true})
vim.api.nvim_create_autocmd({'FileType'}, {
    pattern = text_filetypes,
    group = wrapping_group,
    command = 'setlocal wrap'
})
vim.api.nvim_create_autocmd({'FileType'}, {
    pattern = text_filetypes,
    group = wrapping_group,
    command = 'setlocal linebreak'
})
vim.api.nvim_create_autocmd({'FileType'}, {
    pattern = text_filetypes,
    group = wrapping_group,
    command = 'setlocal breakindent'
})

-- Open new horizontal splits below active window instead of above
vim.opt.splitbelow = true

-- Reload init.lua
vim.keymap.set('n', '<f5>', '<cmd>source $MYVIMRC<cr>', {silent = true})

-- Quick init.lua split
vim.keymap.set('n', '<f6>', '<cmd>vsplit $MYVIMRC<cr>', {silent = true})

-- Leader
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Quick movement
vim.keymap.set('!', '<a-k>', '<up>')
vim.keymap.set('!', '<a-j>', '<down>')
vim.keymap.set('!', '<a-h>', '<left>')
vim.keymap.set('!', '<a-l>', '<right>')
vim.keymap.set('!', '<c-d>', '<delete>')
vim.keymap.set('!', '<a-f>', '<esc>lwi')
vim.keymap.set('!', '<a-b>', '<esc>bi')

-- Put semicolon at the end of a line
vim.keymap.set('n', '<leader>\'', 'm`$a;<esc>``')

-- Quick save
vim.keymap.set('n', '<c-s>', '<cmd>w<cr>')
vim.keymap.set('i', '<c-s>', '<esc><cmd>w<cr>')

-- Quick quit
vim.keymap.set('v', '<c-q>', '<esc>')
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>')
vim.keymap.set('n', '<c-q>', '<cmd>bd<cr>')

-- Delete with(out) yanking
vim.keymap.set('', '<leader>d', '"_d')
vim.keymap.set('', '<leader>D', '"_D')
vim.keymap.set('', '<leader>c', '"_c')
vim.keymap.set('', '<leader>C', '"_C')
vim.keymap.set('', 'x', '"_x')
vim.keymap.set('', 'X', '"_X')
vim.keymap.set('', '<leader>x', 'x')
vim.keymap.set('', '<leader>X', 'X')

-- Tab switching shortcuts
vim.keymap.set('n', '<c-l>', '<cmd>tabnext<cr>')
vim.keymap.set('n', '<c-h>', '<cmd>tabprevious<cr>')
vim.keymap.set('n', '<c-k>', '<cmd>tabnew<cr>')
vim.keymap.set('n', '<c-j>', '<cmd>tabclose<cr>')

-- Use Y for copying to end of the line
vim.keymap.set('n', 'Y', 'y$')

-- Clear search
vim.keymap.set('n', '<leader>a', '<cmd>nohlsearch<cr>')

-- Line numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- Highlight current line
vim.opt.cursorline = true

-- Line length indicator
vim.opt.colorcolumn = {100, 120}

-- Truecolor
vim.opt.termguicolors = true

-- Display tabs and tailing spaces
vim.opt.listchars = 'tab:▸ ,trail:·'
vim.opt.list = true

-- Better fillchars
table.insert(vim.opt.fillchars, 'vert:|')
table.insert(vim.opt.fillchars, 'fold:─')
table.insert(vim.opt.fillchars, 'foldopen:┌')
table.insert(vim.opt.fillchars, 'foldclose:═')
table.insert(vim.opt.fillchars, 'diff:╱')

-- Cursor shape
vim.opt.guicursor =
    'n-o:hor50,i-c-ci:ver25,v-r-cr:block,' ..
    'a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,' ..
    'sm:hor50-blinkwait175-blinkoff150-blinkon175'

-- Plugins

-- If lazy.nvim is already loaded, don't load it again.
-- Without this, it complains.
if package.loaded['lazy'] == nil then
    local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
    if not vim.loop.fs_stat(lazypath) then
      vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
      })
    end
    vim.opt.rtp:prepend(lazypath)

    local plugins = {
        {
            -- Colorscheme
            'nlknguyen/papercolor-theme',
            lazy = true,
            priority = 1000
        },
        {
            -- Quotes, parenthesis, brackets, etc. autocompletion
            'Raimondi/delimitMate'
        },
        {
            -- Surroundings edition with [cdy]s
            'kylechui/nvim-surround',
            event = 'VeryLazy',
            config = function()
                require('nvim-surround').setup({})
            end
        },
        {
            -- Commenting with gc, gcc (not the compiler)
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup()
            end
        },
        {
            -- Allow [fFtT] to work accross multiple lines
            'dahu/vim-fanfingtastic'
        },
    }

    require('lazy').setup(plugins, opts)
end

vim.keymap.set('n', '<f4>', '<cmd>Lazy show<cr>')

vim.cmd.colorscheme('PaperColor')
