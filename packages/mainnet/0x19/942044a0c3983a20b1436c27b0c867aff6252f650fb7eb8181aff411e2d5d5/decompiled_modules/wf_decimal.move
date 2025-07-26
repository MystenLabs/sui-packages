module 0x19942044a0c3983a20b1436c27b0c867aff6252f650fb7eb8181aff411e2d5d5::wf_decimal {
    struct Decimal has copy, drop, store {
        value: u256,
    }

    public fun add(arg0: Decimal, arg1: Decimal) : Decimal {
        Decimal{value: arg0.value + arg1.value}
    }

    public fun ceil(arg0: Decimal) : u64 {
        (((arg0.value + 1000000000000000000 - 1) / 1000000000000000000) as u64)
    }

    public fun dec_mul(arg0: Decimal, arg1: Decimal) : Decimal {
        Decimal{value: (arg0.value * arg1.value + 1000000000000000000 / 2) / 1000000000000000000}
    }

    public fun dec_pow(arg0: Decimal, arg1: u64) : Decimal {
        if (arg1 > 525600000) {
            arg1 = 525600000;
        };
        let v0 = from(1);
        while (arg1 > 0) {
            if (arg1 % 2 == 1) {
                v0 = dec_mul(v0, arg0);
            };
            arg0 = dec_mul(arg0, arg0);
            arg1 = arg1 / 2;
        };
        v0
    }

    public fun div(arg0: Decimal, arg1: Decimal) : Decimal {
        Decimal{value: arg0.value * 1000000000000000000 / arg1.value}
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

    public fun from_bps(arg0: u64) : Decimal {
        Decimal{value: (arg0 as u256) * 1000000000000000000 / 10000}
    }

    public fun from_native_sui(arg0: u64) : Decimal {
        Decimal{value: (arg0 as u256) * 1000000000}
    }

    public fun from_native_token(arg0: u64, arg1: u256) : Decimal {
        Decimal{value: (arg0 as u256) * arg1}
    }

    public fun from_percent(arg0: u8) : Decimal {
        Decimal{value: (arg0 as u256) * 1000000000000000000 / 100}
    }

    public fun from_percent_u64(arg0: u64) : Decimal {
        Decimal{value: (arg0 as u256) * 1000000000000000000 / 100}
    }

    public fun from_q64(arg0: u128) : Decimal {
        let v0 = (arg0 as u256) * 1000000000000000000 / 18446744073709551616;
        assert!(v0 <= 18446744073709551615 * 1000000000000000000, 1);
        from_scaled_val(v0)
    }

    public fun from_scaled_val(arg0: u256) : Decimal {
        Decimal{value: arg0}
    }

    public fun ge(arg0: Decimal, arg1: Decimal) : bool {
        arg0.value >= arg1.value
    }

    public fun gt(arg0: Decimal, arg1: Decimal) : bool {
        arg0.value > arg1.value
    }

    public fun le(arg0: Decimal, arg1: Decimal) : bool {
        arg0.value <= arg1.value
    }

    public fun lt(arg0: Decimal, arg1: Decimal) : bool {
        arg0.value < arg1.value
    }

    public fun max(arg0: Decimal, arg1: Decimal) : Decimal {
        if (arg0.value > arg1.value) {
            arg0
        } else {
            arg1
        }
    }

    public fun min(arg0: Decimal, arg1: Decimal) : Decimal {
        if (arg0.value < arg1.value) {
            arg0
        } else {
            arg1
        }
    }

    public fun mul(arg0: Decimal, arg1: Decimal) : Decimal {
        Decimal{value: arg0.value * arg1.value / 1000000000000000000}
    }

    public fun one() : Decimal {
        Decimal{value: 1000000000000000000}
    }

    public fun pow(arg0: Decimal, arg1: u64) : Decimal {
        let v0 = from(1);
        while (arg1 > 0) {
            if (arg1 % 2 == 1) {
                v0 = mul(v0, arg0);
            };
            arg0 = mul(arg0, arg0);
            arg1 = arg1 / 2;
        };
        v0
    }

    public fun saturating_floor(arg0: Decimal) : u64 {
        if (arg0.value > 18446744073709551615 * 1000000000000000000) {
            (18446744073709551615 as u64)
        } else {
            floor(arg0)
        }
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

    public fun to_bps(arg0: Decimal) : u64 {
        ((arg0.value * 10000 / 1000000000000000000) as u64)
    }

    public fun to_native_sui(arg0: Decimal) : u64 {
        ((arg0.value / 1000000000) as u64)
    }

    public fun to_native_token(arg0: Decimal, arg1: u256) : u64 {
        ((arg0.value / arg1) as u64)
    }

    public fun to_scaled_val(arg0: Decimal) : u256 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

