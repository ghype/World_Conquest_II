-- Springs

function world_conquest_tek_map_postgeneration_2a()
	world_conquest_tek_map_noise_classic("Gs^Fp")
	world_conquest_tek_enemy_army_event()
	world_conquest_tek_map_repaint_2a()
	world_conquest_tek_bonus_points()
	wct_map_2a_post_bunus_decoration()
	wct_map_enemy_themed("undead", "Soulless", "ha", "Aa^Vha", 12)
end

function world_conquest_tek_map_repaint_2a()
	world_conquest_tek_map_rebuild("Uu,Uu^Uf,Uh,Uu^Uf,Uu,Uh,Ql,Qxu,Xu,Ww,Ww", 3)
	world_conquest_tek_map_decoration_2a()
	world_conquest_tek_map_dirt("Gg^Uf,Gg^Uf,Gg^Uf,Gs^Uf")
end

function world_conquest_tek_map_decoration_2a()
	set_terrain { "Gs^Fms",
		f.all(
			f.terrain("Gs^Ft"),
			f.none(
				f.adjacent(f.terrain("Ss,Ds,Dd,Hd,Dd^Do,Ww,Wo"), nil, "2-6")
			)
		),
	}
	set_terrain { "Hh^Fms",
		f.terrain("Hh^Ft"),
	}
	
	-- chances of tropical palm forest near caves
	if wesnoth.random(2) == 1 then
		local terrain_to_change = get_locations(f.all(
			f.terrain("Hh*^F*"),
			f.adjacent(f.terrain("Xu,U*^*,Mv,Ql,Qxu"))
		))
		local r = wesnoth.random(0, #terrain_to_change - 3)
		for i = 1, r do
			local loc = terrain_to_change[wesnoth.random(#terrain_to_change)]
			map:set_terrain(loc, "Hh^Ftp")
		end
	end
	if wesnoth.random(2) == 1 then
		
		local terrain_to_change = get_locations(f.all(
			f.terrain("G*^F*"),
			f.adjacent(f.terrain("Xu,U*^*,Mv,Ql,Qxu"))
		))
		local r = wesnoth.random(0, #terrain_to_change - 3)
		for i = 1, r do
			local loc = terrain_to_change[wesnoth.random(#terrain_to_change)]
			map:set_terrain(loc, "Gs^Ftp")
		end
	end
	-- tropical forest near sand, swamp or water
	set_terrain { "Gs^Ftd",
		f.all(
			f.terrain("Gs^Fp"),
			f.adjacent(f.terrain("Ss,Ds,Dd,Hd,Dd^Do,Ww,Wo"), nil, "3-6"),
			f.adjacent(f.terrain("Aa,Aa^Fpa,Ha,Aa^Vea,Aa^Vha,Ms"), nil, 0)
		),
	}
	set_terrain { "Gg^Fds",
		f.all(
			f.terrain("Gs^Fp"),
			f.radius(2, f.all(
				f.terrain("Gg^Fet"),
				f.none(
					f.radius(3, f.terrain("Ds,Dd,Hd"))
				)
			))
		),
	}
	
	-- tropical forest near lava and water
	set_terrain { "Gs^Ft",
		f.all(
			f.terrain("Gs^Fp"),
			f.radius(3, f.terrain("Ql,Mv")),
			f.radius(3, f.terrain("Ww,Wo,Wwr"))
		),
	}
	set_terrain { "Hh^Ft",
		f.all(
			f.terrain("Hh^Fp"),
			f.radius(3, f.terrain("Ql,Mv")),
			f.radius(3, f.terrain("Ww,Wo,Wwr"))
		),
	}
	set_terrain { "Hh^Fds",
		f.all(
			f.terrain("Hh^Fp"),
			f.radius(2, f.all(
				f.terrain("Gg^Fet"),
				f.none(
					f.radius(1, f.terrain("Ds,Dd,Hd"))
				)
			))
		),
	}
	set_terrain { "Hh^Fds",
		f.all(
			f.terrain("Hh^Fp"),
			f.radius(2, f.all(
				f.terrain("Ql,Mv"),
				f.none(
					f.radius(1, f.terrain("Ds,Dd,Hd"))
				)
			))
		),
	}
	set_terrain { "Hh^Fds",
		f.all(
			f.terrain("Hh^Fp"),
			f.radius(3, f.all(
				f.terrain("Ql,Uu,Hu,Uu^Uf,Qxu,Mv"),
				f.none(
					f.radius(3, f.terrain("Ds,Dd,Hd"))
				)
			)),
			f.radius(3, f.terrain("Ww"))
		),
	}
	set_terrain { "Hh^Fms",
		f.all(
			f.terrain("Hh^Fp"),
			f.adjacent(f.terrain("Gg^Fds"))
		),
	}
	set_terrain { "Gg^Fms",
		f.all(
			f.terrain("Gg^Fds"),
			f.adjacent(f.terrain("Gs^Fp"))
		),
	}
	
	-- randomize a few forest
	set_terrain { "Gg^Fet,Gg^Fds,Gg^Fms,Gg^Fp,Gg^Fds,Gg^Fms,Gs^Fds,Gs^Ftp",
		f.terrain("G*^F*"),
		fraction = 11,
	}
	set_terrain { "Hh^Fds,Hh^Fms,Hh^Fp,Hh^Fds,Hh^Fms,Hh^Fds,Hh^Ftp",
		f.terrain("Hh*^F*"),
		fraction = 11,
	}
	
	-- fords
	
	local r = wesnoth.random(0, 4)
	for i = 1, r do
		set_terrain { "Wwf",
			f.all(
				f.terrain("Gg,Gs"),
				f.adjacent(f.terrain("Wwf,Ww*^*,Wwo")),
				f.adjacent(f.terrain("U*^*,M*^*,Xu"))
			),
		}
		
	end
	-- chances flowers
	local terrain_to_change = wct_store_possible_flowers("G*^Fet")
	while #terrain_to_change > 0 and wesnoth.random(10) ~= 1 do
		local loc = terrain_to_change[wesnoth.random(#terrain_to_change)]
		map:set_terrain(loc, Gg^Efm, "overlay")
		local terrain_to_change = wct_store_possible_flowers("G*^Fet")
	end
	-- extra coast
	set_terrain { "Ww,Ww,Ww,Wwr",
		f.all(
			f.terrain("Wo"),
			f.adjacent(f.terrain("Ds"))
		),
		fraction_rand = "10..12",
	}
	
	wct_map_reduce_castle_expanding_recruit("Ce", "Re")
	if wesnoth.random(5) ~= 1 then
		wct_map_decorative_docks()
	end
end

function wct_map_2a_post_bunus_decoration()
	wct_map_cave_path_to("Rb")
	wct_noise_snow_to("Wwf")
end
