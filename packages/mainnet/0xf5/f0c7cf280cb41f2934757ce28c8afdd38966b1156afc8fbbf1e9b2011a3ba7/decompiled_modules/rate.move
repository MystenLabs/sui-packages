module 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate {
    struct Rate has copy, drop, store {
        value: u128,
    }

    public fun add(arg0: Rate, arg1: Rate) : Rate {
        let v0 = arg0.value + arg1.value;
        assert!(v0 <= 340282366920938463463374607431768211455, 1);
        Rate{value: v0}
    }

    public fun diff(arg0: Rate, arg1: Rate) : Rate {
        let v0 = if (arg0.value > arg1.value) {
            arg0.value - arg1.value
        } else {
            arg1.value - arg0.value
        };
        Rate{value: v0}
    }

    public fun div_by_u64(arg0: Rate, arg1: u64) : Rate {
        assert!(arg1 > 0, 2);
        let v0 = arg0.value / (arg1 as u128);
        assert!(v0 <= 340282366920938463463374607431768211455, 1);
        Rate{value: v0}
    }

    public fun eq(arg0: &Rate, arg1: &Rate) : bool {
        arg0.value == arg1.value
    }

    public fun from_percent(arg0: u8) : Rate {
        Rate{value: (arg0 as u128) * 10000000000000000}
    }

    public fun from_permille(arg0: u16) : Rate {
        assert!((arg0 as u128) * 1000000000000000 <= 340282366920938463463374607431768211455, 1);
        Rate{value: (arg0 as u128) * 1000000000000000}
    }

    public fun from_permyriad(arg0: u16) : Rate {
        assert!((arg0 as u128) * 100000000000000 <= 340282366920938463463374607431768211455, 1);
        Rate{value: (arg0 as u128) * 100000000000000}
    }

    public fun from_raw(arg0: u128) : Rate {
        assert!(arg0 <= 340282366920938463463374607431768211455, 1);
        Rate{value: arg0}
    }

    public fun from_u64(arg0: u64) : Rate {
        assert!((arg0 as u128) * 1000000000000000000 <= 340282366920938463463374607431768211455, 1);
        Rate{value: (arg0 as u128) * 1000000000000000000}
    }

    public fun ge(arg0: &Rate, arg1: &Rate) : bool {
        arg0.value >= arg1.value
    }

    public fun gt(arg0: &Rate, arg1: &Rate) : bool {
        arg0.value > arg1.value
    }

    public fun is_one(arg0: &Rate) : bool {
        arg0.value == 1000000000000000000
    }

    public fun is_zero(arg0: &Rate) : bool {
        arg0.value == 0
    }

    public fun le(arg0: &Rate, arg1: &Rate) : bool {
        arg0.value <= arg1.value
    }

    public fun lt(arg0: &Rate, arg1: &Rate) : bool {
        arg0.value < arg1.value
    }

    public fun mul_with_u64(arg0: Rate, arg1: u64) : Rate {
        let v0 = arg0.value * (arg1 as u128);
        assert!(v0 <= 340282366920938463463374607431768211455, 1);
        Rate{value: v0}
    }

    public fun one() : Rate {
        Rate{value: 1000000000000000000}
    }

    public fun round_u64(arg0: Rate) : u64 {
        let v0 = (500000000000000000 + arg0.value) / 1000000000000000000;
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    public fun sub(arg0: Rate, arg1: Rate) : Rate {
        let v0 = arg0.value - arg1.value;
        assert!(v0 <= 340282366920938463463374607431768211455, 1);
        Rate{value: v0}
    }

    public fun to_raw(arg0: Rate) : u128 {
        arg0.value
    }

    public fun zero() : Rate {
        Rate{value: 0}
    }

    // decompiled from Move bytecode v6
}

