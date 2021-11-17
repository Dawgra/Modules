-- @Dogutsune, 2021

------------------------------------------------------

-- List of all the catalog emotes.
local EmoteList = {
	-- 19/10/2021
	["Panini Dance - Lil Nas X (LNX)"] = {5915781665}, ["Dancin' Shoes - Twenty One Pilots"] = {7405123844}, ["Tantrum"] = {5104374556}, ["Around Town"] = {3576747102}, 
	["Keeping Time"] = {4646306072}, ["Saturday Dance - Twenty One Pilots"] = {7422833723}, ["Robot"] = {3576721660}, ["Top Rock"] = {3570535774}, 
	["Idol"] = {4102317848}, ["Drum Master - Royal Blood"] = {6531538868}, ["Fancy Feet"] = {3934988903}, ["Fishing"] = {3994129128}, 
	["Drum Solo - Royal Blood"] = {6532844183}, ["Get Out"] = {3934984583}, ["Jacks"] = {3570649048}, ["Air Dance"] = {4646302011}, 
	["Swish"] = {3821527813}, ["Rock Guitar - Royal Blood"] = {6532155086}, ["Swan Dance"] = {7466048475}, ["Y"] = {4391211308}, 
	["Rock Star - Royal Blood"] = {6533100850}, ["Drummer Moves - Twenty One Pilots"] = {7422838770}, ["Up and Down - Twenty One Pilots"] = {7422843994}, ["Louder"] = {3576751796}, 
	["Sneaky"] = {3576754235}, ["HOLIDAY Dance - Lil Nas X (LNX)"] = {5938396308}, ["Shuffle"] = {4391208058}, ["Confused"] = {4940592718}, 
	["Break Dance"] = {5915773992}, ["Dolphin Dance"] = {5938365243}, ["Fast Hands"] = {4272351660}, ["Twirl"] = {3716633898}, 
	["Boxing Punch - KSI"] = {7202896732}, ["Take Me Under - Zara Larsson"] = {6797938823}, ["Fashionable"] = {3576745472}, ["Sad"] = {4849502101}, 
	["Jumping Wave"] = {4940602656}, ["Greatest"] = {3762654854}, ["Block Partier"] = {6865011755}, ["Beckon"] = {5230615437}, 
	["Dizzy"] = {3934986896}, ["Rodeo Dance - Lil Nas X (LNX)"] = {5938397555}, ["Flowing Breeze"] = {7466047578}, ["Bodybuilder"] = {3994130516}, 
	["Tree"] = {4049634387}, ["Agree"] = {4849487550}, ["Disagree"] = {4849495710}, ["Zombie"] = {4212496830}, 
	["Rock On"] = {5915782672}, ["Jumping Cheer"] = {5895009708}, ["Power Blast"] = {4849497510}, ["It Ain't My Fault - Zara Larsson"] = {6797948622}, 
	["On The Outside - Twenty One Pilots"] = {7422841700}, ["Dorky Dance"] = {4212499637}, ["T"] = {3576719440}, ["Curtsy"] = {4646306583}, 
	["Monkey"] = {3716636630}, ["Happy"] = {4849499887}, ["Quiet Waves"] = {7466046574}, ["Sleep"] = {4689362868}, 
	["Floss Dance"] = {5917570207}, ["Shy"] = {3576717965}, ["High Wave"] = {5915776835}, ["Tilt"] = {3360692915}, 
	["Salute"] = {3360689775}, ["Godlike"] = {3823158750}, ["Applaud"] = {5915779043}, ["Bored"] = {5230661597}, 
	["Show Dem Wrists - KSI"] = {7202898984}, ["Hero Landing"] = {5104377791}, ["Cower"] = {4940597758}, ["Celebrate"] = {3994127840}, 
	["Baby Dance"] = {4272484885}, ["Samba"] = {6869813008}, ["Line Dance"] = {4049646104}, ["Haha"] = {4102315500}, 
	["Hips Poppin' - Zara Larsson"] = {6797919579}, ["Old Town Road Dance - Lil Nas X (LNX)"] = {5938394742}, ["Shrug"] = {3576968026}, ["Side to Side"] = {3762641826}, 
	["Point2"] = {3576823880}, ["Stadium"] = {3360686498}, ["Wake Up Call - KSI"] = {7202900159}, --["Cha Cha"] = {6865013133},
	["Ud'zal's Summoning"] = {3307604888}, ["Chicken Dance"] = {4849493309}, ["Sandwich Dance"] = {4390121879}, ["Borock's Rage"] = {3236848555},
	["Bunny Hop"] = {4646296016}, ["Superhero Reveal"] = {3696759798}, ["Hype Dance"] = {3696757129}, ["Heisman Pose"] = {3696763549}, 
	["Air Guitar"] = {3696761354}, ["Hello"] = {3576686446}, ["Country Line Dance - Lil Nas X (LNX)"] = {5915780563}, --["Cha-Cha"] = {3696764866},
	["Cobra Arms - Tai Verdes"] = {7942964447}, ["AOK - Tai Verdes"] = {7942960760}, ["Lasso Turn - Tai Verdes"] = {7942960760}, 
	-- Those items are using similar names, so there might be a name change incoming.
	["Cha Cha"] = {6865013133}, ["Cha-Cha"] = {3696764866},
}


-- Biggest ID from the list. It helps with finding recent additions.
local BiggestId = 0
local function GetBiggerId(ID)
	if BiggestId < ID[1] then
		BiggestId = ID[1]
	end
end
for name, ID in pairs (EmoteList) do
	GetBiggerId(ID)
end

------------------------------------------------------

local CatalogEmotes = {}

function CatalogEmotes:GetRecentID()
	return BiggestId
end

function CatalogEmotes:GetRecentList()
	return EmoteList
end

function CatalogEmotes:UpdateList(addList)
	local addedEmotes = 0
	if addList and typeof(addList) == "table" then
		for name, ID in pairs(addList) do
			if typeof(name) == "string" and typeof(ID) == "table" then
				GetBiggerId(ID)
				EmoteList[name] = ID
				addedEmotes += 1
			end
		end
	end
	return addedEmotes
end

return CatalogEmotes
