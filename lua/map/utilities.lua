## add subfolders
{~add-ons/World_Conquest_II/utils/map/generator}
{~add-ons/World_Conquest_II/utils/map/postgeneration}

#define WORLD_CONQUEST_TEK_MAP_EVENTS
	{WORLD_CONQUEST_TEK_MAP_ENEMY_THEMED}
	{WORLD_CONQUEST_TEK_MAP_POSTGENERATION_EVENTS}
	{WCT_MAP_SUPPLY_VILLAGE}
#enddef

#define WCT_MAP_SUPPLY_VILLAGE
	[event]
		name=wct_map_supply_village
		first_time_only=no
		[terrain]
			x=$unit.x
			y=$unit.y
			terrain=Kh^Vov
			layer=overlay
		[/terrain]
		[capture_village]
			x=$unit.x
			y=$unit.y
			side=$unit.side
		[/capture_village]
		[item]
			x=$unit.x
			y=$unit.y
			image=$images.supply[0].image
		[/item]
		[set_variables]
			mode=append
			name=images.supply
			to_variable=images.supply[0]
		[/set_variables]
		{CLEAR_VARIABLE images.supply[0]}
	[/event]
#enddef

#define WCT_MAP_FILTER_OCEANIC
	terrain=Wo*
	x=1
	radius=999
	[filter_radius]
		terrain=W*^V*,Wwr*,Ww,Wwg,Wwt,Wo*
		[filter_adjacent_location]
			terrain=!,W*^*,S*^*,D*^*,Ai
			count=0-3
		[/filter_adjacent_location]
	[/filter_radius]
	[or]
		terrain=Wo*
		y=1
		radius=999
		[filter_radius]
			terrain=W*^V*,Wwr*,Ww,Wwg,Wwt,Wo*
			[filter_adjacent_location]
				terrain=!,W*^*,S*^*,D*^*,Ai
				count=0-3
			[/filter_adjacent_location]
		[/filter_radius]
	[/or]
#enddef

#define WORLD_CONQUEST_TEK_MAP_DEFINITIONS PLAYERS
	[next_scenario]
		[map]
			id={STR_WCT_SCENARIO_ID {PLAYERS} 2 A}
		[/map]
		[map]
			id={STR_WCT_SCENARIO_ID {PLAYERS} 2 B}
		[/map]
		[map]
			id={STR_WCT_SCENARIO_ID {PLAYERS} 2 C}
		[/map]
		[map]
			id={STR_WCT_SCENARIO_ID {PLAYERS} 2 D}
		[/map]
		[map]
			id={STR_WCT_SCENARIO_ID {PLAYERS} 2 E}
		[/map]
		[map]
			id={STR_WCT_SCENARIO_ID {PLAYERS} 2 F}
		[/map]
	[/next_scenario]
	[next_scenario]
		[map]
			id={STR_WCT_SCENARIO_ID {PLAYERS} 3 A}
		[/map]
		[map]
			id={STR_WCT_SCENARIO_ID {PLAYERS} 3 B}
		[/map]
		[map]
			id={STR_WCT_SCENARIO_ID {PLAYERS} 3 C}
		[/map]
		[map]
			id={STR_WCT_SCENARIO_ID {PLAYERS} 3 D}
		[/map]
		[map]
			id={STR_WCT_SCENARIO_ID {PLAYERS} 3 E}
		[/map]
		[map]
			id={STR_WCT_SCENARIO_ID {PLAYERS} 3 F}
		[/map]
	[/next_scenario]
	[next_scenario]
		[map]
			id={STR_WCT_SCENARIO_ID {PLAYERS} 4 A}
		[/map]
		[map]
			id={STR_WCT_SCENARIO_ID {PLAYERS} 4 B}
		[/map]
		[map]
			id={STR_WCT_SCENARIO_ID {PLAYERS} 4 C}
		[/map]
		[map]
			id={STR_WCT_SCENARIO_ID {PLAYERS} 4 D}
		[/map]
		[map]
			id={STR_WCT_SCENARIO_ID {PLAYERS} 4 E}
		[/map]
		[map]
			id={STR_WCT_SCENARIO_ID {PLAYERS} 4 F}
		[/map]
	[/next_scenario]
	[next_scenario]
		[map]
			id={STR_WCT_SCENARIO_ID {PLAYERS} 6 A}
		[/map]
		[map]
			id={STR_WCT_SCENARIO_ID {PLAYERS} 6 B}
		[/map]
		[map]
			id={STR_WCT_SCENARIO_ID {PLAYERS} 6 C}
		[/map]
		[map]
			id={STR_WCT_SCENARIO_ID {PLAYERS} 6 D}
		[/map]
	[/next_scenario]
#enddef
