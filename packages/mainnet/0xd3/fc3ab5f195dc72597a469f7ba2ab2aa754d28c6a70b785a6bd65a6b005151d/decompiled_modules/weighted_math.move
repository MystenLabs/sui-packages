module 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::weighted_math {
    fun absolute(arg0: 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64, arg1: 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64) : (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64, bool) {
        if (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::greater_or_equal(arg0, arg1)) {
            (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::sub(arg0, arg1), false)
        } else {
            (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::sub(arg1, arg0), true)
        }
    }

    public fun compute_derive_lp(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : u64 {
        (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::round(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::add(token_for_lp(arg0, arg4, arg2, arg6), token_for_lp(arg1, arg5, arg3, arg6))) as u64)
    }

    public fun compute_initial_lp(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::round(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::math_fixed64::mul_div(power(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128((arg2 as u128)), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_rational((arg0 as u128), (10000 as u128))), power(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128((arg3 as u128)), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_rational((arg1 as u128), (10000 as u128))), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128(1))) as u64)
    }

    public fun compute_optimal_value(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        get_amount_in(arg0, arg1, arg2, arg3, arg4)
    }

    public fun compute_withdrawn_coins(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64) {
        ((lp_for_token(((arg0 / 2) as u128), arg1, arg2, arg4) as u64), (lp_for_token(((arg0 / 2) as u128), arg1, arg3, arg5) as u64))
    }

    public fun get_amount_in(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = (arg3 as u128);
        if (arg2 == arg4) {
            (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::multiply_u128((arg1 as u128), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::sub(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_rational(v0, v0 - (arg0 as u128)), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128(1))) as u64)
        } else {
            (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::multiply_u128((arg1 as u128), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::sub(power(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_rational(v0, v0 - (arg0 as u128)), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_rational((arg4 as u128), (arg2 as u128))), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128(1))) as u64)
        }
    }

    public fun get_amount_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = (arg1 as u128);
        if (arg2 == arg4) {
            (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::multiply_u128((arg3 as u128), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::sub(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128(1), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_rational(v0, v0 + (arg0 as u128)))) as u64)
        } else {
            (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::multiply_u128((arg3 as u128), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::sub(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128(1), power(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_rational(v0, v0 + (arg0 as u128)), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_rational((arg2 as u128), (arg4 as u128))))) as u64)
        }
    }

    public fun get_fee_to_treasury(arg0: 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64, arg1: u64) : (u64, u64) {
        let v0 = (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::multiply_u128((arg1 as u128), arg0) as u64);
        (arg1 - v0, v0)
    }

    public fun ln(arg0: 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64) : 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64 {
        let (v0, _) = absolute(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::math_fixed64::log2_plus_64(arg0), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128(64));
        0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::math_fixed64::mul_div(v0, 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128(1), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_raw_value(26613026195707766742))
    }

    public fun lp_for_token(arg0: u128, arg1: u64, arg2: u64, arg3: u64) : u64 {
        (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::multiply_u128((arg2 as u128), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::sub(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128(1), power(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_rational(((arg1 - (arg0 as u64)) as u128), (arg1 as u128)), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_rational((10000 as u128), (arg3 as u128))))) as u64)
    }

    public fun nth_root(arg0: 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64, arg1: u64) : 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64 {
        if (arg1 == 0) {
            0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128(1)
        } else {
            let v1 = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_rational(1, 2);
            let v2 = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_rational(18446744073709551615, 1);
            while (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::greater(v2, 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_rational(1, 1000))) {
                let v3 = pow_raw(v1, arg1);
                let v4 = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::math_fixed64::mul_div(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128((arg1 as u128)), pow_raw(v1, arg1 - 1), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128(1));
                if (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::greater_or_equal(v3, arg0)) {
                    let v5 = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::math_fixed64::mul_div(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::sub(v3, arg0), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128(1), v4);
                    v2 = v5;
                    v1 = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::sub(v1, v5);
                    continue
                };
                v2 = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::math_fixed64::mul_div(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::sub(arg0, v3), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128(1), v4);
                v1 = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::add(v1, v2);
            };
            v1
        }
    }

    public fun pow_raw(arg0: 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64, arg1: u64) : 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64 {
        let v0 = (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::get_raw_value(arg0) as u256);
        let v1 = 18446744073709551616;
        while (arg1 != 0) {
            if (arg1 & 1 != 0) {
                let v2 = v1 * v0;
                v1 = v2 >> 64;
            };
            arg1 = arg1 >> 1;
            if (v0 <= 340282366920938463463374607431768211455) {
                let v3 = v0 * v0;
                v0 = v3 >> 64;
                continue
            };
            let v4 = v0 >> 32;
            let v5 = v0 >> 32;
            v0 = v4 * v5;
        };
        0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_raw_value((v1 as u128))
    }

    public fun power(arg0: 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64, arg1: 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64) : 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64 {
        if (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::equal(arg1, 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128(0))) {
            0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128(1)
        } else if (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::equal(arg1, 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128(1))) {
            arg0
        } else if (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::less(arg0, 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128(1))) {
            let v1 = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::floor(arg1);
            let v2 = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::sub(arg1, 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128(v1));
            if (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::equal(v2, 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128(0))) {
                0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::math_fixed64::pow(arg0, (v1 as u64))
            } else {
                0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::math_fixed64::mul_div(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::math_fixed64::pow(arg0, (v1 as u64)), nth_root(arg0, (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::round(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::math_fixed64::mul_div(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128(1), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128(1), v2)) as u64)), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128(1))
            }
        } else {
            0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::math_fixed64::exp(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::math_fixed64::mul_div(arg1, ln(arg0), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128(1)))
        }
    }

    public fun scale_amount(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    public fun token_for_lp(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64 {
        0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::math_fixed64::mul_div(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128((arg3 as u128)), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::sub(power(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_rational(((arg1 + arg0) as u128), (arg1 as u128)), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_rational((arg2 as u128), (10000 as u128))), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128(1)), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_u128(1))
    }

    // decompiled from Move bytecode v6
}

