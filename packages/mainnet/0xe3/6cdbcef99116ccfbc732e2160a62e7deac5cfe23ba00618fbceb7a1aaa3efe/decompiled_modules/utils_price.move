module 0xe36cdbcef99116ccfbc732e2160a62e7deac5cfe23ba00618fbceb7a1aaa3efe::utils_price {
    fun consider_candidate(arg0: u64, arg1: u64, arg2: u128, arg3: u32, arg4: u32, arg5: u32, arg6: &mut u128, arg7: &mut u32, arg8: &mut bool, arg9: &mut u64) {
        if (arg5 > 4294967295 - arg4) {
            return
        };
        let v0 = arg5 + arg4;
        let (v1, v2) = max_liquidity_for_range(arg0, arg1, arg2, arg5, v0);
        let v3 = dist_to_range(arg3, arg5, v0);
        if (v1 > *arg6) {
            *arg6 = v1;
            *arg7 = arg5;
            *arg8 = v2;
            *arg9 = v3;
            return
        };
        if (v1 == *arg6 && v3 < *arg9) {
            *arg7 = arg5;
            *arg8 = v2;
            *arg9 = v3;
        };
    }

    fun dist_to_range(arg0: u32, arg1: u32, arg2: u32) : u64 {
        if (arg0 >= arg1 && arg0 < arg2) {
            return 0
        };
        if (arg0 < arg1) {
            return (arg1 as u64) - (arg0 as u64)
        };
        (arg0 as u64) - ((arg2 - 1) as u64)
    }

    public fun is_current_pos_one_of_three(arg0: u32, arg1: u32, arg2: u32, arg3: u32, arg4: u32) : bool {
        let v0 = arg2 - arg2 % arg3;
        let v1 = v0 + arg4;
        let v2 = if (v0 >= arg4) {
            v0 - arg4
        } else {
            0
        };
        if (arg0 == v0 && arg1 == v0 + arg4) {
            true
        } else if (arg0 == v1 && arg1 == v1 + arg4) {
            true
        } else {
            arg0 == v2 && arg1 == v2 + arg4
        }
    }

    public fun is_in_range_plus_hyst(arg0: u32, arg1: u32, arg2: u32, arg3: u32) : bool {
        let v0 = (arg2 as u64);
        let v1 = (arg3 as u64);
        !(v0 + v1 < (arg0 as u64)) && !(v0 >= (arg1 as u64) + v1)
    }

    public fun m_amount_for_usdc_value(arg0: u64, arg1: u128) : u64 {
        if (arg0 == 0) {
            return 0
        };
        assert!(arg1 > 0, 7);
        let v0 = (18446744073709551616 as u256);
        let v1 = (arg1 as u256);
        let v2 = (arg0 as u256) * v1 * v1 / v0 * v0;
        if (v2 > (18446744073709551615 as u256)) {
            18446744073709551615
        } else {
            (v2 as u64)
        }
    }

    public fun max_liquidity_for_range(arg0: u64, arg1: u64, arg2: u128, arg3: u32, arg4: u32) : (u128, bool) {
        if (arg3 >= arg4) {
            return (0, true)
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3));
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg4));
        let v2 = (arg0 as u128);
        let v3 = (arg1 as u128);
        if (arg2 <= v0) {
            let v4 = v1 - v0;
            if (v2 == 0 || v4 == 0) {
                return (0, true)
            };
            return (0xe36cdbcef99116ccfbc732e2160a62e7deac5cfe23ba00618fbceb7a1aaa3efe::utils_math::mul_div_u128(v2, 0xe36cdbcef99116ccfbc732e2160a62e7deac5cfe23ba00618fbceb7a1aaa3efe::utils_math::mul_div_u128(v1, v0, 18446744073709551616), v4), true)
        };
        if (arg2 >= v1) {
            let v5 = v1 - v0;
            if (v3 == 0 || v5 == 0) {
                return (0, false)
            };
            return (0xe36cdbcef99116ccfbc732e2160a62e7deac5cfe23ba00618fbceb7a1aaa3efe::utils_math::mul_div_u128(v3, 18446744073709551616, v5), false)
        };
        let v6 = if (v2 == 0) {
            0
        } else {
            0xe36cdbcef99116ccfbc732e2160a62e7deac5cfe23ba00618fbceb7a1aaa3efe::utils_math::mul_div_u128(v2, 0xe36cdbcef99116ccfbc732e2160a62e7deac5cfe23ba00618fbceb7a1aaa3efe::utils_math::mul_div_u128(v1, arg2, 18446744073709551616), v1 - arg2)
        };
        let v7 = if (v3 == 0) {
            0
        } else {
            0xe36cdbcef99116ccfbc732e2160a62e7deac5cfe23ba00618fbceb7a1aaa3efe::utils_math::mul_div_u128(v3, 18446744073709551616, arg2 - v0)
        };
        if (v6 <= v7) {
            (v6, true)
        } else {
            (v7, false)
        }
    }

    public fun pick_best_range_and_limit_side(arg0: u64, arg1: u64, arg2: u128, arg3: u32, arg4: u32, arg5: u32) : (u32, u32, bool) {
        let v0 = arg4 * arg5;
        let v1 = arg3 - arg3 % arg5;
        let v2 = 0;
        let v3 = true;
        let v4 = 18446744073709551615;
        let v5 = &mut v2;
        let v6 = &mut v1;
        let v7 = &mut v3;
        let v8 = &mut v4;
        consider_candidate(arg0, arg1, arg2, arg3, v0, v1, v5, v6, v7, v8);
        let v9 = 1;
        let v10 = v1;
        while (v9 <= arg4) {
            if (v10 < arg5) {
                break
            };
            v10 = v10 - arg5;
            let v11 = &mut v2;
            let v12 = &mut v1;
            let v13 = &mut v3;
            let v14 = &mut v4;
            consider_candidate(arg0, arg1, arg2, arg3, v0, v10, v11, v12, v13, v14);
            v9 = v9 + 1;
        };
        v9 = 1;
        let v15 = v1;
        while (v9 <= arg4) {
            if (v15 > 4294967295 - arg5) {
                break
            };
            v15 = v15 + arg5;
            let v16 = &mut v2;
            let v17 = &mut v1;
            let v18 = &mut v3;
            let v19 = &mut v4;
            consider_candidate(arg0, arg1, arg2, arg3, v0, v15, v16, v17, v18, v19);
            v9 = v9 + 1;
        };
        (v1, v1 + v0, v3)
    }

    public fun usdc_value_of_m_amount(arg0: u64, arg1: u128) : u64 {
        if (arg0 == 0) {
            return 0
        };
        assert!(arg1 > 0, 7);
        let v0 = (18446744073709551616 as u256);
        let v1 = (arg1 as u256);
        let v2 = (arg0 as u256) * v0 * v0 / v1 * v1;
        if (v2 > (18446744073709551615 as u256)) {
            18446744073709551615
        } else {
            (v2 as u64)
        }
    }

    // decompiled from Move bytecode v6
}

