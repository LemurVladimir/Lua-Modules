---
-- @Liquipedia
-- wiki=ageofempires
-- page=Module:Faction/Data
--
-- Please see https://github.com/Liquipedia/Lua-Modules to contribute
--

local Array = require('Module:Array')

local AOE1_SUFFIX = '/Age of Empires I'
local AOE2_SUFFIX = '/Age of Empires II'
local AOE3_SUFFIX = '/Age of Empires III'
local AOE4_SUFFIX = '/Age of Empires IV'
local AOM_SUFFIX = '/Age of Mythology'
local AOEO_SUFFIX = '/Age of Empires Online'

local factionPropsAoE1 = {
	assyrians = {
		index = 1,
		name = 'Assyrians',
		faction = 'assyrians',
	},
	babylonians = {
		index = 2,
		name = 'Babylonians',
		pageName = 'Babylonians' .. AOE1_SUFFIX,
		faction = 'babylonians',
	},
	carthaginians = {
		index = 3,
		name = 'Carthaginians',
		faction = 'carthaginians',
	},
	choson = {
		index = 4,
		name = 'Choson',
		faction = 'choson',
	},
	egyptians = {
		index = 5,
		name = 'Egyptians',
		pageName = 'Egyptians' .. AOE1_SUFFIX,
		faction = 'egyptians',
	},
	greeks = {
		index = 6,
		name = 'Greeks',
		pageName = 'Greeks' .. AOE1_SUFFIX,
		faction = 'greeks',
	},
	hittites = {
		index = 7,
		name = 'Hittites',
		faction = 'hittites',
	},
	macedonians = {
		index = 8,
		name = 'Macedonians',
		faction = 'macedonians',
	},
	minoans = {
		index = 9,
		name = 'Minoans',
		faction = 'minoans',
	},
	palmyrans = {
		index = 10,
		name = 'Palmyrans',
		faction = 'palmyrans',
	},
	persians = {
		index = 11,
		name = 'Persians',
		pageName = 'Persians' .. AOE1_SUFFIX,
		faction = 'persians',
	},
	phoenicians = {
		index = 12,
		name = 'Phoenicians',
		faction = 'phoenicians',
	},
	romans = {
		index = 13,
		name = 'Romans',
		pageName = 'Romans' .. AOE1_SUFFIX,
		faction = 'romans',
	},
	shang = {
		index = 14,
		name = 'Shang',
		faction = 'shang',
	},
	sumerians = {
		index = 15,
		name = 'Sumerians',
		faction = 'sumerians',
	},
	yamato = {
		index = 16,
		name = 'Yamato',
		faction = 'yamato',
	},
	lacviet = {
		index = 17,
		name = 'Lac Viet',
		faction = 'lacviet',
	},

	unknown = {
		index = 18,
		name = 'Unknown',
		faction = 'unknown',
	},
}

