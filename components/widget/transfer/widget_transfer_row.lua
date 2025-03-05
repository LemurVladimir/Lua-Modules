---
-- @Liquipedia
-- wiki=commons
-- page=Module:Widget/Transfer/Row
--
-- Please see https://github.com/Liquipedia/Lua-Modules to contribute
--

local Array = require('Module:Array')
local Class = require('Module:Class')
local DateExt = require('Module:Date/Ext')
local Logic = require('Module:Logic')
local Lua = require('Module:Lua')
local String = require('Module:StringUtils')
local Table = require('Module:Table')

local IconModule = Lua.requireIfExists('Module:PositionIcon/data', {loadData = true})
local Info = Lua.import('Module:Info', {loadData = true})
local Platform = Lua.import('Module:Platform')
local PlayerDisplay = Lua.import('Module:Player/Display/Custom')
local TransferRef = Lua.import('Module:Transfer/References')

local Widget = Lua.import('Module:Widget')
local HtmlWidgets = Lua.import('Module:Widget/Html/All')
local Div = HtmlWidgets.Div
local IconFa = Lua.import('Module:Widget/Image/Icon/Fontawesome')
local TransferRoleWidget = Lua.import('Module:Widget/Transfer/Role')
local WidgetUtil = Lua.import('Module:Widget/Util')

local HAS_PLATFORM_ICONS = Lua.moduleExists('Module:Platform/data')
local EMPTY_POSITION_ICON = '[[File:Logo filler event.png|16px|link=]]'
local SPECIAL_ROLES = {'retired', 'inactive', 'military', 'passed away'}
local TRANSFER_ARROW = '&#x21d2;'
local RUMOUR_STATUS_TO_ICON_ARGS = {
	correct = {iconName = 'correct', color = 'forest-green-text'},
	wrong = {iconName = 'wrong', color = 'cinnabar-text'},
	uncertain = {iconName = 'uncertain', color = 'bright-sun-text'},
}
local CONFIDENCE_TO_COLOR = {
	certain = 'forest-theme-dark-text',
	likely = 'bright-sun-non-text',
	possible = 'california-non-text',
	unlikely = 'cinnabar-theme-dark-text',
	unknown = 'gigas-theme-light-alt-text',
}

---@class enrichedTransfer
---@field from {teams: string[], roles: string[]}
---@field to {teams: string[], roles: string[]}
---@field platform string?
---@field displayDate string
---@field date string
---@field wholeteam boolean
---@field players transferPlayer[]
---@field references string[]
---@field confirmed boolean?
---@field confidence string?
---@field isRumour boolean?

---@class transferPlayer: standardPlayer
---@field icons string[]
---@field faction string?
---@field chars string[]

---@class TransferRowWidget: Widget
---@field props {showTeamName: boolean?, transfers: transfer[]}
---@field display Html
local TransferRowWidget = Class.new(Widget)
TransferRowWidget.defaultProps = {
	showTeamName = (Info.config.transfers or {}).showTeamName,
}

---@param transfers transfer[]
---@return enrichedTransfer
function TransferRowWidget:_enrichTransfers(transfers)
	if Logic.isEmpty(transfers) then return {} end

	local transfer = transfers[1]

	local date = DateExt.toYmdInUtc(transfer.date)

	return {
		from = {
			teams = {
				String.nilIfEmpty(transfer.fromteamtemplate),
				String.nilIfEmpty(transfer.extradata.fromteamsectemplate),
			},
			roles = {
				String.nilIfEmpty(transfer.role1),
				String.nilIfEmpty(transfer.extradata.role1sec),
			},
		},
		to = {
			teams = {
				String.nilIfEmpty(transfer.toteamtemplate),
				String.nilIfEmpty(transfer.extradata.toteamsectemplate),
			},
			roles = {
				String.nilIfEmpty(transfer.role2),
				String.nilIfEmpty(transfer.extradata.role2sec),
			},
		},
		platform = HAS_PLATFORM_ICONS and self:_displayPlatform(transfer.extradata.platform) or nil,
		displayDate = String.nilIfEmpty(transfer.extradata.displaydate) or date,
		date = date,
		wholeteam = Logic.readBool(transfer.wholeteam),
		players = self:_readPlayers(transfers),
		references = self:_getReferences(transfers),
		confirmed = transfer.extradata.confirmed,
		confidence = transfer.extradata.confidence,
		isRumour = transfer.extradata.isRumour,
	}
