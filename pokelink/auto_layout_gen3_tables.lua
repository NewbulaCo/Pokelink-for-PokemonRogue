--file for large tables; used by rng v2.0

--these 32-value tables are for fast indexing of RNG values
--the RNG is a linear congruential generator with modulus 2^32
--x<-0x41C64E6D*x+0x6073
--because the modulus is a power of two
--it is very easy to find the index
--only takes O(log n) time (where n is the number of possible RNG states)
--in general, it is unreasonable to calculate the index of an RNG without lookup tables
--one can use lookup tables to find indices in O(1) time
--however for this RNG, it takes up way too much space (16GB)

multspa={
 0x41C64E6D, 0xC2A29A69, 0xEE067F11, 0xCFDDDF21,
 0x5F748241, 0x8B2E1481, 0x76006901, 0x1711D201,
 0xBE67A401, 0xDDDF4801, 0x3FFE9001, 0x90FD2001,
 0x65FA4001, 0xDBF48001, 0xF7E90001, 0xEFD20001,
 0xDFA40001, 0xBF480001, 0x7E900001, 0xFD200001,
 0xFA400001, 0xF4800001, 0xE9000001, 0xD2000001,
 0xA4000001, 0x48000001, 0x90000001, 0x20000001,
 0x40000001, 0x80000001, 0x00000001, 0x00000001}

multspb={
 0x00006073, 0xE97E7B6A, 0x31B0DDE4, 0x67DBB608,
 0xCBA72510, 0x1D29AE20, 0xBA84EC40, 0x79F01880,
 0x08793100, 0x6B566200, 0x803CC400, 0xA6B98800,
 0xE6731000, 0x30E62000, 0xF1CC4000, 0x23988000,
 0x47310000, 0x8E620000, 0x1CC40000, 0x39880000,
 0x73100000, 0xE6200000, 0xCC400000, 0x98800000,
 0x31000000, 0x62000000, 0xC4000000, 0x88000000,
 0x10000000, 0x20000000, 0x40000000, 0x80000000}

multspc={
 0x00003039, 0xD3DC167E, 0xD6651C2C, 0xCD1DCF18,
 0x65136930, 0x642B7E60, 0x1935ACC0, 0xB6461980,
 0x1EF73300, 0x1F9A6600, 0x85E4CC00, 0x26899800,
 0xB8133000, 0x1C266000, 0xE84CC000, 0x90998000,
 0x21330000, 0x42660000, 0x84CC0000, 0x09980000,
 0x13300000, 0x26600000, 0x4CC00000, 0x99800000,
 0x33000000, 0x66000000, 0xCC000000, 0x98000000,
 0x30000000, 0x60000000, 0xC0000000, 0x80000000}

--for data sorting (GAEM)
growthtbl={1,1,1,1,1,1, 2,2,3,4,3,4, 2,2,3,4,3,4, 2,2,3,4,3,4}
attacktbl={2,2,3,4,3,4, 1,1,1,1,1,1, 3,4,2,2,4,3, 3,4,2,2,4,3}
efforttbl={3,4,2,2,4,3, 3,4,2,2,4,3, 1,1,1,1,1,1, 4,3,4,3,2,2}
misctbl  ={4,3,4,3,2,2, 4,3,4,3,2,2, 4,3,4,3,2,2, 1,1,1,1,1,1}

-- Pokemon list

