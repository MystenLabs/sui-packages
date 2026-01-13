module 0xe75d1a9d9ad283462899f78613947b7a159b9415ba23ba37c8f0dbc3264aea6d::constants {
    public fun cancel_maker() : u8 {
        2
    }

    public fun cancel_taker() : u8 {
        1
    }

    public fun canceled() : u8 {
        3
    }

    public fun current_version() : u64 {
        6
    }

    public fun deep_unit() : u64 {
        1000000
    }

    public fun default_additional_taker_fee() : u64 {
        1000000
    }

    public fun default_ewma_alpha() : u64 {
        10000000
    }

    public fun default_stake_required() : u64 {
        100000000
    }

    public fun default_z_score_threshold() : u64 {
        3000000000
    }

    public fun ewma_df_key() : vector<u8> {
        b"ewma"
    }

    public fun expired() : u8 {
        4
    }

    public fun fee_is_deep() : bool {
        true
    }

    public fun fee_penalty_multiplier() : u64 {
        1250000000
    }

    public fun fill_or_kill() : u8 {
        2
    }

    public fun filled() : u8 {
        2
    }

    public fun float_scaling() : u64 {
        1000000000
    }

    public fun float_scaling_u128() : u128 {
        1000000000
    }

    public fun half() : u64 {
        500000000
    }

    public fun immediate_or_cancel() : u8 {
        1
    }

    public fun live() : u8 {
        0
    }

    public fun max_additional_taker_fee() : u64 {
        2000000
    }

    public fun max_balance_managers() : u64 {
        100
    }

    public fun max_ewma_alpha() : u64 {
        100000000
    }

    public fun max_fan_out() : u64 {
        64
    }

    public fun max_fills() : u64 {
        100
    }

    public fun max_open_orders() : u64 {
        100
    }

    public fun max_price() : u64 {
        9223372036854775807
    }

    public fun max_restriction() : u8 {
        3
    }

    public fun max_slice_size() : u64 {
        64
    }

    public fun max_u128() : u128 {
        340282366920938463463374607431768211455
    }

    public fun max_u64() : u64 {
        18446744073709551615
    }

    public fun max_z_score_threshold() : u64 {
        10000000000
    }

    public fun min_price() : u64 {
        1
    }

    public fun no_restriction() : u8 {
        0
    }

    public fun partially_filled() : u8 {
        1
    }

    public fun phase_out_epochs() : u64 {
        28
    }

    public fun pool_creation_fee() : u64 {
        500000000
    }

    public fun post_only() : u8 {
        3
    }

    public fun referral_df_key() : vector<u8> {
        abort 13906835368344289279
    }

    public fun referral_max_multiplier() : u64 {
        2000000000
    }

    public fun referral_multiplier() : u64 {
        100000000
    }

    public fun self_matching_allowed() : u8 {
        0
    }

    // decompiled from Move bytecode v6
}