end

---@param platform string
---@return string?
function TransferRowWidget:_displayPlatform(platform)
	if not HAS_PLATFORM_ICONS then return end
	if Logic.isEmpty(platform) then return '' end
	return Platform._getIcon(platform) or ''
end

---@param transfers transfer[]
---@return transferPlayer[]
function TransferRowWidget:_readPlayers(transfers)
	return Array.map(transfers, function(transfer)
		local extradata = transfer.extradata
		return {
			pageName = transfer.player,
			displayName = String.nilIfEmpty(extradata.displayname) or transfer.player,
			flag = transfer.nationality,
			icons = {String.nilIfEmpty(extradata.icon), String.nilIfEmpty(extradata.icon2)},
			faction = extradata.faction,
			chars = extradata.chars,
		}
	end)
end

---@param transfers transfer[]
---@return string[]
function TransferRowWidget:_getReferences(transfers)
	local references = {}
	Array.forEach(transfers, function(transfer)
		Array.extendWith(references, TransferRef.fromStorageData(transfer.reference))
	end)
	references = TransferRef.makeUnique(references)

	return Array.map(references, TransferRef.createReferenceIconDisplay)
end

---@return Widget?
function TransferRowWidget:render()
	self.transfer = self:_enrichTransfers(self.props.transfers)
	if Logic.isEmpty(self.transfer) then return end

	return Div{
		classes = {
			self.transfer.isRumour and 'RumourRow' or 'divRow mainpage-transfer-' .. self:_getStatus()
		},
		children = {
			self:status(),
			self:confidence(),
			self:date(),
			self:platform(),
			self:players(),
			self:from(),
			self:icon(),
			self:to(),
			self:references()
		}
	}
end

---@return Widget?
function TransferRowWidget:status()
	if not self.transfer.isRumour then return nil end

	local iconArgs = RUMOUR_STATUS_TO_ICON_ARGS[self.transfer.confirmed]
	return Div{
		classes = { 'divCell Status' },
		children = {
			IconFa{
				iconName = iconArgs.iconName,
				color = iconArgs.color
			}
		}
	}
end

---@return Widget?
function TransferRowWidget:confidence()
	if not self.transfer.isRumour then return nil end

	local confidence = self.transfer.confidence

	return Div{
		classes = { 'divCell Confidence', CONFIDENCE_TO_COLOR[confidence] },
		css = { ['font-weight'] = 'bold' },
		children = { confidence and mw.getContentLanguage():ucfirst(confidence) or nil }
	}
end

---@return string
function TransferRowWidget:_getStatus()
	local transfer = self.transfer
	if transfer.from.teams[1] and transfer.to.teams[1] then
		return 'neutral'
	elseif transfer.from.teams[1] then
		return 'from-team'
	elseif transfer.to.teams[1] then
		return 'to-team'
	elseif self:_isSpecialRole(transfer.from.roles[1]) then
		return 'to-team'
	elseif self:_isSpecialRole(transfer.to.roles[1]) then
		return 'from-team'
	end

	return 'neutral'
end

---@param role string?
---@return boolean
function TransferRowWidget:_isSpecialRole(role)
	if not role then return false end
	role = role:lower()
	return Table.includes(SPECIAL_ROLES, role)
end

---@return Widget
function TransferRowWidget:date()
	return Div{
		classes = { 'divCell Date' },
		children = { self.transfer.displayDate }
	}
end

