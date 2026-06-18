module 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign {
    struct FixedPoint64WithSign has copy, drop, store {
        value: u128,
        positive: bool,
    }

    public fun create_from_rational(arg0: u128, arg1: u128, arg2: bool) : FixedPoint64WithSign {
        normalize(0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::get_raw_value(0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::create_from_rational(arg0, arg1)), arg2)
    }

    public fun create_from_raw_value(arg0: u128, arg1: bool) : FixedPoint64WithSign {
        normalize(arg0, arg1)
    }

    public fun get_raw_value(arg0: FixedPoint64WithSign) : u128 {
        arg0.value
    }

    public fun truncate(arg0: FixedPoint64WithSign) : u64 {
        0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::truncate(to_unsigned_checked(arg0))
    }

    public fun abs(arg0: FixedPoint64WithSign) : 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64 {
        0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::create_from_raw_value(arg0.value)
    }

    public fun abs_truncate(arg0: FixedPoint64WithSign) : u64 {
        0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::truncate(abs(arg0))
    }

    public fun add(arg0: FixedPoint64WithSign, arg1: FixedPoint64WithSign) : FixedPoint64WithSign {
        if (arg0.positive == arg1.positive) {
            let v0 = (arg0.value as u256) + (arg1.value as u256);
            assert!(v0 <= 340282366920938463463374607431768211455, 0);
            return normalize((v0 as u128), arg0.positive)
        };
        if (arg0.value >= arg1.value) {
            normalize(arg0.value - arg1.value, arg0.positive)
        } else {
            normalize(arg1.value - arg0.value, arg1.positive)
        }
    }

    public fun assert_positive(arg0: FixedPoint64WithSign) : FixedPoint64WithSign {
        assert!(is_positive(arg0), 3);
        arg0
    }

    fun count_negative(arg0: FixedPoint64WithSign) : u8 {
        if (!is_zero(arg0) && !is_positive(arg0)) {
            1
        } else {
            0
        }
    }

    public fun div(arg0: FixedPoint64WithSign, arg1: FixedPoint64WithSign) : FixedPoint64WithSign {
        assert!(!is_zero(arg1), 1);
        create_from_raw_value(0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_floor(get_raw_value(arg0), 18446744073709551616, get_raw_value(arg1)), same_sign(arg0, arg1))
    }

    public fun exp(arg0: FixedPoint64WithSign) : FixedPoint64WithSign {
        let v0 = 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_floor(get_raw_value(arg0), 18446744073709551616, 12786308645202655660);
        assert!(v0 <= 1162144876643701751808, 0);
        if (!is_positive(arg0)) {
            return create_from_raw_value(0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_floor(18446744073709551616, 18446744073709551616, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::log_exp::exp2(v0)), true)
        };
        create_from_raw_value(0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::log_exp::exp2(v0), true)
    }

    public fun from_uint64(arg0: u64) : FixedPoint64WithSign {
        normalize((arg0 as u128) << 64, true)
    }

    public fun greater(arg0: FixedPoint64WithSign, arg1: FixedPoint64WithSign) : bool {
        if (arg0.positive != arg1.positive) {
            return arg0.positive
        };
        arg0.positive && arg0.value > arg1.value || arg0.value < arg1.value
    }

    public fun greater_or_equal(arg0: FixedPoint64WithSign, arg1: FixedPoint64WithSign) : bool {
        !less(arg0, arg1)
    }

    public fun is_equal(arg0: FixedPoint64WithSign, arg1: FixedPoint64WithSign) : bool {
        arg0.value == arg1.value && arg0.positive == arg1.positive
    }

    public fun is_positive(arg0: FixedPoint64WithSign) : bool {
        arg0.positive
    }

    public fun is_zero(arg0: FixedPoint64WithSign) : bool {
        arg0.value == 0
    }

    public fun less(arg0: FixedPoint64WithSign, arg1: FixedPoint64WithSign) : bool {
        if (arg0.positive != arg1.positive) {
            return !arg0.positive
        };
        arg0.positive && arg0.value < arg1.value || arg0.value > arg1.value
    }

    public fun less_or_equal(arg0: FixedPoint64WithSign, arg1: FixedPoint64WithSign) : bool {
        !greater(arg0, arg1)
    }

    public fun ln(arg0: FixedPoint64WithSign) : FixedPoint64WithSign {
        assert!(is_positive(arg0) && !is_zero(arg0), 2);
        let v0 = 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::log_exp::log2_u128(get_raw_value(arg0));
        let v1 = 1180591620717411303424;
        let v2 = v0 >= v1;
        let v3 = if (v2) {
            v0 - v1
        } else {
            v1 - v0
        };
        create_from_raw_value(((v3 * (12786308645202655660 as u256) >> 64) as u128), v2)
    }

    public fun mul(arg0: FixedPoint64WithSign, arg1: FixedPoint64WithSign) : FixedPoint64WithSign {
        create_from_raw_value(0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_floor(get_raw_value(arg0), get_raw_value(arg1), 18446744073709551616), result_sign(arg0, arg1, one()))
    }

    public fun mul_div(arg0: FixedPoint64WithSign, arg1: FixedPoint64WithSign, arg2: FixedPoint64WithSign) : FixedPoint64WithSign {
        assert!(!is_zero(arg2), 1);
        create_from_raw_value(0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_floor(get_raw_value(arg0), get_raw_value(arg1), get_raw_value(arg2)), result_sign(arg0, arg1, arg2))
    }

    public fun neg(arg0: FixedPoint64WithSign) : FixedPoint64WithSign {
        if (arg0.value == 0) {
            zero()
        } else {
            FixedPoint64WithSign{value: arg0.value, positive: !arg0.positive}
        }
    }

    fun normalize(arg0: u128, arg1: bool) : FixedPoint64WithSign {
        let v0 = arg0 == 0 || arg1;
        FixedPoint64WithSign{
            value    : arg0,
            positive : v0,
        }
    }

    public fun one() : FixedPoint64WithSign {
        from_uint64(1)
    }

    public fun remove_sign(arg0: FixedPoint64WithSign) : 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64 {
        to_unsigned_checked(arg0)
    }

    public fun remove_sign_and_truncate(arg0: FixedPoint64WithSign) : u64 {
        truncate(arg0)
    }

    fun result_sign(arg0: FixedPoint64WithSign, arg1: FixedPoint64WithSign, arg2: FixedPoint64WithSign) : bool {
        (count_negative(arg0) + count_negative(arg1) + count_negative(arg2)) % 2 == 0
    }

    fun same_sign(arg0: FixedPoint64WithSign, arg1: FixedPoint64WithSign) : bool {
        is_positive(arg0) == is_positive(arg1)
    }

    public fun sub(arg0: FixedPoint64WithSign, arg1: FixedPoint64WithSign) : FixedPoint64WithSign {
        add(arg0, neg(arg1))
    }

    public fun to_unsigned_checked(arg0: FixedPoint64WithSign) : 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64 {
        let v0 = assert_positive(arg0);
        0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::create_from_raw_value(v0.value)
    }

    public fun zero() : FixedPoint64WithSign {
        FixedPoint64WithSign{
            value    : 0,
            positive : true,
        }
    }

    // decompiled from Move bytecode v7
}

