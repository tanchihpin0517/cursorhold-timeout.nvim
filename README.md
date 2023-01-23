# cursorhold-timeout.nvim

**This plugin is inspired by [FixCursorHold.nvim](https://github.com/antoinemadec/FixCursorHold.nvim) which is used to solve the performance bug in the earlier version of neovim**

## Features
The triggered time of auto-commands `CursorHold` and `CursorHoldI` is set by `updatetime` of vim's option.

Some plugins like [symbols-outline.nvim](https://github.com/simrat39/symbols-outline.nvim) insert their callback function into `CursorHold` for frequent state updates. 
However, it may cause performance issues if we tune `updatetime` to a small value because this option is also used for other purposes, such as the time interval of **saving swap file**.

This plugin provides a way to set an independent timeout for `CursorHold` and `CursorHoldI` without changing `updatetime`.
Unlike [FixCursorHold.nvim](https://github.com/antoinemadec/FixCursorHold.nvim), this plugin is completely written in Lua.

## Installation

Using `packer.nvim`

```lua
use 'tanchihpin0517/cursorhold-timeout.nvim'
```

## Setup

Put the setup call in your init.lua or any lua file that is sourced.

```lua
require("cursorhold-timeout").setup({
    timeout = 1000, -- (milliseconds)
})
```