pokemontbl={
    "Bulbasaur", "Ivysaur", "Venusaur", "Charmander", "Charmeleon", "Charizard",
    "Squirtle", "Wartortle", "Blastoise", "Caterpie", "Metapod", "Butterfree",
    "Weedle", "Kakuna", "Beedrill", "Pidgey", "Pidgeotto", "Pidgeot", "Rattata", "Raticate",
    "Spearow", "Fearow", "Ekans", "Arbok", "Pikachu", "Raichu", "Sandshrew", "Sandslash",
    "Nidoran♀", "Nidorina", "Nidoqueen", "Nidoran♂", "Nidorino", "Nidoking",
    "Clefairy", "Clefable", "Vulpix", "Ninetales", "Jigglypuff", "Wigglytuff",
    "Zubat", "Golbat", "Oddish", "Gloom", "Vileplume", "Paras", "Parasect", "Venonat", "Venomoth",
    "Diglett", "Dugtrio", "Meowth", "Persian", "Psyduck", "Golduck", "Mankey", "Primeape",
    "Growlithe", "Arcanine", "Poliwag", "Poliwhirl", "Poliwrath", "Abra", "Kadabra", "Alakazam",
    "Machop", "Machoke", "Machamp", "Bellsprout", "Weepinbell", "Victreebel", "Tentacool", "Tentacruel",
    "Geodude", "Graveler", "Golem", "Ponyta", "Rapidash", "Slowpoke", "Slowbro",
    "Magnemite", "Magneton", "Farfetch'd", "Doduo", "Dodrio", "Seel", "Dewgong", "Grimer", "Muk",
    "Shellder", "Cloyster", "Gastly", "Haunter", "Gengar", "Onix", "Drowzee", "Hypno",
    "Krabby", "Kingler", "Voltorb", "Electrode", "Exeggcute", "Exeggutor", "Cubone", "Marowak",
    "Hitmonlee", "Hitmonchan", "Lickitung", "Koffing", "Weezing", "Rhyhorn", "Rhydon", "Chansey",
    "Tangela", "Kangaskhan", "Horsea", "Seadra", "Goldeen", "Seaking", "Staryu", "Starmie",
    "Mr. Mime", "Scyther", "Jynx", "Electabuzz", "Magmar", "Pinsir", "Tauros", "Magikarp", "Gyarados",
    "Lapras", "Ditto", "Eevee", "Vaporeon", "Jolteon", "Flareon", "Porygon", "Omanyte", "Omastar",
    "Kabuto", "Kabutops", "Aerodactyl", "Snorlax", "Articuno", "Zapdos", "Moltres",
    "Dratini", "Dragonair", "Dragonite", "Mewtwo", "Mew",

    "Chikorita", "Bayleef", "Meganium", "Cyndaquil", "Quilava", "Typhlosion",
    "Totodile", "Croconaw", "Feraligatr", "Sentret", "Furret", "Hoothoot", "Noctowl",
    "Ledyba", "Ledian", "Spinarak", "Ariados", "Crobat", "Chinchou", "Lanturn", "Pichu", "Cleffa",
    "Igglybuff", "Togepi", "Togetic", "Natu", "Xatu", "Mareep", "Flaaffy", "Ampharos", "Bellossom",
    "Marill", "Azumarill", "Sudowoodo", "Politoed", "Hoppip", "Skiploom", "Jumpluff", "Aipom",
    "Sunkern", "Sunflora", "Yanma", "Wooper", "Quagsire", "Espeon", "Umbreon", "Murkrow", "Slowking",
    "Misdreavus", "Unown", "Wobbuffet", "Girafarig", "Pineco", "Forretress", "Dunsparce", "Gligar",
    "Steelix", "Snubbull", "Granbull", "Qwilfish", "Scizor", "Shuckle", "Heracross", "Sneasel",
    "Teddiursa", "Ursaring", "Slugma", "Magcargo", "Swinub", "Piloswine", "Corsola", "Remoraid", "Octillery",
    "Delibird", "Mantine", "Skarmory", "Houndour", "Houndoom", "Kingdra", "Phanpy", "Donphan",
    "Porygon2", "Stantler", "Smeargle", "Tyrogue", "Hitmontop", "Smoochum", "Elekid", "Magby", "Miltank",
    "Blissey", "Raikou", "Entei", "Suicune", "Larvitar", "Pupitar", "Tyranitar", "Lugia", "Ho-Oh", "Celebi",

    "Treecko", "Grovyle", "Sceptile", "Torchic", "Combusken", "Blaziken", "Mudkip", "Marshtomp",
    "Swampert", "Poochyena", "Mightyena", "Zigzagoon", "Linoone", "Wurmple", "Silcoon", "Beautifly",
    "Cascoon", "Dustox", "Lotad", "Lombre", "Ludicolo", "Seedot", "Nuzleaf", "Shiftry",
    "Taillow", "Swellow", "Wingull", "Pelipper", "Ralts", "Kirlia", "Gardevoir", "Surskit",
    "Masquerain", "Shroomish", "Breloom", "Slakoth", "Vigoroth", "Slaking", "Nincada", "Ninjask",
    "Shedinja", "Whismur", "Loudred", "Exploud", "Makuhita", "Hariyama", "Azurill", "Nosepass",
    "Skitty", "Delcatty", "Sableye", "Mawile", "Aron", "Lairon", "Aggron", "Meditite", "Medicham",
    "Electrike", "Manectric", "Plusle", "Minun", "Volbeat", "Illumise", "Roselia", "Gulpin",
    "Swalot", "Carvanha", "Sharpedo", "Wailmer", "Wailord", "Numel", "Camerupt", "Torkoal",
    "Spoink", "Grumpig", "Spinda", "Trapinch", "Vibrava", "Flygon", "Cacnea", "Cacturne", "Swablu",
    "Altaria", "Zangoose", "Seviper", "Lunatone", "Solrock", "Barboach", "Whiscash", "Corphish",
    "Crawdaunt", "Baltoy", "Claydol", "Lileep", "Cradily", "Anorith", "Armaldo", "Feebas",
    "Milotic", "Castform", "Kecleon", "Shuppet", "Banette", "Duskull", "Dusclops", "Tropius",
    "Chimecho", "Absol", "Wynaut", "Snorunt", "Glalie", "Spheal", "Sealeo", "Walrein", "Clamperl",
    "Huntail", "Gorebyss", "Relicanth", "Luvdisc", "Bagon", "Shelgon", "Salamence", "Beldum",
    "Metang", "Metagross", "Regirock", "Regice", "Registeel", "Latias", "Latios", "Kyogre",
    "Groudon", "Rayquaza", "Jirachi", "Deoxys",

    "Turtwig", "Grotle", "Torterra", "Chimchar", "Monferno", "Infernape", "Piplup", "Prinplup",
    "Empoleon", "Starly", "Staravia", "Staraptor", "Bidoof", "Bibarel", "Kricketot", "Kricketune",
    "Shinx", "Luxio", "Luxray", "Budew", "Roserade", "Cranidos", "Rampardos", "Shieldon", "Bastiodon",
    "Burmy", "Wormadam", "Mothim", "Combee", "Vespiquen", "Pachirisu", "Buizel", "Floatzel", "Cherubi",
    "Cherrim", "Shellos", "Gastrodon", "Ambipom", "Drifloon", "Drifblim", "Buneary", "Lopunny",
    "Mismagius", "Honchkrow", "Glameow", "Purugly", "Chingling", "Stunky", "Skuntank", "Bronzor",
    "Bronzong", "Bonsly", "Mime Jr.", "Happiny", "Chatot", "Spiritomb", "Gible", "Gabite", "Garchomp",
    "Munchlax", "Riolu", "Lucario", "Hippopotas", "Hippowdon", "Skorupi", "Drapion", "Croagunk",
    "Toxicroak", "Carnivine", "Finneon", "Lumineon", "Mantyke", "Snover", "Abomasnow", "Weavile",
    "Magnezone", "Lickilicky", "Rhyperior", "Tangrowth", "Electivire", "Magmortar", "Togekiss",
    "Yanmega", "Leafeon", "Glaceon", "Gliscor", "Mamoswine", "Porygon-Z", "Gallade", "Probopass",
    "Dusknoir", "Froslass", "Rotom", "Uxie", "Mesprit", "Azelf", "Dialga", "Palkia", "Heatran",
    "Regigigas", "Giratina", "Cresselia", "Phione", "Manaphy", "Darkrai", "Shaymin", "Arceus",

    "Victini", "Snivy", "Servine", "Serperior", "Tepig", "Pignite", "Emboar", "Oshawott", "Dewott", "Samurott", "Patrat", "Watchog",
    "Lillipup", "Herdier", "Stoutland", "Purrloin", "Liepard", "Pansage", "Simisage", "Pansear", "Simisear", "Panpour", "Simipour",
    "Munna", "Musharna", "Pidove", "Tranquill", "Unfezant", "Blitzle", "Zebstrika", "Roggenrola", "Boldore", "Gigalith", "Woobat",
    "Swoobat", "Drilbur", "Excadrill", "Audino", "Timburr", "Gurdurr", "Conkeldurr", "Tympole", "Palpitoad", "Seismitoad", "Throh",
    "Sawk", "Sewaddle", "Swadloon", "Leavanny", "Venipede", "Whirlipede", "Scolipede", "Cottonee", "Whimsicott", "Petilil",
    "Lilligant", "Basculin", "Sandile", "Krokorok", "Krookodile", "Darumaka", "Darmanitan", "Maractus", "Dwebble", "Crustle",
    "Scraggy", "Scrafty", "Sigilyph", "Yamask", "Cofagrigus", "Tirtouga", "Carracosta", "Archen", "Archeops", "Trubbish",
    "Garbodor", "Zorua", "Zoroark", "Minccino", "Cinccino", "Gothita", "Gothorita", "Gothitelle", "Solosis", "Duosion",
    "Reuniclus", "Ducklett", "Swanna", "Vanillite", "Vanillish", "Vanilluxe", "Deerling", "Sawsbuck", "Emolga", "Karrablast",
    "Escavalier", "Foongus", "Amoonguss", "Frillish", "Jellicent", "Alomomola", "Joltik", "Galvantula", "Ferroseed",
    "Ferrothorn", "Klink", "Klang", "Klinklang", "Tynamo", "Eelektrik", "Eelektross", "Elgyem", "Beheeyem", "Litwick",
    "Lampent", "Chandelure", "Axew", "Fraxure", "Haxorus", "Cubchoo", "Beartic", "Cryogonal", "Shelmet", "Accelgor",
    "Stunfisk", "Mienfoo", "Mienshao", "Druddigon", "Golett", "Golurk", "Pawniard", "Bisharp", "Bouffalant", "Rufflet",
    "Braviary", "Vullaby", "Mandibuzz", "Heatmor", "Durant", "Deino", "Zweilous", "Hydreigon", "Larvesta", "Volcarona", "Cobalion",
    "Terrakion", "Virizion", "Tornadus", "Thundurus", "Reshiram", "Zekrom", "Landorus", "Kyurem", "Keldeo", "Meloetta", "Genesect",

	"Chespin", "Quilladin", "Chesnaught", "Fennekin", "Braixen", "Delphox", "Froakie", "Frogadier", "Greninja",
	"Bunnelby", "Diggersby", "Fletchling", "Fletchinder", "Talonflame", "Scatterbug", "Spewpa", "Vivillon", "Litleo",
	"Pyroar", "Flabébé", "Floette", "Florges", "Skiddo", "Gogoat", "Pancham", "Pangoro", "Furfrou", "Espurr", "Meowstic",
	"Honedge", "Doublade", "Aegislash", "Spritzee", "Aromatisse", "Swirlix", "Slurpuff", "Inkay", "Malamar", "Binacle",
	"Barbaracle", "Skrelp", "Dragalge", "Clauncher", "Clawitzer", "Helioptile", "Heliolisk", "Tyrunt", "Tyrantrum", "Amaura",
	"Aurorus", "Sylveon", "Hawlucha", "Dedenne", "Carbink", "Goomy", "Sliggoo", "Goodra", "Klefki", "Phantump", "Trevenant",
	"Pumpkaboo", "Gourgeist", "Bergmite", "Avalugg", "Noibat", "Noivern", "Xerneas", "Yveltal", "Zygarde", "Diancie", "Hoopa",
	"Volcanion", "Rowlet", "Dartrix", "Decidueye", "Litten", "Torracat", "Incineroar", "Popplio", "Brionne", "Primarina",
	"Pikipek", "Trumbeak", "Toucannon", "Yungoos", "Gumshoos", "Grubbin", "Charjabug", "Vikavolt", "Crabrawler", "Crabominable",
	"Oricorio", "Cutiefly", "Ribombee", "Rockruff", "Lycanroc", "Wishiwashi", "Mareanie", "Toxapex", "Mudbray", "Mudsdale",
	"Dewpider", "Araquanid", "Fomantis", "Lurantis", "Morelull", "Shiinotic", "Salandit", "Salazzle", "Stufful", "Bewear",
	"Bounsweet", "Steenee", "Tsareena", "Comfey", "Oranguru", "Passimian", "Wimpod", "Golisopod", "Sandygast", "Palossand",
	"Pyukumuku", "Type: Null", "Silvally", "Minior", "Komala", "Turtonator", "Togedemaru", "Mimikyu", "Bruxish", "Drampa",
	"Dhelmise", "Jangmo-o", "Hakamo-o", "Kommo-o", "Tapu Koko", "Tapu Lele", "Tapu Bulu", "Tapu Fini", "Cosmog", "Cosmoem",
	"Solgaleo", "Lunala", "Nihilego", "Buzzwole", "Pheromosa", "Xurkitree", "Celesteela", "Kartana", "Guzzlord", "Necrozma",
	"Magearna", "Marshadow", "Poipole", "Naganadel", "Stakataka", "Blacephalon", "Zeraora", "Meltan", "Melmetal",

	"Grookey",	"Thwackey", "Rillaboom", "Scorbunny", "Raboot", "Cinderace", "Sobble", "Drizzile", "Inteleon", "Skwovet", "Greedent",
	"Rookidee", "Corvisquire", "Corviknight", "Blipbug", "Dottler", "Orbeetle", "Nickit", "Thievul", "Gossifleur", "Eldegoss",
	"Wooloo", "Dubwool", "Chewtle", "Drednaw", "Yamper", "Boltund", "Rolycoly", "Carkol", "Coalossal", "Applin", "Flapple",
	"Appletun", "Silicobra", "Sandaconda", "Cramorant", "Arrokuda", "Barraskewda", "Toxel", "Toxtricity", "Sizzlipede",
	"Centiskorch", "Clobbopus", "Grapploct", "Sinistea", "Polteageist", "Hatenna", "Hattrem", "Hatterene", "Impidimp", "Morgrem",
	"Grimmsnarl", "Obstagoon", "Perrserker", "Cursola", "Sirfetch’d", "Mr. Rime", "Runerigus", "Milcery", "Alcremie",
	"Falinks", "Pincurchin", "Snom", "Frosmoth", "Stonjourner", "Eiscue", "Indeedee", "Morpeko", "Cufant", "Copperajah",
	"Dracozolt", "Arctozolt", "Dracovish", "Arctovish", "Duraludon", "Dreepy", "Drakloak", "Dragapult", "Zacian",
	"Zamazenta", "Eternatus", "Kubfu", "Urshifu", "Zarude", "Regieleki", "Regidrago", "Glastrier", "Spectrier", "Calyrex", --898?
	
	--all alt forms past this point
	
	"none", "none", --900
	"none", "none", "none", "none", "none", "none", "none", "none", "none", "none", 
	"none", "none", "none", "none", "none", "none", "none", "none", "none", "none", 
	"none", "none", "none", "none", "none", "none", "none", "none", "none", "none", 
	"none", "none", "none", "none", "none", "none", "none", "none", "none", "none", 
	"none", "none", "none", "none", "none", "none", "none", "none",   --948
	
	"Rattata", "Raticate", "Raichu", "Sandshrew", "Sandslash", "Vuplix", "Ninetales", "Diglett", "Dugtrio", "Meowth",
	"Persian", "Geodude", "Graveler", "Golem", "Grimer", "Muk", "Exeggutor", "Marowak",  --966 (alola forms)
	
	"Meowth", "Ponyta", "Rapidash", "Slowpoke", "Slowbro", "Farfetch'd", "Weezing", "Mr. Mime", "Articuno",
	"Zapdos", "Moltres", "Slowking", "Corsola", "Zigzagoon", "Linoone", "Darumaka", "Darmanitan",
	"Yamask", "Stunfisk",	--985 (galar forms)
	
	"none", "none", "none", "none", "none", "none", "none", "none", "none", "none", 
	"none", "none", "none", "none", "none", "none", "none", "none", "none", "none", 
	"none", "none", "none", "none", "none", "none", "none", "none", "none", "none", 
	"none", "none", "none", "none", "none", "none", "none", "none", "none", "none", 
	"none", "none", "none", "none", "none", --1030
	
	"Deoxys", "Deoxys", "Deoxys", "Burmy", "Burmy", "Wormadam", "Wormadam", "none", "Shellos", "Gastrodon", --1040 
	"Rotom", "Rotom", "Rotom", "Rotom", "Rotom", "Rotom", "none", "Shaymin", --1047
	
	"Arceus", "Arceus", "Arceus", "Arceus", "Arceus", "Arceus", "Arceus", "Arceus", "Arceus", "Arceus", 
	"Arceus", "Arceus", "Arceus", "Arceus", "Arceus", "Arceus", "Arceus", --1064
	
	"none", "none", "none", "none", "none", "none", "none", "none", "none", --1073
	
	"Tornadus", "Thundurus", "Landorus", "Kyurem", "Kyurem", --1078
	
	"none", "none", "none", "none", "none", "none", "none", "none", "none", "none", 
	"none", "none", "none", "none", "none", "none", "none", "none", "none", "none", 
	"none", "none", "none", "none", "none", "none", "none", "none", "none", "none", 
	"none", "none", "none", "none", "none", "none", "none", "none", "none", "none", 
	"none", "none", "none", "none", "none", "none", "none", "none", 	--1127
	
	"Meowstic", "none", "none", "none", "none", "none", "none", "none", "none", --1136
	
	"Zygarde", "none", "none", "Zygarde", "Hoopa", "Oricorio", "Oricorio", "Oricorio",
	"none", "Lycanroc",  --1146
	
	"none", "none", 
	
	"Silvally", "Silvally", "Silvally", "Silvally", "Silvally", "Silvally", "Silvally", "Silvally", 
	"Silvally", "Silvally", "Silvally", "Silvally", "Silvally", "Silvally", "Silvally", "Silvally", "Silvally", 
	"none", "none", "none", "none", "none", "none", "none", "none", "none", "none", 
	"none", "none", "none", "none", --1179
	
	"Necrozma", "Necrozma", "none", "none", "none", "none", "none", "none", "none", "none", 
	"none", "none", "none", "none", "none", "none", "none", "none", "none", "none",  --1199
	
	"Zacian", "Zamazenta", "none", "Urshifu", "none", "none", "Calyrex", "Calyrex"
	
	}
			
