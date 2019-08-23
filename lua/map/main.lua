_ = wesnoth.textdomain "wesnoth"
helper = wesnoth.require("helper")
utils = wesnoth.require("wml-utils")
functional = wesnoth.require("functional")
wc2_convert = wesnoth.dofile("./../shared_utils/wml_converter.lua")
wesnoth.dofile("./utility.lua")
wesnoth.dofile("./../shared_utils/pretty_print.lua")
wesnoth.dofile("./scenario_utils/bonus_points.lua")
wesnoth.dofile("./wct_map_generator.lua")
wesnoth.dofile("./scenario_utils/plot.lua")
wesnoth.dofile("./scenario_utils/side_definitions.lua")
settings = globals.settings or {}

local n_villages = {27, 40, 53, 63}

function wc_ii_generate_scenario(nplayers, gen_args)
	nplayers = settings.nplayers or nplayers
	local scenario_extra = wml.get_child(gen_args, "scenario")
	local scenario_num = settings.scenario_num or wesnoth.get_variable("scenario") or 1
	local enemy_stength = wesnoth.get_variable("difficulty.enemy_power") or 6
	local scenario_data = wesnoth.dofile(string.format("./scenarios/WC_II_%dp_scenario%d.lua", nplayers, scenario_num))

	local prestart_event = { name = "prestart" }
	local scenario = {
		event = {
			prestart_event
		},
		lua = {
			-- TODO: what does this do?
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
				id = "wc2_scenario_res_extra"
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
				version = "0.8"
			}
		},
		side = {},
		id = "WC_II_" .. nplayers .. "p",
		next_scenario = "WC_II_" .. nplayers .. "p",
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
	}
	-- sides
	local enemy_data = scenario_data.get_enemy_data(enemy_stength)
	wc_ii_generate_sides(scenario, prestart_event, nplayers, scenario_num, enemy_stength, enemy_data, scenario_data)
	-- plot
	add_plot(scenario, scenario_num, nplayers)
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
	if globals.settings.default_id then
		generator = wct_map_generator(
			globals.settings.default_id,
			globals.settings.postgen_id,
			globals.settings.length,
			globals.settings.villages,
			globals.settings.castle,
			globals.settings.iterations,
			globals.settings.hill_size,
			globals.settings.ncastles,
			globals.settings.island
		)
	end
	generator(scenario, nplayers)

	-- set the correct name.
	if scenario_num == 1 then --first map
		scenario.name = "WC_II_" .. nplayers .. " - " .. _"Start"
	else
		local scenario_desc = _ "Scenario" .. scenario_num
		if scenario_num == 6 then
			scenario_desc = _"Final Battle"
		end
		scenario.name = "WC_II_" .. nplayers .. " " .. scenario_desc .. " - "--.. scenario.map_name
	end


	--std_print(debug_wml(scenario))
	local res = wc2_convert.lon_to_wml(scenario, "scenario")
	--std_print(debug_wml(res))
	for i, v in ipairs(scenario_extra) do
		--insert music and scedule tags.
		table.insert(res, v)
	end
	return res
end
