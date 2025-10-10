module 0x77121acf963c9e5d9531a37c0965811ae827b3fbb5b9689880ae36ae8fb9ed06::almm_constants {
    public fun basis_point_max() : u16 {
        10000
    }

    public fun day() : u64 {
        86400
    }

    public fun max_fee() : u64 {
        10000000
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

