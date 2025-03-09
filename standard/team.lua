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
local Logic = require('Module:Logic')
local String = require('Module:StringUtils')
local Table = require('Module:Table')

local function getNullMessage(name)
	mw.log('Missing team: ' .. name)
	return '<small class="error">No team template exists for name "' .. name .. '".</small>' .. '[[Category:Pages with missing team templates]]'
end

local custom = {
	['team'] = function (name, img)
		return '<span data-highlightingclass="' .. name .. '" class="team-template-team-standard"><span class="team-template-image-icon">[[File:' .. img .. '|100x50px|link=' .. name .. ']]</span> <span class="team-template-text">[[' .. name .. ']]</span></span>'
	end,
	['team2'] = function (name, img)
		return '<span data-highlightingclass="' .. name .. '" class="team-template-team-standard"><span class="team-template-text">[[' .. name .. ']]</span> <span class="team-template-image-icon">[[File:' .. img .. '|100x50px|link=' .. name .. ']]</span></span>'
	end,
	['teamshort'] = function (name, img)
		return '<span data-highlightingclass="' .. name .. '" class="team-template-team-short"><span class="team-template-image-icon">[[File:' .. img .. '|100x50px|link=' .. name .. ']]</span> <span class="team-template-text">[[' .. name .. ']]</span></span>'
	end,
	['team2short'] = function (name, img)
		return '<span data-highlightingclass="' .. name .. '" class="team-template-team-short"><span class="team-template-text">[[' .. name .. ']]</span> <span class="team-template-image-icon">[[File:' .. img .. '|100x50px|link=' .. name .. ']]</span></span>'
	end,
	['teambracket'] = function (name, img)
		return '<span data-highlightingclass="' .. name .. '" class="team-template-team-bracket"><span class="team-template-image-icon">[[File:' .. img .. '|100x50px|link=|' .. name .. ']]</span> <span class="team-template-text">' .. name .. '</span></span>'
	end,
	['teamicon'] = function (name, img)
		return '<span data-highlightingclass="' .. name .. '" class="team-template-team-icon"><span class="team-template-image-icon">[[File:' .. img .. '|100x50px|link=' .. name .. ']]</span></span>'
	end,
	['teampart'] = function (name, img)
		return '<span class="team-template-team-part"><span class="team-template-image-icon">[[File:' .. img .. '|100x50px|link=' .. name .. ']]</span></span>'
	end,
	['iconfile'] = function (_, img) return img end,
	['imageFile'] = function (_, img) return img end,
	['imageFileDark'] = function (_, img) return img end,
	['teampage'] = function (name, _) return name end
} --[[@as table<string, (fun(name:string, img:string): string)> ]]

local p = {}

function p.override(form, name, data)
	if name == nil then
		return nil
	end
	local overrides = mw.loadData('Module:Team/override')
	if overrides.templates[name:lower()] then
		return overrides.templates[name:lower()][form:lower()]
	elseif overrides.game[name:lower()] and data then
		return custom[form:lower()](data, overrides.games[mw.ext.VariablesLua.var('tournament_game', ''):lower()])
	elseif overrides.games[name:lower()] and data then
		return custom[form:lower()](data, overrides.games[name:lower()])
	elseif name:lower() == 'noteam' then
		return overrides.templates[''][form:lower()]
	else
		return nil
	end
end