--Move list

movetbl={
	'Pound',  'Karate Chop',  'Double Slap',  'Comet Punch',  'Mega Punch',  'Pay Day',  'Fire Punch',  'Ice Punch',  'Thunder Punch',  'Scratch', 
	'Vise Grip',  'Guillotine',  'Razor Wind',  'Swords Dance',  'Cut',  'Gust',  'Wing Attack',  'Whirlwind',  'Fly',  'Bind',  'Slam',  'Vine Whip', 
	'Stomp',  'Double Kick',  'Mega Kick',  'Jump Kick',  'Rolling Kick',  'Sand Attack',  'Headbutt',  'Horn Attack',  'Fury Attack',  'Horn Drill', 
	'Tackle',  'Body Slam',  'Wrap',  'Take Down',  'Thrash',  'Double-Edge',  'Tail Whip',  'Poison Sting',  'Twineedle',  'Pin Missile',  'Leer', 
	'Bite',  'Growl',  'Roar',  'Sing',  'Supersonic',  'Sonic Boom',  'Disable',  'Acid',  'Ember',  'Flamethrower',  'Mist',  'Water Gun',  'Hydro Pump', 
	'Surf',  'Ice Beam',  'Blizzard',  'Psybeam',  'Bubble Beam',  'Aurora Beam',  'Hyper Beam',  'Peck',  'Drill Peck',  'Submission',  'Low Kick', 
	'Counter',  'Seismic Toss',  'Strength',  'Absorb',  'Mega Drain',  'Leech Seed',  'Growth',  'Razor Leaf',  'Solar Beam',  'Poison Powder',  'Stun Spore',
	'Sleep Powder',  'Petal Dance',  'String Shot',  'Dragon Rage',  'Fire Spin',  'Thunder Shock',  'Thunderbolt',  'Thunder Wave',  'Thunder', 
	'Rock Throw',  'Earthquake',  'Fissure',  'Dig',  'Toxic',  'Confusion',  'Psychic',  'Hypnosis',  'Meditate',  'Agility',  'Quick Attack',  'Rage', 
	'Teleport',  'Night Shade',  'Mimic',  'Screech',  'Double Team',  'Recover',  'Harden',  'Minimize',  'Smokescreen',  'Confuse Ray',  'Withdraw',  
	'Defense Curl',  'Barrier',  'Light Screen',  'Haze',  'Reflect',  'Focus Energy',  'Bide',  'Metronome',  'Mirror Move',  'Self-Destruct',  'Egg Bomb', 
	'Lick',  'Smog',  'Sludge',  'Bone Club',  'Fire Blast',  'Waterfall',  'Clamp',  'Swift',  'Skull Bash',  'Spike Cannon',  'Constrict',  'Amnesia', 
	'Kinesis',  'Soft-Boiled',  'High Jump Kick',  'Glare',  'Dream Eater',  'Poison Gas',  'Barrage',  'Leech Life',  'Lovely Kiss',  'Sky Attack',  
	'Transform',  'Bubble',  'Dizzy Punch',  'Spore',  'Flash',  'Psywave',  'Splash',  'Acid Armor',  'Crabhammer',  'Explosion',  'Fury Swipes',  'Bonemerang', 
	'Rest',  'Rock Slide',  'Hyper Fang',  'Sharpen',  'Conversion',  'Tri Attack',  'Super Fang',  'Slash',  'Substitute',  'Struggle',  'Sketch',  'Triple Kick', 
	'Thief',  'Spider Web',  'Mind Reader',  'Nightmare',  'Flame Wheel',  'Snore',  'Curse',  'Flail',  'Conversion 2',  'Aeroblast',  'Cotton Spore', 
	'Reversal',  'Spite',  'Powder Snow',  'Protect',  'Mach Punch',  'Scary Face',  'Feint Attack',  'Sweet Kiss',  'Belly Drum',  'Sludge Bomb',  'Mud-Slap', 
	'Octazooka',  'Spikes',  'Zap Cannon',  'Foresight',  'Destiny Bond',  'Perish Song',  'Icy Wind',  'Detect',  'Bone Rush',  'Lock-On',  'Outrage',  
	'Sandstorm',  'Giga Drain',  'Endure',  'Charm',  'Rollout',  'False Swipe',  'Swagger',  'Milk Drink',  'Spark',  'Fury Cutter',  'Steel Wing', 
	'Mean Look',  'Attract',  'Sleep Talk',  'Heal Bell',  'Return',  'Present',  'Frustration',  'Safeguard',  'Pain Split',  'Sacred Fire',  'Magnitude', 
	'Dynamic Punch',  'Megahorn',  'Dragon Breath',  'Baton Pass',  'Encore',  'Pursuit',  'Rapid Spin',  'Sweet Scent',  'Iron Tail',  'Metal Claw',  
	'Vital Throw',  'Morning Sun',  'Synthesis',  'Moonlight',  'Hidden Power',  'Cross Chop',  'Twister',  'Rain Dance',  'Sunny Day',  'Crunch',  
	'Mirror Coat',  'Psych Up',  'Extreme Speed',  'Ancient Power',  'Shadow Ball',  'Future Sight',  'Rock Smash',  'Whirlpool',  'Beat Up',  'Fake Out', 
	'Uproar',  'Stockpile',  'Spit Up',  'Swallow',  'Heat Wave',  'Hail',  'Torment',  'Flatter',  'Will-O-Wisp',  'Memento',  'Facade',  'Focus Punch', 
	'Smelling Salts',  'Follow Me',  'Nature Power',  'Charge',  'Taunt',  'Helping Hand',  'Trick',  'Role Play',  'Wish',  'Assist',  'Ingrain', 
	'Superpower',  'Magic Coat',  'Recycle',  'Revenge',  'Brick Break',  'Yawn',  'Knock Off',  'Endeavor',  'Eruption',  'Skill Swap',  'Imprison',  
	'Refresh',  'Grudge',  'Snatch',  'Secret Power',  'Dive',  'Arm Thrust',  'Camouflage',  'Tail Glow',  'Luster Purge',  'Mist Ball',  'Feather Dance', 
	'Teeter Dance',  'Blaze Kick',  'Mud Sport',  'Ice Ball',  'Needle Arm',  'Slack Off',  'Hyper Voice',  'Poison Fang',  'Crush Claw',  'Blast Burn',  
	'Hydro Cannon',  'Meteor Mash',  'Astonish',  'Weather Ball',  'Aromatherapy',  'Fake Tears',  'Air Cutter',  'Overheat',  'Odor Sleuth',  'Rock Tomb', 
	'Silver Wind',  'Metal Sound',  'Grass Whistle',  'Tickle',  'Cosmic Power',  'Water Spout',  'Signal Beam',  'Shadow Punch',  'Extrasensory', 
	'Sky Uppercut',  'Sand Tomb',  'Sheer Cold',  'Muddy Water',  'Bullet Seed',  'Aerial Ace',  'Icicle Spear',  'Iron Defense',  'Block',  'Howl',  
	'Dragon Claw',  'Frenzy Plant',  'Bulk Up',  'Bounce',  'Mud Shot',  'Poison Tail',  'Covet',  'Volt Tackle',  'Magical Leaf',  'Water Sport', 
	'Calm Mind',  'Leaf Blade',  'Dragon Dance',  'Rock Blast',  'Shock Wave',  'Water Pulse',  'Doom Desire',  'Psycho Boost',  'Roost',  'Gravity',
	'Miracle Eye',  'Wake-Up Slap',  'Hammer Arm',  'Gyro Ball',  'Healing Wish',  'Brine',  'Natural Gift',  'Feint',  'Pluck',  'Tailwind',  'Acupressure', 
	'Metal Burst',  'U-turn',  'Close Combat',  'Payback',  'Assurance',  'Embargo',  'Fling',  'Psycho Shift',  'Trump Card',  'Heal Block',  
	'Wring Out',  'Power Trick',  'Gastro Acid',  'Lucky Chant',  'Me First',  'Copycat',  'Power Swap',  'Guard Swap',  'Punishment',  'Last Resort', 
	'Worry Seed',  'Sucker Punch',  'Toxic Spikes',  'Heart Swap',  'Aqua Ring',  'Magnet Rise',  'Flare Blitz',  'Force Palm',  'Aura Sphere',  
	'Rock Polish',  'Poison Jab',  'Dark Pulse',  'Night Slash',  'Aqua Tail',  'Seed Bomb',  'Air Slash',  'X-Scissor',  'Bug Buzz',  'Dragon Pulse', 
	'Dragon Rush',  'Power Gem',  'Drain Punch',  'Vacuum Wave',  'Focus Blast',  'Energy Ball',  'Brave Bird',  'Earth Power',  'Switcheroo',  'Giga Impact', 
	'Nasty Plot',  'Bullet Punch',  'Avalanche',  'Ice Shard',  'Shadow Claw',  'Thunder Fang',  'Ice Fang',  'Fire Fang',  'Shadow Sneak',  'Mud Bomb',  
	'Psycho Cut',  'Zen Headbutt',  'Mirror Shot',  'Flash Cannon',  'Rock Climb',  'Defog',  'Trick Room',  'Draco Meteor',  'Discharge',  'Lava Plume', 
	'Leaf Storm',  'Power Whip',  'Rock Wrecker',  'Cross Poison',  'Gunk Shot',  'Iron Head',  'Magnet Bomb',  'Stone Edge',  'Captivate',  'Stealth Rock', 
	'Grass Knot',  'Chatter',  'Judgment',  'Bug Bite',  'Charge Beam',  'Wood Hammer',  'Aqua Jet',  'Attack Order',  'Defend Order',  'Heal Order',  
	'Head Smash',  'Double Hit',  'Roar of Time',  'Spacial Rend',  'Lunar Dance',  'Crush Grip',  'Magma Storm',  'Dark Void',  'Seed Flare',  'Ominous Wind',  
	'Shadow Force',  'Hone Claws',  'Wide Guard',  'Guard Split',  'Power Split',  'Wonder Room',  'Psyshock',  'Venoshock',  'Autotomize',  'Rage Powder', 
	'Telekinesis',  'Magic Room',  'Smack Down',  'Storm Throw',  'Flame Burst',  'Sludge Wave',  'Quiver Dance',  'Heavy Slam',  'Synchronoise',  'Electro Ball', 
	'Soak',  'Flame Charge',  'Coil',  'Low Sweep',  'Acid Spray',  'Foul Play',  'Simple Beam',  'Entrainment',  'After You',  'Round',  'Echoed Voice', 
	'Chip Away',  'Clear Smog',  'Stored Power',  'Quick Guard',  'Ally Switch',  'Scald',  'Shell Smash',  'Heal Pulse',  'Hex',  'Sky Drop',  'Shift Gear', 
	'Circle Throw',  'Incinerate',  'Quash',  'Acrobatics',  'Reflect Type',  'Retaliate',  'Final Gambit',  'Bestow',  'Inferno',  'Water Pledge',  
	'Fire Pledge',  'Grass Pledge',  'Volt Switch',  'Struggle Bug',  'Bulldoze',  'Frost Breath',  'Dragon Tail',  'Work Up',  'Electroweb',  'Wild Charge',
	'Drill Run',  'Dual Chop',  'Heart Stamp',  'Horn Leech',  'Sacred Sword',  'Razor Shell',  'Heat Crash',  'Leaf Tornado',  'Steamroller',  
	'Cotton Guard',  'Night Daze',  'Psystrike',  'Tail Slap',  'Hurricane',  'Head Charge',  'Gear Grind',  'Searing Shot',  'Techno Blast',  'Relic Song', 
	'Secret Sword',  'Glaciate',  'Bolt Strike',  'Blue Flare',  'Fiery Dance',  'Freeze Shock',  'Ice Burn',  'Snarl',  'Icicle Crash',  'V-create',
	'Fusion Flare',  'Fusion Bolt',  'Flying Press',  'Mat Block',  'Belch',  'Rototiller',  'Sticky Web',  'Fell Stinger',  'Phantom Force', 
	'Trick-or-Treat',  'Noble Roar',  'Ion Deluge',  'Parabolic Charge',  'Forests Curse',  'Petal Blizzard',  'Freeze-Dry',  'Disarming Voice', 
	'Parting Shot',  'Topsy-Turvy',  'Draining Kiss',  'Crafty Shield',  'Flower Shield',  'Grassy Terrain',  'Misty Terrain',  'Electrify', 
	'Play Rough',  'Fairy Wind',  'Moonblast',  'Boomburst',  'Fairy Lock',  'Kings Shield',  'Play Nice',  'Confide',  'Diamond Storm',  'Steam Eruption', 
	'Hyperspace Hole',  'Water Shuriken',  'Mystical Fire',  'Spiky Shield',  'Aromatic Mist',  'Eerie Impulse',  'Venom Drench',  'Powder', 
	'Geomancy',  'Magnetic Flux',  'Happy Hour',  'Electric Terrain',  'Dazzling Gleam',  'Celebrate',  'Hold Hands',  'Baby-Doll Eyes',  'Nuzzle', 
	'Hold Back',  'Infestation',  'Power-Up Punch',  'Oblivion Wing',  'Thousand Arrows',  'Thousand Waves',  'Lands Wrath',  'Light of Ruin', 
	'Origin Pulse',  'PrecipiceBlades',  'Dragon Ascent',  'Hyperspace Fury',  'Breakneck Blitz',  'Breakneck Blitz',  'All-Out Pummeling',  'All-Out Pummeling', 
	'Supersonic Skystrike',  'Supersonic Skystrike',  'Acid Downpour',  'Acid Downpour',  'Tectonic Rage',  'Tectonic Rage',  'Continental Crush',  
	'Continental Crush',  'Savage Spin-Out',  'Savage Spin-Out',  'Never-Ending Nightmare',  'Never-Ending Nightmare',  'Corkscrew Crash',  'Corkscrew Crash', 
	'Inferno Overdrive',  'Inferno Overdrive',  'Hydro Vortex',  'Hydro Vortex',  'Bloom Doom',  'Bloom Doom',  'Gigavolt Havoc',  'Gigavolt Havoc',  
	'Shattered Psyche',  'Shattered Psyche',  'Subzero Slammer',  'Subzero Slammer',  'Devastating Drake',  'Devastating Drake',  'Black Hole Eclipse', 
	'Black Hole Eclipse',  'Twinkle Tackle',  'Twinkle Tackle',  'Catastropika',  'Shore Up',  'First Impression',  'Baneful Bunker',  'Spirit Shackle',  
	'Darkest Lariat',  'Sparkling Aria',  'Ice Hammer',  'Floral Healing',  'High Horsepower',  'Strength Sap',  'Solar Blade',  'Leafage',  'Spotlight', 
	'Toxic Thread',  'Laser Focus',  'Gear Up',  'Throat Chop',  'Pollen Puff',  'Anchor Shot',  'Psychic Terrain',  'Lunge',  'Fire Lash',  'Power Trip',
	'Burn Up',  'Speed Swap',  'Smart Strike',  'Purify',  'Revelation Dance',  'Core Enforcer',  'Trop Kick',  'Instruct',  'Beak Blast',  
	'Clanging Scales',  'Dragon Hammer',  'Brutal Swing',  'Aurora Veil',  'Sinister Arrow Raid',  'Malicious Moonsault',  'Oceanic Operetta',
	'Guardian of Alola',  'Soul-Stealing 7-Star Strike',  'Stoked Sparksurfer',  'Pulverizing Pancake',  'Extreme Evoboost',  'Genesis Supernova',  'Shell Trap', 
	'Fleur Cannon',  'Psychic Fangs',  'Stomping Tantrum',  'Shadow Bone',  'Accelerock',  'Liquidation',  'Prismatic Laser',  'Spectral Thief',  'Sunsteel Strike', 
	'Moongeist Beam',  'Tearful Look',  'Zing Zap',  'Natures Madness',  'Multi-Attack',  '10,000,000 Volt Thunderbolt',  'Mind Blown',  'Plasma Fists', 
	'Photon Geyser',  'Light That Burns the Sky',  'Searing Sunraze Smash',  'Menacing Moonraze Maelstrom',  'Lets Snuggle Forever',  'Splintered Stormshards', 
	'Clangorous Soulblaze',  'Zippy Zap',  'Splishy Splash',  'Floaty Fall',  'Pika Papow',  'Bouncy Bubble',  'Buzzy Buzz',  'Sizzly Slide',  'Glitzy Glow', 
	'Baddy Bad',  'Sappy Seed',  'Freezy Frost',  'Sparkly Swirl',  'Veevee Volley',  'Double Iron Bash',  'Max Guard',  'Dynamax Cannon',  'Snipe Shot', 
	'Jaw Lock',  'Stuff Cheeks',  'No Retreat',  'Tar Shot',  'Magic Powder',  'Dragon Darts',  'Teatime','Octolock',  'Bolt Beak',  'Fishious Rend', 
	'Court Change',  'Max Flare',  'Max Flutterby',  'Max Lightning',  'Max Strike',  'Max Knuckle',  'Max Phantasm',  'Max Hailstorm',  'Max Ooze', 
	'Max Geyser',  'Max Airstream',  'Max Starfall',  'Max Wyrmwind',  'Max Mindstorm',  'Max Rockfall',  'Max Quake',  'Max Darkness',  'Max Overgrowth', 
	'Max Steelspike',  'Clangorous Soul',  'Body Press',  'Decorate',  'Drum Beating',  'Snap Trap',  'Pyro Ball',  'Behemoth Blade',  'Behemoth Bash', 
	'Aura Wheel',  'Breaking Swipe',  'Branch Poke',  'Overdrive',  'Apple Acid',  'Grav Apple',  'Spirit Break',  'Strange Steam',  'Life Dew',  'Obstruct', 
	'False Surrender',  'Meteor Assault',  'Eternabeam',  'Steel Beam',  'Expanding Force',  'Steel Roller',  'Scale Shot',  'Meteor Beam',  'Shell Side Arm',  
	'Misty Explosion',  'Grassy Glide',  'Rising Voltage',  'Terrain Pulse',  'Skitter Smack',  'Burning Jealousy',  'Lash Out',  'Poltergeist',  'Corrosive Gas',
	'Coaching',  'Flip Turn',  'Triple Axel',  'Dual Wingbeat',  'Scorching Sands',  'Jungle Healing',  'Wicked Blow',  'Surging Strikes',  'Thunder Cage',  'Dragon Energy', 
	'Freezing Glare',  'Fiery Wrath',  'Thunderous Kick',  'Glacial Lance',  'Astral Barrage',  'Eerie Spell'

}
			
			
alternate_forms = {}
alternate_forms[172] = { "normal", "spiky-eared" }
alternate_forms[201] = { "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" }
alternate_forms[385] = { "normal", "attack", "defense", "speed" }
alternate_forms[412] = { "plant", "sandy", "trash" }
alternate_forms[413] = { "plant", "sandy", "trash" }
alternate_forms[422] = { "west", "east" }
alternate_forms[423] = { "west", "east" }
alternate_forms[479] = { "normal", "heat", "wash", "frost", "fan", "mow" }
alternate_forms[487] = { "altered", "origin" }
alternate_forms[492] = { "land", "sky" }
alternate_forms[493] = { "normal", "fist", "sky", "toxic", "earth", "stone", "insect", "spooky", "iron", "dummyValue", "flame", "splash", "meadow", "zap", "mind", "icicle", "draco", "dread", "mystery" }
				
