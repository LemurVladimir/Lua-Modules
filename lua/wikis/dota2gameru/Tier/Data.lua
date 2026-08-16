---
-- @Liquipedia
-- page=Module:Tier/Data
--
-- Please see https://github.com/Liquipedia/Lua-Modules to contribute
--

return {
	tiers = {
		{
			value = '1',
			sort = 'A1',
			name = '1 разряд',
			short = '1',
			link = 'Турниры 1 разряда',
			category = 'Tier 1 Tournaments',
		},
		{
			value = '2',
			sort = 'A2',
			name = '2 разряд',
			short = '2',
			link = 'Турниры 2 разряда',
			category = 'Tier 2 Tournaments',
		},
		{
			value = '3',
			sort = 'A3',
			name = '3 разряд',
			short = '3',
			link = 'Турниры 3 разряда',
			category = 'Tier 3 Tournaments',
		},
		{
			value = '4',
			sort = 'A4',
			name = '4 разряд',
			short = '4',
			link = 'Турниры 4 разряда',
			category = 'Tier 4 Tournaments',
		},
		[''] = {
			value = nil,
			sort = 'D1',
			name = 'Undefined',
			short = '?',
		},
	},

	tierTypes = {
		monthly = {
			value = 'Monthly',
			sort = 'A6',
			name = 'Ежемесячные',
			short = 'Мес.',
			link = 'Ежемесячные турниры',
			category = 'Monthly Tournaments',
		},
		weekly = {
			value = 'Weekly',
			sort = 'A7',
			name = 'Еженедельные',
			short = 'Нед.',
			link = 'Еженедельные турниры',
			category = 'Weekly Tournaments',
		},
		qualifier = {
			value = 'Qualifier',
			sort = 'A8',
			name = 'Квалификации',
			short = 'Квал.',
			link = 'Турниры-квалификации',
			category = 'Qualifier Tournaments',
		},
		misc = {
			value = 'Misc',
			sort = 'A9',
			name = 'Прочие',
			short = 'Прочие',
			link = 'Прочие турниры',
			category = 'Miscellaneous Tournaments',
		},
		showmatch = {
			value = 'Showmatch',
			sort = 'B1',
			name = 'Шоуматч',
			short = 'Шоум.',
			link = 'Шоуматчи',
			category = 'Showmatch Tournaments',
		},
		national = {
			value = 'National',
			sort = 'B2',
			name = 'Национальные',
			short = 'Нац.',
			link = 'Национальные турниры',
			category = 'National Tournaments',
		},
	},
}
