---
-- @Liquipedia
-- wiki=commons
-- page=Module:Team
--
-- Please see https://github.com/Liquipedia/Lua-Modules to contribute
--

local Arguments = require('Module:Arguments')
local Array = require('Module:Array')
local Class = require('Module:Class')
local DateExt = require('Module:Date/Ext')
local FnUtil = require('Module:FnUtil')
local Image = require('Module:Image')
local Logic = require('Module:Logic')
local Lua = require('Module:Lua')
local String = require('Module:StringUtils')
local Table = require('Module:Table')
local TeamTemplate = require('Module:TeamTemplate')
local Variables = require('Module:Variables')

local Overrides = Lua.import('Module:Team/override', { loadData = true })

local function getNullMessage(name)
	mw.log('Missing team: ' .. name)
	mw.ext.TeamLiquidIntegration.add_category('Pages with missing team templates')
	return '<small class="error">No team template exists for name "' .. name .. '".</small>'
end

local custom = {
	['team'] = function (name, img)
		return '<span data-highlightingclass="' .. name .. '" class="team-template-team-standard">' ..
			'<span class="team-template-image-icon">' .. Image.display(img, nil, {size = '100x50px', link = name}) ..
			'</span> <span class="team-template-text">[[' .. name .. ']]</span></span>'
	end,
	['team2'] = function (name, img)
		return '<span data-highlightingclass="' .. name .. '" class="team-template-team-standard">' ..
			'<span class="team-template-text">[[' .. name .. ']]</span> <span class="team-template-image-icon">' ..
			Image.display(img, nil, {size = '100x50px', link = name}) .. '</span></span>'
	end,
	['teamshort'] = function (name, img)
		return '<span data-highlightingclass="' .. name .. '" class="team-template-team-short">' ..
			'<span class="team-template-image-icon">' .. Image.display(img, nil, {size = '100x50px', link = name}) ..
			'</span> <span class="team-template-text">[[' .. name .. ']]</span></span>'
	end,
	['team2short'] = function (name, img)
		return '<span data-highlightingclass="' .. name .. '" class="team-template-team-short">' ..
			'<span class="team-template-text">[[' .. name .. ']]</span> <span class="team-template-image-icon">' ..
			Image.display(img, nil, {size='100x50px', link=name}) .. '</span></span>'
	end,
	['teambracket'] = function (name, img)
		return '<span data-highlightingclass="' .. name .. '" class="team-template-team-bracket">' ..
			'<span class="team-template-image-icon">' .. Image.display(img, nil, {size = '100x50px', link = name}) ..
			'</span> <span class="team-template-text">' .. name .. '</span></span>'
	end,
	['teamicon'] = function (name, img)
		return '<span data-highlightingclass="' .. name .. '" class="team-template-team-icon">' ..
			'<span class="team-template-image-icon">' .. Image.display(img, nil, {size = '100x50px',link = name}) ..
			'</span></span>'
	end,
	['teampart'] = function (name, img)
		return '<span class="team-template-team-part"><span class="team-template-image-icon">' ..
			Image.display(img, nil, {size = '100x50px', link = name}) .. '</span></span>'
	end,
	['iconfile'] = function (_, img) return img end,
	['imageFile'] = function (_, img) return img end,
	['imageFileDark'] = function (_, img) return img end,
	['teampage'] = function (name, _) return name end
} --[[@as table<string, (fun(name:string, img:string): string)> ]]

local Team = {}

---@param name string
---@return string|nil
function Team._preprocessTeamTemplateName(name)
	if TeamTemplate.exists(name) then
		return name
	elseif TeamTemplate.exists(String.trim(name))then
		mw.log("Trimmed needed on team name: ".. name)
		return String.trim(name)
	elseif TeamTemplate.exists(name:gsub("_", " ")) then
		mw.log("Underscore in team name: ".. name)
		mw.ext.TeamLiquidIntegration.add_category('Pages with underscore team templates')
		local sub_name = name:gsub("_", " ")
		return sub_name
	elseif TeamTemplate.exists(name:gsub(" ", "_")) then
		mw.log("Underscore in team name: ".. name)
		mw.ext.TeamLiquidIntegration.add_category('Pages with underscore team templates')
		local sub_name = name:gsub(" ", "_")
		return sub_name
	end
	return nil
