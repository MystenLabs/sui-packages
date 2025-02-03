module 0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::sqrt_price_math {
    public fun get_amount_x_delta(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u64 {
        assert!(arg0 > 0 && arg1 > 0, 0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::error::invalid_price_bounds());
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        if (v0 == 0 || arg2 == 0) {
            return 0
        };
        let (v1, v2) = 0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::math_u256::checked_shlw(0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::full_math_u128::full_mul(arg2, v0));
        assert!(!v2, 0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::error::overflow());
        (0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::math_u256::div_round(v1, 0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::full_math_u128::full_mul(arg0, arg1), arg3) as u64)
    }

    public fun get_amount_y_delta(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u64 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        if (v0 == 0 || arg2 == 0) {
            return 0
        };
        (0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::math_u256::div_round(0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::full_math_u128::full_mul(arg2, v0), (0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::constants::q64() as u256), arg3) as u64)
    }

    public fun get_next_sqrt_price_from_amount_x_rouding_up(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        if (arg2 == 0) {
            return arg0
        };
        let (v0, v1) = 0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::math_u256::checked_shlw(0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::full_math_u128::full_mul(arg0, arg1));
        assert!(!v1, 0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::error::overflow());
        let v2 = (arg1 as u256) << 64;
        let v3 = 0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::full_math_u128::full_mul(arg0, (arg2 as u128));
        let v4 = if (arg3) {
            (0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::math_u256::div_round(v0, v2 + v3, true) as u128)
        } else {
            assert!(v2 > v3, 0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::error::invalid_liquidity_scalled());
            (0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::math_u256::div_round(v0, v2 - v3, true) as u128)
        };
        assert!(v4 <= 0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::tick_math::max_sqrt_price() && v4 >= 0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::tick_math::min_sqrt_price(), 0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::error::invalid_next_price());
        v4
    }

    public fun get_next_sqrt_price_from_amount_y_rouding_down(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        let v0 = (0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::math_u256::div_round((arg2 as u256) << 64, (arg1 as u256), !arg3) as u128);
        let v1 = if (arg3) {
            arg0 + v0
        } else {
            assert!(arg0 > v0, 0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::error::invalid_current_price());
            arg0 - v0
        };
        assert!(v1 <= 0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::tick_math::max_sqrt_price() && v1 >= 0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::tick_math::min_sqrt_price(), 0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::error::invalid_next_price());
        v1
    }

    public fun get_next_sqrt_price_from_input(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        assert!(arg0 > 0 && arg1 > 0, 4);
        if (arg3) {
            get_next_sqrt_price_from_amount_x_rouding_up(arg0, arg1, arg2, true)
        } else {
            get_next_sqrt_price_from_amount_y_rouding_down(arg0, arg1, arg2, true)
        }
    }

    public fun get_next_sqrt_price_from_output(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        assert!(arg0 > 0 && arg1 > 0, 4);
        if (arg3) {
            get_next_sqrt_price_from_amount_y_rouding_down(arg0, arg1, arg2, false)
        } else {
            get_next_sqrt_price_from_amount_x_rouding_up(arg0, arg1, arg2, false)
        }
    }

    // decompiled from Move bytecode v6
}

