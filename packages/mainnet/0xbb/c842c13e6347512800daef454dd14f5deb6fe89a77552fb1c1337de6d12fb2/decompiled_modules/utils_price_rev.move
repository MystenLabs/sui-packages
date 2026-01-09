module 0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::utils_price_rev {
    fun consider_candidate(arg0: u64, arg1: u64, arg2: u128, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg4: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg5: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg6: u32, arg7: &mut u128, arg8: &mut 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg9: &mut bool, arg10: &mut u64) {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(arg5, arg4);
        if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::is_valid_index(arg5, arg6)) {
            return
        };
        if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::is_valid_index(v0, arg6)) {
            return
        };
        let (v1, v2) = max_liquidity_for_range(arg0, arg1, arg2, arg5, v0);
        let v3 = dist_to_range(arg3, arg5, v0);
        if (v1 > *arg7) {
            *arg7 = v1;
            *arg8 = arg5;
            *arg9 = v2;
            *arg10 = v3;
            return
        };
        if (v1 == *arg7 && v3 < *arg10) {
            *arg8 = arg5;
            *arg9 = v2;
            *arg10 = v3;
        };
    }

    fun dist_to_range(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u64 {
        if (!0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg0, arg1) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg0, arg2)) {
            return 0
        };
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg0, arg1)) {
            return (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg1, arg0)) as u64)
        };
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(1)))) as u64)
    }

    fun floor_to_spacing(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u32) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(arg0, v0), v0);
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg0, v1) && !0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg0, v2), v1)) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v2, v0)
        } else {
            v2
        }
    }

    fun i32_tick_to_u32(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u32 {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(arg0)
    }

    public fun is_in_range_plus_hyst(arg0: u32, arg1: u32, arg2: u32, arg3: u32) : bool {
        let v0 = u32_tick_to_i32(arg2);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3);
        !0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v0, v1), u32_tick_to_i32(arg0)) && !!0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(u32_tick_to_i32(arg1), v1))
    }

    public fun m_amount_for_usdc_value(arg0: u64, arg1: u128) : u64 {
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

    public fun max_liquidity_for_range(arg0: u64, arg1: u64, arg2: u128, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg4: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : (u128, bool) {
        if (!0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg3, arg4)) {
            return (0, true)
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(arg3);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(arg4);
        let v2 = (arg1 as u128);
        let v3 = (arg0 as u128);
        if (arg2 <= v0) {
            let v4 = v1 - v0;
            if (v2 == 0 || v4 == 0) {
                return (0, true)
            };
            return (0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::utils_math::mul_div_u128(v2, 0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::utils_math::mul_div_u128(v1, v0, 18446744073709551616), v4), true)
        };
        if (arg2 >= v1) {
            let v5 = v1 - v0;
            if (v3 == 0 || v5 == 0) {
                return (0, false)
            };
            return (0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::utils_math::mul_div_u128(v3, 18446744073709551616, v5), false)
        };
        let v6 = if (v2 == 0) {
            0
        } else {
            0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::utils_math::mul_div_u128(v2, 0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::utils_math::mul_div_u128(v1, arg2, 18446744073709551616), v1 - arg2)
        };
        let v7 = if (v3 == 0) {
            0
        } else {
            0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::utils_math::mul_div_u128(v3, 18446744073709551616, arg2 - v0)
        };
        if (v6 <= v7) {
            (v6, true)
        } else {
            (v7, false)
        }
    }

    public fun pick_best_range_and_limit_side(arg0: u64, arg1: u64, arg2: u128, arg3: u32, arg4: u32, arg5: u32) : (u32, u32, bool) {
        let v0 = u32_tick_to_i32(arg3);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg4 * arg5);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg5);
        let v3 = floor_to_spacing(v0, arg5);
        let v4 = 0;
        let v5 = true;
        let v6 = 18446744073709551615;
        let v7 = &mut v4;
        let v8 = &mut v3;
        let v9 = &mut v5;
        let v10 = &mut v6;
        consider_candidate(arg0, arg1, arg2, v0, v1, v3, arg5, v7, v8, v9, v10);
        let v11 = 1;
        let v12 = v3;
        while (v11 <= arg4) {
            v12 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v12, v2);
            let v13 = &mut v4;
            let v14 = &mut v3;
            let v15 = &mut v5;
            let v16 = &mut v6;
            consider_candidate(arg0, arg1, arg2, v0, v1, v12, arg5, v13, v14, v15, v16);
            v11 = v11 + 1;
        };
        v11 = 1;
        let v17 = v3;
        while (v11 <= arg4) {
            v17 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v17, v2);
            let v18 = &mut v4;
            let v19 = &mut v3;
            let v20 = &mut v5;
            let v21 = &mut v6;
            consider_candidate(arg0, arg1, arg2, v0, v1, v17, arg5, v18, v19, v20, v21);
            v11 = v11 + 1;
        };
        (i32_tick_to_u32(v3), i32_tick_to_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v3, v1)), v5)
    }

    fun u32_tick_to_i32(arg0: u32) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0)
    }

    public fun usdc_value_of_m_amount(arg0: u64, arg1: u128) : u64 {
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

    // decompiled from Move bytecode v6
}

