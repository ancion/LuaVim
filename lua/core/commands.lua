local M = {}

M.defaults = {
  --: QuickFixToggle
  [[
    function! QuickFixToggle()
      if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
      else
        cclose
      endif
    endfunction
  ]],

   -- : CompileAndRun
  [[
    function! CompileAndRun()
      exec "w"
      if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
      elseif &filetype == 'cpp'
        set splitbelow
        exec "!g++ -std=c++11 % -Wall -o %<"
        :sp
        :res -15
        :term ./%<
      elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
      elseif &filetype == "html"
        silent! exec "!live-server % &"
      elseif &filetype == 'python'
        set splitbelow
        :sp
        :term python3 %
      elseif &filetype == 'sh'
        :term bash %
      elseif &filetype == 'javascript'
        :set splitbelow
        :sp
        :term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings %
      elseif &filetype == 'go'
        :TermExec cmd="go run ."
        " set splitbelow
        " :sp
        " :term go run .
      endif
    endfunction
  ]],

  -- :LvimInfo
  [[ command! LvimInfo lua require('core.info').toggle_popup(vim.bo.filetype) ]],
  [[ command! LvimCacheReset lua require('utils.hooks').reset_cache() ]],
  [[ command! LvimUpdate lua require('bootstrap').update() ]],
}

M.load = function(commands)
  for _, command in ipairs(commands) do
    vim.cmd(command)
  end
end

return M
