module 0x75046c88d07e333bce3cada4ff9cdbaae74891fbb1f90efd19d7b88545debc1b::math {
    public fun buy(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: u64, arg5: bool) : (u64, u64, u128, u64) {
        assert!(arg1 > arg0, 1);
        assert!(arg2 > 0, 2);
        let v0 = false;
        let (v1, v2, v3, v4) = if (arg5) {
            let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_floor(arg3, 1000000 - arg4, 1000000);
            let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_up_from_input(arg0, arg1, arg2, v0);
            let (v1, v3, v4) = if (v6 > (v5 as u256)) {
                (v5, arg3 - v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_next_sqrt_price_from_input(arg0, arg2, v5, v0))
            } else {
                let v7 = (v6 as u64);
                (v7, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(v7, arg4, 1000000 - arg4), arg1)
            };
            (v1, (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_down_from_output(arg0, v4, arg2, v0) as u64), v3, v4)
        } else {
            let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_down_from_output(arg0, arg1, arg2, v0);
            let (v2, v4) = if (v8 > (arg3 as u256)) {
                (arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_next_sqrt_price_from_output(arg0, arg2, arg3, v0))
            } else {
                ((v8 as u64), arg1)
            };
            let v9 = (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_up_from_input(arg0, v4, arg2, v0) as u64);
            (v9, v2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(v9, arg4, 1000000 - arg4), v4)
        };
        (v1, v2, v4, v3)
    }

    public fun get_init_liquidity_from_sui(arg0: u128, arg1: u128, arg2: u64) : (u128, u64) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_b(arg0, arg1, arg2, false);
        (v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_a(arg0, arg1, v0, true))
    }

    public fun sell(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: u64, arg5: bool) : (u64, u64, u128, u64) {
        assert!(arg1 < arg0, 1);
        assert!(arg2 > 0, 2);
        let v0 = true;
        let (v1, v2, v3, v4) = if (arg5) {
            let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_up_from_input(arg0, arg1, arg2, v0);
            let (v1, v4) = if (v5 > (arg3 as u256)) {
                (arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_next_sqrt_price_from_input(arg0, arg2, arg3, v0))
            } else {
                ((v5 as u64), arg1)
            };
            let v6 = (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_down_from_output(arg0, v4, arg2, v0) as u64);
            let v7 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(v6, arg4, 1000000);
            (v1, v6 - v7, v7, v4)
        } else {
            let v8 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(arg3, 1000000, 1000000 - arg4);
            let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_down_from_output(arg0, arg1, arg2, v0);
            let (v2, v3, v4) = if (v9 > (v8 as u256)) {
                (arg3, v8 - arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_next_sqrt_price_from_output(arg0, arg2, v8, v0))
            } else {
                let v10 = (v9 as u64);
                let v11 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(v10, arg4, 1000000);
                (v10 - v11, v11, arg1)
            };
            ((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_up_from_input(arg0, v4, arg2, v0) as u64), v2, v3, v4)
        };
        (v1, v2, v4, v3)
    }

    // decompiled from Move bytecode v6
}

