module 0xec9e4b2ff9e183237f972d595346ebb1a5898678cbeb8dafbe19493377d4b954::trade {
    struct CalculationInfo has copy, drop {
        total_loop: u64,
    }

    struct SwapResult has copy, drop {
        amount_in: u64,
        amount_out: u64,
        diff: u64,
        steps: vector<SwapStep>,
    }

    struct SwapStep has copy, drop {
        amount_in: u64,
        amount_out: u64,
        pool_id: address,
        token_a: 0x1::ascii::String,
        token_b: 0x1::ascii::String,
        a2b: bool,
        pool_type: u8,
    }

    public fun calculate_swap_internal<T0, T1, T2, T3>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg2: u64, arg3: bool, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: &0x2::clock::Clock) : SwapResult {
        let v0 = SwapResult{
            amount_in  : arg2,
            amount_out : 0,
            diff       : 0,
            steps      : 0x1::vector::empty<SwapStep>(),
        };
        if (arg3) {
            let v1 = arg4 == arg5;
            let (v2, v3, _) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_swap_out<T0, T1>(arg0, arg2, v1, arg9);
            if (v2 > 0) {
                return v0
            };
            let v5 = SwapStep{
                amount_in  : arg2,
                amount_out : v3,
                pool_id    : 0x2::object::id_address<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>>(arg0),
                token_a    : arg5,
                token_b    : arg6,
                a2b        : v1,
                pool_type  : 1,
            };
            0x1::vector::push_back<SwapStep>(&mut v0.steps, v5);
            let v6 = arg4 != arg7;
            let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T2, T3>(arg1, v6, true, v3);
            if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v7)) {
                return v0
            };
            let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v7);
            let v9 = SwapStep{
                amount_in  : v3,
                amount_out : v8,
                pool_id    : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg1),
                token_a    : arg7,
                token_b    : arg8,
                a2b        : v6,
                pool_type  : 2,
            };
            0x1::vector::push_back<SwapStep>(&mut v0.steps, v9);
            if (v8 > arg2) {
                v0.diff = v8 - arg2;
            };
            v0.amount_out = v8;
        } else {
            let v10 = arg4 == arg7;
            let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T2, T3>(arg1, v10, true, arg2);
            if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v11)) {
                return v0
            };
            let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v11);
            let v13 = SwapStep{
                amount_in  : arg2,
                amount_out : v12,
                pool_id    : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg1),
                token_a    : arg7,
                token_b    : arg8,
                a2b        : v10,
                pool_type  : 2,
            };
            0x1::vector::push_back<SwapStep>(&mut v0.steps, v13);
            let v14 = arg4 != arg5;
            let (v15, v16, _) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_swap_out<T0, T1>(arg0, v12, v14, arg9);
            if (v15 > 0) {
                return v0
            };
            let v18 = SwapStep{
                amount_in  : v12,
                amount_out : v16,
                pool_id    : 0x2::object::id_address<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>>(arg0),
                token_a    : arg5,
                token_b    : arg6,
                a2b        : v14,
                pool_type  : 1,
            };
            0x1::vector::push_back<SwapStep>(&mut v0.steps, v18);
            if (v16 > arg2) {
                v0.diff = v16 - arg2;
            };
            v0.amount_out = v16;
        };
        v0
    }

    public fun calculate_swaps<T0, T1, T2, T3, T4>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T4>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v3 = 0x1::type_name::into_string(0x1::type_name::get<T2>());
        let v4 = 0x1::type_name::into_string(0x1::type_name::get<T3>());
        let v5 = CalculationInfo{total_loop: 0};
        while (arg2 > 0) {
            let v6 = calculate_swap_internal<T0, T1, T2, T3>(arg0, arg1, arg2, false, v0, v1, v2, v3, v4, arg4);
            let v7 = calculate_swap_internal<T0, T1, T2, T3>(arg0, arg1, arg2, true, v0, v1, v2, v3, v4, arg4);
            if (v6.diff > 0) {
                0x2::event::emit<SwapResult>(v6);
            };
            if (v7.diff > 0) {
                0x2::event::emit<SwapResult>(v7);
            };
            if (arg2 > arg3) {
                arg2 = arg2 - arg3;
            } else {
                arg2 = 0;
            };
            v5.total_loop = v5.total_loop + 1;
        };
        0x2::event::emit<CalculationInfo>(v5);
    }

    public fun calculate_swaps_v2<T0, T1, T2, T3, T4>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T4>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v3 = 0x1::type_name::into_string(0x1::type_name::get<T2>());
        let v4 = 0x1::type_name::into_string(0x1::type_name::get<T3>());
        let v5 = CalculationInfo{total_loop: 0};
        while (arg2 > 0) {
            let v6 = calculate_swap_internal<T0, T1, T2, T3>(arg0, arg1, arg2, false, v0, v1, v2, v3, v4, arg5);
            let v7 = calculate_swap_internal<T0, T1, T2, T3>(arg0, arg1, arg2, true, v0, v1, v2, v3, v4, arg5);
            if (v6.diff > 0 || arg4) {
                0x2::event::emit<SwapResult>(v6);
            };
            if (v7.diff > 0 || arg4) {
                0x2::event::emit<SwapResult>(v7);
            };
            if (arg2 > arg3) {
                arg2 = arg2 - arg3;
            } else {
                arg2 = 0;
            };
            v5.total_loop = v5.total_loop + 1;
        };
        0x2::event::emit<CalculationInfo>(v5);
    }

    public fun calculate_swaps_v3<T0, T1, T2, T3, T4>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T4>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v3 = 0x1::type_name::into_string(0x1::type_name::get<T2>());
        let v4 = 0x1::type_name::into_string(0x1::type_name::get<T3>());
        let v5 = CalculationInfo{total_loop: 0};
        while (arg2 > 0) {
            let v6 = calculate_swap_internal<T0, T1, T2, T3>(arg0, arg1, arg2, false, v0, v1, v2, v3, v4, arg6);
            let v7 = calculate_swap_internal<T0, T1, T2, T3>(arg0, arg1, arg2, true, v0, v1, v2, v3, v4, arg6);
            if (v6.diff > 0 || arg5) {
                0x2::event::emit<SwapResult>(v6);
            };
            if (v7.diff > 0 || arg5) {
                0x2::event::emit<SwapResult>(v7);
            };
            if (arg2 > arg4 + arg3) {
                arg2 = arg2 - arg4;
            } else {
                arg2 = 0;
            };
            v5.total_loop = v5.total_loop + 1;
        };
        0x2::event::emit<CalculationInfo>(v5);
    }

    // decompiled from Move bytecode v6
}

