module 0x8686b9667821db83a232193c61650d45f2495d23e6b97a9d33cb5286e81a7758::uq64x64 {
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