local factionPropsAoE2 = {
	achaemenids = {
		index = 1,
		name = 'Achaemenids',
		faction = 'achaemenids',
	},
	armenians = {
		index = 2,
		name = 'Armenians',
		faction = 'armenians',
	},
	athenians = {
		index = 3,
		name = 'Athenians',
		faction = 'athenians',
	},
	aztecs = {
		index = 4,
		name = 'Aztecs',
		pageName = 'Aztecs' .. AOE2_SUFFIX,
		faction = 'aztecs',
	},
	berbers = {
		index = 5,
		name = 'Berbers',
		faction = 'berbers',
	},
	bengalis = {
		index = 6,
		name = 'Bengalis',
		faction = 'bengalis',
	},
	bohemians = {
		index = 7,
		name = 'Bohemians',
		faction = 'bohemians',
	},
	britons = {
		index = 8,
		name = 'Britons',
		faction = 'britons',
	},
	bulgarians = {
		index = 9,
		name = 'Bulgarians',
		faction = 'bulgarians',
	},
	burgundians = {
		index = 10,
		name = 'Burgundians',
		faction = 'burgundians',
	},
	burmese = {
		index = 11,
		name = 'Burmese',
		faction = 'burmese',
	},
	byzantines = {
		index = 12,
		name = 'Byzantines',
		faction = 'byzantines',
	},
	celts = {
		index = 13,
		name = 'Celts',
		pageName = 'Celts' .. AOE2_SUFFIX,
		faction = 'celts',
	},
	chinese = {
		index = 14,
		name = 'Chinese',
		pageName = 'Chinese' .. AOE2_SUFFIX,
		faction = 'chinese',
	},
	cumans = {
		index = 15,
		name = 'Cumans',
		faction = 'cumans',
	},
	dravidians = {
		index = 16,
		name = 'Dravidians',
		faction = 'dravidians',
	},
	ethiopians = {
		index = 17,
		name = 'Ethiopians',
		faction = 'ethiopians',
	},
	franks = {
		index = 18,
		name = 'Franks',
		faction = 'franks',
	},
	georgians = {
		index = 19,
		name = 'Georgians',
		faction = 'georgians',
	},
	goths = {
		index = 20,
		name = 'Goths',
		faction = 'goths',
	},
	gurjaras = {
		index = 21,
		name = 'Gurjaras',
		faction = 'gurjaras',
	},
	hindustanis = {
		index = 22,
		name = 'Hindustanis',
		faction = 'hindustanis',
	},
	huns = {
		index = 23,
		name = 'Huns',
		faction = 'huns',
	},
	incas = {
		index = 24,
		name = 'Incas',
		pageName = 'Incas' .. AOE2_SUFFIX,
		faction = 'incas',
	},
	indians = {
		index = 25,
		name = 'Indians',
		pageName = 'Indians' .. AOE2_SUFFIX .. '/The_Forgotten',
		faction = 'indians',
	},
	italians = {
		index = 26,
		name = 'Italians',
		faction = 'italians',
	},
	japanese = {
		index = 27,
		name = 'Japanese',
		pageName = 'Japanese' .. AOE2_SUFFIX,
		faction = 'japanese',
	},
	khmer = {
		index = 28,
		name = 'Khmer',
		faction = 'khmer',
	},
	koreans = {
		index = 29,
		name = 'Koreans',
		faction = 'koreans',
	},
	lithuanians = {
		index = 30,
		name = 'Lithuanians',
		faction = 'lithuanians',
	},
	magyars = {
		index = 31,
		name = 'Magyars',
		faction = 'magyars',
	},
	malay = {
		index = 32,
		name = 'Malay',
		faction = 'malay',
	},
	malians = {
		index = 33,
		name = 'Malians',
		pageName = 'Malians' .. AOE2_SUFFIX,
		faction = 'malians',
	},
	mayans = {
		index = 34,
		name = 'Mayans',
		faction = 'mayans',
	},
	mongols = {
		index = 35,
		name = 'Mongols',
		pageName = 'Mongols' .. AOE2_SUFFIX,
		faction = 'mongols',
	},
	persians = {
		index = 36,
		name = 'Persians',
		pageName = 'Persians' .. AOE2_SUFFIX,
		faction = 'persians',
	},
	poles = {
		index = 37,
		name = 'Poles',
		faction = 'poles',
	},
	portuguese = {
		index = 38,
		name = 'Portuguese',
		pageName = 'Portuguese' .. AOE2_SUFFIX,
		faction = 'portuguese',
	},
	romans = {
		index = 39,
		name = 'Romans',
		pageName = 'Romans' .. AOE2_SUFFIX,
		faction = 'romans',
	},
	saracens = {
		index = 40,
		name = 'Saracens',
		faction = 'saracens',
	},
	sicilians = {
		index = 41,
		name = 'Sicilians',
		faction = 'sicilians',
	},
	slavs = {
		index = 42,
		name = 'Slavs',
		faction = 'slavs',
	},
	spanish = {
		index = 43,
		name = 'Spanish',
		pageName = 'Spanish' .. AOE2_SUFFIX,
		faction = 'spanish',
	},
	spartans = {
		index = 44,
		name = 'Spartans',
		faction = 'spartans',
	},
	tatars = {
		index = 45,
		name = 'Tatars',
		faction = 'tatars',
	},
	teutons = {
		index = 46,
		name = 'Teutons',
		faction = 'teutons',
	},
	turks = {
		index = 47,
		name = 'Turks',
		faction = 'turks',
	},
	vietnamese = {
		index = 48,
		name = 'Vietnamese',
		faction = 'vietnamese',
	},
	vikings = {
		index = 49,
		name = 'Vikings',
		pageName = 'Vikings' .. AOE2_SUFFIX,
		faction = 'vikings',
	},

	unknown = {
		index = 50,
		name = 'Unknown',
		faction = 'unknown',
	},
}

