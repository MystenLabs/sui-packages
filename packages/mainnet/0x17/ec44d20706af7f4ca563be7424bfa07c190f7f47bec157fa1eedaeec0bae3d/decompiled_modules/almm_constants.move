module 0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_constants {
    public fun basis_point_max() : u16 {
        10000
    }

    public fun day() : u64 {
        86400
    }

    public fun max_fee() : u64 {
        100000000
    }

    public fun max_liquidity_per_bin() : u256 {
        65251743116719673010965625540244653191619923014385985379600384103134737
    }

    public fun max_protocol_share() : u16 {
        2500
    }

    public fun precision() : u128 {
        1000000000
    }

    public fun precision_n() : u8 {
        9
    }

    public fun scale() : u256 {
        1 << 128
    }

    public fun scale_offset() : u8 {
        128
    }

    public fun squared_precision() : u128 {
        1000000000000000000
    }

    // decompiled from Move bytecode v6
}

