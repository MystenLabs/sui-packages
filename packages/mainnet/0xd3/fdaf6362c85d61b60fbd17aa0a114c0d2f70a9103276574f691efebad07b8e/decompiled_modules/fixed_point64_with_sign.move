module 0xd3fdaf6362c85d61b60fbd17aa0a114c0d2f70a9103276574f691efebad07b8e::fixed_point64_with_sign {
    struct FixedPoint64WithSign has copy, drop, store {
        value: u128,
        positive: bool,
    }

    public fun create_from_rational(arg0: u128, arg1: u128, arg2: bool) : FixedPoint64WithSign {
        FixedPoint64WithSign{
            value    : 0xd3fdaf6362c85d61b60fbd17aa0a114c0d2f70a9103276574f691efebad07b8e::fixed_point64::get_raw_value(0xd3fdaf6362c85d61b60fbd17aa0a114c0d2f70a9103276574f691efebad07b8e::fixed_point64::create_from_rational(arg0, arg1)),
            positive : arg2,
        }
    }

    public fun create_from_raw_value(arg0: u128, arg1: bool) : FixedPoint64WithSign {
        FixedPoint64WithSign{
            value    : arg0,
            positive : arg1,
        }
    }

    public fun get_raw_value(arg0: FixedPoint64WithSign) : u128 {
        arg0.value
    }

    public fun abs(arg0: FixedPoint64WithSign) : FixedPoint64WithSign {
        FixedPoint64WithSign{
            value    : get_raw_value(arg0),
            positive : true,
        }
    }

    public fun abs_u128(arg0: FixedPoint64WithSign) : u128 {
        get_raw_value(arg0)
    }

    public fun add(arg0: FixedPoint64WithSign, arg1: FixedPoint64WithSign) : FixedPoint64WithSign {
        let v0 = get_raw_value(arg0);
        let v1 = get_raw_value(arg1);
        let v2 = is_positive(arg0);
        let v3 = is_positive(arg1);
        let v4 = 0;
        let v5 = false;
        if (v2 && v3) {
            v4 = (v0 as u256) + (v1 as u256);
            v5 = true;
        } else {
            if (v2 && !v3) {
                if (v0 > v1) {
                    v4 = (v0 as u256) - (v1 as u256);
                    v5 = true;
                } else {
                    v4 = (v1 as u256) - (v0 as u256);
                    v5 = false;
                };
            };
            if (!v2 && v3) {
                if (v1 > v0) {
                    v4 = (v1 as u256) - (v0 as u256);
                    v5 = true;
                } else {
                    v4 = (v0 as u256) - (v1 as u256);
                    v5 = false;
                };
            };
            if (!v2 && !v3) {
                v4 = (v1 as u256) + (v0 as u256);
                v5 = false;
            };
        };
        assert!(v4 <= 340282366920938463463374607431768211455, 131077);
        create_from_raw_value((v4 as u128), v5)
    }

    public fun from_uint64(arg0: u64) : FixedPoint64WithSign {
        FixedPoint64WithSign{
            value    : (arg0 as u128) * 18446744073709551616,
            positive : true,
        }
    }

    public fun greater_or_equal(arg0: FixedPoint64WithSign, arg1: FixedPoint64WithSign) : bool {
        let v0 = sub(arg0, arg1);
        is_positive(v0) || get_raw_value(v0) == 0
    }

    public fun greater_or_equal_without_sign(arg0: FixedPoint64WithSign, arg1: FixedPoint64WithSign) : bool {
        arg0.value >= arg1.value
    }

    public fun is_equal(arg0: FixedPoint64WithSign, arg1: FixedPoint64WithSign) : bool {
        if (arg0.value == arg1.value && arg0.positive == arg1.positive) {
            return true
        };
        false
    }

    public fun is_positive(arg0: FixedPoint64WithSign) : bool {
        arg0.positive
    }

    public fun is_zero(arg0: FixedPoint64WithSign) : bool {
        arg0.value == 0
    }

    public fun less(arg0: FixedPoint64WithSign, arg1: FixedPoint64WithSign) : bool {
        is_positive(sub(arg1, arg0))
    }

    public fun less_or_equal(arg0: FixedPoint64WithSign, arg1: FixedPoint64WithSign) : bool {
        let v0 = sub(arg1, arg0);
        is_positive(v0) || is_zero(v0)
    }

    public fun neg(arg0: FixedPoint64WithSign) : FixedPoint64WithSign {
        FixedPoint64WithSign{
            value    : arg0.value,
            positive : !arg0.positive,
        }
    }

    public fun one() : FixedPoint64WithSign {
        FixedPoint64WithSign{
            value    : 18446744073709551616,
            positive : true,
        }
    }

    public fun remove_sign(arg0: FixedPoint64WithSign) : 0xd3fdaf6362c85d61b60fbd17aa0a114c0d2f70a9103276574f691efebad07b8e::fixed_point64::FixedPoint64 {
        0xd3fdaf6362c85d61b60fbd17aa0a114c0d2f70a9103276574f691efebad07b8e::fixed_point64::create_from_raw_value(get_raw_value(arg0))
    }

    public fun revert_sign(arg0: FixedPoint64WithSign) : FixedPoint64WithSign {
        FixedPoint64WithSign{
            value    : get_raw_value(arg0),
            positive : !arg0.positive,
        }
    }

    public fun sub(arg0: FixedPoint64WithSign, arg1: FixedPoint64WithSign) : FixedPoint64WithSign {
        add(arg0, revert_sign(arg1))
    }

    public fun truncate(arg0: FixedPoint64WithSign) : u64 {
        assert!(is_positive(arg0), 0);
        ((arg0.value / 18446744073709551616) as u64)
    }

    public fun zero() : FixedPoint64WithSign {
        FixedPoint64WithSign{
            value    : 0,
            positive : true,
        }
    }

    // decompiled from Move bytecode v6
}

