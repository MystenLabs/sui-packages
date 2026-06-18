module 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal {
    struct Decimal has copy, drop, store {
        value: u256,
    }

    public fun add(arg0: Decimal, arg1: Decimal) : Decimal {
        Decimal{value: arg0.value + arg1.value}
    }

    public fun ceil(arg0: &Decimal) : u64 {
        let v0 = if (arg0.value == 0) {
            0
        } else {
            (arg0.value + 1000000000000000000 - 1) / 1000000000000000000
        };
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    public fun ceil_u128(arg0: &Decimal) : u128 {
        let v0 = if (arg0.value == 0) {
            0
        } else {
            (arg0.value + 1000000000000000000 - 1) / 1000000000000000000
        };
        (v0 as u128)
    }

    public fun div(arg0: Decimal, arg1: Decimal) : Decimal {
        assert!(arg1.value != 0, 0);
        Decimal{value: arg0.value * 1000000000000000000 / arg1.value}
    }

    public fun div_u256(arg0: Decimal, arg1: u256) : Decimal {
        assert!(arg1 != 0, 0);
        Decimal{value: arg0.value / arg1}
    }

    public fun div_u64(arg0: Decimal, arg1: u64) : Decimal {
        assert!(arg1 != 0, 0);
        Decimal{value: arg0.value / (arg1 as u256)}
    }

    public fun eq(arg0: Decimal, arg1: Decimal) : bool {
        arg0.value == arg1.value
    }

    public fun floor(arg0: &Decimal) : u64 {
        let v0 = arg0.value / 1000000000000000000;
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    public fun floor_u128(arg0: &Decimal) : u128 {
        ((arg0.value / 1000000000000000000) as u128)
    }

    public fun from(arg0: u64) : Decimal {
        Decimal{value: (arg0 as u256) * 1000000000000000000}
    }

    public fun from_bps(arg0: u64) : Decimal {
        Decimal{value: (arg0 as u256) * 1000000000000000000 / 10000}
    }

    public fun from_percent(arg0: u64) : Decimal {
        Decimal{value: (arg0 as u256) * 1000000000000000000 / 100}
    }

    public fun from_scaled(arg0: u256) : Decimal {
        Decimal{value: arg0}
    }

    public fun from_u128(arg0: u128) : Decimal {
        Decimal{value: (arg0 as u256) * 1000000000000000000}
    }

    public fun from_u256(arg0: u256) : Decimal {
        Decimal{value: arg0 * 1000000000000000000}
    }

    public fun ge(arg0: Decimal, arg1: Decimal) : bool {
        arg0.value >= arg1.value
    }

    public fun gt(arg0: Decimal, arg1: Decimal) : bool {
        arg0.value > arg1.value
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

    public fun max(arg0: Decimal, arg1: Decimal) : Decimal {
        if (arg0.value >= arg1.value) {
            arg0
        } else {
            arg1
        }
    }

    public fun min(arg0: Decimal, arg1: Decimal) : Decimal {
        if (arg0.value <= arg1.value) {
            arg0
        } else {
            arg1
        }
    }

    public fun mul(arg0: Decimal, arg1: Decimal) : Decimal {
        Decimal{value: arg0.value * arg1.value / 1000000000000000000}
    }

    public fun mul_bps(arg0: Decimal, arg1: u64) : Decimal {
        Decimal{value: arg0.value * (arg1 as u256) / 10000}
    }

    public fun mul_u128(arg0: Decimal, arg1: u128) : Decimal {
        Decimal{value: arg0.value * (arg1 as u256)}
    }

    public fun mul_u64(arg0: Decimal, arg1: u64) : Decimal {
        Decimal{value: arg0.value * (arg1 as u256)}
    }

    public fun one() : Decimal {
        Decimal{value: 1000000000000000000}
    }

    public fun pow(arg0: Decimal, arg1: u64) : Decimal {
        let v0 = one();
        let v1 = arg1;
        while (v1 > 0) {
            if (v1 & 1 == 1) {
                v0 = mul(v0, arg0);
            };
            v1 = v1 >> 1;
            if (v1 > 0) {
                arg0 = mul(arg0, arg0);
            };
        };
        v0
    }

    public fun sub(arg0: Decimal, arg1: Decimal) : Decimal {
        assert!(arg0.value >= arg1.value, 2);
        Decimal{value: arg0.value - arg1.value}
    }

    public fun sub_or_zero(arg0: Decimal, arg1: Decimal) : Decimal {
        if (arg0.value >= arg1.value) {
            Decimal{value: arg0.value - arg1.value}
        } else {
            Decimal{value: 0}
        }
    }

    public fun value(arg0: &Decimal) : u256 {
        arg0.value
    }

    public fun zero() : Decimal {
        Decimal{value: 0}
    }

    // decompiled from Move bytecode v7
}

