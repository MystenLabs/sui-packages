module 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::constants {
    public(friend) fun confidence_scale_factor_liquidate() : u128 {
        25
    }

    public(friend) fun confidence_scale_factor_operate() : u128 {
        50
    }

    public(friend) fun feed_id_length() : u64 {
        32
    }

    public(friend) fun max_age_liquidate() : u64 {
        7200
    }

    public(friend) fun max_age_operate() : u64 {
        600
    }

    public(friend) fun max_invertible_rate() : u128 {
        1000000000000000000000000
    }

    public(friend) fun max_pyth_arrival_lag() : u64 {
        60
    }

    public(friend) fun max_pyth_exponent() : u64 {
        12
    }

    public(friend) fun rate_factor() : u128 {
        1000000000000000
    }

    public(friend) fun rate_output_decimals() : u8 {
        15
    }

    public(friend) fun redstone_decimals() : u8 {
        8
    }

    public(friend) fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

