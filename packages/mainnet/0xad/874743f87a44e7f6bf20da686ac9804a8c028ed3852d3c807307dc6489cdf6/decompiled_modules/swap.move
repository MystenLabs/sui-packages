module 0xad874743f87a44e7f6bf20da686ac9804a8c028ed3852d3c807307dc6489cdf6::swap {
    entry fun swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: vector<0x2::coin::Coin<T0>>, arg4: vector<0x2::coin::Coin<T1>>, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: u8, arg11: u128, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = merge_coins<T0>(arg3, arg13);
        let v1 = merge_coins<T1>(arg4, arg13);
        while (arg10 > 0) {
            let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, arg5, arg6, arg7);
            let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::step_swap_result_target_sqrt_price(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_step_swap_result(&v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_steps_length(&v2) - 1));
            if (arg5 && arg9 < v3 || !arg5 && arg9 > v3) {
                let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, arg5, arg6, arg7, arg11, arg12);
                let v7 = v6;
                let v8 = v5;
                let v9 = v4;
                if (arg5) {
                };
                let (v10, v11) = if (arg5) {
                    (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v7), arg13)), 0x2::balance::zero<T1>())
                } else {
                    (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v7), arg13)))
                };
                0x2::coin::join<T1>(&mut v1, 0x2::coin::from_balance<T1>(v8, arg13));
                0x2::coin::join<T0>(&mut v0, 0x2::coin::from_balance<T0>(v9, arg13));
                0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, v10, v11, v7);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg13));
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg13));
                return
            };
            arg7 = (arg7 + arg8) / 2;
            arg10 = arg10 - 1;
        };
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, arg5, arg6, arg8, arg11, arg12);
        let v15 = v14;
        let v16 = v13;
        let v17 = v12;
        if (arg5) {
        };
        let (v18, v19) = if (arg5) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v15), arg13)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v15), arg13)))
        };
        0x2::coin::join<T1>(&mut v1, 0x2::coin::from_balance<T1>(v16, arg13));
        0x2::coin::join<T0>(&mut v0, 0x2::coin::from_balance<T0>(v17, arg13));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, v18, v19, v15);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg13));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg13));
    }

    fun merge_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0), 0);
        let v0 = 0x2::coin::zero<T0>(arg1);
        0x2::pay::join_vec<T0>(&mut v0, arg0);
        v0
    }

    // decompiled from Move bytecode v6
}