---@param form string
---@param name string
---@param date string
---@param skipOverride boolean?
---@return teamTemplateData|string?
function p._getTemplate(form, name, date, skipOverride)
	if not(skipOverride) then
		local override = p.override(form, name, date)
		if override then
			return override
		end
	end
	if mw.ext.TeamTemplate.teamexists(name) then
		return mw.ext.TeamTemplate[form](name, date or DateExt.getContextualDateOrNow())
	elseif mw.ext.TeamTemplate.teamexists(mw.text.trim(name))then
		mw.log("Trimmed needed on team name: ".. name)
		mw.ext.TeamLiquidIntegration.add_category('Pages with trimmed team templates')
		return mw.ext.TeamTemplate[form](mw.text.trim(name), date or DateExt.getContextualDaeOrNow())
	elseif mw.ext.TeamTemplate.teamexists(name:gsub("_", " ")) then
		mw.log("Underscore in team name: ".. name)
		mw.ext.TeamLiquidIntegration.add_category('Pages with underscore team templates')
		return mw.ext.TeamTemplate[form]((name:gsub("_", " ")), date or DateExt.getContextualDateOrNow())
	elseif mw.ext.TeamTemplate.teamexists(name:gsub(" ", "_")) then
		mw.log("Underscore in team name: ".. name)
		mw.ext.TeamLiquidIntegration.add_category('Pages with underscore team templates')
		return mw.ext.TeamTemplate[form]((name:gsub(" ", "_")), date or DateExt.getContextualDateOrNow())
	else
		return nil
	end
end

function p.team(_, name, date)
	return p._getTemplate('team', name, date) or getNullMessage(name)
end

function p.team2(_, name, date)
	return p._getTemplate('team2', name, date) or getNullMessage(name)
end

function p.short(_, name, date)
	return p._getTemplate('teamshort', name, date) or ('<div class="error">' .. name .. ' (missing)</div>' .. '[[Category:Pages with missing team templates]]')
end

function p.short2 (_, name, date)
	return p._getTemplate('team2short', name, date) or ('<span class="error">(missing) ' .. name .. '</span>' .. '[[Category:Pages with missing team templates]]')
end

function p.bracket(_, name, date, skipOverride)
	return p._getTemplate('teambracket', name, date, skipOverride) or ('<span class="error">Missing: ' .. name .. '</span>' .. '[[Category:Pages with missing team templates]]')
end

function p.bracketShort(_, name, date, skipOverride)
	if not(skipOverride) then
		local override = p.override('teambracket', name, date)
		if override then return override end
	end
	local output
	if mw.ext.TeamTemplate.teamexists(name) then
		output = mw.ext.TeamTemplate.raw(name, date or DateExt.getContextualDateOrNow())
	elseif mw.ext.TeamTemplate.teamexists(mw.text.trim(name)) then
		output = mw.ext.TeamTemplate.raw(mw.text.trim(name), date or DateExt.getContextualDateOrNow())
	elseif mw.ext.TeamTemplate.teamexists(name:gsub("_", " ")) then
		output = mw.ext.TeamTemplate.raw(name:gsub("_", " "), date or DateExt.getContextualDateOrNow())
	elseif mw.ext.TeamTemplate.teamexists(name:gsub(" ", "_")) then
		output = mw.ext.TeamTemplate.raw(name:gsub(" ", "_"), date or DateExt.getContextualDateOrNow())
	else
		mw.log('Missing team: ' .. name)
		return '<span class="error">Missing: ' .. name .. '</span>' .. '[[Category:Pages with missing team templates]]'
	end
	if String.isNotEmpty(output.image) then
		return '<span data-highlightingclass="' .. output.page .. '" class="team-template-team-bracket"><span class="team-template-image-icon lightmode">[[File:' .. output.image .. '|100x50px|link=]]</span><span class="team-template-image-icon darkmode" style="display:none">[[File:' .. Logic.emptyOr(output.imagedark, output.image) .. '|100x50px|link=]]</span> <span class="team-template-text">' .. output.shortname .. '</span></span>'
	else
		return '<span data-highlightingclass="' .. output.page .. '" class="team-template-team-bracket"><span class="team-template-image-legacy">[[File:' .. output.legacyimage .. '|link=]]</span> <span class="team-template-text">' .. output.shortname .. '</span></span>'
	end
end

function p.icon(_, name, date)
		return p._getTemplate('teamicon', name, date) or getNullMessage(name)
end

