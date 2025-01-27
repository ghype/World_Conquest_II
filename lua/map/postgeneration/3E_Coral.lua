-- Coral

function world_conquest_tek_map_postgeneration_3e()
	world_conquest_tek_enemy_army_event()
	world_conquest_tek_map_repaint_3e()
	world_conquest_tek_bonus_points()
	wct_map_3e_post_bunus_decoration()
end

function world_conquest_tek_map_repaint_3e()
	set_terrain { "Ur",
		f.terrain("U*^Uf,U*"),
		fraction = 8,
	}
	
	wct_reduce_wall_clusters("Uu,Uu^Uf,Uh,Uu^Uf,Uu,Uh,Ur,Uu,Ur,Uu,Ur")
	set_terrain { "Xu",
		f.all(
			f.adjacent(f.terrain("U*^*")),
			f.terrain("Mm^Xm")
		),
	}
	set_terrain { "Gs",
		f.terrain("Wog"),
	}
	set_terrain { "Ds",
		f.terrain("Dd"),
	}
	set_terrain { "Hh^Ftp",
		f.terrain("Hh^Fp"),
	}
	set_terrain { "Gs^Vht",
		f.terrain("Gs^Vc"),
		fraction = 2,
	}
	set_terrain { "Ss",
		f.terrain("Gs"),
		fraction = 9,
	}
	set_terrain { "Gg",
		f.terrain("Hh,Hh^F*,Hh^Uf"),
		fraction = 4,
	}
	set_terrain { "Ds^Ftd",
		f.all(
			f.terrain("Ds"),
			f.adjacent(f.terrain("G*"))
		),
		fraction = 4,
	}
	set_terrain { "Gg",
		f.terrain("Mm"),
		fraction = 3,
	}
	set_terrain { "*^Ft",
		f.terrain("G*"),
		fraction = 4,
		layer = "overlay",
	}
	set_terrain { "Hh,Hh,Hh,Hh^Ftp,Mm",
		f.terrain("G*"),
		fraction = 5,
	}
	
	-- fix water due to bug in generator creating rivers
	set_terrain { "Wot",
		f.terrain("Ww"),
	}
	
end

function wct_map_3e_post_bunus_decoration()
	wct_map_cave_path_to("Re")
	set_terrain { "Wwt",
		f.all(
			f.adjacent(f.terrain("!,W*^*")),
			f.terrain("Wot")
		),
	}
	
end
