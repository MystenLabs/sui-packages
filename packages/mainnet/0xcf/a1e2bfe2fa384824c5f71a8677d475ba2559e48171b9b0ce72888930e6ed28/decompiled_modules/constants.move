module 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::constants {
    public fun alliance_fee_rate() : u64 {
        50000
    }

    public fun buy_fee_rate() : u64 {
        20000
    }

    public fun decorate_fee() : u64 {
        5000000000
    }

    public fun destroy_duration() : u64 {
        3600000
    }

    public fun game_round_status_end() : u8 {
        2
    }

    public fun game_round_status_pending() : u8 {
        0
    }

    public fun game_round_status_playing() : u8 {
        1
    }

    public fun listing_fee() : u64 {
        19900000000
    }

    public fun migrate_fee() : u64 {
        100000000000
    }

    public fun pixel_count() : u64 {
        900
    }

    public fun rate_size() : u64 {
        1000000
    }

    public fun round_duration() : u64 {
        604800000
    }

    public fun sell_fee_rate() : u64 {
        20000
    }

    public fun stake_fee_rate() : u64 {
        5000
    }

    public fun stake_scale() : u64 {
        1000000000000000000
    }

    public fun target_supply_threshold() : u64 {
        200000000000000000
    }

    public fun token_reserve_rate() : u64 {
        10000
    }

    public fun token_total_supply() : u64 {
        1000000000000000000
    }

    public fun version() : u64 {
        1
    }

    public fun virtual_sui_amount() : u64 {
        4200000000000
    }

    // decompiled from Move bytecode v6
}