function p.iconFile(_, name, date)
	local output = p.override('iconfile', name, date)
	if output then return output
	elseif mw.ext.TeamTemplate.teamexists(name) then
		output = mw.ext.TeamTemplate.raw(name, date or DateExt.getContextualDateOrNow())
	elseif mw.ext.TeamTemplate.teamexists(mw.text.trim(name)) then
		output = mw.ext.TeamTemplate.raw(mw.text.trim(name), date or DateExt.getContextualDateOrNow())
	elseif mw.ext.TeamTemplate.teamexists(name:gsub("_", " ")) then
		output = mw.ext.TeamTemplate.raw(name:gsub("_", " "), date or DateExt.getContextualDateOrNow())
	elseif mw.ext.TeamTemplate.teamexists(name:gsub(" ", "_")) then
		output = mw.ext.TeamTemplate.raw(name:gsub(" ", "_"), date or DateExt.getContextualDateOrNow())
	else
		mw.log('Missing team: ' .. name .. ' (icon)')
		return mw.loadData('Module:Team/override').games['']
	end
	return Logic.emptyOr(output.image, output.legacyimage)
end

function p.imageFile(_, name, date)
	local output
	if mw.ext.TeamTemplate.teamexists(name) then
		output = mw.ext.TeamTemplate.raw(name, date or DateExt.getContextualDateOrNow())
	elseif mw.ext.TeamTemplate.teamexists(mw.text.trim(name)) then
		output = mw.ext.TeamTemplate.raw(mw.text.trim(name), date or DateExt.getContextualDateOrNow())
	elseif mw.ext.TeamTemplate.teamexists(name:gsub("_", " ")) then
		output = mw.ext.TeamTemplate.raw(name:gsub("_", " "), date or DateExt.getContextualDateOrNow())
	elseif mw.ext.TeamTemplate.teamexists(name:gsub(" ", "_")) then
		output = mw.ext.TeamTemplate.raw(name:gsub(" ", "_"), date or DateExt.getContextualDateOrNow())
	else
		mw.log('Missing team: ' .. name .. ' (icon)')
		return nil
	end
	return Logic.emptyOr(output.image)
end

function p.imageFileDark(_, name,date)
	local output
	if mw.ext.TeamTemplate.teamexists(name) then
		output = mw.ext.TeamTemplate.raw(name, date or DateExt.getContextualDateOrNow())
	elseif mw.ext.TeamTemplate.teamexists(mw.text.trim(name)) then
		output = mw.ext.TeamTemplate.raw(mw.text.trim(name), date or DateExt.getContextualDateOrNow())
	elseif mw.ext.TeamTemplate.teamexists(name:gsub("_", " ")) then
		output = mw.ext.TeamTemplate.raw(name:gsub("_", " "), date or DateExt.getContextualDateOrNow())
	elseif mw.ext.TeamTemplate.teamexists(name:gsub(" ", "_")) then
		output = mw.ext.TeamTemplate.raw(name:gsub(" ", "_"), date or DateExt.getContextualDateOrNow())
	else
		mw.log('Missing team: ' .. name .. ' (icon)')
		return nil
	end
	return Logic.emptyOr(output.imagedark, output.image)
end

function p.part(_, name, date)
	return p._getTemplate('teampart', name, date) or getNullMessage(name)
end

function p.page(_, name, date)
	local override = p.override('teampage', name, date)
	if override then
		return override
	elseif mw.ext.TeamTemplate.teamexists(name) then
		return mw.ext.TeamTemplate.teampage(name, date or DateExt.getContextualDateOrNow())
	elseif mw.ext.TeamTemplate.teamexists(mw.text.trim(name)) then
		return mw.ext.TeamTemplate.teampage(mw.text.trim(name), date or DateExt.getContextualDateOrNow())
	elseif mw.ext.TeamTemplate.teamexists(name:gsub("_", " ")) then
		return mw.ext.TeamTemplate.teampage(name:gsub("_", " "), date or DateExt.getContextualDateOrNow())
	elseif mw.ext.TeamTemplate.teamexists(name:gsub(" ", "_")) then
		return mw.ext.TeamTemplate.teampage(name:gsub(" ", "_"), date or DateExt.getContextualDateOrNow())
	else
		return name
	end
