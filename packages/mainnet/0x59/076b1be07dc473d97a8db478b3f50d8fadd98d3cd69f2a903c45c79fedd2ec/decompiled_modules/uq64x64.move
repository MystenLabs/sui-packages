module 0x59076b1be07dc473d97a8db478b3f50d8fadd98d3cd69f2a903c45c79fedd2ec::uq64x64 {
    struct UQ64x64 has copy, drop, store {
        v: u128,
    }

    public fun compare(arg0: &UQ64x64, arg1: &UQ64x64) : u8 {
        if (arg0.v == arg1.v) {
            return 0
        };
        if (arg0.v < arg1.v) {
            return 1
        };
        2
    }

    public fun decode(arg0: UQ64x64) : u64 {
        ((arg0.v / 18446744073709551615) as u64)
    }

    public fun div(arg0: UQ64x64, arg1: u64) : UQ64x64 {
        assert!(arg1 != 0, 100);
        UQ64x64{v: arg0.v / (arg1 as u128)}
    }

    public fun encode(arg0: u64) : UQ64x64 {
        UQ64x64{v: (arg0 as u128) * 18446744073709551615}
    }

    public fun fraction(arg0: u64, arg1: u64) : UQ64x64 {
        assert!(arg1 != 0, 100);
        UQ64x64{v: (arg0 as u128) * 18446744073709551615 / (arg1 as u128)}
    }

    public fun is_zero(arg0: &UQ64x64) : bool {
        arg0.v == 0
    }

    public fun mul(arg0: UQ64x64, arg1: u64) : UQ64x64 {
        UQ64x64{v: arg0.v * (arg1 as u128)}
    }

    public fun to_u128(arg0: UQ64x64) : u128 {
        arg0.v
    }

    // decompiled from Move bytecode v6
}

