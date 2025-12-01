module 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float {
    struct Decimal has copy, drop, store {
        value: u256,
    }

    public fun add(arg0: Decimal, arg1: Decimal) : Decimal {
        Decimal{value: arg0.value + arg1.value}
    }

    public fun add_u64(arg0: &Decimal, arg1: u64) : Decimal {
        Decimal{value: arg0.value + (arg1 as u256) * 1000000000000000000}
    }

    public fun ceil(arg0: Decimal) : u64 {
        (((arg0.value + 1000000000000000000 - 1) / 1000000000000000000) as u64)
    }

    public fun div(arg0: Decimal, arg1: Decimal) : Decimal {
        Decimal{value: arg0.value * 1000000000000000000 / arg1.value}
    }

    public fun div_u64(arg0: Decimal, arg1: u64) : Decimal {
        div(arg0, from(arg1))
    }

    public fun eq(arg0: Decimal, arg1: Decimal) : bool {
        arg0.value == arg1.value
    }

    public fun floor(arg0: Decimal) : u64 {
        ((arg0.value / 1000000000000000000) as u64)
    }

    public fun from(arg0: u64) : Decimal {
        Decimal{value: (arg0 as u256) * 1000000000000000000}
    }

    public fun from_percent(arg0: u8) : Decimal {
        Decimal{value: (arg0 as u256) * 1000000000000000000 / 100}
    }

    public fun from_quotient(arg0: u64, arg1: u64) : Decimal {
        Decimal{value: (arg0 as u256) * 1000000000000000000 / (arg1 as u256)}
    }

    public fun ge(arg0: Decimal, arg1: Decimal) : bool {
        arg0.value >= arg1.value
    }

    public fun ge_u64(arg0: Decimal, arg1: u64) : bool {
        arg0.value >= (arg1 as u256) * 1000000000000000000
    }

    public fun gt(arg0: Decimal, arg1: Decimal) : bool {
        arg0.value > arg1.value
    }

    public fun gt_u64(arg0: &Decimal, arg1: u64) : bool {
        arg0.value > (arg1 as u256) * 1000000000000000000
    }

    public fun int_div(arg0: u64, arg1: Decimal) : u64 {
        0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::u64::safe_from_u256(1000000000000000000 * (arg0 as u256) / arg1.value)
    }

    public fun int_mul(arg0: Decimal, arg1: u64) : u64 {
        0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::u64::safe_from_u256(arg0.value * (arg1 as u256) / 1000000000000000000)
    }

    public fun is_zero(arg0: &Decimal) : bool {
        arg0.value == 0
    }

    public fun le(arg0: Decimal, arg1: Decimal) : bool {
        arg0.value <= arg1.value
    }

    public fun lt(arg0: Decimal, arg1: Decimal) : bool {
        arg0.value < arg1.value
    }

    public fun min(arg0: Decimal, arg1: Decimal) : Decimal {
        if (lt(arg0, arg1)) {
            arg0
        } else {
            arg1
        }
    }

    public fun mul(arg0: Decimal, arg1: Decimal) : Decimal {
        Decimal{value: arg0.value * arg1.value / 1000000000000000000}
    }

    public fun mul_u64(arg0: Decimal, arg1: u64) : Decimal {
        mul(arg0, from(arg1))
    }

    public fun one() : Decimal {
        from(1)
    }

    public fun saturating_sub(arg0: Decimal, arg1: Decimal) : Decimal {
        if (arg0.value < arg1.value) {
            Decimal{value: 0}
        } else {
            Decimal{value: arg0.value - arg1.value}
        }
    }

    public fun sub(arg0: Decimal, arg1: Decimal) : Decimal {
        Decimal{value: arg0.value - arg1.value}
    }

    public fun sub_u64(arg0: Decimal, arg1: u64) : Decimal {
        sub(arg0, from(arg1))
    }

    public fun zero() : Decimal {
        Decimal{value: 0}
    }

    // decompiled from Move bytecode v6
}

