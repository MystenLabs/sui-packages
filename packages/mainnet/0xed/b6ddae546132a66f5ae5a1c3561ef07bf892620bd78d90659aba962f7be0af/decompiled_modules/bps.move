module 0xedb6ddae546132a66f5ae5a1c3561ef07bf892620bd78d90659aba962f7be0af::bps {
    struct Bps has copy, drop, store {
        pos0: u64,
    }

    public fun apply_up(arg0: Bps, arg1: u64) : u64 {
        0x1::u64::mul_div_ceil(arg1, value(arg0), 10000)
    }

    public(friend) fun denominator() : u64 {
        10000
    }

    public fun new(arg0: u64) : Bps {
        assert!(arg0 <= 10000, 13835058119706738690);
        Bps{pos0: arg0}
    }

    public fun value(arg0: Bps) : u64 {
        let Bps { pos0: v0 } = arg0;
        v0
    }

    // decompiled from Move bytecode v7
}

