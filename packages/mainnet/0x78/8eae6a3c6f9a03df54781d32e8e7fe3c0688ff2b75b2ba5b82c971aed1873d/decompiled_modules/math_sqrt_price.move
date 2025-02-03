module 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_sqrt_price {
    public fun get_amount_a_delta(arg0: u128, arg1: u128, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::I128) : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::I128 {
        if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::is_neg(arg2)) {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::neg_from(get_amount_a_delta_(arg0, arg1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::abs_u128(arg2), false))
        } else {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::from(get_amount_a_delta_(arg0, arg1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::abs_u128(arg2), true))
        }
    }

    public fun get_amount_a_delta_(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u128 {
        assert!(arg0 > 0, 0);
        if (arg0 > arg1) {
            let v0 = arg1;
            arg1 = arg0;
            arg0 = v0;
        };
        let v1 = (arg0 as u256);
        let v2 = (arg1 as u256);
        let v3 = if (arg3) {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u256::div_round(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u256::div_round(((arg2 as u256) << 64) * (v2 - v1), v2, true), v1, true)
        } else {
            ((arg2 as u256) << 64) * (v2 - v1) / v2 / v1
        };
        (v3 as u128)
    }

    public fun get_amount_b_delta(arg0: u128, arg1: u128, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::I128) : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::I128 {
        if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::is_neg(arg2)) {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::neg_from(get_amount_b_delta_(arg0, arg1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::abs_u128(arg2), false))
        } else {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::from(get_amount_b_delta_(arg0, arg1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::abs_u128(arg2), true))
        }
    }

    public fun get_amount_b_delta_(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u128 {
        if (arg0 > arg1) {
            let v0 = arg1;
            arg1 = arg0;
            arg0 = v0;
        };
        if (arg3) {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u128::mul_div_round(arg2, arg1 - arg0, 18446744073709551616)
        } else {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u128::mul_div_floor(arg2, arg1 - arg0, 18446744073709551616)
        }
    }

    public fun get_next_sqrt_price(arg0: u128, arg1: u128, arg2: u128, arg3: bool, arg4: bool) : u128 {
        if (arg3 == arg4) {
            get_next_sqrt_price_from_amount_a_rounding_up(arg0, arg1, arg2, arg3)
        } else {
            get_next_sqrt_price_from_amount_b_rounding_down(arg0, arg1, arg2, arg3)
        }
    }

    fun get_next_sqrt_price_from_amount_a_rounding_up(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u128 {
        if (arg2 == 0) {
            return arg0
        };
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        let v2 = if (arg3) {
            (v1 << 64) + (arg2 as u256) * v0
        } else {
            (v1 << 64) - (arg2 as u256) * v0
        };
        (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u256::div_round(v1 * v0 << 64, v2, true) as u128)
    }

    fun get_next_sqrt_price_from_amount_b_rounding_down(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u128 {
        if (arg3) {
            let v1 = if (arg2 <= 18446744073709551615) {
                (arg2 << 64) / arg1
            } else {
                0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u128::mul_div_floor(arg2, 18446744073709551616, arg1)
            };
            arg0 + v1
        } else {
            let v2 = if (arg2 <= 18446744073709551615) {
                0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::checked_div_round(arg2 << 64, arg1, true)
            } else {
                0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u128::mul_div_round(arg2, 18446744073709551616, arg1)
            };
            assert!(arg0 > v2, 0);
            arg0 - v2
        }
    }

    public fun mul_div_round_fixed(arg0: u256, arg1: u256, arg2: u256) : u128 {
        (((arg0 * arg1 + (arg2 >> 1)) / arg2) as u128)
    }

    // decompiled from Move bytecode v6
}

