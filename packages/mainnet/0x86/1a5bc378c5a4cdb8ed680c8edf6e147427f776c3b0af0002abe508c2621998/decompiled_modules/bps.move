module 0x861a5bc378c5a4cdb8ed680c8edf6e147427f776c3b0af0002abe508c2621998::bps {
    struct BPS has copy, drop, store {
        pos0: u64,
    }

    public fun add(arg0: BPS, arg1: BPS) : BPS {
        BPS{pos0: assert_overflow(arg0.pos0 + arg1.pos0)}
    }

    fun assert_overflow(arg0: u64) : u64 {
        assert!(arg0 <= 10000, 0);
        arg0
    }

    public fun calc(arg0: BPS, arg1: u64) : u64 {
        (((arg0.pos0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun div(arg0: BPS, arg1: u64) : BPS {
        assert!(arg1 != 0, 2);
        BPS{pos0: arg0.pos0 / arg1}
    }

    public fun max_bps() : u64 {
        10000
    }

    public fun mul(arg0: BPS, arg1: u64) : BPS {
        BPS{pos0: assert_overflow(arg0.pos0 * arg1)}
    }

    public fun new(arg0: u64) : BPS {
        BPS{pos0: assert_overflow(arg0)}
    }

    public fun sub(arg0: BPS, arg1: BPS) : BPS {
        assert!(arg0.pos0 >= arg1.pos0, 1);
        BPS{pos0: arg0.pos0 - arg1.pos0}
    }

    public fun value(arg0: BPS) : u64 {
        arg0.pos0
    }

    // decompiled from Move bytecode v6
}

