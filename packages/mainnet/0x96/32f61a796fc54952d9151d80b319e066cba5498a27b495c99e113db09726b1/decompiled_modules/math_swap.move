module 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_swap {
    public fun compute_swap(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: bool, arg5: u32) : (u128, u128, u128, u128) {
        let v0 = arg0 >= arg1;
        let v1 = get_amount_fixed_delta(arg0, arg1, arg2, arg4, v0);
        let v2 = v1;
        let v3 = arg3;
        if (arg4) {
            v3 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u128::mul_div_floor(arg3, ((1000000 - arg5) as u128), 1000000);
        };
        let v4 = if (v3 >= v1) {
            arg1
        } else {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_sqrt_price::get_next_sqrt_price(arg0, arg2, v3, arg4, v0)
        };
        let v5 = v4 == arg1;
        if (!v5) {
            v2 = get_amount_fixed_delta(arg0, v4, arg2, arg4, v0);
        };
        let (v6, v7) = if (arg4) {
            (v2, get_amount_unfixed_delta(arg0, v4, arg2, arg4, v0))
        } else {
            (get_amount_unfixed_delta(arg0, v4, arg2, arg4, v0), v2)
        };
        let v8 = v7;
        if (!arg4 && v7 > arg3) {
            v8 = arg3;
        };
        let v9 = if (arg4 && !v5) {
            arg3 - v6
        } else {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u128::mul_div_round(v6, (arg5 as u128), ((1000000 - arg5) as u128))
        };
        (v4, v6, v8, v9)
    }

    public fun get_amount_fixed_delta(arg0: u128, arg1: u128, arg2: u128, arg3: bool, arg4: bool) : u128 {
        if (arg4 == arg3) {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_sqrt_price::get_amount_a_delta_(arg0, arg1, arg2, arg3)
        } else {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_sqrt_price::get_amount_b_delta_(arg0, arg1, arg2, arg3)
        }
    }

    public fun get_amount_unfixed_delta(arg0: u128, arg1: u128, arg2: u128, arg3: bool, arg4: bool) : u128 {
        if (arg4 == arg3) {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_sqrt_price::get_amount_b_delta_(arg0, arg1, arg2, !arg3)
        } else {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_sqrt_price::get_amount_a_delta_(arg0, arg1, arg2, !arg3)
        }
    }

    // decompiled from Move bytecode v6
}

