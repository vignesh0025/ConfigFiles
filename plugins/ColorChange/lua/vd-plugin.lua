json = require "json"

select_scheme = {
        [0] = function() set_color_scheme("gruvbox-material", "dark", "gruvbox_material") end,
        [1] = function() set_color_scheme("PaperColor", "light", "papercolor") end,
        [2] = function() set_color_scheme("gotham256", "dark", "gotham256") end,
        [3] = function() set_color_scheme("jellybeans", "dark", "jellybeans") end,
        [4] = function() set_color_scheme("nord", "dark", "nord") end
}

config_file = "/home/vignesh/.config/nvim/set.json"

function set_color_scheme(name, background, airline)
    -- [[
    -- This the below statement are set twice before and after setting colorscheme to fix an
    -- issue of nord colorscheme for airline not working before settings colorscheme. Whereas
    -- some themes affect colorscheme themself
    -- ]]
    current_color_scheme = vim.api.nvim_exec(string.format([[
        set background=%s
        colorscheme %s
    ]], background, name), false)

    vim.api.nvim_set_var("airline_theme", airline)

    current_color_scheme = vim.api.nvim_exec(string.format([[
        set background=%s
        colorscheme %s
    ]], background, name), false)

end

local lsettings_write = function(data)
    file,err = io.open(config_file,"w")
    io.output(file)
    json_data = json.encode({color_no = data})
    io.write(json_data)
    file:close()
end

local lsettings_read = function()
    file = io.open(config_file, 'r')
    if file == nil then
        lsettings_write(0)
        file = io.open(config_file, 'r')
    end
    io.input(file)
    data = io.read()
    file:close()
    return json.decode(data)
end

local linit = function ()
    if vim.g.color_no == nil then vim.g.color_no = lsettings_read()["color_no"] end
    vim.g.color_no = vim.g.color_no + 1
    if vim.g.color_no > 4 then vim.g.color_no = 0 end
    -- current_color_scheme = vim.api.nvim_exec("colorscheme", true)
    select_scheme[vim.g.color_no]()
    lsettings_write(vim.g.color_no)
    return vim.g.color_no
end


local lset_init_theme = function()
    if vim.g.color_no == nil then vim.g.color_no = lsettings_read()["color_no"] end
    select_scheme[vim.g.color_no]()
end

return {
    init = linit,
    settings_read = lsettings_read,
    set_init_theme = lset_init_theme
}