local factionPropsAoE3 = {
	aztecs = {
		index = 1,
		name = 'Aztecs',
		pageName = 'Aztecs' .. AOE3_SUFFIX,
		faction = 'aztecs',
	},
	british = {
		index = 2,
		name = 'British',
		faction = 'british',
	},
	chinese = {
		index = 3,
		name = 'Chinese',
		pageName = 'Chinese' .. AOE3_SUFFIX,
		faction = 'chinese',
	},
	dutch = {
		index = 4,
		name = 'Dutch',
		faction = 'dutch',
	},
	ethiopians = {
		index = 5,
		name = 'Ethiopians',
		pageName = 'Ethiopians' .. AOE3_SUFFIX,
		faction = 'ethiopians',
	},
	french = {
		index = 6,
		name = 'French',
		faction = 'french',
	},
	germans = {
		index = 7,
		name = 'Germans',
		faction = 'germans',
	},
	haudenosaunee = {
		index = 8,
		name = 'Haudenosaunee',
		faction = 'haudenosaunee',
	},
	hausa = {
		index = 9,
		name = 'Hausa',
		faction = 'hausa',
	},
	incas = {
		index = 10,
		name = 'Incas',
		pageName = 'Incas' .. AOE3_SUFFIX,
		faction = 'incas',
	},
	indians = {
		index = 11,
		name = 'Indians',
		pageName = 'Indians' .. AOE3_SUFFIX,
		faction = 'indians',
	},
	italians = {
		index = 12,
		name = 'Italians',
		pageName = 'Italians' .. AOE3_SUFFIX,
		faction = 'italians',
	},
	japanese = {
		index = 13,
		name = 'Japanese',
		pageName = 'Japanese' .. AOE3_SUFFIX,
		faction = 'japanese',
	},
	lakota = {
		index = 14,
		name = 'Lakota',
		faction = 'lakota',
	},
	maltese = {
		index = 15,
		name = 'Maltese',
		pageName = 'Maltese' .. AOE3_SUFFIX,
		faction = 'maltese',
	},
	mexicans = {
		index = 16,
		name = 'Mexicans',
		faction = 'mexicans',
	},
	ottomans = {
		index = 17,
		name = 'Ottomans',
		pageName = 'Ottomans' .. AOE3_SUFFIX,
		faction = 'ottomans',
	},
	portuguese = {
		index = 18,
		name = 'Portuguese',
		pageName = 'Portuguese' .. AOE3_SUFFIX,
		faction = 'portuguese',
	},
	russians = {
		index = 19,
		name = 'Russians',
		faction = 'russians',
	},
	spanish = {
		index = 20,
		name = 'Spanish',
		pageName = 'Spanish' .. AOE3_SUFFIX,
		faction = 'spanish',
	},
	swedes = {
		index = 21,
		name = 'Swedes',
		faction = 'swedes',
	},
	unitedstates = {
		index = 22,
		name = 'United States',
		faction = 'unitedstates',
	},
	random = {
		index = 23,
		name = 'Random',
		faction = 'random',
	},

	unknown = {
		index = 24,
		name = 'Unknown',
		faction = 'unknown',
	},
}

