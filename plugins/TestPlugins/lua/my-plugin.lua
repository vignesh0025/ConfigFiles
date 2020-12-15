local fn = function ()
    print("Testing new plugin.. Ahaha Hahah")

    -- THis represents the usable window size and excluding the splits
    local width = vim.api.nvim_win_get_width(0)
    local height = vim.api.nvim_win_get_height(0)

    -- This represents the total window size (including the window splits)
    local columns = vim.api.nvim_get_option("columns")
    local lines = vim.api.nvim_get_option("lines")

    local win_width = math.ceil(columns * 0.8)
    local win_height = math.ceil(lines * 0.8)

    -- Starting position of the window in the screen
    local row = math.ceil((lines - win_height) / 2)
    local col = math.ceil((columns - win_width) / 2)

    buf = vim.api.nvim_create_buf(false, true)
    win = vim.api.nvim_open_win(buf, true, {focusable=true,
        relative='win',style='minimal',row=row, col=col, width=win_width, height=win_height})

    -- Create a scratch buffer and window to display like a border around out floating display
    bbuf = vim.api.nvim_create_buf(false, true)
    bwin = vim.api.nvim_open_win(bbuf, false, {focusable=false,
        relative='win',style='minimal',row=row-1, col=col-1, width=win_width+2,
    height=win_height+2})

    -- Manually Create a buffer and draw the border aroud the floating window
    border_lines = {"|"..string.rep("-",win_width).."|"}
    for i=1,win_height do
        table.insert(border_lines,"|"..string.rep(" ",win_width).."|")
    end

    table.insert(border_lines, "|"..string.rep("-",win_width).."|")
    vim.api.nvim_buf_set_lines(bbuf, 0, -1, false, border_lines)

    -- print('au! BufWipeout,BufUnload,BufDelete <buffer='..buf..'> bwipeout! '..bbuf)
    -- This command deletes the buffer we created for the background. Oh WOW WOW WOW
    vim.api.nvim_command('au! BufWinLeave,BufWipeout,BufUnload,BufDelete <buffer='..buf..'> bwipeout! '..bbuf)
end

return fn
