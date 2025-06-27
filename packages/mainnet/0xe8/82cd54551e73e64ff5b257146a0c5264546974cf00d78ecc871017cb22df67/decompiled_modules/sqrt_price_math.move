module 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::sqrt_price_math {
    public fun get_amount_x_delta(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            abort 1
        };
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        if (v0 == 0 || arg2 == 0) {
            return 0
        };
        let (v1, v2) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::math_u256::checked_shlw(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::full_math_u128::full_mul(arg2, v0));
        if (v2) {
            abort 0
        };
        (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::math_u256::div_round(v1, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::full_math_u128::full_mul(arg0, arg1), arg3) as u64)
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
        (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::math_u256::div_round(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::full_math_u128::full_mul(arg2, v0), (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::constants::get_q64() as u256), arg3) as u64)
    }

    public fun get_next_sqrt_price_from_amount_x_rouding_up(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        if (arg2 == 0) {
            return arg0
        };
        let (v0, v1) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::math_u256::checked_shlw(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::full_math_u128::full_mul(arg0, arg1));
        if (v1) {
            abort 0
        };
        let v2 = (arg1 as u256) << 64;
        let v3 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::full_math_u128::full_mul(arg0, (arg2 as u128));
        let v4 = if (arg3) {
            (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::math_u256::div_round(v0, v2 + v3, true) as u128)
        } else {
            if (v2 <= v3) {
                abort 2
            };
            (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::math_u256::div_round(v0, v2 - v3, true) as u128)
        };
        if (v4 > 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_sqrt_price() || v4 < 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_sqrt_price()) {
            abort 2
        };
        v4
    }

    public fun get_next_sqrt_price_from_amount_y_rouding_down(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        let v0 = (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::math_u256::div_round((arg2 as u256) << 64, (arg1 as u256), !arg3) as u128);
        let v1 = if (arg3) {
            arg0 + v0
        } else {
            if (arg0 <= v0) {
                abort 3
            };
            arg0 - v0
        };
        if (v1 > 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_sqrt_price() || v1 < 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_sqrt_price()) {
            abort 2
        };
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

