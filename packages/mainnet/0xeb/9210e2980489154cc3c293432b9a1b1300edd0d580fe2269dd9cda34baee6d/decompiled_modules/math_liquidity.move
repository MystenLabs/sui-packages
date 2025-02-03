module 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity {
    public fun add_delta(arg0: u128, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::I128) : u128 {
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::abs_u128(arg1);
        if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::is_neg(arg1)) {
            assert!(arg0 >= v0, 0);
            arg0 - v0
        } else {
            let v2 = arg0 + v0;
            assert!(v2 >= arg0, 0);
            v2
        }
    }

    public fun get_amount_a_for_liquidity(arg0: u128, arg1: u128, arg2: u128) : u128 {
        if (arg0 > arg1) {
            let v0 = arg1;
            arg1 = arg0;
            arg0 = v0;
        };
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u128::mul_div_floor(arg2 << 64, arg1 - arg0, arg1) / arg0
    }

    public fun get_amount_b_for_liquidity(arg0: u128, arg1: u128, arg2: u128) : u128 {
        if (arg0 > arg1) {
            let v0 = arg1;
            arg1 = arg0;
            arg0 = v0;
        };
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u128::mul_div_floor(arg2, arg1 - arg0, 18446744073709551616)
    }

    public fun get_amount_for_liquidity(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : (u128, u128) {
        if (arg1 > arg2) {
            let v0 = arg2;
            arg2 = arg1;
            arg1 = v0;
        };
        let v1 = 0;
        let v2 = 0;
        if (arg0 <= arg1) {
            v1 = get_amount_a_for_liquidity(arg1, arg2, arg3);
        } else if (arg0 < arg2) {
            v1 = get_amount_a_for_liquidity(arg0, arg2, arg3);
            v2 = get_amount_b_for_liquidity(arg1, arg0, arg3);
        } else {
            v2 = get_amount_b_for_liquidity(arg1, arg2, arg3);
        };
        (v1, v2)
    }

    public fun get_liquidity_for_amount_a(arg0: u128, arg1: u128, arg2: u128) : u128 {
        if (arg0 > arg1) {
            let v0 = arg1;
            arg1 = arg0;
            arg0 = v0;
        };
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u128::mul_div_floor(arg2, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u128::mul_div_floor(arg0, arg1, 18446744073709551616), arg1 - arg0)
    }

    public fun get_liquidity_for_amount_b(arg0: u128, arg1: u128, arg2: u128) : u128 {
        if (arg0 > arg1) {
            let v0 = arg1;
            arg1 = arg0;
            arg0 = v0;
        };
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u128::mul_div_floor(arg2, 18446744073709551616, arg1 - arg0)
    }

    public fun get_liquidity_for_amounts(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128) : u128 {
        if (arg1 > arg2) {
            let v0 = arg2;
            arg2 = arg1;
            arg1 = v0;
        };
        if (arg0 <= arg1) {
            get_liquidity_for_amount_a(arg1, arg2, arg3)
        } else if (arg0 < arg2) {
            let v2 = get_liquidity_for_amount_a(arg0, arg2, arg3);
            let v3 = get_liquidity_for_amount_b(arg1, arg0, arg4);
            if (v2 < v3) {
                v2
            } else {
                v3
            }
        } else {
            get_liquidity_for_amount_b(arg1, arg2, arg4)
        }
    }

    // decompiled from Move bytecode v6
}

