module 0x23c2d463d1cd8e0519aac95589f8050586a3b2d25491c34d33a7e959084b05c9::closer {
    public fun close_smart<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: u64, arg6: u64, arg7: bool, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg3);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg2);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(&arg2);
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(v2, v3, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3), v1, arg7);
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg1, arg3, &mut arg2, v1, arg0);
        let v8 = 0x2::coin::from_balance<T0>(v6, arg9);
        let v9 = 0x2::coin::from_balance<T1>(v7, arg9);
        if (is_in_range(v2, v3, v0)) {
            if (arg5 < v4 && arg6 > v5) {
                let v10 = true;
                let (v11, v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg3, v10, true, v4 - arg5, 4295048017, arg0);
                let v14 = v13;
                let v15 = v12;
                let v16 = v11;
                if (v10) {
                };
                let (v17, v18) = if (v10) {
                    (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v8, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v14), arg9)), 0x2::balance::zero<T1>())
                } else {
                    (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v9, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v14), arg9)))
                };
                0x2::coin::join<T1>(&mut v9, 0x2::coin::from_balance<T1>(v15, arg9));
                0x2::coin::join<T0>(&mut v8, 0x2::coin::from_balance<T0>(v16, arg9));
                0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg3, v17, v18, v14);
            };
            if (arg5 > v4 && arg6 < v5) {
                let v19 = false;
                let (v20, v21, v22) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg3, v19, true, v5 - arg6, 79226673515401279992447579054, arg0);
                let v23 = v22;
                let v24 = v21;
                let v25 = v20;
                if (v19) {
                };
                let (v26, v27) = if (v19) {
                    (0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v8, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v23), arg9)))
                } else {
                    (0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v9, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v23), arg9)), 0x2::balance::zero<T0>())
                };
                0x2::coin::join<T1>(&mut v9, 0x2::coin::from_balance<T1>(v24, arg9));
                0x2::coin::join<T0>(&mut v8, 0x2::coin::from_balance<T0>(v25, arg9));
                0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg3, v27, v26, v23);
            };
        };
        let v28 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_and_update_rewards<T0, T1>(arg1, arg3, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg2), arg0);
        let v29 = 0;
        while (v29 < 0x1::vector::length<u64>(&v28)) {
            let v30 = *0x1::vector::borrow<u64>(&v28, v29);
            if (v30 > 0 && v29 == 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg1, arg3, &arg2, arg4, true, arg0), arg9), arg8);
            };
            if (v30 > 0 && v29 == 1) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T3>(arg1, arg3, &arg2, arg4, true, arg0), arg9), arg8);
            };
            if (v30 > 0 && v29 == 2) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(0x2::coin::from_balance<T4>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T4>(arg1, arg3, &arg2, arg4, true, arg0), arg9), arg8);
            };
            v29 = v29 + 1;
        };
        if (0x2::coin::value<T0>(&v8) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, arg8);
        } else {
            0x2::coin::destroy_zero<T0>(v8);
        };
        if (0x2::coin::value<T1>(&v9) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v9, arg8);
        } else {
            0x2::coin::destroy_zero<T1>(v9);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg1, arg3, arg2);
    }

    fun is_in_range(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : bool {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(arg2, arg0) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg2, arg1)
    }

    // decompiled from Move bytecode v6
}

