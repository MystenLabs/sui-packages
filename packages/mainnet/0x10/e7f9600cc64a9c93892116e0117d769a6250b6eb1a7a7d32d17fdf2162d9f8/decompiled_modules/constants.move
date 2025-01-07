module 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants {
    public fun buck_decimal() : u8 {
        9
    }

    public fun decay_factor_precision() : u64 {
        1000000000000000000
    }

    public fun decimal_factor() : u64 {
        1000000000
    }

    public fun distribution_precision() : u128 {
        18446744073709551616
    }

    public fun fee_precision() : u64 {
        1000000
    }

    public fun flash_loan_fee() : u64 {
        500
    }

    public fun interest_precision() : u256 {
        1000000000000000000000000000
    }

    public fun liquidation_fee() : u64 {
        20000
    }

    public fun liquidation_rebate() : u64 {
        5000
    }

    public fun max_fee() : u64 {
        50000
    }

    public fun max_lock_time() : u64 {
        31104000000
    }

    public fun max_u64() : u64 {
        18446744073709551615
    }

    public fun min_fee() : u64 {
        5000
    }

    public fun min_lock_time() : u64 {
        2592000000
    }

    public fun minute_decay_factor() : u64 {
        999037758833783500
    }

    public fun ms_in_year() : u256 {
        31536000000
    }

    public fun p_initial_value() : u64 {
        1000000000000000000
    }

    public fun scale_factor() : u64 {
        1000000000
    }

    // decompiled from Move bytecode v6
}

