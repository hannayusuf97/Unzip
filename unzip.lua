local files = get_input_files()
local username = users_find()

local supportedExtensions = {".zip", ".7z", ".rar", ".tar", ".gz", ".bz2", ".xz"}

local function removeSupportedExtensions(fpath)
    for _, ext in ipairs(supportedExtensions) do
        fpath = fpath:gsub(ext .. "$", "")
    end
    return fpath
end

if (#files >  0) then
    for i, file in ipairs(files) do
        local fpath = (meta_data(file).local_path)
        local noext = removeSupportedExtensions(fpath)
        shell_command("7z x " .. fpath .." -o" .. noext)
        shell_command("chmod a+rx " .. noext)
    end
end
