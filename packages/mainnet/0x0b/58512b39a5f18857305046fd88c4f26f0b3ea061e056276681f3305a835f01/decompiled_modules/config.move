module 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config {
    public(friend) fun aquarium_edit_name_and_description_cost_in_dive_token() : u64 {
        100000000
    }

    public(friend) fun aquarium_feed_payment() : u64 {
        20000000
    }

    public(friend) fun aquarium_fish_yield_rate_divisor() : u64 {
        10
    }

    public(friend) fun aquarium_price_in_sui() : u64 {
        8000000000
    }

    public(friend) fun base_training_cost() : u64 {
        200000000
    }

    public(friend) fun diver_level_bonus_ms() : u64 {
        60000
    }

    public(friend) fun diver_marketplace_fee() : u64 {
        25
    }

    public(friend) fun diver_marketplace_type() : u8 {
        0
    }

    public(friend) fun diver_max_level() : u64 {
        10
    }

    public(friend) fun diver_min_level() : u64 {
        0
    }

    public(friend) fun dividend_epoch_ms() : u64 {
        604800000
    }

    public(friend) fun diving_duration_ms(arg0: u8) : u64 {
        let v0 = vector[2400000, 1800000, 1200000, 600000, 600000];
        *0x1::vector::borrow<u64>(&v0, (arg0 as u64))
    }

    public(friend) fun diving_with_dive_token_cost() : u64 {
        100000000
    }

    public(friend) fun diving_with_sui_tier_1_cost() : u64 {
        200000000
    }

    public(friend) fun diving_with_sui_tier_2_cost() : u64 {
        400000000
    }

    public(friend) fun diving_with_sui_tier_3_cost() : u64 {
        600000000
    }

    public(friend) fun equipment_marketplace_fee() : u64 {
        30
    }

    public(friend) fun equipment_marketplace_type() : u8 {
        2
    }

    public(friend) fun fish_marketplace_fee() : u64 {
        30
    }

    public(friend) fun fish_marketplace_type() : u8 {
        1
    }

    public(friend) fun fishing_attempt_level_bonus_base() : u8 {
        10
    }

    public(friend) fun fully_release_bonus_duration_ms() : u64 {
        604800000
    }

    public(friend) fun has_fish_probability() : vector<u8> {
        b"A<72-"
    }

    public(friend) fun max_aquarium_count_per_user() : u64 {
        10
    }

    public(friend) fun max_aquarium_slot_count() : u64 {
        30
    }

    public(friend) fun max_base_fishing_attempts() : vector<u8> {
        x"0403020101"
    }

    public(friend) fun max_fish_rarity_count() : u8 {
        5
    }

    public(friend) fun max_fish_size_count() : u8 {
        5
    }

    public(friend) fun max_nitrogen_saturation() : u64 {
        6
    }

    public(friend) fun max_nitrogen_saturation_with_dive_token() : u64 {
        3
    }

    public(friend) fun nitrogen_decay_period_ms() : u64 {
        14400000
    }

    public(friend) fun phase_1_divers_supply() : u64 {
        9999
    }

    public(friend) fun phase_2_divers_supply() : u64 {
        23000
    }

    public(friend) fun rarity_common_index() : u8 {
        4
    }

    public(friend) fun rarity_epic_index() : u8 {
        2
    }

    public(friend) fun rarity_legendary_index() : u8 {
        1
    }

    public(friend) fun rarity_mythic_index() : u8 {
        0
    }

    public(friend) fun rarity_probability_common() : u16 {
        5800
    }

    public(friend) fun rarity_probability_epic() : u16 {
        900
    }

    public(friend) fun rarity_probability_epic_arithmetic() : u16 {
        1201
    }

    public(friend) fun rarity_probability_legendary() : u16 {
        280
    }

    public(friend) fun rarity_probability_legendary_arithmetic() : u16 {
        301
    }

    public(friend) fun rarity_probability_mythic() : u16 {
        20
    }

    public(friend) fun rarity_probability_mythic_arithmetic() : u16 {
        21
    }

    public(friend) fun rarity_probability_rare() : u16 {
        3000
    }

    public(friend) fun rarity_probability_rare_arithmetic() : u16 {
        4201
    }

    public(friend) fun rarity_rare_index() : u8 {
        3
    }

    public(friend) fun recruit_cost_in_sui_phase_1() : u64 {
        7000000000
    }

    public(friend) fun recruit_cost_in_sui_phase_2() : u64 {
        10000000000
    }

    public(friend) fun recruit_liquidity_pool_distribution_amount() : u64 {
        1000000000
    }

    public(friend) fun recruit_treasure_pool_distribution_amount() : u64 {
        1000000000
    }

    public(friend) fun reed_plant_duration_ms() : u64 {
        86400000
    }

    public(friend) fun release_bonus() : vector<vector<u64>> {
        vector[vector[210000, 120000, 90000, 72000, 60000], vector[122500, 70000, 52500, 42000, 35000], vector[70000, 40000, 30000, 24000, 20000], vector[42000, 24000, 18000, 14400, 12000], vector[28000, 16000, 12000, 9600, 8000]]
    }

    public(friend) fun skip_diving_cost_in_sui() : u64 {
        100000000
    }

    public(friend) fun skip_training_cost_in_sui() : u64 {
        300000000
    }

    public(friend) fun slot_price_tier_1_in_sui() : u64 {
        1000000000
    }

    public(friend) fun slot_price_tier_2_in_sui() : u64 {
        1500000000
    }

    public(friend) fun total_divers_supply() : u64 {
        334 + 9999 + 23000
    }

    public(friend) fun training_cost_growth_rate() : vector<u64> {
        vector[140, 135, 130, 125, 120]
    }

    public(friend) fun training_duration_ms() : u64 {
        14400000
    }

    public(friend) fun update_name_cost_in_dive_token() : u64 {
        100000000
    }

    public(friend) fun update_nationality_cost_in_dive_token() : u64 {
        100000000
    }

    public(friend) fun whitelist_divers_supply() : u64 {
        334
    }

    // decompiled from Move bytecode v6
}