---@return Widget?
function TransferRowWidget:platform()
	return self.transfer.platform and Div{
		classes = { 'divCell GameIcon' },
		children = { self.transfer.platform }
	} or nil
end

---@return Widget
function TransferRowWidget:players()
	return Div{
		classes = { 'divCell Name' },
		children = Array.map(self.transfer.players, function(player)
			return PlayerDisplay.BlockPlayer{player = player}
		end)
	}
end

---@return Widget
function TransferRowWidget:from()
	return self:_displayTeam{
		data = self.transfer.from,
		date = self.transfer.date,
		isOldTeam = true,
	}
end

---@param args {isOldTeam: boolean, date: string, data: {teams: string[], roles: string[]}}
---@return Widget
function TransferRowWidget:_displayTeam(args)
	local showTeamName = self.props.showTeamName
	local isOldTeam = args.isOldTeam
	local data = args.data
	local align = isOldTeam and 'right' or 'left'
	local teamDisplay
	local roleDisplay

	if not data.teams[1] and not data.roles[1] then
		roleDisplay = TransferRoleWidget{
			roles = { '&nbsp;None&nbsp;' },
			align = align,
			addMargin = showTeamName
		}
	else
		local displayTeam = showTeamName and
			(isOldTeam and mw.ext.TeamTemplate.team2short or mw.ext.TeamTemplate.teamshort) or
			mw.ext.TeamTemplate.teamicon

		teamDisplay = Array.interleave(Array.map(data.teams, function(team)
			return displayTeam(team, args.date)
		end), ' / ')

		roleDisplay = TransferRoleWidget{
			roles = data.roles,
			team = data.teams[1],
			align = align,
			addMargin = (showTeamName and not data.teams[1])
		}
	end

	return Div{
		classes = { 'divCell Team ' .. (isOldTeam and 'OldTeam' or 'NewTeam') },
		css = { ['text-align'] = showTeamName and align or nil },
		children = WidgetUtil.collect(
			teamDisplay,
			data.teams[1] and HtmlWidgets.Br,
			roleDisplay
		)
	}
end

---@param roles string[]
---@param team string?
---@return Widget?
function TransferRowWidget:_createRole(roles, team)
	return TransferRoleWidget{roles = roles, team = team}
end

---@return Widget
function TransferRowWidget:icon()
	local iconCell = Div{
		classes = { 'divCell Icon' },
		css = {
			width = '70%',
			['font-size'] = IconModule and '70%' or nil
		}
	}

	if not IconModule then
		iconCell.props.children = { TRANSFER_ARROW }
		return iconCell
	end

	---@param iconInput string?
	---@return string
	local getIcon = function(iconInput)
		if Logic.isEmpty(iconInput) then
			return EMPTY_POSITION_ICON
		end
		---@cast iconInput -nil
		local icon = IconModule[iconInput:lower()]
		if not icon then
			mw.log( 'No entry found in Module:PositionIcon/data: ' .. iconInput)
			mw.ext.TeamLiquidIntegration.add_category('Pages with transfer errors')
			return EMPTY_POSITION_ICON
		end

		return icon
	end

	local targetRoleIsSpecialRole = TransferRowWidget:_isSpecialRole(self.transfer.to.roles[1])

	local iconRows = IconModule and Array.map(self.transfer.players, function(player)
		return getIcon(player.icons[1]) .. '&nbsp;' .. TRANSFER_ARROW ..
			'&nbsp;' .. getIcon(player.icons[2] or targetRoleIsSpecialRole and player.icons[1] or nil)
	end)

	iconCell.props.children = { table.concat(iconRows, '<br>') }
	return iconCell
end

---@return Widget
function TransferRowWidget:to()
	return self:_displayTeam{
		data = self.transfer.to,
		date = self.transfer.date,
		isOldTeam = false,
	}
end

---@return Widget
function TransferRowWidget:references()
	return Div{
		classes = { 'divCell Ref' },
		children = { table.concat(self.transfer.references, '<br>') }
	}
end

return TransferRowWidget
