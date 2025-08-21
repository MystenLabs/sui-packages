module 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::stat_effects {
    public(friend) fun agility_drop_bonus(arg0: u64) : u64 {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::agility_drop_bonus_max() * calculate_stat_effectiveness(arg0) / 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::stat_precision_factor()
    }

    public(friend) fun calculate_stat_effectiveness(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::max_stat_points();
        if (arg0 >= v0) {
            return 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::stat_precision_factor()
        };
        arg0 * 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::stat_precision_factor() / v0
    }

    public(friend) fun endurance_avoid_arrest_chance(arg0: u64) : u64 {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::endurance_avoid_arrest_max() * calculate_stat_effectiveness(arg0) / 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::stat_precision_factor()
    }

    public(friend) fun endurance_max_stamina(arg0: u64) : u64 {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::endurance_max_stamina_base() + 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::endurance_max_stamina_bonus() * calculate_stat_effectiveness(arg0) / 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::stat_precision_factor()
    }

    public(friend) fun endurance_stamina_regen_rate(arg0: u64) : u64 {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::endurance_regen_base() * 1000 + 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::endurance_regen_bonus() * 1000 * calculate_stat_effectiveness(arg0) / 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::stat_precision_factor()
    }

    public(friend) fun luck_avoid_arrest_chance(arg0: u64) : u64 {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::luck_avoid_arrest_max() * calculate_stat_effectiveness(arg0) / 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::stat_precision_factor()
    }

    public(friend) fun luck_reroll_chance(arg0: u64) : u64 {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::luck_reroll_chance_max() * calculate_stat_effectiveness(arg0) / 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::stat_precision_factor()
    }

    public(friend) fun stealth_avoid_arrest_chance(arg0: u64) : u64 {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::stealth_avoid_arrest_max() * calculate_stat_effectiveness(arg0) / 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::stat_precision_factor()
    }

    public(friend) fun stealth_rarity_reduction(arg0: u64) : u64 {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::stealth_rarity_reduction_max() * calculate_stat_effectiveness(arg0) / 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::stat_precision_factor()
    }

    public(friend) fun stealth_wanted_decay_rate(arg0: u64) : u64 {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::stealth_wanted_decay_base() * 1000 + 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::stealth_wanted_decay_bonus() * 1000 * calculate_stat_effectiveness(arg0) / 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::stat_precision_factor()
    }

    public(friend) fun stealth_wanted_gain(arg0: u64) : u64 {
        let v0 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::stealth_wanted_reduction_max() * calculate_stat_effectiveness(arg0) / 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::stat_precision_factor();
        if (v0 >= 10000) {
            1
        } else {
            let v2 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::base_wanted_gain() * (10000 - v0) / 10000;
            if (v2 == 0) {
                1
            } else {
                v2
            }
        }
    }

    // decompiled from Move bytecode v6
}

