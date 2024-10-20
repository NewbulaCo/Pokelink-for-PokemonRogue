-- Based on the gen 3 Lua script by FractalFusion
-- Modified by EverOddish for automatic image updates
-- Modified by dfoverdx for using a NodeJS server for automatic image updates

-- Modified by Newbula for Pokemon Rogue compatibility


-- ROM HACK COMPATILIBITY: 
-- Repalce the below list of nicknames with the nicknames of the pokemon in your party (in order)
-- For best results use a party of 6 pokemon with unique nicknames with at least one using the full 10 character limit
-- The script will output an offset value if is able to find your party
-- Afterwards replace 'correct_offset' below with that value and set 'offset_found' to true
-- If an offset value is not found the rom hack likely has a custom data structure that Pokelink is unable to read
-- Note: The order of pokemon/moves in auto_layout_gen_3_table.lua may need to be adjusted if the romhack has an expanded pokedex/moves list

local party_nicknames = {"Name1", "Name2", "Name3", "Name4", "Name5", "Name6"}
local offset_found = true
local find_offset_running = false
local correct_offset = 258360

--for different game versions
--1: Ruby/Sapphire U
--2: Emerald U
--3: FireRed/LeafGreen U
--4: Ruby/Sapphire J
--5: Emerald J (TODO)
--6: FireRed/LeafGreen J (1360)

--for subgame
--0: Ruby/FireRed, Emerald
--1: Sapphire/LeafGreen
local gv = require("game_version")
local game = gv[1]
local subgame= gv[2]
local startvalue=0x83ED --insert the first value of RNG

local gen = 3
-- These are all the possible key names: [keys]
-- backspace, tab, enter, shift, control, alt, pause, capslock, escape,
-- space, pageup, pagedown, end, home, left, up, right, down, insert, delete,
-- 0 .. 9, A .. Z, numpad0 .. numpad9, numpad*, numpad+, numpad-, numpad., numpad/,
-- F1 .. F24, numlock, scrolllock, semicolon, plus, comma, minus, period, slash, tilde,
-- leftbracket, backslash, rightbracket, quote.
-- [/keys]
-- Key names must be in quotes.
-- Key names are case sensitive.
local key={"9", "8", "7"}

-- NOTE: if pokemon genders are not being correctly determined, search this file for "local baseStats" and follow the
--       directions in the comment there.

-- It is not necessary to change anything beyond this point.

--for different display modes
local status=1
local substatus={1,1,1}

local tabl={}
local prev={}

local xfix=0 --x position of display handle
local yfix=65 --y position of display handle

local xfix2=105 --x position of 2nd handle
local yfix2=0 --y position of 2nd handle

local k

dofile "send_data_to_server.lua"

--reset_server()

local Pokemon = require("pokemon")

local new_party = ""

local last_check = 0
local last_party = { Pokemon(), Pokemon(), Pokemon(), Pokemon(), Pokemon(), Pokemon() }
local print_ivs = 0

local gamename={"Ruby/Sapphire U", "Emerald U", "FireRed/LeafGreen U", "Ruby/Sapphire J", "Emerald J", "FireRed/LeafGreen J (1360)"}

--game dependent

local pstats={0x03004360, 0x020244EC, 0x02024284, 0x03004290, 0x02024190, 0x020241E4}
local estats={0x030045C0, 0x02024744, 0x0202402C, 0x030044F0, 0x00000000, 0x02023F8C}
local rng   ={0x03004818, 0x03005D80, 0x03005000, 0x03004748, 0x00000000, 0x03005040} --0X03004FA0
local rng2  ={0x00000000, 0x00000000, 0x020386D0, 0x00000000, 0x00000000, 0x0203861C}

