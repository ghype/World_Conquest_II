#define WORLD_CONQUEST_TEK_MAP_DESTRUCTION
	## decorative change of terrain look, with no game effect, upon unit dead on some terrains
	[event]
		name=die
		first_time_only=no
		[filter_condition]
			[variable]
				name="wc2_config_enable_terrain_destruction"
				not_equals="false"
			[/variable]
		[/filter_condition]
		[filter]
			[filter_location]
				terrain=K*^*,C*^*,*^Fet,G*^F*,G*^Uf,A*,*^Effy,*^B*,Rrc,Iwr,*^Vhh,*^Vy*,*^Vz*,*^Fz*
			[/filter_location]
		[/filter]
		[store_locations]
			x,y=$x1,$y1
			variable=death_point
		[/store_locations]
		## too many terrain filters can be slow, use switch to avoid visual delay
		[switch]
			variable=death_point.terrain
			[case]
				value=Kh,Kha,Kh^Vov,Kha^Vov
				[terrain]
					x,y=$x1,$y1
					terrain=Khr
					layer=base
				[/terrain]
			[/case]
			[case]
				value=Ch,Cha
				[terrain]
					x,y=$x1,$y1
					terrain=Chr^Es
				[/terrain]
			[/case]
			[case]
				## only without custom activated
				value=Ch^Vh,Ch^Vhc
				[terrain]
					x,y=$x1,$y1
					terrain=Chr
					layer=base
				[/terrain]
			[/case]
			[case]
				value=Cd
				[terrain]
					x,y=$x1,$y1
					terrain=Cdr^Es
				[/terrain]
			[/case]
			[case]
				value=Cd^Vd
				[terrain]
					x,y=$x1,$y1
					terrain=Cdr
					layer=base
				[/terrain]
			[/case]
			[case]
				value=Kd
				[terrain]
					x,y=$x1,$y1
					terrain=Kdr^Es
				[/terrain]
			[/case]
			[case]
				value= Gg^Fmf,Gg^Fdf,Gg^Fp,Gg^Uf,Gs^Fmf,Gs^Fdf,Gs^Fp,Gs^Uf
				[terrain]
					x,y=$x1,$y1
					terrain=Gll
					layer=base
				[/terrain]
			[/case]
			[case]
				value=Cv^Fds
				[terrain]
					x,y=$x1,$y1
					terrain=Cv^Fdw
				[/terrain]
			[/case]
			[case]
				value=Rr^Fet,Cv^Fet
				[terrain]
					x,y=$x1,$y1
					terrain=Rr^Fetd
					layer=overlay
				[/terrain]
			[/case]
			[case]
				value=Aa
				{RANDOM_INDEX images.snow}
				[item]
					z_order = -1
					x,y=$x1,$y1
					image=$images.snow[$random].image
				[/item]
			[/case]
			[case]
				value=Ai
				{RANDOM_INDEX images.ice}
				[item]
					x,y=$x1,$y1
					z_order = -1
					image=$images.ice[$random].image
				[/item]
			[/case]
			[case]
				value=Gg^Effy,Gs^Effy,Gd^Effy,Gll^Effy
				[terrain]
					x,y=$x1,$y1
					terrain=*^Effz
					layer=overlay
				[/terrain]
			[/case]
			[case]
				value= Ww^Bsb|,Ww^Bsb/,Ww^Bsb\,Wwt^Bsb|,Wwt^Bsb/,Wwt^Bsb\,Wwg^Bsb|,Wwg^Bsb/,Wwg^Bsb
				[terrain]
					x,y=$x1,$y1
					terrain=Wwf^Edt
				[/terrain]
				[sound]
					name=water-blast.wav
				[/sound]
				[item]
					x,y=$x1,$y1
					z_order = -1
					image=scenery/castle-ruins.png
				[/item]
			[/case]
			[case]
				value=Rrc
				[if]
					[variable]
						name=bonus.theme
						equals=paradise
					[/variable]
					[then]
						[remove_item]
							x,y=$x1,$y1
							image={IMG_CITADEL_LEANTO}
						[/remove_item]
						[item]
							x,y=$x1,$y1
							##todo: this is currently broken fix it by drawing this image _under_ the artifact
							[not]
								find_in=items.point
							[/not]
							image=scenery/trash.png
						[/item]
						[terrain]
							x,y=$x1,$y1
							terrain=Rrc^Edt
						[/terrain]
					[/then]
				[/if]
			[/case]
			[case]
				value=Iwr
				[remove_item]
					x,y=$x1,$y1
					##todo: this is currently broken
					[not]
						find_in=items.point
					[/not]
				[/remove_item]
				[item]
					x,y=$x1,$y1
					##todo: this is currently broken fix it by drawing this image _under_ the artifact

					[not]
						find_in=items.point
					[/not]
					image=scenery/trash.png
				[/item]
				[terrain]
					x,y=$x1,$y1
					terrain=Iwr^Edt
				[/terrain]
			[/case]
			[else]
				[if]
					[have_location]
						x,y=$x1,$y1
						terrain=*^Vy*,*^Vz*,*^Fz*
					[/have_location]
					[then]
						{WCT_MAP_CUSTOM_RUIN_VILLAGE $x1 $y1}
						[terrain]
							x,y=$x1,$y1
							[and]
								terrain=Ch^V*
							[/and]
							terrain=Chr
							layer=base
						[/terrain]
						{WCT_MAP_CUSTOM_UNSNOW_FOREST death_point}
					[/then]
					[else]
						[terrain]
							x,y=$x1,$y1
							[and]
								terrain=*^Vhh,*^Vhha
							[/and]
							terrain=*^Vhhr
							layer=overlay
						[/terrain]
						[terrain]
							x,y=$x1,$y1
							[and]
								terrain=*^Bw|,*^Bw/,*^Bw\
							[/and]
							terrain=$death_point.terrain|r
						[/terrain]
					[/else]
				[/if]
			[/else]
		[/switch]
		{CLEAR_VARIABLE death_point}
	[/event]
#enddef
