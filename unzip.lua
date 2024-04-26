local files = get_input_files()
local username = users_find()

if (#files >  0) then
    for i, file in ipairs(files) do
        local fpath = string.lower(meta_data(file).local_path)
        local noext = fpath:gsub("%.zip$", "")
        shell_command("unzip " .. fpath .." -d " .. noext)
        shell_command("chmod a+rx " .. fpath)
    end
end