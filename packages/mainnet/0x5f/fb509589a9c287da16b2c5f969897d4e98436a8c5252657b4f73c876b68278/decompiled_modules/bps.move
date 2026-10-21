module 0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::bps {
    struct Bps has copy, drop, store {
        pos0: u64,
    }

    public fun apply_up(arg0: Bps, arg1: u64) : u64 {
        0x1::u64::mul_div_ceil(arg1, value(arg0), 10000)
    }

    public fun new(arg0: u64) : Bps {
        assert!(arg0 <= 10000, 0);
        Bps{pos0: arg0}
    }

    public fun value(arg0: Bps) : u64 {
        let Bps { pos0: v0 } = arg0;
        v0
    }

    // decompiled from Move bytecode v7
}

