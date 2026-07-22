module 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float {
    struct Decimal has copy, drop, store {
        value: u256,
    }

    public fun add(arg0: Decimal, arg1: Decimal) : Decimal {
        Decimal{value: ensure_decimal_value_safe(arg0.value + arg1.value)}
    }

    public fun div(arg0: Decimal, arg1: Decimal) : Decimal {
        Decimal{value: ensure_decimal_value_safe(arg0.value * 1000000000000000000 / arg1.value)}
    }

    fun ensure_decimal_value_safe(arg0: u256) : u256 {
        assert!(arg0 <= 18446744073709551615000000000000000000, 100002);
        arg0
    }

    public fun floor(arg0: Decimal) : u64 {
        safe_from_u256(arg0.value / 1000000000000000000)
    }

    public fun from(arg0: u64) : Decimal {
        Decimal{value: (arg0 as u256) * 1000000000000000000}
    }

    public fun mul(arg0: Decimal, arg1: Decimal) : Decimal {
        Decimal{value: ensure_decimal_value_safe(arg0.value * arg1.value / 1000000000000000000)}
    }

    fun safe_from_u256(arg0: u256) : u64 {
        assert!(arg0 <= 18446744073709551615, 100001);
        (arg0 as u64)
    }

    public fun sub(arg0: Decimal, arg1: Decimal) : Decimal {
        Decimal{value: arg0.value - arg1.value}
    }

    // decompiled from Move bytecode v7
}

