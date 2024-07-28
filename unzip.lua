-- Functions to get input files and find user
local files = get_input_files()
local username = users_find()
local is_dirpath = get_input("is_dirpath")
-- Supported extensions
local supportedExtensions = {".zip", ".7z", ".rar", ".tar", ".gz", ".bz2", ".xz"}

-- Function to get the directory path
local function getDirectoryPath(rootpath)
    add_message("rootpath " .. rootpath)
    
    -- Execute the shell command to get the directory path
    local result = shell_command("dirname \"" .. rootpath .. "\"")
    add_message("result " .. result.output)
    
    -- Trim any trailing whitespace from the output
    local dirPath = result.output:gsub("%s+$", "")
    return dirPath
end

-- Function to remove supported extensions from file paths
local function removeSupportedExtensions(fpath)
    for _, ext in ipairs(supportedExtensions) do
        fpath = fpath:gsub(ext .. "$", "")
    end
    return fpath
end

-- Function to create a directory if it doesn't exist
local function createDirectory(dir)
    add_message("Creating directory: " .. dir)
    shell_command("mkdir -p \"" .. dir .. "\"")
end

-- Function to extract files based on their extension
local function extractFile(fpath, noext, outputdir)
    local command = ""
    if fpath:match("%.rar$") then
        if is_dirpath then
            add_message("is dirpath")
            createDirectory(noext)
            command = "unrar x \"" .. fpath .. "\" \"" .. noext .. "\""
        else
            command = "unrar x \"" .. fpath .. "\" \"" .. outputdir .. "\""
        end
    else
        if is_dirpath then
           createDirectory(noext)
           command = "7z x \"" .. fpath .. "\" -o\"" .. noext .. "\""
        else
            command = "7z x \"" .. fpath .. "\" -o\"" .. outputdir .. "\""
        end
    end
    return command
end

-- Main script logic
if (#files > 0) then
    for i, file in ipairs(files) do
        local fpath = meta_data(file).local_path
        add_message("filepath " .. fpath)
        local noext = removeSupportedExtensions(fpath)
        add_message("no ext " .. noext)
        local outputdir = getDirectoryPath(fpath)
        local command = extractFile(fpath, noext, outputdir)
        add_message("Command to execute: " .. command)
        shell_command(command)
        shell_command("chmod a+rx \"" .. noext .. "\"")
    end
end
