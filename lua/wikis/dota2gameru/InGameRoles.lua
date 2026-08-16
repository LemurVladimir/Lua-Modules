---
-- @Liquipedia
-- page=Module:InGameRoles
--
-- Please see https://github.com/Liquipedia/Lua-Modules to contribute
--

---@type table<string, RoleBaseData>
local inGameRoles = {
	['carry'] = {category = 'Carry players', display = 'Основа'},
	['mid'] = {category = 'Solo middle players', display = 'Соло Центр'},
	['offlane'] = {category = 'Offlaners', display = 'Сложная линия'},
	['support'] = {category = 'Support players', display = 'Поддержка'},
}

inGameRoles['solo middle'] = inGameRoles.mid
inGameRoles['solomiddle'] = inGameRoles.mid
inGameRoles['offlaner'] = inGameRoles.offlane
inGameRoles['соло мид'] = inGameRoles.mid
inGameRoles['мид'] = inGameRoles.mid
inGameRoles['мидер'] = inGameRoles.mid
inGameRoles['оффлэйн'] = inGameRoles.offlane
inGameRoles['оффлэйнер'] = inGameRoles.offlane
inGameRoles['сложная'] = inGameRoles.offlane
inGameRoles['сложная линия'] = inGameRoles.offlane
inGameRoles['саппорт'] = inGameRoles.support
inGameRoles['суппорт'] = inGameRoles.support
inGameRoles['поддержка'] = inGameRoles.support

return inGameRoles
