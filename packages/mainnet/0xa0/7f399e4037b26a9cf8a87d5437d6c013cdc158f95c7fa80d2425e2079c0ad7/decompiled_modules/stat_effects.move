module 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::stat_effects {
    public(friend) fun agility_drop_bonus(arg0: u64) : u64 {
        0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::agility_drop_bonus_max() * calculate_stat_effectiveness(arg0) / 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::stat_precision_factor()
    }

    public(friend) fun calculate_stat_effectiveness(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::max_stat_points();
        if (arg0 >= v0) {
            return 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::stat_precision_factor()
        };
        arg0 * 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::stat_precision_factor() / v0
    }

    public(friend) fun endurance_avoid_arrest_chance(arg0: u64) : u64 {
        0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::endurance_avoid_arrest_max() * calculate_stat_effectiveness(arg0) / 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::stat_precision_factor()
    }

    public(friend) fun endurance_max_stamina(arg0: u64) : u64 {
        0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::endurance_max_stamina_base() + 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::endurance_max_stamina_bonus() * calculate_stat_effectiveness(arg0) / 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::stat_precision_factor()
    }

    public(friend) fun endurance_stamina_regen_rate(arg0: u64) : u64 {
        0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::endurance_regen_base() * 1000 + 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::endurance_regen_bonus() * 1000 * calculate_stat_effectiveness(arg0) / 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::stat_precision_factor()
    }

    public(friend) fun luck_avoid_arrest_chance(arg0: u64) : u64 {
        0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::luck_avoid_arrest_max() * calculate_stat_effectiveness(arg0) / 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::stat_precision_factor()
    }

    public(friend) fun luck_reroll_chance(arg0: u64) : u64 {
        0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::luck_reroll_chance_max() * calculate_stat_effectiveness(arg0) / 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::stat_precision_factor()
    }

    public(friend) fun stealth_avoid_arrest_chance(arg0: u64) : u64 {
        0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::stealth_avoid_arrest_max() * calculate_stat_effectiveness(arg0) / 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::stat_precision_factor()
    }

    public(friend) fun stealth_rarity_reduction(arg0: u64) : u64 {
        0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::stealth_rarity_reduction_max() * calculate_stat_effectiveness(arg0) / 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::stat_precision_factor()
    }

    public(friend) fun stealth_wanted_decay_rate(arg0: u64) : u64 {
        0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::stealth_wanted_decay_base() * 1000 + 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::stealth_wanted_decay_bonus() * 1000 * calculate_stat_effectiveness(arg0) / 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::stat_precision_factor()
    }

    public(friend) fun stealth_wanted_gain(arg0: u64) : u64 {
        let v0 = 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::stealth_wanted_reduction_max() * calculate_stat_effectiveness(arg0) / 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::stat_precision_factor();
        if (v0 >= 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::bp_den()) {
            1
        } else {
            let v2 = 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::base_wanted_gain() * (0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::bp_den() - v0) / 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::bp_den();
            if (v2 == 0) {
                1
            } else {
                v2
            }
        }
    }

    // decompiled from Move bytecode v6
}