end

function p.shortname(_, name, date)
	return (p._getTemplate('raw', name, date) or {}).shortname or getNullMessage(name)
end

function p.name(_, name, date)
	return (p._getTemplate('raw', name, date) or {}).name or getNullMessage(name)
end

function p.template(_, name, date)
	return (p._getTemplate('raw', name, date) or {}).templatename or getNullMessage(name)
end

function p.bracketname(_, name, date, skipOverride)
	if not(skipOverride) then
		local override = p.override('teambracket', name, date)
		if override then return override end
	end
	local output
	if mw.ext.TeamTemplate.teamexists(name) then
		output = mw.ext.TeamTemplate.raw(name, date or DateExt.getContextualDateOrNow())
	elseif mw.ext.TeamTemplate.teamexists(mw.text.trim(name)) then
		output = mw.ext.TeamTemplate.raw(mw.text.trim(name), date or DateExt.getContextualDateOrNow())
	elseif mw.ext.TeamTemplate.teamexists(name:gsub("_", " ")) then
		output = mw.ext.TeamTemplate.raw(name:gsub("_", " "), date or DateExt.getContextualDateOrNow())
	elseif mw.ext.TeamTemplate.teamexists(name:gsub(" ", "_")) then
		output = mw.ext.TeamTemplate.raw(name:gsub(" ", "_"), date or DateExt.getContextualDateOrNow())
	else
		mw.log('Missing team: ' .. name)
		mw.ext.TeamLiquidIntegration.add_category('Pages with missing team templates')
		return '<span class="error">Missing: ' .. name .. '</span>'
	end
	if String.isNotEmpty(output.image) then
		return '<span data-highlightingclass="' .. output.page .. '" class="team-template-team-short"><span class="team-template-image-icon">[[File:' .. output.image .. '|link=' .. name .. ']]</span> <span class="team-template-text">[[' .. output.bracketname .. ']]</span></span>'
	else
		return '<span data-highlightingclass="' .. output.page .. '" class="team-template-team-short"><span class="team-template-image-legacy">[[File:' .. output.legacyimage .. '|link=' .. name .. ']]</span> <span class="team-template-text">[[' .. output.bracketname .. ']]</span>'
	end
end

function p.get(frame)
	local args = Arguments.getArgs(frame)
	if args[1] then
		return p[args[1]](frame, args[2] or '', args[3])
	else
		mw.ext.TeamLiquidIntegration.add_category('Pages with invalid team templates')
		return '<span class="error">Invalid team template form specified.</span>'
	end
end

function p.queryDB(type, name, date)
	if mw.ext.TeamTemplate.teamexists(name) then
		return mw.ext.TeamTemplate[type](name, date)
	else
		return nil
	end
end

---@param name string
---@param date string|number?
---@return teamTemplateData?
function p.queryRaw(name, date)
	if mw.ext.TeamTemplate.teamexists(name) then
		return mw.ext.TeamTemplate.raw(name, date)
	else
		return nil
	end
end

---@param name string
---@return {[string]: string}?
function p.queryHistorical(name)
	return mw.ext.TeamTemplate.raw_historical(name)
end

---@param name string
---@return string[]|nil
function p.queryHistoricalNames(name)
	if mw.ext.TeamTemplate.teamexists(name) then
		local index = p.queryHistorical(name)
		if Logic.isNotEmpty(index) then
			local templates = Table.mapValues(index, FnUtil.identity)
			return Array.unique(templates)
		else
			return { mw.ext.TeamTemplate.teampage(name) }
		end
	else
		return nil
	end
end

return Class.export(p)
