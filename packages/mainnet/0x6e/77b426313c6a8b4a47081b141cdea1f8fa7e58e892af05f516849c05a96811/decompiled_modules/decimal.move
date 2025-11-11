module 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal {
    struct Decimal has copy, drop, store {
        value: u256,
    }

    public fun add(arg0: Decimal, arg1: Decimal) : Decimal {
        let v0 = arg0.value + arg1.value;
        assert!(v0 <= 18446744073709551615000000000000000000, 1);
        Decimal{value: v0}
    }

    public fun ceil_u64(arg0: Decimal) : u64 {
        let v0 = (1000000000000000000 - 1 + arg0.value) / 1000000000000000000;
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
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
        assert!(arg1.value > 0, 2);
        let v0 = arg0.value * 1000000000000000000 / arg1.value;
        assert!(v0 <= 18446744073709551615000000000000000000, 1);
        Decimal{value: v0}
    }

    public fun div_by_rate(arg0: Decimal, arg1: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate) : Decimal {
        div(arg0, from_rate(arg1))
    }

    public fun div_by_u64(arg0: Decimal, arg1: u64) : Decimal {
        assert!(arg1 > 0, 2);
        Decimal{value: arg0.value / (arg1 as u256)}
    }

    public fun eq(arg0: &Decimal, arg1: &Decimal) : bool {
        arg0.value == arg1.value
    }

    public fun floor_u64(arg0: Decimal) : u64 {
        let v0 = arg0.value / 1000000000000000000;
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    public fun from_rate(arg0: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate) : Decimal {
        Decimal{value: (0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::to_raw(arg0) as u256)}
    }

    public fun from_raw(arg0: u256) : Decimal {
        assert!(arg0 <= 18446744073709551615000000000000000000, 1);
        Decimal{value: arg0}
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
        let v0 = arg0.value * arg1.value / 1000000000000000000;
        assert!(v0 <= 18446744073709551615000000000000000000, 1);
        Decimal{value: v0}
    }

    public fun mul_div(arg0: Decimal, arg1: Decimal, arg2: Decimal) : Decimal {
        assert!(arg2.value > 0, 2);
        let v0 = if (arg0.value > 0) {
            if (arg1.value > 0) {
                arg0.value > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1.value
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            let v2 = arg0.value / arg2.value * arg1.value;
            assert!(v2 <= 18446744073709551615000000000000000000, 1);
            Decimal{value: v2}
        } else {
            let v3 = arg0.value * arg1.value / arg2.value;
            assert!(v3 <= 18446744073709551615000000000000000000, 1);
            Decimal{value: v3}
        }
    }

    public fun mul_div_by_64(arg0: Decimal, arg1: Decimal, arg2: u64) : Decimal {
        assert!(arg2 > 0, 2);
        mul_div(arg0, arg1, from_u64(arg2))
    }

    public fun mul_with_rate(arg0: Decimal, arg1: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate) : Decimal {
        mul(arg0, from_rate(arg1))
    }

    public fun mul_with_u64(arg0: Decimal, arg1: u64) : Decimal {
        let v0 = arg0.value * (arg1 as u256);
        assert!(v0 <= 18446744073709551615000000000000000000, 1);
        Decimal{value: v0}
    }

    public fun one() : Decimal {
        Decimal{value: 1000000000000000000}
    }

    public fun pow_u64(arg0: Decimal, arg1: u64) : Decimal {
        if (arg1 == 0) {
            return one()
        };
        if (is_zero(&arg0)) {
            return zero()
        };
        let v0 = one();
        let v1 = arg1;
        while (v1 > 0) {
            if (v1 % 2 == 1) {
                v0 = mul(v0, arg0);
            };
            v1 = v1 / 2;
            if (v1 > 0) {
                arg0 = mul(arg0, arg0);
            };
        };
        v0
    }

    public fun round_u64(arg0: Decimal) : u64 {
        let v0 = (arg0.value + 500000000000000000) / 1000000000000000000;
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    public fun sub(arg0: Decimal, arg1: Decimal) : Decimal {
        let v0 = arg0.value - arg1.value;
        assert!(v0 <= 18446744073709551615000000000000000000, 1);
        Decimal{value: v0}
    }

    public fun to_rate(arg0: Decimal) : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate {
        assert!(arg0.value <= (340282366920938463463374607431768211455 as u256), 1);
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::from_raw((arg0.value as u128))
    }

    public fun to_raw(arg0: Decimal) : u256 {
        arg0.value
    }

    public fun truncate_decimal(arg0: Decimal) : u64 {
        let v0 = to_raw(arg0) / 1000000000000;
        assert!(v0 <= (18446744073709551615 as u256), 1);
        (v0 as u64)
    }

    public fun zero() : Decimal {
        Decimal{value: 0}
    }

    // decompiled from Move bytecode v6
}

