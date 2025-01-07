module 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::rate {
    struct Rate has copy, drop, store {
        value: u128,
    }

    public fun add(arg0: Rate, arg1: Rate) : Rate {
        Rate{value: arg0.value + arg1.value}
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
        Rate{value: arg0.value / (arg1 as u128)}
    }

    public fun eq(arg0: &Rate, arg1: &Rate) : bool {
        arg0.value == arg1.value
    }

    public fun from_percent(arg0: u8) : Rate {
        Rate{value: (arg0 as u128) * 10000000000000000}
    }

    public fun from_permille(arg0: u16) : Rate {
        Rate{value: (arg0 as u128) * 1000000000000000}
    }

    public fun from_permyriad(arg0: u16) : Rate {
        Rate{value: (arg0 as u128) * 100000000000000}
    }

    public fun from_raw(arg0: u128) : Rate {
        Rate{value: arg0}
    }

    public fun from_u64(arg0: u64) : Rate {
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
        Rate{value: arg0.value * (arg1 as u128)}
    }

    public fun one() : Rate {
        Rate{value: 1000000000000000000}
    }

    public fun round_u64(arg0: Rate) : u64 {
        (((500000000000000000 + arg0.value) / 1000000000000000000) as u64)
    }

    public fun sub(arg0: Rate, arg1: Rate) : Rate {
        Rate{value: arg0.value - arg1.value}
    }

    public fun to_raw(arg0: Rate) : u128 {
        arg0.value
    }

    public fun zero() : Rate {
        Rate{value: 0}
    }

    // decompiled from Move bytecode v6
}

