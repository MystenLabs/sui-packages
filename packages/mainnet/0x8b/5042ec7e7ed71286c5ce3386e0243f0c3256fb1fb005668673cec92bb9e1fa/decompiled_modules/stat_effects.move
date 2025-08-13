module 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::stat_effects {
    public fun agility_drop_bonus(arg0: u64) : u64 {
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::agility_drop_bonus_max() * calculate_stat_effectiveness(arg0) / 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::stat_precision_factor()
    }

    public fun calculate_stat_effectiveness(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::max_stat_points();
        if (arg0 >= v0) {
            return 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::stat_precision_factor()
        };
        arg0 * 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::stat_precision_factor() / v0
    }

    public fun endurance_avoid_arrest_chance(arg0: u64) : u64 {
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::endurance_avoid_arrest_max() * calculate_stat_effectiveness(arg0) / 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::stat_precision_factor()
    }

    public fun endurance_max_stamina(arg0: u64) : u64 {
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::endurance_max_stamina_base() + 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::endurance_max_stamina_bonus() * calculate_stat_effectiveness(arg0) / 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::stat_precision_factor()
    }

    public fun endurance_stamina_regen_rate(arg0: u64) : u64 {
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::endurance_regen_base() * 1000 + 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::endurance_regen_bonus() * 1000 * calculate_stat_effectiveness(arg0) / 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::stat_precision_factor()
    }

    public fun luck_avoid_arrest_chance(arg0: u64) : u64 {
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::luck_avoid_arrest_max() * calculate_stat_effectiveness(arg0) / 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::stat_precision_factor()
    }

    public fun luck_reroll_chance(arg0: u64) : u64 {
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::luck_reroll_chance_max() * calculate_stat_effectiveness(arg0) / 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::stat_precision_factor()
    }

    public fun stealth_avoid_arrest_chance(arg0: u64) : u64 {
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::stealth_avoid_arrest_max() * calculate_stat_effectiveness(arg0) / 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::stat_precision_factor()
    }

    public fun stealth_rarity_reduction(arg0: u64) : u64 {
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::stealth_rarity_reduction_max() * calculate_stat_effectiveness(arg0) / 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::stat_precision_factor()
    }

    public fun stealth_wanted_decay_rate(arg0: u64) : u64 {
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::stealth_wanted_decay_base() * 1000 + 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::stealth_wanted_decay_bonus() * 1000 * calculate_stat_effectiveness(arg0) / 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::stat_precision_factor()
    }

    public fun stealth_wanted_gain(arg0: u64) : u64 {
        let v0 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::stealth_wanted_reduction_max() * calculate_stat_effectiveness(arg0) / 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::stat_precision_factor();
        if (v0 >= 10000) {
            1
        } else {
            let v2 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::constants::base_wanted_gain() * (10000 - v0) / 10000;
            if (v2 == 0) {
                1
            } else {
                v2
            }
        }
    }

    // decompiled from Move bytecode v6
}

