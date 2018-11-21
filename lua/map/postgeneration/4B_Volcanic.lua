-- Volcanic

function world_conquest_tek_map_postgeneration_4b()
	--[event]
	--	name=prestart
	--	world_conquest_tek_map_noise_classic("Gs^Fp")
	--	{WORLD_CONQUEST_TEK_ENEMY_ARMY_EVENT}
	--	{WORLD_CONQUEST_TEK_MAP_REPAINT_4B}
		world_conquest_tek_bonus_points("volcanic")
	--	{WCT_MAP_ENEMY_THEMED dwarf "Giant Mudcrawler" ud Ur^Vud 5}
	--[/event]
end

function world_conquest_tek_map_repaint_4b()
	set_terrain { "Ql,Md,Md^Xm",
		f.terrain("U*,U*^Uf"),
		exact = false,
		percentage = 10,
	}
	set_terrain { "Ql,Uu,Uh,Uh,Uu^Uf,Qxu,Uh^Uf",
		f.terrain("Xu"),
	}
	set_terrain { "Ql,Uu^Uf,Qxu,Uh^Uf,Uh,Uh,Uu,Ql,Md",
		f.terrain("Mm^Xm"),
		fraction = 2,
	}
	set_terrain { "Ql,Uu^Uf,Qxu,Uh^Uf",
		f.all(
			f.terrain("Hh^F*"),
			f.adjacent(f.terrain("Ql,Uu,Uh,Uu^Uf,Qxu,Uh^Uf"))
		),
		fraction = 3,
	}
	set_terrain { "Uh",
		f.all(
			f.terrain("Hh"),
			f.adjacent(f.terrain("Ql,Uu,Uh,Uu^Uf,Qxu,Uh^Uf,Ur"))
		),
		fraction = 3,
	}
	
	wct_fill_lava_chasms()
	set_terrain { "Uh",
		f.all(
			f.adjacent(f.terrain("Ql")),
			f.terrain("Hh*^*")
		),
		layer = "base",
	}
	set_terrain { "Ur",
		f.all(
			f.terrain("Re"),
			f.none(
				f.radius(999, f.terrain("Ch*^*,Kh*^*"), f.terrain("Re"))
			)
		),
	}
	
	{REPEAT_IT 3 obsidian_i (
		set_terrain { "Ur",
			f.all(
				f.adjacent(f.terrain("Ql,Uu^*,Qxu,Uh^*,Ur^*")),
				f.terrain("G*^*")
			),
			layer = "base",
		}
		
	)}
	{REPEAT_IT 2 scorched_i (
		set_terrain { "Rd",
			f.all(
				f.radius(2, f.terrain("Ql,Uu^*,Qxu,Uh^*,Ur^*,Rd")),
				f.terrain("G*^*")
			),
			layer = "base",
		}
		
	)}
	-- change villages
	set_terrain { "Ur^Vu",
		f.terrain("Ur^V*"),
	}
	set_terrain { "*^Vd",
		f.terrain("*^Vhh"),
		layer = "overlay",
	}
	set_terrain { "*^Vo",
		f.terrain("*^Ve"),
		layer = "overlay",
	}
	set_terrain { "Gd^Vc",
		f.terrain("G*^Vh"),
	}
	set_terrain { "*^Vh",
		f.terrain("*^Vht"),
		layer = "overlay",
	}
	set_terrain { "Rd^Vhh",
		f.terrain("Rd^Vh"),
	}
	set_terrain { "Ds^Vct",
		f.terrain("Dd^Vda"),
		fraction = 3,
	}
	
	if wesnoth.random(2) == 1 then
		set_terrain { "Ur^Vd",
			f.terrain("Ur^Vu"),
			fraction_rand = "2..3",
		}
		
	end
	if wesnoth.random(2) == 1 then
		set_terrain { "Rd^Vd",
			f.terrain("Rd^Vhh"),
			fraction_rand = "2..3",
		}
		
	end
	if wesnoth.random(2) == 1 then
		set_terrain { "Ds^Vd",
			f.terrain("D*^V*"),
			fraction_rand = "3..4",
		}
		
	end
	-- dry terrain
	set_terrain { "Sm",
		f.terrain("Ss^*"),
		layer = "base",
	}
	set_terrain { "Gd",
		f.terrain("G*^*"),
		layer = "base",
	}
	set_terrain { "Md",
		f.terrain("M*^*"),
		layer = "base",
	}
	set_terrain { "Hhd",
		f.terrain("Hh^*"),
		layer = "base",
	}
	set_terrain { "*^Fdw",
		f.all(
			f.terrain("U*^F*"),
			f.none(
				f.terrain("*^Fet")
			)
		),
		layer = "overlay",
	}
	set_terrain { "*^Fmw",
		f.all(
			f.terrain("Rd^F*"),
			f.none(
				f.terrain("Rd^Fet")
			)
		),
		layer = "overlay",
	}
	set_terrain { "*^Fetd",
		f.terrain("*^Fet"),
		layer = "overlay",
	}
	
	-- change some forest
	set_terrain { "Gd^Fdw,Gd^Fmw",
		f.terrain("G*^Ft"),
		fraction = 3,
	}
	set_terrain { "Gd^Fms,Gd^Fmw,Gd^Fet",
		f.terrain("G*^Ft"),
		fraction = 2,
	}
	set_terrain { "Hhd^Fdw,Hhd^Fmw",
		f.terrain("Hhd^Ft"),
		fraction = 3,
	}
	set_terrain { "Hhd^Fms,Hhd^Fmw",
		f.terrain("Hhd^Ft"),
		fraction = 2,
	}
	
	-- difumine dry/grass border
	set_terrain { "Rd",
		f.all(
			f.terrain("Gd"),
			f.adjacent(f.terrain("Rd"))
		),
		fraction = 3,
	}
	set_terrain { "Gd",
		f.all(
			f.terrain("Rd"),
			f.adjacent(f.terrain("Gd"))
		),
		fraction = 3,
	}
	
	-- create volcanos where possible and force one
	local terrain_to_change = get_locations(f.all(
		f.terrain("Ql"),
		f.adjacent(f.terrain("M*,M*^Xm"), "se,s,sw", 2),
		f.adjacent(f.terrain("K*^*,C*^*,*^V"), "se,s,sw", 0)
	))
	if #terrain_to_change > 0 then
		local loc = terrain_to_change[wesnoth.random(#terrain_to_change)]
		set_terrain { "Md^Xm",
			f.and(
				f.none(f.terrain("M*^*")),
				f.adjacent(f.is_loc(loc), "ne,n,nw")
			)
		}
	end
	set_terrain { "Mv",
		f.all(
			f.terrain("Ql"),
			f.adjacent(f.terrain("Md^Xm,Md"), "se,s,sw", 3)
		),
	}
	local terrain_to_change = get_locations(f.terrain("Mv"))
	
	for i, v in ipairs(terrain_to_change) do
		--[sound_source]
		--	id=volcano$i
		--	sounds=rumble.ogg
		--	delay=450000
		--	chance=1
		--	x,y=v
		--	full_range=5
		--	fade_range=5
		--	loop=0
		--[/sound_source]
	end
	-- some volcanic coast and reefs
	set_terrain { "Uue",
		f.all(
			f.terrain("Ww,Wo"),
			f.adjacent(f.terrain("S*^*"))
		),
		fraction = 2,
	}
	set_terrain { "Uue,Wwr",
		f.all(
			f.terrain("Ww,Wo"),
			f.adjacent(f.terrain("Uu*,Ur,Uh,D*^*"))
		),
		fraction_rand = "9..11",
	}
	set_terrain { "Uue",
		f.all(
			f.terrain("Ds"),
			f.adjacent(f.terrain("U*,S*^*,W*^*,Gd,Rd"))
		),
		fraction_rand = "9..11",
	}
	set_terrain { "Uue",
		f.all(
			f.terrain("Ds"),
			f.adjacent(f.terrain("U*"))
		),
		fraction_rand = "9..11",
	}
	
	-- rubble
	set_terrain { "Rd^Dr,Hhd^Dr",
		f.all(
			f.terrain("Hhd"),
			f.adjacent(f.terrain("Rd*^*")),
			f.radius(4, f.all(
			))
		),
		fraction_rand = "16..20",
	}
	set_terrain { "Ur^Dr,Hhd^Dr",
		f.all(
			f.terrain("Hhd"),
			f.adjacent(f.terrain("U*^*"))
		),
		fraction_rand = "10..15",
	}
	set_terrain { "Uu^Dr,Uh^Dr",
		f.terrain("Uh"),
		fraction_rand = "9..13",
	}
	
	-- mushrooms, base amount in map surface
	local terrain_to_change = get_locations(f.terrain("Hhd,Hhd^F^*"))
	helper.shuffle(terrain_to_change)
	local r = helper.rand(tostring(total_tiles // 600) .. ".." .. tostring(total_tiles // 300))
	
	for mush_i = 1, math.min(r, #terrain_to_change) do
		map:set_terrain(terrain_to_change[mush_i], "Hhd^Uf")
	end
	-- chances of few orcish castles
	wct_possible_map4_castle("Co", 2)
	-- craters
	set_terrain { "Dd^Dc",
		f.terrain("Dd"),
		fraction_rand = "4..6",
	}
	
	-- grass near muddy or earthy cave become dark dirt
	set_terrain { "Rb",
		f.all(
			f.adjacent(f.terrain("S*^*,Uue"), nil, "2-6"),
			f.terrain("G*^*")
		),
	}
	
	-- some small mushrooms on dark dirt
	set_terrain { "Rb^Em",
		f.terrain("Rb"),
		fraction_rand = "9..11",
	}
	
	-- some extra reefs
	set_terrain { "Wwr",
		f.all(
			f.terrain("Ww,Wo"),
			f.adjacent(f.terrain("Ds,Ww,Uu"))
		),
		fraction_rand = "18..22",
	}
	
	-- whirpools
	local terrain_to_change = get_locations(f.all(
		f.terrain("Ww"),
		f.adjacent(f.terrain("Wo")),
		f.adjacent(f.terrain("Uue"))
	))
	
	helper.shuffle(terrain_to_change)
	for i = 1, #terrain_to_change // wesnoth.random(4, 15) do
		--[item]
		--	x, y = terrain_to_change[i]
		--	image=scenery/whirlpool.png
		--[/item]
		--[sound_source]
		--	id=volcano$i
		--	sounds=mermen-hit.wav
		--	delay=90000
		--	chance=1
		--	x, y = terrain_to_change[i]
		--	full_range=5
		--	fade_range=5
		--	loop=0
		--[/sound_source]
	end
	-- dessert sand no near water or village
	set_terrain { "Dd",
		f.all(
			f.adjacent(f.terrain("W*^*,*^V*"), nil, 0),
			f.terrain("Ds")
		),
	}
	
	-- very dirt coast
	local terrain_to_change = get_locations(f.terrain("Ds"))
	
	helper.shuffle(terrain_to_change)
	for i = 1, #terrain_to_change // wesnoth.random(3, 4) do
		map:set_terrain(terrain_to_change[i], "Ds^Esd")
	end
	helper.shuffle(terrain_to_change)
	for i = 1, #terrain_to_change // 6 do
		map:set_terrain(terrain_to_change[i], "Ds^Es")
	end
	set_terrain { "Dd^Es",
		f.terrain("Dd"),
		fraction_rand = "4..6",
	}
	set_terrain { "Uue^Es",
		f.terrain("Uue"),
		fraction_rand = "2..3",
	}
	set_terrain { "Sm^Es",
		f.terrain("Sm"),
		fraction_rand = "4..6",
	}
	
	-- 1.12 new forest
	set_terrain { "*^Ft",
		f.terrain("*^Fp"),
		fraction_rand = "6..10",
		layer = "overlay",
	}
	set_terrain { "*^Ftd",
		f.terrain("H*^Ft"),
		layer = "overlay",
	}
	set_terrain { "*^Fts",
		f.terrain("*^Ft"),
		layer = "overlay",
	}
	set_terrain { "*^Fts",
		f.terrain("*^Fmw"),
		fraction_rand = "4..7",
		layer = "overlay",
	}
	set_terrain { "*^Ft",
		f.terrain("*^Fms"),
		fraction_rand = "2..4",
		layer = "overlay",
	}
	
	
	local r = wesnoth.random(20)
	if r == 1 then
		wct_change_map_water("g")
		elseif r == 2 then
		wct_change_map_water("t")
	end
	
end
