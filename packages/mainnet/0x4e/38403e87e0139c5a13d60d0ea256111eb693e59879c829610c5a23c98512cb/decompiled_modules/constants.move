module 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::constants {
    public fun amplification_precision() : u64 {
        100
    }

    public fun batch_swap_threshold() : u64 {
        3
    }

    public fun default_fee_rate() : u64 {
        30
    }

    public fun fee_denominator() : u64 {
        10000
    }

    public fun max_pool_assets() : u64 {
        8
    }

    public fun max_slippage() : u64 {
        100
    }

    public fun min_profit_threshold() : u64 {
        1000
    }

    public fun minimum_liquidity() : u64 {
        1000
    }

    public fun minimum_swap_amount() : u64 {
        100
    }

    public fun precision() : u128 {
        1000000000000000000
    }

    public fun sqrt_precision() : u128 {
        1000000000
    }

    // decompiled from Move bytecode v6
}