local factionPropsAoE4 = {
	abbasiddynasty = {
		index = 1,
		name = 'Abbasid Dynasty',
		faction = 'abbasiddynasty',
	},
	ayyubids = {
		index = 2,
		name = 'Ayyubids',
		faction = 'ayyubids',
	},
	byzantines = {
		index = 3,
		name = 'Byzantines',
		pageName = 'Byzantines' .. AOE4_SUFFIX,
		faction = 'byzantines',
	},
	chinese = {
		index = 4,
		name = 'Chinese',
		pageName = 'Chinese' .. AOE4_SUFFIX,
		faction = 'chinese',
	},
	delhisultanate = {
		index = 5,
		name = 'Delhi Sultanate',
		faction = 'delhisultanate',
	},
	english = {
		index = 6,
		name = 'English',
		faction = 'english',
	},
	french = {
		index = 7,
		name = 'French',
		pageName = 'French' .. AOE4_SUFFIX,
		faction = 'french',
	},
	holyromanempire = {
		index = 8,
		name = 'Holy Roman Empire',
		faction = 'holyromanempire',
	},
	japanese = {
		index = 9,
		name = 'Japanese',
		pageName = 'Japanese' .. AOE4_SUFFIX,
		faction = 'japanese',
	},
	jeannedarc = {
		index = 10,
		name = 'Jeanne d\'Arc',
		faction = 'jeannedarc',
	},
	malians = {
		index = 11,
		name = 'Malians',
		pageName = 'Malians' .. AOE4_SUFFIX,
		faction = 'malians',
	},
	mongols = {
		index = 12,
		name = 'Mongols',
		pageName = 'Mongols' .. AOE4_SUFFIX,
		faction = 'mongols',
	},
	ottomans = {
		index = 13,
		name = 'Ottomans',
		pageName = 'Ottomans' .. AOE4_SUFFIX,
		faction = 'ottomans',
	},
	orderofthedragon = {
		index = 14,
		name = 'Order of the Dragon',
		faction = 'orderofthedragon',
	},
	rus = {
		index = 15,
		name = 'Rus',
		faction = 'rus',
	},
	zhuxislegacy = {
		index = 16,
		name = 'Zhu Xi\'s Legacy',
		faction = 'zhuxislegacy',
	},

	unknown = {
		index = 17,
		name = 'Unknown',
		faction = 'unknown',
	},
}

local factionPropsAoM = {
	chinese = {
		index = 1,
		name = 'Chinese',
		pageName = 'Chinese' .. AOM_SUFFIX,
		faction = 'chinese',
	},
	greeks = {
		index = 2,
		name = 'Greeks',
		pageName = 'Greeks' .. AOM_SUFFIX,
		faction = 'greeks',
	},
	atlanteans = {
		index = 3,
		name = 'Atlanteans',
		faction = 'atlanteans',
	},
	egyptians = {
		index = 4,
		name = 'Egyptians',
		pageName = 'Egyptians' .. AOM_SUFFIX,
		faction = 'egyptians',
	},
	freyr = {
		index = 5,
		name = 'Freyr',
		faction = 'freyr',
	},
	norse = {
		index = 6,
		name = 'Norse',
		pageName = 'Norse' .. AOM_SUFFIX,
		faction = 'norse',
	},
	fuxi = {
		index = 7,
		name = 'Fu Xi',
		faction = 'fuxi',
	},
	gaia = {
		index = 8,
		name = 'Gaia',
		pageName = 'Gaia',
		faction = 'gaia',
	},
	hades = {
		index = 9,
		name = 'Hades',
		faction = 'hades',
	},
	isis = {
		index = 10,
		name = 'Isis',
		faction = 'isis',
	},
	kronos = {
		index = 11,
		name = 'Kronos',
		faction = 'kronos',
	},
	loki = {
		index = 12,
		name = 'Loki',
		faction = 'loki',
	},
	nuwa = {
		index = 13,
		name = 'Nü Wa',
		faction = 'nuwa',
	},
	odin = {
		index = 14,
		name = 'Odin',
		faction = 'odin',
	},
	oranos = {
		index = 15,
		name = 'Oranos',
		faction = 'oranos',
	},
	poseidon = {
		index = 16,
		name = 'Poseidon',
		pageName = 'Poseidon (god)',
		faction = 'poseidon',
	},
	ra = {
		index = 17,
		name = 'Ra',
		pageName = 'Ra (god)',
		faction = 'ra',
	},
	set = {
		index = 18,
		name = 'Set',
		faction = 'set',
	},
	shennong = {
		index = 19,
		name = 'Shennong',
		faction = 'shennong',
	},
	thor = {
		index = 20,
		name = 'Thor',
		faction = 'thor',
	},
	zeus = {
		index = 21,
		name = 'Zeus',
		faction = 'zeus',
	},
	quetzalcoatl = {
		index = 22,
		name = 'Quetzalcoatl',
		faction = 'quetzalcoatl',
	},
	huitzilopochtli = {
		index = 23,
		name = 'Huitzilopochtli',
		faction = 'huitzilopochtli',
	},
	tezcatlipoca = {
		index = 24,
		name = 'Tezcatlipoca',
		faction = 'tezcatlipoca',
	},

	unknown = {
		index = 25,
		name = 'Unknown',
		faction = 'unknown',
	},
}

