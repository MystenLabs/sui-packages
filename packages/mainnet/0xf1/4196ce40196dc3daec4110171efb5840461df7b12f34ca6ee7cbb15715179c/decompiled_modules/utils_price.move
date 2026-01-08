module 0xf14196ce40196dc3daec4110171efb5840461df7b12f34ca6ee7cbb15715179c::utils_price {
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
            return (0xf14196ce40196dc3daec4110171efb5840461df7b12f34ca6ee7cbb15715179c::utils_math::mul_div_u128(v2, 0xf14196ce40196dc3daec4110171efb5840461df7b12f34ca6ee7cbb15715179c::utils_math::mul_div_u128(v1, v0, 18446744073709551616), v4), true)
        };
        if (arg2 >= v1) {
            let v5 = v1 - v0;
            if (v3 == 0 || v5 == 0) {
                return (0, false)
            };
            return (0xf14196ce40196dc3daec4110171efb5840461df7b12f34ca6ee7cbb15715179c::utils_math::mul_div_u128(v3, 18446744073709551616, v5), false)
        };
        let v6 = if (v2 == 0) {
            0
        } else {
            0xf14196ce40196dc3daec4110171efb5840461df7b12f34ca6ee7cbb15715179c::utils_math::mul_div_u128(v2, 0xf14196ce40196dc3daec4110171efb5840461df7b12f34ca6ee7cbb15715179c::utils_math::mul_div_u128(v1, arg2, 18446744073709551616), v1 - arg2)
        };
        let v7 = if (v3 == 0) {
            0
        } else {
            0xf14196ce40196dc3daec4110171efb5840461df7b12f34ca6ee7cbb15715179c::utils_math::mul_div_u128(v3, 18446744073709551616, arg2 - v0)
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
        let v2 = v1 + v0;
        let v3 = if (v1 >= v0) {
            v1 - v0
        } else {
            0
        };
        if (arg0 > 0 && arg1 == 0) {
            return (v2, v2 + v0, true)
        };
        if (arg1 > 0 && arg0 == 0) {
            return (v3, v3 + v0, false)
        };
        let (v4, v5) = max_liquidity_for_range(arg0, arg1, arg2, v1, v1 + v0);
        let (v6, v7) = max_liquidity_for_range(arg0, arg1, arg2, v2, v2 + v0);
        let (v8, v9) = max_liquidity_for_range(arg0, arg1, arg2, v3, v3 + v0);
        let (v10, v11, v12) = if (v4 >= v6 && v4 >= v8) {
            (v5, v1, v1 + v0)
        } else {
            let (v13, v14, v15) = if (v6 >= v8) {
                (v2, v2 + v0, v7)
            } else {
                (v3, v3 + v0, v9)
            };
            (v15, v13, v14)
        };
        (v11, v12, v10)
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

