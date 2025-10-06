module 0xa7f7bf7179e384a4b6d5a31928b278bad00aae9cff545a44add9a2476e5f1f76::constants {
    public fun basis_point_max() : u64 {
        10000
    }

    public fun mask_32bits() : u128 {
        4294967295
    }

    public fun mask_64bits() : u256 {
        18446744073709551615
    }

    public fun max_bins() : u64 {
        1500
    }

    public fun max_fee_rate() : u64 {
        100000000
    }

    public fun max_liquidity_per_bin() : u128 {
        383123885216472214589586756787
    }

    public fun max_protocol_share() : u16 {
        2500
    }

    public fun max_u128() : u128 {
        340282366920938463463374607431768211455
    }

    public fun max_u32() : u32 {
        4294967295
    }

    public fun max_u64() : u64 {
        18446744073709551615
    }

    public fun max_variable_fee_control() : u32 {
        20000
    }

    public fun precision() : u64 {
        1000000000
    }

    public fun squared_precision() : u64 {
        1000000000000000000
    }

    // decompiled from Move bytecode v6
}

