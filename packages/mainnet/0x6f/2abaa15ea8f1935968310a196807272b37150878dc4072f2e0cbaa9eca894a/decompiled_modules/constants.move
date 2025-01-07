module 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants {
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
        1
    }

    public fun deep_unit() : u64 {
        1000000
    }

    public fun default_stake_required() : u64 {
        100000000
    }

    public fun expired() : u8 {
        4
    }

    public fun fee_is_deep() : bool {
        true
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
        0
    }

    public fun post_only() : u8 {
        3
    }

    public fun self_matching_allowed() : u8 {
        0
    }

    // decompiled from Move bytecode v6
}

