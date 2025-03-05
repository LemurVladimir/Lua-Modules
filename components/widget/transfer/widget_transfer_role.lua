---
-- @Liquipedia
-- wiki=commons
-- page=Module:Widget/Transfer/Role
--
-- Please see https://github.com/Liquipedia/Lua-Modules to contribute
--

local Array = require('Module:Array')
local Class = require('Module:Class')
local Logic = require('Module:Logic')
local Lua = require('Module:Lua')

local Widget = Lua.import('Module:Widget')
local HtmlWidgets = Lua.import('Module:Widget/Html/All')
local WidgetUtil = Lua.import('Module:Widget/Util')

---@class TransferRoleWidget: Widget
---@field props {roles: string[], teamDefined: boolean?, align: 'left'|'right', addMargin: boolean?}
local TransferRoleWidget = Class.new(Widget)
TransferRoleWidget.defaultProps = {
	roles = {},
	css = {}
}

---@return Widget?
function TransferRoleWidget:render()
	local roles = self.props.roles

	if Logic.isEmpty(roles) then return end

	roles = Array.interleave(Array.filter(roles, Logic.isNotEmpty), '/')
	local teamDefined = self.props.teamDefined

	return HtmlWidgets.Span{
		css = {
			['font-style'] = 'italic',
			['font-size'] = teamDefined and '85%' or nil,
			['margin-' .. self.props.align] = self.props.addMargin and '60px' or nil
		},
		children = WidgetUtil.collect(
			teamDefined and '(' or nil,
			roles,
			teamDefined and ')' or nil
		)
	}
end

return TransferRoleWidget
