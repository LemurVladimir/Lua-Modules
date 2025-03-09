---
-- @Liquipedia
-- wiki=commons
-- page=Module:Team/override
--
-- Please see https://github.com/Liquipedia/Lua-Modules to contribute
--

local overrides = {
	game = {},
	games = {},
	templates = {
		definitions = {
			team = '<span data-highlightingclass="TBD" class="team-template-team-standard">' ..
				'<span class="team-template-image-legacy">[[File:Logo filler std.png|link=]]</span> ' ..
				'<span class="team-template-text"><abbr title="To Be Determined">TBD</abbr></span></span>',
			team2 = '<span data-highlightingclass="TBD" class="team-template-team-standard">' ..
				'<span class="team-template-text"><abbr title="To Be Determined">TBD</abbr></span> ' ..
				'<span class="team-template-image-legacy">[[File:Logo filler std.png|link=]]</span></span>',
			teamshort = '<span data-highlightingclass="TBD" class="team-template-team-short">' ..
				'<span class="team-template-image-legacy">[[File:Logo filler std.png|link=]]</span> ' ..
				'<span class="team-template-text"><abbr title="To Be Determined">TBD</abbr></span></span>',
			team2short = '<span data-highlightingclass="TBD" class="team-template-team-short">' ..
				'<span class="team-template-text"><abbr title="To Be Determined">TBD</abbr></span> ' ..
				'<span class="team-template-image-legacy">[[File:Logo filler std.png|link=]]</span></span>',
			teambracket = '<span data-highlightingclass="TBD" class="team-template-team-bracket">' ..
				'<span class="team-template-image-legacy">[[File:Logo filler std.png|link=]]</span> ' ..
				'<span class="team-template-text"><abbr title="To Be Determined">TBD</abbr></span></span>',
			teamicon = '<span data-highlightingclass="TBD" class="team-template-team-icon">' ..
				'<span class="team-template-image-legacy">[[File:Logo filler std.png|link=]]</span></span>',
			teampart = '<span class="team-template-team-part"><span class="team-template-image-legacy">' ..
				'[[File:Logo filler std.png|link=]]</span></span>',
			iconfile = 'Logo filler std.png',
			teampage = 'TBD'
		},
		tbd = {
			team = '<span data-highlightingclass="TBD" class="team-template-team-standard">' ..
				'<span class="team-template-image-legacy">[[File:Logo filler std.png|link=]]</span> ' ..
				'<span class="team-template-text"><abbr title="To Be Determined">TBD</abbr></span></span>',
			team2 = '<span data-highlightingclass="TBD" class="team-template-team-standard">' ..
				'<span class="team-template-text"><abbr title="To Be Determined">TBD</abbr></span> ' ..
				'<span class="team-template-image-legacy">[[File:Logo filler std.png|link=]]</span></span>',
			teamshort = '<span data-highlightingclass="TBD" class="team-template-team-short">' ..
				'<span class="team-template-image-legacy">[[File:Logo filler std.png|link=]]</span> ' ..
				'<span class="team-template-text"><abbr title="To Be Determined">TBD</abbr></span></span>',
			team2short = '<span data-highlightingclass="TBD" class="team-template-team-short">' ..
			'<span class="team-template-text"><abbr title="To Be Determined">TBD</abbr></span> ' ..
				'<span class="team-template-image-legacy">[[File:Logo filler std.png|link=]]</span></span>',
			teambracket = '<span data-highlightingclass="TBD" class="team-template-team-bracket">' ..
				'<span class="team-template-image-legacy">[[File:Logo filler std.png|link=]]</span> ' ..
				'<span class="team-template-text"><abbr title="To Be Determined">TBD</abbr></span></span>',
			teamicon = '<span data-highlightingclass="TBD" class="team-template-team-icon">' ..
				'<span class="team-template-image-legacy">[[File:Logo filler std.png|link=]]</span></span>',
			teampart = '<span class="team-template-team-part"><span class="team-template-image-legacy">' ..
				'[[File:Logo filler std.png|link=]]</span></span>',
			iconfile = 'Logo filler std.png',
			teampage = 'TBD'
		},
		tba = {
			team = '<span data-highlightingclass="TBA" class="team-template-team-standard">' ..
				'<span class="team-template-image-legacy">[[File:Logo filler std.png|link=]]</span> ' ..
				'<span class="team-template-text"><abbr title="To Be Announced">TBA</abbr></span></span>',
			team2 = '<span data-highlightingclass="TBA" class="team-template-team-standard">' ..
			'<span class="team-template-text"><abbr title="To Be Announced">TBA</abbr></span> ' ..
				'<span class="team-template-image-legacy">[[File:Logo filler std.png|link=]]</span></span>',
			teamshort = '<span data-highlightingclass="TBA" class="team-template-team-short">' ..
				'<span class="team-template-image-legacy">[[File:Logo filler std.png|link=]]</span> ' ..
				'<span class="team-template-text"><abbr title="To Be Announced">TBA</abbr></span></span>',
			team2short = '<span data-highlightingclass="TBA" class="team-template-team-short">' ..
			'<span class="team-template-text"><abbr title="To Be Announced">TBA</abbr></span> ' ..
				'<span class="team-template-image-legacy">[[File:Logo filler std.png|link=]]</span></span>',
			teambracket = '<span data-highlightingclass="TBA" class="team-template-team-bracket">' ..
				'<span class="team-template-image-legacy">[[File:Logo filler std.png|link=]]</span> ' ..
				'<span class="team-template-text"><abbr title="To Be Announced">TBA</abbr></span></span>',
			teamicon = '<span data-highlightingclass="TBA" class="team-template-team-icon">' ..
				'<span class="team-template-image-legacy">[[File:Logo filler std.png|link=]]</span></span>',
			teampart = '<span class="team-template-team-part"><span class="team-template-image-legacy">' ..
				'[[File:Logo filler std.png|link=]]</span></span>',
			iconfile = 'Logo filler std.png',
			teampage = 'TBA'
		},
		bye = {
			team = '<span class="team-template-team-standard"><span class="team-template-image-legacy">'..
				'[[File:Logo filler std.png|link=]]</span>' ..
				'<span class="team-template-text brkts-opponent-block-literal"><i>BYE</i></span></span>',
			team2 = '<span class="team-template-team-standard">'..
				'<span class="team-template-text brkts-opponent-block-literal"><i>BYE</i></span> ' ..
				'<span class="team-template-image-legacy">[[File:Logo filler std.png|link=]]</span></span>',
			teamshort = '<span class="team-template-team-short"><span class="team-template-image-legacy">' ..
				'[[File:Logo filler std.png|link=]]</span> ' ..
				'<span class="team-template-text brkts-opponent-block-literal"><i>BYE</i></span></span>',
			team2short = '<span class="team-template-team-short">' ..
				'<span class="team-template-text brkts-opponent-block-literal"><i>BYE</i></span> ' ..
				'<span class="team-template-image-legacy">[[File:Logo filler std.png|link=]]</span></span>',
			teambracket = '<span class="team-template-team-bracket"><span class="team-template-image-legacy">' ..
				'[[File:Logo filler std.png|link=]]</span> ' ..
				'<span class="team-template-text brkts-opponent-block-literal"><i>BYE</i></span></span>',
			teamicon = '<span class="team-template-team-icon"><span class="team-template-image-legacy">' ..
				'[[File:Logo filler std.png|link=]]</span></span>',
			teampart = '<span class="team-template-team-part"><span class="team-template-image-legacy">' ..
				'[[File:Logo filler std.png|link=]]</span></span>',
			iconfile = 'Logo filler std.png',
			teampage = ''
		},
		filler = {
			team = '<span class="team-template-team-standard"><span class="team-template-image-legacy">' ..
				'[[File:Logo filler std.png|link=]]</span></span>',
			team2 = '<span class="team-template-team-standard"><span class="team-template-image-legacy">' ..
				'[[File:Logo filler std.png|link=]]</span></span>',
			teamshort = '<span class="team-template-team-short"><span class="team-template-image-legacy">' ..
				'[[File:Logo filler std.png|link=]]</span></span>',
			team2short = '<span class="team-template-team-short"><span class="team-template-image-legacy">' ..
				'[[File:Logo filler std.png|link=]]</span></span>',
			teambracket = '<span class="team-template-team-bracket"><span class="team-template-image-legacy">' ..
				'[[File:Logo filler std.png|link=]]</span> </span>',
			teamicon = '<span class="team-template-team-icon"><span class="team-template-image-legacy">' ..
				'[[File:Logo filler std.png|link=]]</span></span>',
			teampart = '<span class="team-template-team-part"><span class="team-template-image-legacy">' ..
				'[[File:Logo filler std.png|link=]]</span></span>',
			iconfile = 'Logo filler std.png',
			teampage = ''
		},
		[''] = {
			team = '<span class="team-template-team-standard"><span class="team-template-image-legacy">' ..
				'[[File:Logo filler std.png|link=]]</span></span>',
			team2 = '<span class="team-template-team-standard"><span class="team-template-image-legacy">' ..
				'[[File:Logo filler std.png|link=]]</span></span>',
			teamshort = '<span class="team-template-team-short"><span class="team-template-image-legacy">' ..
				'[[File:Logo filler std.png|link=]]</span></span>',
			team2short = '<span class="team-template-team-short"><span class="team-template-image-legacy">' ..
				'[[File:Logo filler std.png|link=]]</span></span>',
			teambracket = '<span class="team-template-team-bracket"><span class="team-template-image-legacy">' ..
				'[[File:Logo filler std.png|link=]]</span> </span>',
			teamicon = '<span class="team-template-team-icon"><span class="team-template-image-legacy">' ..
				'[[File:Logo filler std.png|link=]]</span></span>',
			teampart = '<span class="team-template-team-part"><span class="team-template-image-legacy">' ..
				'[[File:Logo filler std.png|link=]]</span></span>',
			iconfile = 'Logo filler std.png',
			teampage = ''
		}
	}
}

return overrides
