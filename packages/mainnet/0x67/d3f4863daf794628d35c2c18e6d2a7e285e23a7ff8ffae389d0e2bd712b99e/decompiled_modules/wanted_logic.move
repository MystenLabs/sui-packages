module 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::wanted_logic {
    public(friend) fun add_wanted_level_with_stealth_and_rarity(arg0: &mut 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::progression::WantedLevel, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::constants::bp_den();
        let v1 = if (arg3 > v0) {
            v0
        } else {
            arg3
        };
        let v2 = 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::progression::wanted_level(arg0);
        let v3 = v2 + (0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::stat_effects::stealth_wanted_gain(arg1) + calculate_rarity_wanted_bonus(arg2) * (0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::constants::bp_den() - 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::stat_effects::stealth_rarity_reduction(arg1)) / 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::constants::bp_den()) * (v0 - v1) / v0;
        let v4 = if (v3 > 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::constants::max_wanted_level()) {
            0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::constants::max_wanted_level()
        } else {
            v3
        };
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::progression::set_wanted_level(arg0, v4);
        v4 - v2
    }

    public(friend) fun amount_from_time_rate(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        arg0 / 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::constants::ms_per_min() * arg1 / 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::constants::rate_scale() + arg0 % 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::constants::ms_per_min() * arg1 / 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::constants::time_rate_den()
    }

    public(friend) fun auto_release_if_time_passed(arg0: &mut 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::progression::WantedLevel, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::progression::wanted_arrest_ends_at(arg0);
        if (v1 > 0 && v0 >= v1) {
            0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::progression::set_wanted_level(arg0, 0);
            0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::progression::set_wanted_arrest_ends_at(arg0, 0);
            0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::progression::set_wanted_last_decay_time(arg0, v0);
        };
    }

    public(friend) fun calculate_arrest_duration_ms(arg0: u64) : u64 {
        let v0 = 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::stat_effects::stealth_wanted_decay_rate(arg0) / 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::constants::arrest_decay_slowdown_factor();
        if (v0 == 0) {
            return 60 * 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::constants::ms_per_min()
        };
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::constants::max_wanted_level() * 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::constants::time_rate_den() / v0
    }

    public(friend) fun calculate_rarity_wanted_bonus(arg0: u64) : u64 {
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

    public(friend) fun check_arrest_with_separate_rolls(arg0: &mut 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::progression::WantedLevel, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext, arg6: &0x2::clock::Clock) : 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::arrest_result::ArrestResult {
        let v0 = 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::progression::wanted_level(arg0);
        if (v0 == 0) {
            return 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::arrest_result::new_no_arrest()
        };
        let v1 = 0x2::random::new_generator(arg4, arg5);
        let v2 = if (v0 > 100) {
            0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::constants::bp_den()
        } else {
            v0 * 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::constants::bp_den() / 100
        };
        if (0x2::random::generate_u64(&mut v1) % 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::constants::bp_den() >= v2) {
            return 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::arrest_result::new_no_arrest()
        };
        let v3 = 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::stat_effects::endurance_avoid_arrest_chance(arg1);
        if (v3 > 0) {
            if (0x2::random::generate_u64(&mut v1) % 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::constants::bp_den() < v3) {
                return 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::arrest_result::new_avoided(0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::arrest_result::save_reason_endurance())
            };
        };
        let v4 = 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::stat_effects::stealth_avoid_arrest_chance(arg2);
        if (v4 > 0) {
            if (0x2::random::generate_u64(&mut v1) % 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::constants::bp_den() < v4) {
                return 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::arrest_result::new_avoided(0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::arrest_result::save_reason_stealth())
            };
        };
        let v5 = 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::stat_effects::luck_avoid_arrest_chance(arg3);
        if (v5 > 0) {
            if (0x2::random::generate_u64(&mut v1) % 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::constants::bp_den() < v5) {
                return 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::arrest_result::new_avoided(0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::arrest_result::save_reason_luck())
            };
        };
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::progression::set_wanted_level(arg0, 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::constants::max_wanted_level());
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::progression::set_arrest(arg0, 0x2::clock::timestamp_ms(arg6) + calculate_arrest_duration_ms(arg2));
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::arrest_result::new_arrested()
    }

    public(friend) fun update_wanted_level(arg0: &mut 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::progression::WantedLevel, arg1: u64, arg2: &0x2::clock::Clock) {
        auto_release_if_time_passed(arg0, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::progression::is_arrested(arg0)) {
            return
        };
        let v1 = 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::progression::wanted_last_decay_time(arg0);
        if (v0 <= v1) {
            return
        };
        let v2 = v0 - v1;
        if (v2 == 0) {
            return
        };
        let v3 = 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::progression::wanted_level(arg0);
        let v4 = amount_from_time_rate(v2, 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::stat_effects::stealth_wanted_decay_rate(arg1));
        let v5 = if (v3 > v4) {
            v3 - v4
        } else {
            0
        };
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::progression::set_wanted_level(arg0, v5);
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::progression::set_wanted_last_decay_time(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