end

function Team.override(form, name, data)
	if name == nil then
		return nil
	end
	if Overrides.templates[name:lower()] then
		return Overrides.templates[name:lower()][form:lower()]
	elseif Overrides.game[name:lower()] and data then
		return custom[form:lower()](data, Overrides.games[Variables.varDefault('tournament_game', ''):lower()])
	elseif Overrides.games[name:lower()] and data then
		return custom[form:lower()](data, Overrides.games[name:lower()])
	elseif name:lower() == 'noteam' then
		return Overrides.templates[''][form:lower()]
	else
		return nil
	end
end

---@param type 'team'|'team2'|'teamshort'|'team2short'|'teambracket'|'teamicon'|'teampart'
---@param name string
---@param date string|number?
---@return string
---@overload fun(type: 'raw', name: string, date: string|number?): teamTemplateData?
function Team._getTemplate(type, name, date, skipOverride)
	if not(skipOverride) then
		local override = Team.override(type, name, date)
		if override then
			return override
		end
	end
	local processedName = Team._preprocessTeamTemplateName(name)
	if processedName == nil then
		return nil
	elseif type == 'raw' then
		return TeamTemplate.getRawOrNil(processedName)
	end
	return mw.ext.TeamTemplate[type](processedName, date or DateExt.getContextualDateOrNow())
end

function Team.team(_, name, date)
	return Team._getTemplate('team', name, date) or getNullMessage(name)
end

function Team.team2(_, name, date)
	return Team._getTemplate('team2', name, date) or getNullMessage(name)
end

function Team.short(_, name, date)
	return Team._getTemplate('teamshort', name, date) or (
		'<div class="error">' .. name .. ' (missing)</div>' .. '[[Category:Pages with missing team templates]]'
	)
end

function Team.short2(_, name, date)
	return Team._getTemplate('team2short', name, date) or (
		'<span class="error">(missing) ' .. name .. '</span>' .. '[[Category:Pages with missing team templates]]'
	)
end

function Team.bracket(_, name, date, skipOverride)
	return Team._getTemplate('teambracket', name, date, skipOverride) or (
		'<span class="error">Missing: ' .. name .. '</span>' .. '[[Category:Pages with missing team templates]]'
	)
end

function Team.bracketShort(_, name, date, skipOverride)
	if not(skipOverride) then
		local override = Team.override('teambracket', name, date)
	if override then return override end
	end
	local processedName = Team._preprocessTeamTemplateName(name)
	if not processedName then
		mw.log('Missing team: ' .. name)
		mw.ext.TeamLiquidIntegration.add_category('Pages with missing team templates')
		return '<span class="error">Missing: ' .. name .. '</span>'
	end
	local output = TeamTemplate.getRawOrNil(processedName, date or DateExt.getContextualDateOrNow()) or {}
	if String.isNotEmpty(output.image) then
		return '<span data-highlightingclass="' .. output.page .. '" class="team-template-team-bracket">' ..
			'<span class="team-template-image-icon lightmode">' ..
			Image.display(output.image, nil, {size = '100x50px', link = ''}) ..
			'</span><span class="team-template-image-icon darkmode" style="display:none">' ..
			Image.display(Logic.emptyOr(output.imagedark, output.image), nil, {size = '100x50px', link = ''}) ..
			'</span> <span class="team-template-text">' .. output.shortname .. '</span></span>'
	else
		return '<span data-highlightingclass="' .. output.page .. '" class="team-template-team-bracket">' ..
			'<span class="team-template-image-legacy">' .. Image.display(output.legacyimage, nil, {link = ''}) ..
			'</span> <span class="team-template-text">' .. output.shortname .. '</span></span>'
	end
end

function Team.icon(_, name, date)
		return Team._getTemplate('teamicon', name, date) or getNullMessage(name)
end

