module 0x35d41521243b0252101900010afe354f6292ba29b3506dd9611c666ce23b01ee::reader {
    struct WindowCursor has drop {
        score: 0x1::option::Option<u64>,
        terminal: bool,
    }

    public fun begin_if<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: bool) : (WindowCursor, u128, vector<u128>, vector<u128>, vector<bool>, u64, u64, bool, bool) {
        if (!arg4) {
            let v0 = WindowCursor{
                score    : 0x1::option::none<u64>(),
                terminal : false,
            };
            return (v0, 0, vector[], vector[], vector[], 0, 0, false, false)
        };
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::first_score_for_swap(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_manager<T0, T1>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0), arg1);
        let v2 = if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v1)) {
            0x1::option::some<u64>(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v1))
        } else {
            0x1::option::none<u64>()
        };
        let v3 = WindowCursor{
            score    : v2,
            terminal : false,
        };
        let v4 = &mut v3;
        let (v5, v6, v7, v8, v9, v10, v11, v12) = read_window<T0, T1>(arg0, arg1, v4, arg2, arg3, true, 0x1::vector::empty<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>());
        let v13 = v11 && !v12;
        (v3, v5, v6, v7, v8, v9, v10, v11, !v13)
    }

    public fun continue_if<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &mut WindowCursor, arg3: u64, arg4: u64, arg5: bool) : (u128, vector<u128>, vector<u128>, vector<bool>, u64, u64, bool) {
        if (!arg5 || arg2.terminal) {
            return (0, vector[], vector[], vector[], 0, 0, arg2.terminal)
        };
        let (v0, v1, v2, v3, v4, v5, v6, _) = read_window<T0, T1>(arg0, arg1, arg2, arg3, arg4, false, 0x1::vector::empty<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>());
        (v0, v1, v2, v3, v4, v5, v6)
    }

    public fun current<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : (u128, u64, u64) {
        (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0), 1000000)
    }

    public fun economic_window_if<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: bool, arg4: u256) : (u128, vector<u128>, vector<u128>, vector<bool>) {
        window_impl<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    fun first_curve(arg0: &mut u128, arg1: &mut u128, arg2: bool, arg3: u128, arg4: u128, arg5: bool) : bool {
        if (*arg0 > 0 && arg3 != *arg1) {
            return true
        };
        if (arg2 != arg5) {
            *arg0 = *arg0 - arg4;
        } else {
            *arg0 = *arg0 + arg4;
        };
        *arg1 = arg3;
        false
    }

    fun read_window<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &mut WindowCursor, arg3: u64, arg4: u64, arg5: bool, arg6: vector<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>) : (u128, vector<u128>, vector<u128>, vector<bool>, u64, u64, bool, bool) {
        let v0 = !0x1::vector::is_empty<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>(&arg6);
        let v1 = if (v0) {
            0
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg0)
        };
        let v2 = v1;
        let v3 = if (arg5) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0)
        } else {
            0
        };
        let v4 = v3;
        let v5 = false;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_manager<T0, T1>(arg0);
        let v7 = vector[];
        let v8 = vector[];
        let v9 = vector[];
        let v10 = 0;
        while (v10 < 0x1::u64::min(arg3, arg4) && 0x1::option::is_some<u64>(&arg2.score)) {
            let (v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::borrow_tick_for_swap(v6, *0x1::option::borrow<u64>(&arg2.score), arg1);
            let v13 = v12;
            let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::liquidity_net(v11);
            let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::sqrt_price(v11);
            let v16 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::abs_u128(v14);
            let v17 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::is_neg(v14);
            0x1::vector::push_back<u128>(&mut v7, v15);
            0x1::vector::push_back<u128>(&mut v8, v16);
            0x1::vector::push_back<bool>(&mut v9, v17);
            v10 = v10 + 1;
            let v18 = if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v13)) {
                0x1::option::some<u64>(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v13))
            } else {
                0x1::option::none<u64>()
            };
            arg2.score = v18;
            if (v0) {
                let v19 = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::v3_read_demand_step(0x1::vector::borrow_mut<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>(&mut arg6, 0), arg1, v15, v16, v17, false, false, true);
                v5 = v19;
                if (v19) {
                    break
                } else {
                    continue
                };
            };
            if (arg5) {
                let v20 = &mut v2;
                let v21 = &mut v4;
                let v22 = first_curve(v20, v21, arg1, v15, v16, v17);
                v5 = v22;
                if (v22) {
                    break
                };
            };
        };
        arg2.terminal = !0x1::option::is_some<u64>(&arg2.score);
        if (arg2.terminal) {
            let v23 = if (arg1) {
                0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price()
            } else {
                0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price()
            };
            if (0x1::vector::is_empty<u128>(&v7) || *0x1::vector::borrow<u128>(&v7, 0x1::vector::length<u128>(&v7) - 1) != v23) {
                0x1::vector::push_back<u128>(&mut v7, v23);
                0x1::vector::push_back<u128>(&mut v8, 0);
                0x1::vector::push_back<bool>(&mut v9, false);
                if (!v5) {
                    if (v0) {
                        v5 = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::v3_read_demand_step(0x1::vector::borrow_mut<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>(&mut arg6, 0), arg1, v23, 0, false, false, false, true);
                    } else if (arg5) {
                        let v24 = &mut v2;
                        let v25 = &mut v4;
                        v5 = first_curve(v24, v25, arg1, v23, 0, false);
                    };
                };
            };
        };
        (v1, v7, v8, v9, v10, v10, arg2.terminal, v5)
    }

    public fun resume<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &mut WindowCursor, arg3: &mut 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::AdaptiveSearch, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: u64) {
        let (v0, v1, v2, v3) = 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::adaptive_v3_request(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        if (!v2) {
            return
        };
        let v4 = 0x1::vector::empty<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>();
        0x1::vector::push_back<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>(&mut v4, v3);
        let (_, v6, v7, v8, v9, v10, v11, _) = read_window<T0, T1>(arg0, arg1, arg2, v0, v1, false, v4);
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::adaptive_append_v3_run(arg3, arg4, v6, v7, v8, v9, v10, v11, false, true);
    }

    public fun window_if<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: bool) : (u128, vector<u128>, vector<u128>, vector<bool>) {
        window_impl<T0, T1>(arg0, arg1, arg2, arg3, 0)
    }

    fun window_impl<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: bool, arg4: u256) : (u128, vector<u128>, vector<u128>, vector<bool>) {
        if (!arg3) {
            return (0, vector[], vector[], vector[])
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_manager<T0, T1>(arg0);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::first_score_for_swap(v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0), arg1);
        let v2 = vector[];
        let v3 = vector[];
        let v4 = vector[];
        let v5 = 0;
        let v6 = 0;
        while (v5 < arg2 && 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v1)) {
            let (v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::borrow_tick_for_swap(v0, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v1), arg1);
            let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::liquidity_net(v7);
            let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::sqrt_price(v7);
            v6 = v10;
            0x1::vector::push_back<u128>(&mut v2, v10);
            0x1::vector::push_back<u128>(&mut v3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::abs_u128(v9));
            0x1::vector::push_back<bool>(&mut v4, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::is_neg(v9));
            v1 = v8;
            v5 = v5 + 1;
            if (arg4 > 0) {
                let v11 = (v10 as u256) * (v10 as u256);
                if (arg1 && v11 <= arg4 || !arg1 && v11 >= arg4) {
                    break
                };
            };
        };
        let v12 = if (arg1) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price()
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price()
        };
        if (!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v1) && (v5 == 0 || v6 != v12)) {
            0x1::vector::push_back<u128>(&mut v2, v12);
            0x1::vector::push_back<u128>(&mut v3, 0);
            0x1::vector::push_back<bool>(&mut v4, false);
        };
        (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg0), v2, v3, v4)
    }

    // decompiled from Move bytecode v7
}

