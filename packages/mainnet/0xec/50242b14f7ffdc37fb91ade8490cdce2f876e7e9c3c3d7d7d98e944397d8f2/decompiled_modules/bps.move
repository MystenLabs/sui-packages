module 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps {
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
        (((arg0.pos0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    public fun calc_up(arg0: BPS, arg1: u64) : u64 {
        let v0 = (arg0.pos0 as u128);
        let v1 = (arg1 as u128);
        let v2 = 10000;
        let v3 = if (v0 * v1 % v2 > 0) {
            1
        } else {
            0
        };
        ((v0 * v1 / v2 + v3) as u64)
    }

    public fun div(arg0: BPS, arg1: u64) : BPS {
        assert!(arg1 != 0, 2);
        BPS{pos0: arg0.pos0 / arg1}
    }

    public fun div_up(arg0: BPS, arg1: u64) : BPS {
        assert!(arg1 != 0, 2);
        let v0 = if (arg0.pos0 == 0) {
            0
        } else {
            1 + (arg0.pos0 - 1) / arg1
        };
        BPS{pos0: v0}
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

