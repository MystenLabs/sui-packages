module 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::constants {
    public fun amount_after_fee(arg0: u64, arg1: u64) : u64 {
        0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::safe_math::mul_div_u64(arg0, 1000000 - arg1, 1000000)
    }

    public fun amount_before_fee(arg0: u64, arg1: u64) : u64 {
        0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::safe_math::mul_div_u64(arg0, 1000000, 1000000 - arg1)
    }

    public fun max_fee_pips() : u64 {
        1000000
    }

    public fun max_fee_pips_u128() : u128 {
        (1000000 as u128)
    }

    public fun max_fee_pips_u256() : u256 {
        (1000000 as u256)
    }

    // decompiled from Move bytecode v6
}