alternate_forms[19] = { "normal", "alola" }
alternate_forms[20] = { "normal", "alola" }
alternate_forms[26] = { "normal", "alola" }
alternate_forms[27] = { "normal", "alola" }
alternate_forms[28] = { "normal", "alola" }
alternate_forms[37] = { "normal", "alola" }
alternate_forms[38] = { "normal", "alola" }
alternate_forms[50] = { "normal", "alola" }
alternate_forms[51] = { "normal", "alola" }
alternate_forms[52] = { "normal", "alola", "galar" }
alternate_forms[53] = { "normal", "alola", "galar" }
alternate_forms[74] = { "normal", "alola" }
alternate_forms[75] = { "normal", "alola" }
alternate_forms[76] = { "normal", "alola" }
alternate_forms[88] = { "normal", "alola" }
alternate_forms[89] = { "normal", "alola" }
alternate_forms[103] = { "normal", "alola" }
alternate_forms[105] = { "normal", "alola" }

alternate_forms[77] = { "normal", "galar" }
alternate_forms[78] = { "normal", "galar" }
alternate_forms[79] = { "normal", "galar" }
alternate_forms[80] = { "normal", "galar" }
alternate_forms[83] = { "normal", "galar" }
alternate_forms[110] = { "normal", "galar" }
alternate_forms[122] = { "normal", "galar" }
alternate_forms[144] = { "normal", "galar" }
alternate_forms[145] = { "normal", "galar" }
alternate_forms[146] = { "normal", "galar" }
alternate_forms[199] = { "normal", "galar" }
alternate_forms[222] = { "normal", "galar" }
alternate_forms[263] = { "normal", "galar" }
alternate_forms[264] = { "normal", "galar" }
alternate_forms[554] = { "normal", "galar" }
alternate_forms[555] = { "normal", "galar" }
alternate_forms[562] = { "normal", "galar" }
alternate_forms[618] = { "normal", "galar" }

