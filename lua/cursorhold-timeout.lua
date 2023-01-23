local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local M = {}
local timer_n = nil
local timer_i = nil
local config = {
  -- default config
  timeout = vim.opt.updatetime:get(),
}

local function cursor_hold(mode, cmd)
  if vim.api.nvim_get_mode().mode ~= mode then
    return
  end

  vim.opt.eventignore:remove(cmd)
  vim.api.nvim_exec_autocmds(cmd, {})
  vim.opt.eventignore:append(cmd)
end

local function cursor_move(t, callback)
  if t == nil or t:is_closing() then
    t = vim.defer_fn(callback, config.timeout)
  else
    t:stop()
    t:start(config.timeout, 0, vim.schedule_wrap(callback))
  end

  return t
end

local function cursor_hold_n()
  cursor_hold("n", "CursorHold")
end

local function cursor_hold_i()
  cursor_hold("i", "CursorHoldI")
end

local function cursor_move_n()
  timer_n = cursor_move(timer_n, cursor_hold_n)
end

local function cursor_move_i()
  timer_i = cursor_move(timer_i, cursor_hold_i)
end

function M.setup(opts)
  config = vim.tbl_deep_extend("force", config, opts or {})

  -- disable default CursorHold
  vim.opt.eventignore:append("CursorHold")

  -- set custom cursor hold
  local g = augroup("custom_hold", { clear = true })
  autocmd("CursorMoved", { callback = cursor_move_n, group = g})
  autocmd("CursorMovedI", { callback = cursor_move_i, group = g})
end

return M
