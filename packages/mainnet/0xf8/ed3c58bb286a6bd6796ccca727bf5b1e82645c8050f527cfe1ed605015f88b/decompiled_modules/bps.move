module 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps {
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

