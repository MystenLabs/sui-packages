module 0x5b34385fa5b2e4ce6341fa5a7ed70e1dea401553b58947bbccd96bc4bcd9f7cd::constants {
    public fun amount_after_fee(arg0: u64, arg1: u64) : u64 {
        0x5b34385fa5b2e4ce6341fa5a7ed70e1dea401553b58947bbccd96bc4bcd9f7cd::safe_math::mul_div_u64(arg0, 1000000 - arg1, 1000000)
    }

    public fun amount_before_fee(arg0: u64, arg1: u64) : u64 {
        0x5b34385fa5b2e4ce6341fa5a7ed70e1dea401553b58947bbccd96bc4bcd9f7cd::safe_math::mul_div_u64(arg0, 1000000, 1000000 - arg1)
    }

    public fun current_version() : u64 {
        1
    }

    public fun max_output_delta_pips() : u64 {
        200
    }

    public fun max_price_delta_pips() : u64 {
        20000
    }

    public fun scaling_pips() : u64 {
        1000000
    }

    public fun scaling_pips_u128() : u128 {
        (1000000 as u128)
    }

    public fun scaling_pips_u256() : u256 {
        (1000000 as u256)
    }

    // decompiled from Move bytecode v6
}