alternate_forms[641] = { "incarnate", "therian" }
alternate_forms[642] = { "incarnate", "therian" }
alternate_forms[645] = { "incarnate", "therian" }
alternate_forms[646] = { "normal", "white", "black" }

alternate_forms[678] = { "male", "female" } --meowstic: unconfirmed form names
alternate_forms[718] = { "normal", "10", "complete" }
alternate_forms[720] = { "confined", "unbound" }

alternate_forms[741] = { "baile", "pompom", "pau", "sensu" }
alternate_forms[745] = { "midday", "midnight" } --lycanroc: missing midnight or dusk form
alternate_forms[773] = { "normal", "fight", "flying", "poison", "ground", "rock", "bug", "ghost", "steel", "fire", "water", "grass", "electric", "psychic", "ice", "dragon", "dark", "fairy" } --different order than pokelink api
alternate_forms[800] = { "normal", "duskmane", "dawnwings", "ultra" } --necrozma: unknown ultra form species

alternate_forms[888] = { "normal", "crowned" }
alternate_forms[889] = { "normal", "crowned" }
alternate_forms[892] = { "single", "rapid" }
alternate_forms[898] = { "normal", "ice-rider", "ghost-rider" }

				
				
alternate_species = {} 
alternate_species[19] = {949}
alternate_species[20] = {950}
alternate_species[26] = {951}
alternate_species[27] = {952}
alternate_species[28] = {953}
alternate_species[37] = {954}
alternate_species[38] = {955}
alternate_species[50] = {956}
alternate_species[51] = {957}
alternate_species[52] = {958, 967}
alternate_species[53] = {959}
alternate_species[74] = {960}
alternate_species[75] = {961}
alternate_species[76] = {962}
alternate_species[88] = {963}
alternate_species[89] = {964}
alternate_species[103] = {965}
alternate_species[105] = {966}
alternate_species[77] = {968}
alternate_species[78] = {969}
alternate_species[79] = {970}
alternate_species[80] = {971}
alternate_species[83] = {972}
alternate_species[110] = {973}
alternate_species[122] = {974}
alternate_species[144] = {975}
alternate_species[145] = {976}
alternate_species[146] = {977}
alternate_species[199] = {978}
alternate_species[222] = {979}
alternate_species[263] = {980}
alternate_species[264] = {981}
alternate_species[554] = {982}
alternate_species[555] = {983}
alternate_species[562] = {984}
alternate_species[618] = {985}

