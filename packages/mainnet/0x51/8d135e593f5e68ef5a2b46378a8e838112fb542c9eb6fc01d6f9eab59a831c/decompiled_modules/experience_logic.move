module 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::experience_logic {
    public(friend) fun activate_newbie_buff(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: &0x2::clock::Clock) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::set_newbie_buff_end_time(arg0, 0x2::clock::timestamp_ms(arg1) + 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::newbie_buff_duration_ms());
    }

    public(friend) fun calculate_level_from_exp(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 1
        };
        let v0 = 0x1::u64::sqrt(1 + 4 * arg0 / 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::base_exp_per_level());
        if (v0 < 1) {
            return 1
        };
        let v1 = (1 + v0) / 2;
        if (v1 == 0) {
            return 1
        };
        if (v1 > 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::max_level()) {
            return 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::max_level()
        };
        v1
    }

    public(friend) fun calculate_rarity_bonus_exp(arg0: u64) : u64 {
        let v0 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::bp_den();
        if (arg0 >= v0) {
            return 0
        };
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::raid_base_exp() * (v0 - arg0) * 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::rarity_bonus_exp_max_percent() / v0 / 100
    }

    public(friend) fun gain_experience(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::CharacterStats, arg1: u64) : bool {
        let v0 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::stats_level(arg0);
        if (v0 >= 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::max_level()) {
            return false
        };
        let v1 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::stats_experience(arg0) + arg1;
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::set_stats_experience(arg0, v1);
        let v2 = calculate_level_from_exp(v1);
        if (v2 > v0) {
            0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::set_stats_level(arg0, v2);
            0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::set_stats_stat_points(arg0, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::stats_stat_points(arg0) + (v2 - v0) * 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::stat_points_per_level());
            return true
        };
        false
    }

    public(friend) fun gain_experience_with_newbie_buff_check(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: 0x1::option::Option<u64>, arg2: u64, arg3: &0x2::clock::Clock) : bool {
        let v0 = if (0x1::option::is_some<u64>(&arg1)) {
            0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::raid_base_exp() + calculate_rarity_bonus_exp(*0x1::option::borrow<u64>(&arg1))
        } else {
            0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::raid_base_exp()
        };
        let v1 = if (arg2 > 0) {
            v0 + v0 * arg2 / 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::bp_den()
        } else {
            v0
        };
        let v2 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::stats_mut(arg0);
        let v3 = gain_experience(v2, v1);
        if (v3) {
            let v4 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::stamina_mut(arg0);
            0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::set_stamina_current(v4, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::stamina_max(v4));
            0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::set_stamina_last_recovery_time(v4, 0x2::clock::timestamp_ms(arg3));
        };
        if (v3 && 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::stats_level(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::stats(arg0)) < 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::newbie_buff_trigger_level()) {
            if (0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::stats_level(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::stats(arg0)) >= 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::newbie_buff_trigger_level() && 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::newbie_buff_end_time(arg0) == 0) {
                activate_newbie_buff(arg0, arg3);
            };
        };
        v3
    }

    public(friend) fun is_newbie_buff_active(arg0: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::newbie_buff_end_time(arg0);
        if (v0 == 0) {
            return false
        };
        0x2::clock::timestamp_ms(arg1) < v0
    }

    public(friend) fun update_newbie_buff_state(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: &0x2::clock::Clock) {
        let v0 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::newbie_buff_end_time(arg0);
        if (v0 > 0) {
            if (0x2::clock::timestamp_ms(arg1) >= v0) {
                0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::set_newbie_buff_end_time(arg0, 0);
            };
        };
    }

    // decompiled from Move bytecode v6
}

