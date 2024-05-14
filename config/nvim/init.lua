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
local spellcheck_group = vim.api.nvim_create_augroup('spellcheck', { clear = true })
vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = text_filetypes,
    group = spellcheck_group,
    command = 'setlocal spell spelllang=en,pl',
})

-- Folding
vim.optfoldmethod = 'indent'
vim.optnofoldenable = true


-- Line wrapping
vim.opt.wrap = false
local wrapping_group = vim.api.nvim_create_augroup('wrapping', { clear = true })
vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = text_filetypes,
    group = wrapping_group,
    command = 'setlocal wrap'
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = text_filetypes,
    group = wrapping_group,
    command = 'setlocal linebreak'
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = text_filetypes,
    group = wrapping_group,
    command = 'setlocal breakindent'
})

-- Open new horizontal splits below active window instead of above
vim.opt.splitbelow = true

-- Reload init.lua
vim.keymap.set('n', '<f5>', '<cmd>source $MYVIMRC<cr>', { silent = true })

-- Quick init.lua split
vim.keymap.set('n', '<f6>', '<cmd>vsplit $MYVIMRC<cr>', { silent = true })

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
vim.opt.colorcolumn = { 100, 120 }

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

vim.keymap.set('n', '<leader>3', function()
    vim.diagnostic.open_float(0, {
        scope = "cursor",
        focusable = false,
        close_events = {
            "CursorMoved",
            "CursorMovedI",
            "BufHidden",
            "InsertCharPre",
            "WinLeave",
        },
    })
end)

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
        { -- Colorscheme
            'sainnhe/sonokai',
            lazy = true,
            priority = 1000
        },
        {
            -- Quotes, parenthesis, brackets, etc. autocompletion
            'Raimondi/delimitMate'
        },
        {
            -- Color matching delimiters
            'hiphish/rainbow-delimiters.nvim'
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
            -- Smooth scrolling
            'psliwka/vim-smoothie'
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
        {
            -- Better syntax highlighting
            'nvim-treesitter/nvim-treesitter',
            config = function()
                require('nvim-treesitter.configs').setup({
                    ensure_installed = {
                        'c',
                        'cpp',
                        'rust',
                        'lua',
                        'vim',
                        'vimdoc',
                        'glsl',
                        'toml'
                    },
                    auto_install = false,
                    highlight = {
                        enable = true
                    }
                })
            end,
            build = function()
                vim.cmd('TSUpdate')
            end
        },
        {
            -- Find files, buffers, symbols and other things
            'nvim-telescope/telescope.nvim',
            dependencies = {
                'nvim-lua/plenary.nvim',
                'debugloop/telescope-undo.nvim',
                'nvim-telescope/telescope-ui-select.nvim'
            },
            config = function()
                require('telescope').setup({
                    extensions = {
                        undo = {},
                        ['ui-select'] = {
                            require("telescope.themes").get_dropdown({})
                        }
                    }
                })

                require('telescope').load_extension('undo')
                require('telescope').load_extension('ui-select')

                local tlin = require('telescope.builtin')
                vim.keymap.set('n', '<leader>fb', tlin.buffers)
                vim.keymap.set('n', '<leader>fG', tlin.live_grep)
                vim.keymap.set('n', '<leader>ff', tlin.find_files)
                vim.keymap.set('n', '<leader>fg', tlin.git_files)
                vim.keymap.set('n', '<leader>fr', tlin.oldfiles)

                local tlex = require('telescope').extensions
                vim.keymap.set('n', '<leader>u', tlex.undo.undo)

                vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>')
                vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>')
                vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<cr>')
                vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<cr>')
                vim.keymap.set('n', 'gw', '<cmd>Telescope lsp_workspace_symbols<cr>')
                vim.keymap.set('n', 'gl', '<cmd>Telescope diagnostics<cr>')
            end
        },
        {
            -- Git integration
            'tpope/vim-fugitive'
        },
        {
            -- Indentation guides
            'lukas-reineke/indent-blankline.nvim',
            main = 'ibl',
            opts = {}
        },
        {
            -- Keep undo history even after modification with tools other than neovim
            'kevinhwang91/nvim-fundo',
            dependencies = {
                'kevinhwang91/promise-async'
            },
            config = function()
                require('fundo').setup()
            end,
            build = function()
                require('fundo').install()
            end,
            lazy = false
        },
        {
            -- File manager
            'nvim-neo-tree/neo-tree.nvim',
            dependencies = {
                'nvim-lua/plenary.nvim',
                'nvim-tree/nvim-web-devicons',
                'MunifTanjim/nui.nvim'
            },
            config = function()
                require("neo-tree").setup({
                    filesystem = {
                        follow_current_file = {
                            enabled = true
                        }
                    }
                })

                vim.keymap.set('n', '<leader>N', '<cmd>Neotree right<cr>')
            end
        },
        {
            -- Task runner
            'stevearc/overseer.nvim',
            lazy = false,
            opts = {
                task_list = {
                    direction = 'bottom',
                    min_height = 20,
                }
            }
        },
        {
            -- Display list of diagnostics
            "folke/trouble.nvim",
            dependencies = { "nvim-tree/nvim-web-devicons" },
            config = function()
                vim.keymap.set('n', '<leader>t', '<cmd>TroubleToggle<cr>')
            end
        },
        {
            -- Language server
            'VonHeikemen/lsp-zero.nvim',
            dependencies = {
                'williamboman/mason.nvim',
                'williamboman/mason-lspconfig.nvim',
                'neovim/nvim-lspconfig',
                'hrsh7th/nvim-cmp',
                'hrsh7th/cmp-nvim-lsp',
                'L3MON4D3/LuaSnip',
            },
            config = function()
                local lsp = require('lsp-zero')
                lsp.on_attach(function(_, bufnr)
                    lsp.default_keymaps({ buffer = bufnr })
                end)

                require('mason').setup({})
                require('mason-lspconfig').setup({
                    ensure_installed = {
                        'rust_analyzer',
                        'clangd',
                        'lua_ls',
                        'jsonls',
                    },
                    handlers = {
                        lsp.default_setup,
                        lua_ls = function()
                            local lua_opts = lsp.nvim_lua_ls()
                            require('lspconfig').lua_ls.setup(lua_opts)
                        end
                    }
                })

                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
                vim.keymap.set('n', '<leader>1', vim.lsp.buf.format)
                vim.keymap.set('n', '<leader>2', vim.lsp.buf.code_action)
                vim.keymap.set('v', '<leader>2', vim.lsp.buf.code_action)
            end,
            build = function()
            end
        },
        {
            -- Debug adapter protocol
            'puremourning/vimspector',
            config = function()
                vim.g.vimspector_sign_priority = {
                    vimspectorBP = 50,
                    vimspectorBPCond = 50,
                    vimspectorBPLog = 50,
                    vimspectorBPDisabled = 50,
                }
                -- function CustomizeVimspectorUI()
                --   call win_gotoid( g:vimspector_session_windows.output )
                --   100winc -
                --   call win_gotoid( g:vimspector_session_windows.code )
                -- end
                --
                -- augroup VimspectorUICustomistaion
                --   autocmd!
                --   autocmd User VimspectorUICreated call CustomizeVimspectorUI()
                -- augroup END

                -- vim.api.sign_define('vimspectorBP', { text = 'B', texthl = 'WarningMsg' })
                -- vim.api.sign_define('vimspectorBPCond', { text = 'C', texthl = 'WarningMsg' })
                -- vim.api.sign_define('vimspectorBPLog', { text = 'L', texthl = 'SpellRare' })
                -- vim.api.sign_define('vimspectorBPDisabled', { text = 'D', texthl = 'LineNr' })
                -- vim.api.sign_define('vimspectorPC', { text = '->', texthl = 'MatchParen', linehl = 'CursorLine' })
                -- vim.api.sign_define('vimspectorPCBP', { text = 'B>', texthl = 'MatchParen', linehl = 'CursorLine' })
                -- vim.api.sign_define('vimspectorCurrentThread', {
                --     text = '->',
                --     texthl = 'MatchParen',
                --     linehl =
                --     'CursorLine'
                -- })
                -- vim.api.sign_define('vimspectorCurrentFrame', { text = '->', texthl = 'Special', linehl = 'CursorLine' })

                vim.keymap.set('n', '<A-b>', '<plug>VimspectorToggleBreakpoint<cr>')
                vim.keymap.set('n', '<A-x>', '<plug>VimspectorToggleConditionalBreakpoint<cr>')
                vim.keymap.set('n', '<A-f>', '<plug>VimspectorAddFunctionBreakpoint<cr>')

                vim.keymap.set('n', '<A-c>', '<plug>VimspectorContinue<cr>')
                vim.keymap.set('n', '<A-p>', '<plug>VimspectorPause<cr>')
                vim.keymap.set('n', '<A-h>', '<plug>VimspectorStop<cr>')
                vim.keymap.set('n', '<A-r>', '<plug>VimspectorRestart<cr>')
                vim.keymap.set('n', '<A-q>', '<Cmd>VimspectorReset<cr>')

                vim.keymap.set('n', '<A-n>', '<plug>VimspectorStepOver<cr>')
                vim.keymap.set('n', '<A-s>', '<plug>VimspectorStepInto<cr>')
                vim.keymap.set('n', '<A-o>', '<plug>VimspectorStepOut<cr>')

                vim.keymap.set('n', '<A-k>', '<plug>VimspectorUpFrame<cr>')
                vim.keymap.set('n', '<A-j>', '<plug>VimspectorDownFrame<cr>')
                vim.keymap.set('n', '<A-m>', '<plug>VimspectorJumpToProgramCounter<cr>')
                vim.keymap.set('n', '<A-w>', '<Cmd>VimspectorWatch\\ ')

                vim.keymap.set('n', '<A-e>', '<plug>VimspectorBalloonEval<cr>')
                vim.keymap.set('n', '<A-l>', '<plug>VimspectorGoToCurrentLine<cr>')
                vim.keymap.set('n', '<A-u>', '<plug>VimspectorRunToCursor<cr>')
                vim.keymap.set('n', '<A-d>', '<plug>VimspectorDisassemble<cr>')
                vim.keymap.set('n', '<A-p>', '<cmd>VimspectorShowOutput Console<cr>')
            end
        }
    }

    require('lazy').setup(plugins, {})
end

vim.keymap.set('n', '<f4>', '<cmd>Lazy show<cr>')

vim.g.sonokai_style = 'shusia'
vim.g.sonokai_better_performance = 1
vim.cmd.colorscheme('sonokai')
