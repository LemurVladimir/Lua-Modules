config = function()
    local cfg = require("luacheck.config").load_default_config()

    -- Function to check if a file imports 'standard.lua'
    local function imports_standard(file_content)
        return file_content:match("require%s*%(?%s*['\"]Module:Standard['\"]%)?")
    end

    -- Add globals to files that import 'standard.lua'
    for _, file in ipairs(cfg.files) do
        local file_content = require("luacheck.utils").read_file(file)
        if file_content and imports_standard(file_content) then
            cfg.overrides[file] = {
				read_globals = {
                    "Array",
                    "Class",
                    "Condition",
                    "DateExt",
                    "I18n",
                    "Info",
                    "Json",
                    "Logic",
                    "Lpdb",
                    "Lua",
                    "Operator",
                    "Page",
                    "String",
                    "Table",
                    "Variables",
                }
            }
        end
    end

    return cfg
end

std = {
	globals = {
		"mw",
	},
	read_globals = {
		"arg",
		"assert",
		"debug",
		"error",
		"getmetatable",
		"ipairs",
		"math",
		"next",
		"os",
		"package",
		"pairs",
		"pcall",
		"rawget",
		"rawset",
		"require",
		"select",
		"setmetatable",
		"string",
		"table",
		"tonumber",
		"tostring",
		"type",
		"unpack",
		"xpcall",
	}
}

exclude_files = {
	".install", -- package files
	".luarocks", -- package manager files
	"3rd/*", -- 3rd party
	"node_modules/*", -- to speedup run when running locally
}

-- https://luacheck.readthedocs.io/en/stable/warnings.html#list-of-warnings
ignore = {
	"212" -- unused argument
}

files["spec/*_spec.lua"].read_globals = {"GoldenTest", "SetActiveWiki", "allwikis"}