function Team.iconFile(_, name, date)
	local output = Team.override('iconfile', name, date)
	if output then
		return output
	end
	local processedName = Team._preprocessTeamTemplateName(name)
	if not processedName then
		mw.log('Missing team: ' .. name .. ' (icon)')
		return Overrides.games['']
	end
	local imageLight, _ = TeamTemplate.getIcon(processedName, date)
	return imageLight
end

function Team.imageFile(_, name, date)
	local processedName = Team._preprocessTeamTemplateName(name)
	if not processedName then
		mw.log('Missing team: ' .. name .. ' (icon)')
		return nil
	end
	local imageLight, _ = TeamTemplate.getIcon(processedName, date)
	return imageLight
end

function Team.imageFileDark(_, name,date)
	local processedName = Team._preprocessTeamTemplateName(name)
	if not processedName then
		mw.log('Missing team: ' .. name .. ' (icon)')
		return nil
	end
	local _, imageDark = TeamTemplate.getIcon(processedName, date)
	return imageDark
end

function Team.part(_, name, date)
	return Team._getTemplate('teampart', name, date) or getNullMessage(name)
end

function Team.page(_, name, date)
	local override = Team.override('teampage', name, date)
	if override then
		return override
	end
	local processedName = Team._preprocessTeamTemplateName(name)
	if processedName then
		return mw.ext.TeamTemplate.teampage(processedName, date or DateExt.getContextualDateOrNow())
	else
		return name
	end
end

function Team.shortname(_, name, date)
	return (TeamTemplate.getRawOrNil(name, date) or {}).shortname or getNullMessage(name)
end

function Team.name(_, name, date)
	return (TeamTemplate.getRawOrNil(name, date) or {}).name or getNullMessage(name)
end

function Team.template(_, name, date)
	return (TeamTemplate.getRawOrNil(name, date) or {}).templatename or getNullMessage(name)
end

function Team.bracketname(_, name, date, skipOverride)
	if not(skipOverride) then
		local override = Team.override('teambracket', name, date)
		if override then return override end
	end
	local processedName = Team._preprocessTeamTemplateName(name)
	if not processedName then
		mw.log('Missing team: ' .. name .. ' (icon)')
		return Overrides.games['']
	end
	local output = TeamTemplate.getRawOrNil(processedName, date or DateExt.getContextualDateOrNow()) or {}
	if String.isNotEmpty(output.image) then
		return '<span data-highlightingclass="' .. output.page .. '" class="team-template-team-short">' ..
			'<span class="team-template-image-icon">' .. Image.display(output.image, nil, {link = name}) ..
			'</span> <span class="team-template-text">[[' .. output.bracketname .. ']]</span></span>'
	else
		return '<span data-highlightingclass="' .. output.page .. '" class="team-template-team-short">' ..
			'<span class="team-template-image-legacy">' .. Image.display(output.legacyimage, nil, {link = name}) ..
			'</span> <span class="team-template-text">[[' .. output.bracketname .. ']]</span>'
	end
end

---@param frame Frame
---@return string
function Team.get(frame)
	local args = Arguments.getArgs(frame)
	if args[1] then
		return Team[args[1]](frame, args[2] or '', args[3])
	else
		mw.ext.TeamLiquidIntegration.add_category('Pages with invalid team templates')
		return '<span class="error">Invalid team template form specified.</span>'
	end
end

---@param type string
---@param name string
---@param date string|number?
---@return string|teamTemplateData?
function Team.queryDB(type, name, date)
	if TeamTemplate.exists(name) then
		return mw.ext.TeamTemplate[type](name, date)
	else
		return nil
	end
end

---Use TeamTemplate.getRawOrNil instead.
---@param name string
---@param date string|number?
---@return teamTemplateData?
---@deprecated
function Team.queryRaw(name, date)
	return TeamTemplate.getRawOrNil(name, date)
end

---Use TeamTemplate.queryHistorical instead. 
---@param name string
---@return {[string]: string}?
---@deprecated
function Team.queryHistorical(name)
	return TeamTemplate.queryHistorical(name)
end

---Use TeamTemplate.queryHistoricalNames instead.
---@param name string
---@return string[]|nil
---@deprecated
function Team.queryHistoricalNames(name)
	return TeamTemplate.queryHistoricalNames(name)
end

return Class.export(Team)
