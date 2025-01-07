module 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal {
    struct Decimal has copy, drop, store {
        value: u256,
    }

    public fun add(arg0: Decimal, arg1: Decimal) : Decimal {
        Decimal{value: arg0.value + arg1.value}
    }

    public fun ceil_u64(arg0: Decimal) : u64 {
        (((1000000000000000000 - 1 + arg0.value) / 1000000000000000000) as u64)
    }

    public fun diff(arg0: Decimal, arg1: Decimal) : Decimal {
        let v0 = if (arg0.value > arg1.value) {
            arg0.value - arg1.value
        } else {
            arg1.value - arg0.value
        };
        Decimal{value: v0}
    }

    public fun div(arg0: Decimal, arg1: Decimal) : Decimal {
        Decimal{value: arg0.value * 1000000000000000000 / arg1.value}
    }

    public fun div_by_rate(arg0: Decimal, arg1: 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::Rate) : Decimal {
        div(arg0, from_rate(arg1))
    }

    public fun div_by_u64(arg0: Decimal, arg1: u64) : Decimal {
        Decimal{value: arg0.value / (arg1 as u256)}
    }

    public fun eq(arg0: &Decimal, arg1: &Decimal) : bool {
        arg0.value == arg1.value
    }

    public fun floor_u64(arg0: Decimal) : u64 {
        ((arg0.value / 1000000000000000000) as u64)
    }

    public fun from_rate(arg0: 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::Rate) : Decimal {
        Decimal{value: (0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::to_raw(arg0) as u256)}
    }

    public fun from_raw(arg0: u256) : Decimal {
        Decimal{value: arg0}
    }

    public fun from_u128(arg0: u128) : Decimal {
        Decimal{value: (arg0 as u256) * 1000000000000000000}
    }

    public fun from_u64(arg0: u64) : Decimal {
        Decimal{value: (arg0 as u256) * 1000000000000000000}
    }

    public fun ge(arg0: &Decimal, arg1: &Decimal) : bool {
        arg0.value >= arg1.value
    }

    public fun gt(arg0: &Decimal, arg1: &Decimal) : bool {
        arg0.value > arg1.value
    }

    public fun is_one(arg0: &Decimal) : bool {
        arg0.value == 1000000000000000000
    }

    public fun is_zero(arg0: &Decimal) : bool {
        arg0.value == 0
    }

    public fun le(arg0: &Decimal, arg1: &Decimal) : bool {
        arg0.value <= arg1.value
    }

    public fun lt(arg0: &Decimal, arg1: &Decimal) : bool {
        arg0.value < arg1.value
    }

    public fun mul(arg0: Decimal, arg1: Decimal) : Decimal {
        Decimal{value: arg0.value * arg1.value / 1000000000000000000}
    }

    public fun mul_with_rate(arg0: Decimal, arg1: 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::Rate) : Decimal {
        mul(arg0, from_rate(arg1))
    }

    public fun mul_with_u64(arg0: Decimal, arg1: u64) : Decimal {
        Decimal{value: arg0.value * (arg1 as u256)}
    }

    public fun one() : Decimal {
        Decimal{value: 1000000000000000000}
    }

    public fun round_u64(arg0: Decimal) : u64 {
        (((arg0.value + 500000000000000000) / 1000000000000000000) as u64)
    }

    public fun sub(arg0: Decimal, arg1: Decimal) : Decimal {
        Decimal{value: arg0.value - arg1.value}
    }

    public fun to_rate(arg0: Decimal) : 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::Rate {
        0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::from_raw((arg0.value as u128))
    }

    public fun to_raw(arg0: Decimal) : u256 {
        arg0.value
    }

    public fun zero() : Decimal {
        Decimal{value: 0}
    }

    // decompiled from Move bytecode v6
}

