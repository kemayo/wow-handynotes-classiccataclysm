local myname, ns = ...

function ns.ImportSilverDragonData(SD_DATA)
	local POINTS = {}
	for npc, data in pairs(SD_DATA) do
		if data.locations then
			for mapID, coords in pairs(data.locations) do
				if not POINTS[mapID] then
					POINTS[mapID] = {}
				end
				for _, coord in ipairs(coords) do
					POINTS[mapID][coord] = {
						-- label=data.name,
						npc=npc,
						loot=data.loot,
						requires=data.requires,
						quest=data.quest,
						vignette=data.vignette,
						note=data.notes,
						routes=data.routes and data.routes[mapID]
					}
					if data.faction then
						-- SilverDragon has the faction of the rare, but this needs the faction of the player
						POINTS[mapID][coord].faction = data.faction == "Alliance" and "Horde" or "Alliance"
					end
				end
			end
		end
	end
	for mapID, data in pairs(POINTS) do
		ns.RegisterPoints(mapID, data)
	end
end
