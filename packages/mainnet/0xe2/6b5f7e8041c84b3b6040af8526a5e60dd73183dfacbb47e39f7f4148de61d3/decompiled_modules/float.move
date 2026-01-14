module 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float {
    struct Decimal has copy, drop, store {
        value: u256,
    }

    public fun add(arg0: Decimal, arg1: Decimal) : Decimal {
        Decimal{value: ensure_decimal_value_safe(arg0.value + arg1.value)}
    }

    public fun add_u64(arg0: &Decimal, arg1: u64) : Decimal {
        Decimal{value: ensure_decimal_value_safe(arg0.value + (arg1 as u256) * 1000000000000000000)}
    }

    public fun ceil(arg0: Decimal) : u64 {
        (ensure_decimal_value_safe((arg0.value + 1000000000000000000 - 1) / 1000000000000000000) as u64)
    }

    public fun div(arg0: Decimal, arg1: Decimal) : Decimal {
        Decimal{value: ensure_decimal_value_safe(arg0.value * 1000000000000000000 / arg1.value)}
    }

    public fun div_u64(arg0: Decimal, arg1: u64) : Decimal {
        div(arg0, from(arg1))
    }

    fun ensure_decimal_value_safe(arg0: u256) : u256 {
        assert!(arg0 <= 18446744073709551615000000000000000000, 2);
        arg0
    }

    public fun eq(arg0: Decimal, arg1: Decimal) : bool {
        arg0.value == arg1.value
    }

    public fun floor(arg0: Decimal) : u64 {
        (ensure_decimal_value_safe(arg0.value / 1000000000000000000) as u64)
    }

    public fun from(arg0: u64) : Decimal {
        Decimal{value: (arg0 as u256) * 1000000000000000000}
    }

    public fun from_percent(arg0: u8) : Decimal {
        Decimal{value: (arg0 as u256) * 1000000000000000000 / 100}
    }

    public fun from_quotient(arg0: u64, arg1: u64) : Decimal {
        Decimal{value: ensure_decimal_value_safe((arg0 as u256) * 1000000000000000000 / (arg1 as u256))}
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
        safe_from_u256(1000000000000000000 * (arg0 as u256) / arg1.value)
    }

    public fun int_mul(arg0: Decimal, arg1: u64) : u64 {
        safe_from_u256(arg0.value * (arg1 as u256) / 1000000000000000000)
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
        Decimal{value: ensure_decimal_value_safe(arg0.value * arg1.value / 1000000000000000000)}
    }

    public fun mul_u64(arg0: Decimal, arg1: u64) : Decimal {
        mul(arg0, from(arg1))
    }

    public fun one() : Decimal {
        from(1)
    }

    fun safe_from_u256(arg0: u256) : u64 {
        assert!(arg0 <= 18446744073709551615, 1);
        (arg0 as u64)
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

