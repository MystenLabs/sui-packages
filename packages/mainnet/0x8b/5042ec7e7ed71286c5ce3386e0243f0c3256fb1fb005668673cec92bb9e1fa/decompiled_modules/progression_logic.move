module 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression_logic {
    public fun activate_newbie_buff(arg0: &mut 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::character_data::Character, arg1: &0x2::clock::Clock) {
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::character_data::set_newbie_buff_end_time(arg0, 0x2::clock::timestamp_ms(arg1) + 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::newbie_buff_duration_ms());
    }

    public fun add_wanted_level_with_stealth_and_rarity(arg0: &mut 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::WantedLevel, arg1: u64, arg2: u64) {
        let v0 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::wanted_level(arg0) + 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::stat_effects::stealth_wanted_gain(arg1) + calculate_rarity_wanted_bonus(arg2) * (10000 - 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::stat_effects::stealth_rarity_reduction(arg1)) / 10000;
        let v1 = if (v0 > 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::max_wanted_level()) {
            0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::max_wanted_level()
        } else {
            v0
        };
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::set_wanted_level(arg0, v1);
    }

    public fun allocate_stat_points_character(arg0: &mut 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::character_data::Character, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::stats_stat_points(0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::character_data::stats(arg0));
        let v1 = arg1 + arg2 + arg3 + arg4;
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::errors::assert_sufficient_stat_points(v0 >= v1);
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::errors::assert_valid_stat_allocation(validate_stat_allocation(v0, arg1, arg2, arg3, arg4));
        let v2 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::character_data::stats(arg0);
        let v3 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::stats_agility(v2);
        let v4 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::stats_endurance(v2);
        let v5 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::stats_stealth(v2);
        let v6 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::stats_luck(v2);
        let v7 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::character_data::stats_mut(arg0);
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::set_stats_stat_points(v7, v0 - v1);
        *0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::stats_agility_mut(v7) = v3 + arg1;
        *0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::stats_endurance_mut(v7) = v4 + arg2;
        *0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::stats_stealth_mut(v7) = v5 + arg3;
        *0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::stats_luck_mut(v7) = v6 + arg4;
        if (arg2 > 0) {
            let v8 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::character_data::stamina_mut(arg0);
            update_max_stamina(v8, v4 + arg2);
        };
    }

    public fun calculate_exp_for_level(arg0: u64) : u64 {
        if (arg0 == 1) {
            return 0
        };
        (arg0 - 1) * arg0 * 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::base_exp_per_level()
    }

    public fun calculate_level_from_exp(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 1
        };
        let v0 = 0x1::u64::sqrt(1 + 4 * arg0 / 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::base_exp_per_level());
        if (v0 < 1) {
            return 1
        };
        let v1 = (1 + v0) / 2;
        if (v1 == 0) {
            return 1
        };
        if (v1 > 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::max_level()) {
            return 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::max_level()
        };
        v1
    }

    public fun calculate_max_stamina(arg0: u64) : u64 {
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::stat_effects::endurance_max_stamina(arg0)
    }

    public fun calculate_rarity_bonus_exp(arg0: u64) : u64 {
        let v0 = 10000;
        if (arg0 >= v0) {
            return 0
        };
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::raid_base_exp() * (v0 - arg0) * 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::rarity_bonus_exp_max_percent() / v0 / 100
    }

    public fun calculate_rarity_wanted_bonus(arg0: u64) : u64 {
        if (arg0 >= 5000) {
            return 0
        };
        if (arg0 >= 3000) {
            return 1
        };
        if (arg0 >= 2000) {
            return 3
        };
        if (arg0 >= 1000) {
            return 8
        };
        if (arg0 >= 500) {
            return 25
        };
        if (arg0 >= 300) {
            return 35
        };
        if (arg0 >= 100) {
            return 45
        };
        if (arg0 >= 50) {
            return 48
        };
        if (arg0 >= 10) {
            return 49
        };
        50
    }

    public fun check_arrest_with_separate_rolls(arg0: &mut 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::WantedLevel, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::random::RandomGenerator, arg5: &0x2::clock::Clock) : (bool, bool, 0x1::option::Option<u8>) {
        let v0 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::wanted_level(arg0);
        if (v0 == 0) {
            return (false, false, 0x1::option::none<u8>())
        };
        let v1 = if (v0 > 100) {
            10000
        } else {
            v0 * 100
        };
        if (0x2::random::generate_u64(arg4) % 10000 >= v1) {
            return (false, false, 0x1::option::none<u8>())
        };
        let v2 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::stat_effects::endurance_avoid_arrest_chance(arg1);
        if (v2 > 0) {
            if (0x2::random::generate_u64(arg4) % 10000 < v2) {
                return (true, true, 0x1::option::some<u8>(1))
            };
        };
        let v3 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::stat_effects::stealth_avoid_arrest_chance(arg2);
        if (v3 > 0) {
            if (0x2::random::generate_u64(arg4) % 10000 < v3) {
                return (true, true, 0x1::option::some<u8>(2))
            };
        };
        let v4 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::stat_effects::luck_avoid_arrest_chance(arg3);
        if (v4 > 0) {
            if (0x2::random::generate_u64(arg4) % 10000 < v4) {
                return (true, true, 0x1::option::some<u8>(3))
            };
        };
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::set_wanted_arrest_time(arg0, 0x2::clock::timestamp_ms(arg5));
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::set_wanted_level(arg0, 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::max_wanted_level());
        (true, false, 0x1::option::none<u8>())
    }

    public fun consume_stamina(arg0: &mut 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::Stamina, arg1: u64) {
        let v0 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::stamina_current(arg0);
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::errors::assert_sufficient_stamina(v0 >= arg1);
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::set_stamina_current(arg0, v0 - arg1);
    }

    public fun gain_experience(arg0: &mut 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::CharacterStats, arg1: u64) : bool {
        let v0 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::stats_level(arg0);
        if (v0 >= 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::max_level()) {
            return false
        };
        let v1 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::stats_experience(arg0) + arg1;
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::set_stats_experience(arg0, v1);
        let v2 = calculate_level_from_exp(v1);
        if (v2 > v0) {
            0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::set_stats_level(arg0, v2);
            0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::set_stats_stat_points(arg0, 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::stats_stat_points(arg0) + (v2 - v0) * 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::stat_points_per_level());
            return true
        };
        false
    }

    public fun gain_experience_with_newbie_buff_check(arg0: &mut 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::character_data::Character, arg1: 0x1::option::Option<u64>, arg2: u64, arg3: &0x2::clock::Clock) : bool {
        let v0 = if (0x1::option::is_some<u64>(&arg1)) {
            0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::raid_base_exp() + calculate_rarity_bonus_exp(*0x1::option::borrow<u64>(&arg1))
        } else {
            0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::raid_base_exp()
        };
        let v1 = if (arg2 > 0) {
            v0 + v0 * arg2 / 10000
        } else {
            v0
        };
        let v2 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::character_data::stats_mut(arg0);
        let v3 = gain_experience(v2, v1);
        if (v3) {
            let v4 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::character_data::stamina_mut(arg0);
            0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::set_stamina_current(v4, 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::stamina_max(v4));
        };
        if (v3 && 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::stats_level(0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::character_data::stats(arg0)) < 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::newbie_buff_trigger_level()) {
            if (0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::stats_level(0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::character_data::stats(arg0)) >= 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::newbie_buff_trigger_level() && 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::character_data::newbie_buff_end_time(arg0) == 0) {
                activate_newbie_buff(arg0, arg3);
            };
        };
        v3
    }

    public fun gain_experience_with_rarity_bonus(arg0: &mut 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::CharacterStats, arg1: 0x1::option::Option<u64>) : bool {
        let v0 = if (0x1::option::is_some<u64>(&arg1)) {
            0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::raid_base_exp() + calculate_rarity_bonus_exp(*0x1::option::borrow<u64>(&arg1))
        } else {
            0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::raid_base_exp()
        };
        gain_experience(arg0, v0)
    }

    public fun is_newbie_buff_active(arg0: &0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::character_data::Character, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::character_data::newbie_buff_end_time(arg0);
        if (v0 == 0) {
            return false
        };
        0x2::clock::timestamp_ms(arg1) < v0
    }

    public fun recover_stamina(arg0: &mut 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::Stamina, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::global_buffs::GlobalBuffs) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::stamina_last_recovery_time(arg0);
        if (v0 <= v1) {
            return
        };
        let v2 = v0 - v1;
        if (v2 == 0) {
            return
        };
        let v3 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::stamina_current(arg0);
        let v4 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::stamina_max(arg0);
        let v5 = v2 * (0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::stat_effects::endurance_stamina_regen_rate(arg1) + 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::global_buffs::get_buff_strength(arg3, 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::global_buffs::buff_type_stamina_regen(), arg2)) / 60000000;
        let v6 = if (v3 + v5 > v4) {
            v4
        } else {
            v3 + v5
        };
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::set_stamina_current(arg0, v6);
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::set_stamina_last_recovery_time(arg0, v0);
    }

    public fun update_max_stamina(arg0: &mut 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::Stamina, arg1: u64) {
        let v0 = calculate_max_stamina(arg1);
        let v1 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::stamina_max(arg0);
        let v2 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::stamina_current(arg0);
        let v3 = if (v0 > v1) {
            v2 + v0 - v1
        } else if (v2 > v0) {
            v0
        } else {
            v2
        };
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::set_stamina_max(arg0, v0);
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::set_stamina_current(arg0, v3);
    }

    public fun update_newbie_buff_state(arg0: &mut 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::character_data::Character, arg1: &0x2::clock::Clock) {
        let v0 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::character_data::newbie_buff_end_time(arg0);
        if (v0 > 0) {
            if (0x2::clock::timestamp_ms(arg1) >= v0) {
                0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::character_data::set_newbie_buff_end_time(arg0, 0);
            };
        };
    }

    public fun update_wanted_level(arg0: &mut 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::WantedLevel, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::wanted_arrest_time(arg0) > 0;
        let v2 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::wanted_last_decay_time(arg0);
        if (v0 <= v2) {
            if (v1) {
                if (0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::wanted_level(arg0) == 0) {
                    0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::set_wanted_arrest_time(arg0, 0);
                };
            };
            return
        };
        let v3 = v0 - v2;
        if (v3 == 0) {
            if (v1) {
                if (0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::wanted_level(arg0) == 0) {
                    0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::set_wanted_arrest_time(arg0, 0);
                };
            };
            return
        };
        let v4 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::wanted_level(arg0);
        let v5 = if (v1) {
            v3 * 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::stat_effects::stealth_wanted_decay_rate(arg1) / 60000000 / 2
        } else {
            v3 * 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::stat_effects::stealth_wanted_decay_rate(arg1) / 60000000
        };
        let v6 = if (v4 > v5) {
            v4 - v5
        } else {
            0
        };
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::set_wanted_level(arg0, v6);
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::set_wanted_last_decay_time(arg0, v0);
        if (v1 && v6 == 0) {
            0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::progression::set_wanted_arrest_time(arg0, 0);
        };
    }

    public fun validate_stat_allocation(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : bool {
        arg1 + arg2 + arg3 + arg4 <= arg0
    }

    // decompiled from Move bytecode v6
}