local factionPropsAoEO = {
	babylonians = {
		index = 1,
		name = 'Babylonians',
		pageName = 'Babylonians' .. AOEO_SUFFIX,
		faction = 'babylonians',
	},
	celts = {
		index = 2,
		name = 'Celts',
		pageName = 'Celts' .. AOEO_SUFFIX,
		faction = 'celts',
	},
	egyptians = {
		index = 3,
		name = 'Egyptians',
		pageName = 'Egyptians' .. AOEO_SUFFIX,
		faction = 'egyptians',
	},
	greeks = {
		index = 4,
		name = 'Greeks',
		pageName = 'Greeks' .. AOEO_SUFFIX,
		faction = 'greeks',
	},
	indians = {
		index = 5,
		name = 'Indians',
		pageName = 'Indians' .. AOEO_SUFFIX,
		faction = 'indians',
	},
	norse = {
		index = 6,
		name = 'Norse',
		pageName = 'Norse' .. AOEO_SUFFIX,
		faction = 'norse',
	},
	persians = {
		index = 7,
		name = 'Persians',
		pageName = 'Persians' .. AOEO_SUFFIX,
		faction = 'persians',
	},
	romans = {
		index = 8,
		name = 'Romans',
		pageName = 'Romans' .. AOEO_SUFFIX,
		faction = 'romans',
	},

	unknown = {
		index = 9,
		name = 'Unknown',
		faction = 'unknown',
	},
}

