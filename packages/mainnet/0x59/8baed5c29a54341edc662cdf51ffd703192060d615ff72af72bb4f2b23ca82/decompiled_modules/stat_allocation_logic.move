module 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::stat_allocation_logic {
    public(friend) fun allocate_stat_points_character(arg0: &mut 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::Character, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::progression::stats_stat_points(0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::stats(arg0));
        let v1 = arg1 + arg2 + arg3 + arg4;
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::errors::assert_sufficient_stat_points(v0 >= v1);
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::errors::assert_valid_stat_allocation(validate_stat_allocation(v0, arg1, arg2, arg3, arg4));
        let v2 = 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::stats(arg0);
        let v3 = 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::progression::stats_agility(v2);
        let v4 = 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::progression::stats_endurance(v2);
        let v5 = 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::progression::stats_stealth(v2);
        let v6 = 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::progression::stats_luck(v2);
        let v7 = 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::stats_mut(arg0);
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::progression::set_stats_stat_points(v7, v0 - v1);
        *0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::progression::stats_agility_mut(v7) = v3 + arg1;
        *0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::progression::stats_endurance_mut(v7) = v4 + arg2;
        *0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::progression::stats_stealth_mut(v7) = v5 + arg3;
        *0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::progression::stats_luck_mut(v7) = v6 + arg4;
        if (arg2 > 0) {
            let v8 = 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::total_stats::calculate_total_stats(arg0);
            0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::stamina_logic::update_max_stamina(0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::stamina_mut(arg0), 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::total_stats::total_endurance(&v8));
        };
    }

    public(friend) fun reset_all_stats(arg0: &mut 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::Character) : u64 {
        let v0 = 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::stats(arg0);
        let v1 = 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::progression::stats_level(v0);
        let v2 = 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::progression::stats_agility(v0) + 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::progression::stats_endurance(v0) + 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::progression::stats_stealth(v0) + 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::progression::stats_luck(v0);
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::errors::assert_has_stats_to_reset(v2 > 0);
        let v3 = 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::stats_mut(arg0);
        *0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::progression::stats_agility_mut(v3) = 0;
        *0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::progression::stats_endurance_mut(v3) = 0;
        *0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::progression::stats_stealth_mut(v3) = 0;
        *0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::progression::stats_luck_mut(v3) = 0;
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::progression::set_stats_stat_points(v3, (v1 - 1) * 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::constants::stat_points_per_level());
        let v4 = 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::total_stats::calculate_total_stats(arg0);
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::stamina_logic::update_max_stamina(0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::stamina_mut(arg0), 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::total_stats::total_endurance(&v4));
        v2
    }

    public(friend) fun validate_stat_allocation(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : bool {
        arg1 + arg2 + arg3 + arg4 <= arg0
    }

    // decompiled from Move bytecode v6
}

