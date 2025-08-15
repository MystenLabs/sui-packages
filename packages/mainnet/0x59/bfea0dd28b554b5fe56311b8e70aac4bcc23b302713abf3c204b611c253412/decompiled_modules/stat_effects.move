module 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::stat_effects {
    public fun agility_drop_bonus(arg0: u64) : u64 {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::agility_drop_bonus_max() * calculate_stat_effectiveness(arg0) / 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::stat_precision_factor()
    }

    public fun calculate_stat_effectiveness(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::max_stat_points();
        if (arg0 >= v0) {
            return 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::stat_precision_factor()
        };
        arg0 * 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::stat_precision_factor() / v0
    }

    public fun endurance_avoid_arrest_chance(arg0: u64) : u64 {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::endurance_avoid_arrest_max() * calculate_stat_effectiveness(arg0) / 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::stat_precision_factor()
    }

    public fun endurance_max_stamina(arg0: u64) : u64 {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::endurance_max_stamina_base() + 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::endurance_max_stamina_bonus() * calculate_stat_effectiveness(arg0) / 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::stat_precision_factor()
    }

    public fun endurance_stamina_regen_rate(arg0: u64) : u64 {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::endurance_regen_base() * 1000 + 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::endurance_regen_bonus() * 1000 * calculate_stat_effectiveness(arg0) / 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::stat_precision_factor()
    }

    public fun luck_avoid_arrest_chance(arg0: u64) : u64 {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::luck_avoid_arrest_max() * calculate_stat_effectiveness(arg0) / 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::stat_precision_factor()
    }

    public fun luck_reroll_chance(arg0: u64) : u64 {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::luck_reroll_chance_max() * calculate_stat_effectiveness(arg0) / 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::stat_precision_factor()
    }

    public fun stealth_avoid_arrest_chance(arg0: u64) : u64 {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::stealth_avoid_arrest_max() * calculate_stat_effectiveness(arg0) / 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::stat_precision_factor()
    }

    public fun stealth_rarity_reduction(arg0: u64) : u64 {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::stealth_rarity_reduction_max() * calculate_stat_effectiveness(arg0) / 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::stat_precision_factor()
    }

    public fun stealth_wanted_decay_rate(arg0: u64) : u64 {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::stealth_wanted_decay_base() * 1000 + 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::stealth_wanted_decay_bonus() * 1000 * calculate_stat_effectiveness(arg0) / 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::stat_precision_factor()
    }

    public fun stealth_wanted_gain(arg0: u64) : u64 {
        let v0 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::stealth_wanted_reduction_max() * calculate_stat_effectiveness(arg0) / 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::stat_precision_factor();
        if (v0 >= 10000) {
            1
        } else {
            let v2 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::base_wanted_gain() * (10000 - v0) / 10000;
            if (v2 == 0) {
                1
            } else {
                v2
            }
        }
    }

    // decompiled from Move bytecode v6
}