return {
	factionProps = {
		aoe1 = factionPropsAoE1,
		aoe2 = factionPropsAoE2,
		aoe3 = factionPropsAoE3,
		aoe4 = factionPropsAoE4,
		aom = factionPropsAoM,
		aoeo = factionPropsAoEO,
	},
	defaultFaction = 'unknown',
	factions = {
		aoe1 = Array.extractKeys(factionPropsAoE1),
		aoe2 = Array.extractKeys(factionPropsAoE2),
		aoe3 = Array.extractKeys(factionPropsAoE3),
		aoe4 = Array.extractKeys(factionPropsAoE4),
		aom = Array.extractKeys(factionPropsAoM),
		aoeo = Array.extractKeys(factionPropsAoEO),
	},
	aliases = {
		aoe1 = {
			asr = 'assyrians',
			asy = 'assyrians',
			bab = 'babylonians',
			car = 'carthaginians',
			cho = 'choson',
			egy = 'egyptians',
			gre = 'greeks',
			hit = 'hittites',
			mac = 'macedonians',
			min = 'minoans',
			pal = 'palmyrans',
			per = 'persians',
			pho = 'phoenicians',
			rom = 'romans',
			sha = 'shang',
			sum = 'sumerians',
			yam = 'yamato',
			lac = 'lacviet',
			lv = 'lacviet',
			['lac viet'] = 'lacviet',
		 },
		aoe2 = {
			ach = 'achaemenids',
			arm = 'armenians',
			ath = 'athenians',
			azt = 'aztecs',
			ber = 'berbers',
			ben = 'bengalis',
			boh = 'bohemians',
			bri = 'britons',
			bul = 'bulgarians',
			brg = 'burgundians',
			bur = 'burmese',
			byz = 'byzantines',
			cel = 'celts',
			chi = 'chinese',
			cms = 'cumans',
			cum = 'cumans',
			dra = 'dravidians',
			eth = 'ethiopians',
			fra = 'franks',
			geo = 'georgians',
			got = 'goths',
			gur = 'gurjaras',
			hin = 'hindustanis',
			hun = 'huns',
			inc = 'incas',
			ind = 'indians',
			ita = 'italians',
			jap = 'japanese',
			jpn = 'japanese',
			khm = 'khmer',
			kor = 'koreans',
			lit = 'lithuanians',
			mag = 'magyars',
			mly = 'malay',
			mal = 'malians',
			mli = 'malians',
			may = 'mayans',
			mon = 'mongols',
			per = 'persians',
			pol = 'poles',
			por = 'portuguese',
			rom = 'romans',
			sar = 'saracens',
			sic = 'sicilians',
			sla = 'slavs',
			spa = 'spanish',
			spr = 'spartans',
			tat = 'tatars',
			teu = 'teutons',
			tur = 'turks',
			vie = 'vietnamese',
			vik = 'vikings',
		},
		aoe3 = {
			azt = 'aztecs',
			brt = 'british',
			bri = 'british',
			chi = 'chinese',
			dut = 'dutch',
			eth = 'ethiopians',
			fre = 'french',
			ger = 'germans',
			hau = 'haudenosaunee',
			hsa = 'hausa',
			inc = 'incas',
			ind = 'indians',
			ita = 'italians',
			jap = 'japanese',
			jpn = 'japanese',
			lak = 'lakota',
			mal = 'maltese',
			malta = 'maltese',
			mex = 'mexicans',
			otm = 'ottomans',
			ott = 'ottomans',
			por = 'portuguese',
			rus = 'russians',
			ran = 'random',
			spa = 'spanish',
			swe = 'swedes',
			usa = 'unitedstates',
		},
		aoe4 = {
			abb = 'abbasiddynasty',
			aba = 'abbasiddynasty',
			abba = 'abbasiddynasty',
			abbasid = 'abbasiddynasty',
			ayy = 'ayyubids',
			byz = 'byzantines',
			chi = 'chinese',
			del = 'delhisultanate',
			delhi = 'delhisultanate',
			eng = 'english',
			fre = 'french',
			hre = 'holyromanempire',
			jap = 'japanese',
			jpn = 'japanese',
			jea = 'jeannedarc',
			arc = 'jeannedarc',
			mal = 'malians',
			mon = 'mongols',
			ord = 'orderofthedragon',
			dra = 'orderofthedragon',
			otm = 'ottomans',
			ott = 'ottomans',
			zhu = 'zhuxislegacy',
		},
		aom = {
			atl = 'atlanteans',
			chi = 'chinese',
			egy = 'egyptians',
			fre = 'freyr',
			fux = 'fuxi',
			gai = 'gaia',
			gre = 'greeks',
			had = 'hades',
			isi = 'isis',
			kro = 'kronos',
			lok = 'loki',
			nor = 'norse',
			['nu wa'] = 'nuwa',
			nuw = 'nuwa',
			odi = 'odin',
			ora = 'oranos',
			pos = 'poseidon',
			she = 'shennong',
			tho = 'thor',
			zeu = 'zeus',
			que = 'quetzalcoatl',
			hui = 'huitzilopochtli',
			tez = 'tezcatlipoca',
		},
		aoeo = {
			bab = 'babylonians',
			cel = 'celts',
			egy = 'egyptians',
			gre = 'greeks',
			ind = 'indians',
			nor = 'norse',
			per = 'persians',
			rom = 'romans',
		}
	},
}
