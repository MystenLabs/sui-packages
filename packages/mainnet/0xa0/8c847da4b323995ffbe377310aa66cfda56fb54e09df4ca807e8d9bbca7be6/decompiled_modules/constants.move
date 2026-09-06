module 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::constants {
    public fun base_fee_scale() : u128 {
        10
    }

    public fun bin_delta_scale() : u32 {
        10000
    }

    public fun bin_id_offset() : u32 {
        8388608
    }

    public fun bps_denominator_u128() : u128 {
        (10000 as u128)
    }

    public fun bps_denominator_u16() : u16 {
        (10000 as u16)
    }

    public fun bps_denominator_u64() : u64 {
        10000
    }

    public fun fee_calc_precision() : u128 {
        100000000000
    }

    public fun fee_precision() : u64 {
        1000000000
    }

    public fun max_total_fee() : u128 {
        100000000
    }

    public fun price_range_num() : u32 {
        443000
    }

    public fun price_range_num_low() : u32 {
        300000
    }

    // decompiled from Move bytecode v7
}

