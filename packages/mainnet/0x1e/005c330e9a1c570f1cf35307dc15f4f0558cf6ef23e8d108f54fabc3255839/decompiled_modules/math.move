module 0xdb1d6ee14a7fc1864361b87e194e893f5271b9f180ddf645b51b35301d0a854a::math {
    struct FixedDecimal has copy, drop, store {
        x: u64,
    }

    public fun add(arg0: FixedDecimal, arg1: FixedDecimal) : FixedDecimal {
        FixedDecimal{x: arg0.x + arg1.x}
    }

    public fun add_u64(arg0: FixedDecimal, arg1: u64) : FixedDecimal {
        let v0 = to_fixed_decimal(arg1);
        FixedDecimal{x: arg0.x + v0.x}
    }

    public fun div_u64(arg0: FixedDecimal, arg1: u64) : FixedDecimal {
        FixedDecimal{x: arg0.x / arg1}
    }

    public fun mul_u64(arg0: FixedDecimal, arg1: u64) : FixedDecimal {
        FixedDecimal{x: arg0.x * arg1}
    }

    public fun sub(arg0: FixedDecimal, arg1: FixedDecimal) : FixedDecimal {
        FixedDecimal{x: arg0.x - arg1.x}
    }

    public fun to_fixed_decimal(arg0: u64) : FixedDecimal {
        FixedDecimal{x: arg0 * 1000000000000000}
    }

    public fun to_raw_value(arg0: FixedDecimal) : u64 {
        arg0.x / 1000000000000000
    }

    // decompiled from Move bytecode v6
}

