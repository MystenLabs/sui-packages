module 0xe39c3e326abde050f2f0dfa84c3343e7e2efac2cf5206c3dd0946ae12aef4d77::constants {
    public fun basis_point_max() : u64 {
        10000
    }

    public fun collect_fee_mode_on_both() : u8 {
        0
    }

    public fun collect_fee_mode_on_quote() : u8 {
        1
    }

    public fun fee_scheduler_mode_exponential() : u8 {
        1
    }

    public fun fee_scheduler_mode_linear() : u8 {
        0
    }

    public fun mask_32bits() : u128 {
        4294967295
    }

    public fun mask_64bits() : u256 {
        18446744073709551615
    }

    public fun max_decay_period() : u16 {
        4095
    }

    public fun max_fee() : u64 {
        500000000
    }

    public fun max_fee_rate() : u64 {
        100000000
    }

    public fun max_protocol_fee_rate() : u64 {
        3000
    }

    public fun max_protocol_share() : u16 {
        2500
    }

    public fun max_u128() : u128 {
        340282366920938463463374607431768211455
    }

    public fun max_u16() : u16 {
        65535
    }

    public fun max_u32() : u32 {
        4294967295
    }

    public fun max_u64() : u64 {
        18446744073709551615
    }

    public fun max_variable_fee_control() : u32 {
        2000000
    }

    public fun max_volatility_accumulator() : u32 {
        1048575
    }

    public fun min_fee_numerator() : u64 {
        100000
    }

    public fun precision() : u64 {
        1000000000
    }

    public fun scale() : u128 {
        18446744073709551616
    }

    public fun scale_offset() : u8 {
        64
    }

    public fun squared_precision() : u64 {
        1000000000000000000
    }

    // decompiled from Move bytecode v6
}