alternate_species[385] = {1031, 1032, 1033}
alternate_species[412] = {1034, 1035}
alternate_species[413] = {1036, 1037}
alternate_species[422] = {1039}
alternate_species[423] = {1040}
alternate_species[479] = {1041, 1042, 1043, 1044, 1045}
alternate_species[492] = {1047}
alternate_species[493] = {1048, 1049, 1050, 1051, 1052, 1053, 1054, 1055, 1056, 1057, 1058, 1059, 1060, 1061, 1062, 1063, 1064}
alternate_species[641] = {1074}
alternate_species[642] = {1075}
alternate_species[643] = {1076}
alternate_species[646] = {1077, 1078}
alternate_species[678] = {1128}
alternate_species[718] = {1137, 1140}
alternate_species[720] = {1141}
alternate_species[741] = {1142, 1143, 1144}
alternate_species[745] = {1146}
alternate_species[773] = {1149, 1150, 1151, 1152, 1153, 1154, 1155, 1156, 1157, 1158, 1159, 1160, 1161, 1162, 1163, 1164, 1165}
alternate_species[800] = {1180, 1181}
alternate_species[888] = {1200}
alternate_species[889] = {1201}
alternate_species[892] = {1203}
alternate_species[898] = {1205, 1206}


characterTable = {}

-- numbers
for i = 161, 171 do
	characterTable[i] = string.char(i - 161 + 48)
end

-- capital letters
for i = 187, 212 do
	characterTable[i] = string.char(i - 187 + 65)
end

-- lowercase letters
for i = 213, 239 do
	characterTable[i] = string.char(i - 213 + 97)
end

characterTable[0] = " "
characterTable[171] = "!"
characterTable[172] = "?"
characterTable[173] = "."
characterTable[174] = "-"
characterTable[175] = "•"
characterTable[176] = ".."
characterTable[177] = "“"
characterTable[178] = "”"
characterTable[179] = "‘"
characterTable[180] = "’"
characterTable[181] = "♂"
characterTable[182] = "♀"
characterTable[184] = ","
characterTable[185] = "×"
characterTable[186] = "/"
characterTable[240] = ":"