-- IMPORTANT: These values may be wrong.  I pulled them from
--            https://bulbapedia.bulbagarden.net/wiki/Pok%C3%A9mon_base_stats_data_structure_in_Generation_III but
--            found that at least the US FireRed version had the wrong value.  I manually searched for the correct
--            address, but I don't know about the rest of the versions, and am uninspired to search for the ROMs to
--            correct them. FR(U) is correct.  If the gender of Pokemon is not being calculated properly, run
--            find_bulbasaur_gen3.lua after loading the ROM and update these values manually.
--
--            If you do this and want to help out future streamers, send me the value you discovered and the version
--            of the game you are running in the dxdt#pokemon-streamer-tools Discord channel
--            (https://discord.gg/FKDntWR), and I will add it to the github repo
--
-- baseStats={Ruby U, Emerald U, FireRed U, Ruby J, Emerald J, FireRed J}
local baseStats={0x081FEC34, 0x083203E8, 0x08254810, 0x081FEC34, 0x082F0D70, 0x082111A8}
if subgame == 1 then
    -- Ruby to Sapphire
    baseStats[1] = 0x081FEBC4 -- Saphire U
    baseStats[4] = 0x081FEBC4 -- Saphire J

    -- FireRed to LeafGreen
    baseStats[3] = 0x0825477 -- LeafGreen U
    baseStats[6] = 0x08211184 -- LeafGreen J
end

--HP, Atk, Def, Spd, SpAtk, SpDef
local statcolor = {"yellow", "red", "blue", "green", "magenta", "cyan"}

dofile "auto_layout_gen3_tables.lua"
dofile "pokemon_name_to_pokedex_id.lua"


local flag=0
local last=0
local counter=0

local bnd,br,bxr=bit.band,bit.bor,bit.bxor
local rshift, lshift=bit.rshift, bit.lshift
local mdword=memory.readdwordunsigned
local mword=memory.readwordunsigned
local mbyte=memory.readbyteunsigned

local natureorder={"Atk","Def","Spd","SpAtk","SpDef"}
local naturename={
    "Hardy","Lonely","Brave","Adamant","Naughty",
    "Bold","Docile","Relaxed","Impish","Lax",
    "Timid","Hasty","Serious","Jolly","Naive",
    "Modest","Mild","Quiet","Bashful","Rash",
    "Calm","Gentle","Sassy","Careful","Quirky"
}
local typeorder={
    "Fighting","Flying","Poison","Ground",
    "Rock","Bug","Ghost","Steel",
    "Fire","Water","Grass","Electric",
    "Psychic","Ice","Dragon","Dark"
}

--a 32-bit, b bit position bottom, d size
function getbits(a,b,d)
    return rshift(a,b)%lshift(1,d)
end

--for RNG purposes
function gettop(a)
    return(rshift(a,16))
end

--does 32-bit multiplication
--necessary because Lua does not allow 32-bit integer definitions
--so one cannot do 32-bit arithmetic
--furthermore, precision loss occurs at around 10^10
--so numbers must be broken into parts
--may be improved using bitop library exclusively
function mult32(a,b)
    local c=rshift(a,16)
    local d=a%0x10000
    local e=rshift(b,16)
    local f=b%0x10000
    local g=(c*f+d*e)%0x10000
    local h=d*f
    local i=g*0x10000+h
    return i
end

--checksum stuff; add halves
function ah(a)
    b=getbits(a,0,16)
    c=getbits(a,16,16)
    return b+c
end

function translateUsingCharacterTable(nicknamebytes)
    local nickname = ""
    local num_nil_characters = 0
    for j=1,10 do
        if nicknamebytes[j] == nil then
            num_nil_characters = num_nil_characters + 1
        elseif characterTable[nicknamebytes[j]] ~= nil then
            if num_nil_characters ~= 0 then
                nickname = nickname .. " " * num_nil_characters
                num_nil_characters = 0
            end
            nickname = nickname .. characterTable[nicknamebytes[j]]
        end
    end
    return nickname
end

function get_is_female(species, val)
    if species == 0 then
        return nil
    else
        local speciesIdx = (species - 1) * 28
        local genderIdx = speciesIdx + 16
        local bulbasaurAddr = baseStats[game] - 28
        local genderThreshold = mbyte(bulbasaurAddr + genderIdx)

        -- print(string.format("%02x", val))

        if genderThreshold == 0 or genderThreshold == 255 then
            -- all male or genderless
            return false
        elseif val == 254 then
            -- all female
            return true
        else
            return val >= genderThreshold
        end
    end
end

function find_offset()
	find_offset_running = true
	print("finding offset...")
	nicknameoffset=8
	nicknamelength=10
	for offset = 0, 300000 do
		num_matches = 0
		for slot = 1, table.getn(party_nicknames) do
			if status==1 then
				start=pstats[game]+100*(slot-1)
			else
				start=estats[game]+100*(substatus[2]-1)
			end
			new_start = start + offset
			nicknamebytes=memory.readbyterange(new_start+nicknameoffset,nicknamelength)
			nickname=translateUsingCharacterTable(nicknamebytes)
			if nickname==party_nicknames[slot] or nickname:gsub("%s+", "")==party_nicknames[slot] then
				--print(nickname)
				num_matches = num_matches + 1
			else
				break
			end
		end
		if num_matches==table.getn(party_nicknames) then
			print("potential offset: "..offset)
			offset_found=true
			correct_offset=offset
		end
		if num_matches > 0 then
			--print(offset)
			--print("")
		end
	end
	if offset_found == false then 
		print("offset not found")
	else
		print("using offset: "..correct_offset)
	end
	find_offset_running = false
end


--a press is when input is registered on one frame but not on the previous
--that's why the previous input is used as well
prev=input.get()
function fn()

    tabl=input.get()

    if tabl["Q"] and not prev["Q"] then
        print_ivs = 1
    end
    --*********
    current_time = os.time()
    is_in_battle_party_screen = memory.readbyteunsigned(0x0202000C) == 252 or memory.readbyteunsigned(0x0202000C) == 172 or memory.readbyteunsigned(0x0202000C) == 236 or memory.readbyteunsigned(0x0202000C) == 192 or memory.readbyteunsigned(0x0202000C) == 212
    in_battle = mbyte(0x02023BC8) ~= 0
    -- and mword(0x020370D0) ~= 0
    -- vba.print(mdword(0x03005008))

    mapDataSaveBlockPointer = mdword(0x03005008)
    trainerDataSaveBlockPointer = mdword(0x0300500C)
    boxDataSaveBlockPointer = mdword(0x03005010)

    -- boxStart = boxDataSaveBlockPointer
    -- boxedMonPersonality=mdword(boxStart)
    -- boxTrainerid=mdword(boxStart+4)
    -- vba.print(boxTrainerid)
    -- boxI=boxedMonPersonality%24
    -- boxedMonTrainerid=mdword(boxStart+4)
    -- boxMagicword=bxr(boxedMonPersonality, boxTrainerid)
    -- boxGrowthoffset=(growthtbl[boxI+1]-1)*12
    -- boxgrowth1=bxr(mdword(boxStart+32+boxGrowthoffset),boxMagicword)
    -- species=getbits(boxgrowth1,0,16)
    -- speciesname=pokemontbl[species]
    -- This data below could be coming soon, it allows us to possible get the current player location
    --     Including X,Y Coordinates (so we could map this to a set of location names.. You see where
    --     I'm doing with this.. It's a lot of work)
    -- If you see this, DM me ;)

    -- vba.print('coords: '
    --     .. mword(mapDataSaveBlockPointer + 0x0000) .. ', '
    --     .. mword(mapDataSaveBlockPointer + 0x0002) .. ', '
    --     .. mbyte(mapDataSaveBlockPointer + 0x0004) .. ', '
    --     .. mbyte(mapDataSaveBlockPointer + 0x0005) .. ', '
    -- )

    -- The data below could also be coming soon, This allows us to get the trainer name,
    --     current money in the players "wallet", thier playtime (live, in-game time, by the second)

    -- hours = mword(trainerDataSaveBlockPointer + 0x000E) --    2b    Playtime (hours)
    -- minutes = mbyte(trainerDataSaveBlockPointer + 0x0010) --    1b    Playtime (minutes)
    -- seconds = mbyte(trainerDataSaveBlockPointer + 0x0011) --    1b    Playtime (seconds)
    -- vba.print(string.format("%02d", hours) .. ':' .. string.format("%02d", minutes) .. ':' .. string.format("%02d", seconds))
    -- vba.print(translateUsingCharacterTable(memory.readbyterange(trainerDataSaveBlockPointer + 0x0000, 8)))


    -- vba.print(estats[game]+100*(substatus[2]-1))

    if current_time - last_check > 1 and is_in_battle_party_screen == false and find_offset_running == false then

		if offset_found == false then
			find_offset()
			last_check = current_time
			if offset_found == false then
				return nil
			end
		end

        local slot_changes = {}

        -- now for display
        if status==1 or status==2 then --status 1 or 2

            if print_ivs == 1 then
                print("")
            end

            party = {}

            for slot = 1, 6 do
                if status==1 then
                    start=pstats[game]+100*(slot-1)
                else
                    start=estats[game]+100*(substatus[2]-1)
                end
				--for offset = 100000, 300000 do
					old_start = 0x020244EC+100*(slot-1)
					--start = old_start + offset
					start = old_start + correct_offset
				--print(start)
					is_active_mon_in_battle = slot-1 == memory.readbyteunsigned(0x02023BCE)

					personality=mdword(start)
					trainerid=mdword(start+4)
					otid = mword(start+4)
					otsid = mword(start+6)

					is_shiny = bxr(otid, otsid, getbits(personality, 0, 16), getbits(personality, 16, 16)) < 8

					magicword=bxr(personality, trainerid)

					i=personality%24

					nicknameoffset=8
					nicknamelength=10
					growthoffset=(growthtbl[i+1]-1)*12
					attackoffset=(attacktbl[i+1]-1)*12
					effortoffset=(efforttbl[i+1]-1)*12
					miscoffset=(misctbl[i+1]-1)*12

					nicknamebytes=memory.readbyterange(start+nicknameoffset,nicknamelength)
					nickname=translateUsingCharacterTable(nicknamebytes)
					--if slot==1 and nickname=="AABBCC" then
					--	print(offset)
					--end
				--end


                growth1=bxr(mdword(start+32+growthoffset),magicword)
                growth2=bxr(mdword(start+32+growthoffset+4),magicword)
                growth3=bxr(mdword(start+32+growthoffset+8),magicword)

                attack1=bxr(mdword(start+32+attackoffset),magicword)
                attack2=bxr(mdword(start+32+attackoffset+4),magicword)
                attack3=bxr(mdword(start+32+attackoffset+8),magicword)

                effort1=bxr(mdword(start+32+effortoffset),magicword)
                effort2=bxr(mdword(start+32+effortoffset+4),magicword)
                effort3=bxr(mdword(start+32+effortoffset+8),magicword)

                misc1=bxr(mdword(start+32+miscoffset),magicword)
                misc2=bxr(mdword(start+32+miscoffset+4),magicword)
                misc3=bxr(mdword(start+32+miscoffset+8),magicword)

                location_met=getbits(misc1,8,8)
                level_met=getbits(misc1,16,6)

                cs=ah(growth1)+ah(growth2)+ah(growth3)+ah(attack1)+ah(attack2)+ah(attack3)
                +ah(effort1)+ah(effort2)+ah(effort3)+ah(misc1)+ah(misc2)+ah(misc3)

                cs=cs%65536

                species=getbits(growth1,0,16)
                -- print(string.format("0x%08x", personality))
                --is_female=get_is_female(species, personality % 256)

                hold_item = getbits(growth1,16,16)

                experience = growth2
                pokerus=getbits(misc1,0,8)
                caught_in_ball=getbits(misc1,16+11,3)

                ivs=misc2

                evs1=effort1
                evs2=effort2

                hpiv=getbits(ivs,0,5)
                atkiv=getbits(ivs,5,5)
                defiv=getbits(ivs,10,5)
                spdiv=getbits(ivs,15,5)
                spatkiv=getbits(ivs,20,5)
                spdefiv=getbits(ivs,25,5)
                is_egg=getbits(ivs,30,1)
                abilityOffset=getbits(ivs,31,1)
                iv_set = {
                    atk = atkiv,
                    def = defiv,
                    spatk = spatkiv,
                    spdef = spdefiv,
                    hp = hpiv,
                    spd = spdiv
                }

                hpev=getbits(evs1, 0, 8)
                atkev=getbits(evs1, 8, 8)
                defev=getbits(evs1, 16, 8)
                spdev=getbits(evs1, 24, 8)
                spatkev=getbits(evs2, 0, 8)
                spdefev=getbits(evs2, 8, 8)
                -- vba.print(getbits(evs2, 16, 8))
                -- vba.print(getbits(evs2, 24, 8))
                ev_set = {
                    atk = atkev,
                    def = defev,
                    spatk = spatkev,
                    spdef = spdefev,
                    hp = hpev,
                    spd = spdev
                }

                nature = personality%25
                natinc = math.floor(nature/5)
                natdec = nature%5

                friendship=getbits(growth3,8,8)

                hidpowtype = math.floor(((hpiv%2 + 2*(atkiv%2) + 4*(defiv%2) + 8*(spdiv%2) + 16*(spatkiv%2) + 32*(spdefiv%2))*15)/63)
                hidpowbase = math.floor((( getbits(hpiv,1,1) + 2*getbits(atkiv,1,1) + 4*getbits(defiv,1,1) + 8*getbits(spdiv,1,1) + 16*getbits(spatkiv,1,1) + 32*getbits(spdefiv,1,1))*40)/63 + 30)

                move1 = getbits(attack1,0,16)
                move2 = getbits(attack1,16,16)
                move3 = getbits(attack2,0,16)
                move4 = getbits(attack2,16,16)

                moveset = {}
                moveset["move1"] = {
                    name = movetbl[move1],
                    pp = getbits(attack3,0,8)
                }
                moveset["move2"] = {
                    name = movetbl[move2],
                    pp = getbits(attack3,8,8)
                }
                moveset["move3"] = {
                    name = movetbl[move3],
                    pp = getbits(attack3,16,8)
                }
                moveset["move4"] = {
                    name = movetbl[move4],
                    pp = getbits(attack3,24,8)
                }
                --print(species)
                speciesname=pokemontbl[species]
                if speciesname==nil then speciesname="none" end
                --print(speciesname)
				
				
				
				if alternate_species[pokedex_ids[speciesname]] ~= nil then --alt-form search
					if species >= 949 then
						for k,v in pairs(alternate_species[pokedex_ids[speciesname]]) do
							if species == v then
								alternateFormId = k end
						end
					else alternateFormId = 0
					end 
				else alternateFormId = 0
				end
				
				if alternateFormId == nil then alternateFormId = 0 end

				if alternate_forms[pokedex_ids[speciesname]] ~= nil then
					if species >= 949 then
						local form = alternateFormId
					--print (alternate_forms[pokedex_ids[speciesname]][form + 1])
						alternateForm = alternate_forms[pokedex_ids[speciesname]][form + 1] -- Lua is 1-indexed
					else alternateForm = ""
				    end
				else alternateForm = ""
				end
				
				
				if alternateForm == nil then alternateForm = "" end
	
				--print("formID " .. alternateFormId)
				--print("form " .. alternateForm)

                level=mbyte(start+84)
				--print ("speciesname" .. speciesname)
				--print ("species: " .. species)
				--print ("pdex id" .. pokedex_ids[speciesname])

                local speciesIdx = (species - 1) * 28
                local type1Idx = speciesIdx + 6
                local type2Idx = speciesIdx + 7
                local bulbasaurAddr = baseStats[game] - 28 
                local type1 = typeorder[mbyte(bulbasaurAddr + type1Idx)]
                local type2 = typeorder[mbyte(bulbasaurAddr + type2Idx)]
                if type1==nil then type1="none" end
                if type2==nil then type2="none" end

                status_condition=mbyte(start+80)

                status_set = {
                   slp = status_condition > 0 and status_condition < 8,
                   psn = status_condition == 8,
                   brn = status_condition == 16,
                   frz = status_condition == 32,
                   par = status_condition == 64,
                   bps = status_condition == 128
                }

                local abilityIdx = speciesIdx + 22 + abilityOffset
                local ability = mbyte(bulbasaurAddr + abilityIdx)


                -- vba.print(abilityIdx)
                -- vba.print(ability)

                if "none" ~= speciesname then
                    party_member = {
                        gen = 3
                    }
                    party_member["pid"] = personality
                    party_member["species"] = 0
                    party_member["speciesName"] = nil
                    party_member["held_item"] = hold_item
                    party_member["exp"] = experience
                    party_member["level"] = level
                    party_member["is_female"] = false
                    party_member["is_genderless"] = true
                    party_member["is_shiny"] = is_shiny
                    party_member["is_egg"] = is_egg
                    party_member["current_hp"] = current_hp
                    party_member["max_hp"] = max_hp
                    party_member["location_met"] = location_met
                    party_member["level_met"] = level_met
                    party_member["evs"] = ev_set
                    party_member["ivs"] = iv_set
                    party_member["pokerus"] = pokerus
                    party_member["status"] = status_set
                    party_member["friendship"] = friendship
                    party_member["pokeball"] = caught_in_ball
					party_member["alternate_form"] = alternateForm
					party_member["alternate_form_id"] = alternateFormID
                    --party_member["moves"] = moveset
                    --party_member["ability"] = abilities[ability + 1]
                    party_member["ability"] = ability
                    party_member["nature"] = naturename[nature+1]
                    party_member["hiddenpower"] = typeorder[hidpowtype+1]
                    --party_member["evsum"] = hpev + atkev + defev + spatkev + spdefev + spdev
                    party_member["type1"] = type1
                    party_member["type2"] = type2
                    party_member["move1"] = nil
                    party_member["move2"] = nil
                    party_member["move3"] = nil
                    party_member["move4"] = nil
                    party_member["is_active_in_battle"] = in_battle and is_active_mon_in_battle

                    party[slot] = party_member
                end
				
				
                current_hp=mword(start+86)
                max_hp=mword(start+88)
                hp = {
                    current = current_hp,
                    max = max_hp
                }
				--print(current_hp)
                -- vba.print(is_currently_in_battle)

                local last_state = last_party[slot]

                local current_state = Pokemon{
                    gen = 3,
                    pid = personality,
                    species = species ~= 0 and pokedex_ids[speciesname] or -1,
                    speciesName = speciesname,
                    nickname = nickname,
                    held_item = hold_item,
                    exp = experience,
                    level = level,
                    is_female = false, -- TODO
                    is_genderless = true, -- TODO
                    is_egg = is_egg,
                    is_shiny = is_shiny,
                    hp = hp,
                    location_met = location_met,
                    level_met = level_met,
                    evs = ev_set,
                    ivs = iv_set,
                    pokerus = pokerus,
                    status = status_set,
                    ability = ability,
                    nature = naturename[nature+1],
                    hiddenpower = typeorder[hidpowtype+1],
                    type1 = type1,
                    type2 = type2,
                    friendship = friendship,
                    pokeball = caught_in_ball,
					alternate_form_id = alternateFormId,
					alternate_form = alternateForm,
                    move1 = moveset["move1"],
                    move2 = moveset["move2"],
                    move3 = moveset["move3"],
                    move4 = moveset["move4"],
                    is_active_in_battle = in_battle and is_active_mon_in_battle,
                }

                local change = current_state ~= last_state

                if change then
                    -- print("Slot " .. slot .. " -> " .. tostring(current_state))

                    if current_state.pid ~= 0 then
                        pokemon = current_state
                    else
                        pokemon = Pokemon()
                    end
                    slot_changes[#slot_changes + 1] = { slot_id = slot, pokemon = pokemon }
                    last_party[slot] = current_state
                end

                if print_ivs == 1 then
                    if speciesname ~= "none" then
                        evsum = hpev + atkev + defev + spatkev + spdefev + spdev
                        print("Pokemon: " .. speciesname .. " IV(" .. hpiv .. "/" .. atkiv .. "/" .. defiv .. "/" .. spatkiv .. "/"
                        .. spdefiv .. "/" .. spdiv .. ") EV(" .. hpev .. "/" .. atkev .. "/" .. defev .. "/" .. spatkev .. "/"
                        .. spdefev .. "/" .. spdev .. ") " .. evsum .. "/508")
                    end
                end

                --print("slot " .. slot .. " " .. speciesname)
            end -- for loop slots

            if #slot_changes > 0 then
                send_slots(slot_changes, gen, game, subgame)
            end

            if (last_check == 0) then
                print("================")
                print("DO NOT CLOSE THIS LUA SCRIPT WINDOW")
                print("You can minimize it, but do not close it, doing so will stop the emulator sending updates to Pokelink")
                print("================")
            end

            last_check = current_time
            if print_ivs == 1 then
                print("")
            end
            print_ivs = 0
        end --status 1 or 2


    end
end

--*********
gui.register(fn)
