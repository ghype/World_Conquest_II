_ = wesnoth.textdomain "wesnoth"
helper = wesnoth.require("helper")
utils = wesnoth.require("wml-utils")
functional = wesnoth.require("functional")
wesnoth.dofile("./utility.lua")
wesnoth.dofile("./pretty_print.lua")
wesnoth.dofile("./bonus_points.lua")
wesnoth.dofile("./wct_map_generator.lua")
wesnoth.dofile("./wml_lua_schema.lua")
wesnoth.dofile("./plot.lua")
wesnoth.dofile("./side_definitions.lua")


local n_villages = {27, 40, 53, 63}

function wc_ii_generate_scenario(nplayers)
	local scenario_num = wesnoth.get_variable("scenario") or 1
	local enemy_stength = wesnoth.get_variable("difficulty.enemy_power") or 6
	local scenario_data = wesnoth.dofile(string.format("./scenarios/WC_II_%dp_scenario%d.lua", nplayers, scenario_num))

	local prestart_event = { name = "prestart" }
	local scenario = {
		event = {
			prestart_event
		},
		lua = {
			{
				code = "",
			},
		},
		load_resource = {
			{
				id = "wc2_era_res"
			},
			{
				id = "wc2_scenario_res"
			},
			{
				id = "wc2_campaign_start"
			},
		},
		options = {
			wml.tag.checkbox {
				id="wc2_config_enable_pya",
				default=true,
				name="Enable advancement mod",
				description="enables the buildin mod to preselect what unit will advance into, disable this to be compatible with other mods that do the same thing",
			},
			wml.tag.checkbox {
				id="wc2_config_enable_unitmarker",
				default=true,
				name="Enable unitmarker",
				description="enables the buildin mod to mark units, disable this to be compatible with other mods that do the same thing",
			},
		},
		variables = {
			scenario = scenario_num,
			players = nplayers,
			carryover = 0,
			wml.tag.wct {
				versions = "1.9"
			}
		},
		side = {},
		id = "WC_II_" .. nplayers .. "p",
		next_scenario = "WC_II_" .. nplayers .. "p",
		name = "WC_II_" .. nplayers .. "p_name",
		description = "WC_II_" .. nplayers .. "p_desc",
		modify_placing = false,
		-- does this work
		turns = scenario_data.turns,
		experience_modifier = 80,
		victory_when_enemies_defeated = true,
		carryover_percentage = 0,
		carryover_report = false,
		carryover_add = false,
		force_lock_settings = true,
		--{DEFAULT_SCHEDULE}
		--{DEFAULT_MUSIC_PLAYLIST}
	}
	-- sides
	local enemy_data = scenario_data.get_enemy_data(enemy_stength)
	wc_ii_generate_sides(scenario, prestart_event, nplayers, scenario_num, enemy_stength, enemy_data, scenario_data)
	-- plot
	add_plot(scenario, scenario_num, nplayers)

	local enemy_army = nil
	if wesnoth.get_variable("enemy_army.length") == 0 or wesnoth.get_variable("enemy_army.length") == nil then
		enemy_army = wesnoth.dofile("./enemy_data.lua")
		table.insert(scenario.variables, wml.tag.enemy_army (lon_to_wml(enemy_army, "wct_enemy")))
	else
		std_print("enemy_army.length:", type(wesnoth.get_variable("enemy_army.length")))
		enemy_army = wml_to_lon(wesnoth.get_variable("enemy_army[0]"), "wct_enemy")
	end
	-- todo check in campaign,aon,lua so that we dont do this fase.
	if scenario_num < #n_villages then
		table.insert(scenario.event, {
			name = "victory",
			wml.tag.wc2_store_carryover {
				nvillages = n_villages[scenario_num] + 2 * nplayers,
				wml.tag.sides {
					side="1,2,3",
					wml.tag.has_unit {
					}
				}
			}
		})
	end
	if scenario_num ~= 1 then
		--todo: maybe move this into here
		table.insert(scenario.event, {
			name = "start",
			wml.tag.gold {
				amount = "$($carryover+$difficulty.extra_gold)",
				side="1,2,3",
				wml.tag.has_unit {
				}
			},
			wml.tag.clear_variable {
				name = "carryover"
			}
		})
	end
	for side_num = 1, nplayers do
		--todo: maybe move this into here
		table.insert(scenario.event, {
			name = "recruit,recall",
			wml.tag.filter {
				side = side_num
			},
			wml.tag.wc2_invest {
			}
		})
	end

	local generator = scenario_data.generators[wesnoth.random(#scenario_data.generators)]	
	generator(scenario)
	--std_print(debug_wml(scenario))
	local res = lon_to_wml(scenario, "scenario")
	std_print(debug_wml(res))
	return res
end


		