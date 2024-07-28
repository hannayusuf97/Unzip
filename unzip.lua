-- Functions to get input files and find user
local files = get_input_files()
local username = users_find()
local is_dirpath = get_input("is_dirpath")

-- Supported extensions
local supportedExtensions = {".zip", ".7z", ".rar", ".tar", ".gz", ".bz2", ".xz"}

-- Function to remove supported extensions from file paths
local function removeSupportedExtensions(fpath)
    for _, ext in ipairs(supportedExtensions) do
        fpath = fpath:gsub(ext .. "$", "")
    end
    return fpath
end

-- Function to create a directory if it doesn't exist
local function createDirectory(dir)
    Commented out shell command, added message for testing
    shell_command("mkdir -p \"" .. dir .. "\"")
end

-- Function to extract files based on their extension
local function extractFile(fpath, noext)
    local command = ""
    if fpath:match("%.rar$") then
        if is_dirpath then
            command = "unrar x \"" .. fpath .. "\" \"" .. noext .. "\""
        else
            command = "unrar x \"" .. fpath .. "\""
        end
    else
        if is_dirpath then
            command = "7z x \"" .. fpath .. "\" -o\"" .. noext .. "\""
        else
            command = "7z x \"" .. fpath .. "\""
        end
    end
    add_message("Extracting file: " .. command)
    return command
end

-- Main script logic
if (#files > 0) then
    for i, file in ipairs(files) do
        local fpath = meta_data(file).local_path
        local noext = removeSupportedExtensions(fpath)
        createDirectory(noext)  -- Create directory before extraction
        local command = extractFile(fpath, noext)
        add_message("Command to execute: " .. command)
        shell_command(command)
        shell_command("chmod a+rx \"" .. noext .. "\"")
    end
end
