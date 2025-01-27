----------------------------------------
local function generate(length, villages, castle, iterations, size, players, island)
	----------------------------------------
	local res = wct_generator_settings_arguments( length, villages, castle, iterations, size, players, island)
	res.max_lakes=30
	res.min_lake_height=170
	res.lake_size=75
	res.river_frequency=80
	res.temperature_size=9
	res.road_cost=11
	res.road_windiness=8

	res.height = {
		dr_height(990, "Qxu"),
		dr_height(960, "Uu"),
		dr_height(900, "Uh"),
		dr_height(825, "Uu"),
		dr_height(775, "Xu"),
		dr_height(750, "Mm^Xm"),
		dr_height(720, "Mm"),
		dr_height(670, "Hhd"),
		dr_height(650, "Hh^Fp"),
		dr_height(630, "Hhd^Uf"),
		dr_height(610, "Gll^Fp"),
		dr_height(590, "Gll^Uf"),
		dr_height(580, "Hhd"),
		dr_height(400, "Gll"),
		dr_height(395, "Hh"),
		dr_height(360, "Ss"),
		dr_height(340, "Gll^Ftr"),
		dr_height(330, "Hh"),
		dr_height(320, "Hh^Uf"),
		dr_height(300, "Hh^Fp"),
		dr_height(280, "Ss"),
		dr_height(270, "Hh"),
		dr_height(250, "Gll^Fp"),
		dr_height(225, "Gll^Uf"),
		dr_height(175, "Gll"),
		dr_height(70, "Ds"),
		dr_height(65, "Wwrt"),
		dr_height(35, "Wwt"),
		dr_height(30, "Wwrt"),
		dr_height(1, "Wwt"),
		dr_height(0, "Wot"),
	}
	res.convert = {
		wct_fix_river_into_ocean("t", 65),
		
		-- DR_CONVERT MIN_HT MAX_HT MIN_TMP MAX_TMP FROM TO
		dr_convert(360, 999, 10, 400, "Ww", "Ai"),
		dr_convert(475, 750, 10, 415, "Gll^Fp", "Aa^Fpa"),
		dr_convert(450, 750, 10, 425, "Gll", "Aa"),
		dr_convert(410, 750, 10, 465, "Gll,Gll^Uf", "Gd"),
		dr_convert(650, 750, 10, 540, "Hh,Hhd", "Ha"),
		dr_convert(650, 750, 10, 510, "Hh^Fp", "Ha^Fpa"),
		dr_convert(650, 750, 10, 415, "Hh^Uf,Hhd^Uf", "Ha^Uf"),
		dr_convert(375, 750, 10, 390, "Ss", "Ai"),
		dr_convert(450, 750, 650, 675, "Gll", "Gll^Fet"),
		dr_convert(100, 300, 800, 850, "Gll", "Gll^Em"),
		dr_convert(400, 750, 680, 700, "Gll", "Gll^Efm"),
		dr_convert(475, 505, 725, 750, "Gll", "Ce"),
		dr_convert(585, 595, 10, 440, "Aa,Gll^Uf", "Ms"),
		dr_convert(575, 585, 10, 440, "Aa", "Ha"),
		dr_convert(475, 600, 870, 900, "Gll,Gll^Uf", "Ql"),
		
		-- DR_TEMPERATURE FROM MIN MAX TO),
		dr_temperature("Mm", 10, 570, "Ms"),
		dr_temperature("Mm^Xm", 10, 585, "Ms^Xm"),
		dr_temperature("Ds", 870, 900, "Ds^Edpp"),
		dr_temperature("Uu", 100, 300, "Ai"),
		dr_temperature("Uu", 650, 700, "Uu^Uf"),
		dr_temperature("Uh", 675, 725, "Uh^Uf"),
		dr_temperature("(Uu,Uh,Uu^Uf)", 850, 999, "Ql"),
		dr_temperature("Qxu", 800, 999, "Ql"),
	}
	res.road_cost = {
		dr_road("Gll", "Rb", 10),
		dr_road("Ce", "Rb", 20),
		dr_road("Gll^Fp", "Rb", 20),
		dr_road("Gll^Ftr", "Rb", 25),
		dr_road("Gll^Fet", "Rb", 15),
		dr_road("Ds", "Rb", 40),
		dr_road("Ww", "Wwf", 50),
		dr_road("Gll^Uf", "Rb", 15),
		dr_road("Hh^Uf", "Rb", 15),
		dr_road("Hhd^Uf", "Rb", 15),
		dr_road("Ss", "Rb", 15),
		dr_road("Aa", "Rb", 10),
		dr_road("Hh", "Rb", 20),
		dr_road("Hhd", "Rb", 20),
		dr_road("Hh^Fp", "Rb", 25),
		dr_road("Ha", "Rb", 25),
		dr_road("Ha^Fpa", "Rb", 30),
		dr_road("Mm", "Rb", 50),
		dr_road("Ms", "Rb", 55),
		dr_bridge("Ql", "Ql^Bsb", "Cud", 45),
		dr_road("Uu", "Rb", 35),
		dr_road("Uu^Uf", "Rb", 40),
		dr_road("Uh", "Rb", 45),
		dr_road("Xu", "Rb", 60),
		dr_road("Rb", "Rb", 2),
		dr_road_over_bridges("Ql^Bsb", 2),
	}
	res.village = {
		dr_village {
			terrain="q",
			convert_to="Gll^Vh",
			rating=5,
			adjacent_liked="Gll, Ce, Ww, Ww, Ww, Ww, Ww, Wwt, Wwf, Wwf, Rb, Rb, Rb, Rb, Gll, Gll, Hh, Gll^Fp",
		},
		dr_village {
			terrain="q",
			convert_to="Gd^Vc",
			rating=5,
			adjacent_liked="Gll, Gll^Fet, Ww, Ww, Ww, Ww, Wwt, Wwf, Wwf, Rb, Rb, Ce, Gd, Gd, Gll, Hh, Hh^Fp, Gll^Fp",
		},
		dr_village {
			terrain="q",
			convert_to="Gll^Ve",
			rating=5,
			adjacent_liked="Gll, Gll^Fet, Ww, Ww, Ww, Ww, Ww, Wwt, Wwf, Wwf, Rb, Rb, Rb, Ce, Gd, Gll, Hh, Hh^Fp, Gll^Fp",
		},
		dr_village {
			terrain="q",
			convert_to="Gll^Ve",
			rating=7,
			adjacent_liked="Gll, Gll^Fet, Ww, Ww, Ww, Ww, Ww, Wwt, Wwf, Wwf, Rb, Rb, Rb, Ce, Gd, Gll, Hh, Hh^Fp, Gll^Fp, Gll^Fp, Gll^Fet, Gll^Fet",
		},
		dr_village {
			terrain="q",
			convert_to="Ds^Vda",
			rating=4,
			adjacent_liked="Gll, Gll, Wwt, Wwt, Wwt, Wwt, Wwt, Rb, Rb, Rb, Rb, Gll, Gll, Hh, Hh^Fp, Gll^Fp, Gll^Fet, Ds",
		},
		dr_village {
			terrain="q",
			convert_to="Uu^Vo",
			rating=4,
			adjacent_liked="Ai,Hh,Mm,Uu,Uh,Uu^Uf,Xu,Rb",
		},
		dr_village {
			terrain="q",
			convert_to="Uh^Vud",
			rating=3,
			adjacent_liked="Ai,Hh,Mm,Uu,Uh,Uu^Uf,Xu,Rb",
		},
		dr_village {
			terrain="q",
			convert_to="Hh^Vhh",
			rating=4,
			adjacent_liked="Gll, Gll^Fet, Ww, Ww, Ww, Ww, Ww, Wwt, Wwf, Wwf, Rb, Rb, Rb, Ce, Gd, Gll, Hh, Hh^Fp, Gll^Fp, Gll^Fp, Gll^Fet, Gll^Fet",
		},
		dr_village {
			terrain="q",
			convert_to="Hh^Vhh",
			rating=4,
			adjacent_liked="Gll, Gll^Fet, Ww, Ww, Ww, Ww, Ww, Ww, Wwf, Wwf, Rb, Rb, Rb, Ce, Gd, Gll, Hhd, Hh^Fp, Gll^Fp, Gll^Fp, Gll^Fet, Gll^Fet",
		},
		dr_village {
			terrain="q",
			convert_to="Mm^Vhh",
			rating=3,
			adjacent_liked="Gll, Gll^Fet, Mm, Mm^Xm, Ms, Ha, Ha^Fpa, Ww, Wwf, Wwf, Rb, Rb, Ce, Gd, Gd, Gll, Hh, Hh^Fp, Gll^Fp, Gll^Fp, Gll^Fet, Gll^Fet",
		},
		-- villages in snow
		dr_village {
			terrain="q",
			convert_to="Aa^Vha",
			rating=3,
			adjacent_liked="Gll, Gll^Fet, Aa, Ai, Ha, Mm, Ms, Ww, Wwf, Wwf, Rb, Rb, Ce, Gd, Gd, Gll, Hh, Hh^Fp, Gll^Fp",
		},
		dr_village {
			terrain="q",
			convert_to="Aa^Vea",
			rating=3,
			adjacent_liked="Gll, Gll^Fet, Aa, Ai, Ha, Mm, Ms, Ww, Wwf, Wwf, Rb, Rb, Ce, Gd, Gd, Gll, Hh, Hh^Fp, Gll^Fp",
		},
		dr_village {
			terrain="q",
			convert_to="Ha^Vhha",
			rating=2,
			adjacent_liked="Gll, Gll^Fet, Aa, Ai, Ha, Mm, Ms, Ww, Wwf, Wwf, Rb, Rb, Ce, Gd, Gd, Gll, Hh, Hh^Fp, Gll^Fp",
		},
		dr_village {
			terrain="q",
			convert_to="Ms^Vhha",
			rating=1,
			adjacent_liked="Gll, Gll^Fet, Aa, Ai, Ha, Mm, Ms, Ww, Wwf, Wwf, Rb, Rb, Ce, Gd, Gd, Gll, Hh, Hh^Fp, Gll^Fp",
		},
		dr_village {
			terrain="q",
			convert_to="Ss^Vhs",
			rating=3,
			adjacent_liked="Gll, Ss, Ce, Ww, Ww, Ww, Ww, Wwt, Wwf, Wwf, Rb, Rb, Rb, Rb, Gll, Gll, Hh, Gll^Fp",
		},
		dr_village {
			terrain="q",
			convert_to="Ww^Vm",
			rating=1,
			adjacent_liked="Ww, Ww",
		},
	}
	res.castle = { 
		valid_terrain="Gll, Gd, Hh, Gll^Ft, Gll^Efm, Gll^Fet, Gll^Ftr, Ss, Ai, Gll^Uf, Hh^Uf, Hh^Fp, Aa, Ha, Ha^Fpa, Mm, Ms",
		min_distance=13,
	}
	
	return default_generate_map(res)
end
return generate
