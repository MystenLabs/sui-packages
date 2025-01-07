module 0x2e62a8e44758fafee01a3f6ad6dcd08d582b57a1647b663b067f15a3cb0a7764::migrate {
    public fun migrate_cetus_sui_usdc_positions_to_vault<T0, T1, T2>(arg0: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 4295048016;
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg3, arg1, &mut arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg0), arg5);
        let v3 = v1;
        let v4 = 0x2::balance::value<T0>(&v3);
        let v5 = 0x2::coin::from_balance<T1>(v2, arg6);
        if (v4 > 0) {
            let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg3, arg1, true, true, v4, v0, arg5);
            let v9 = v7;
            0x2::balance::destroy_zero<T0>(v6);
            0x2::balance::value<T1>(&v9);
            0x2::coin::join<T1>(&mut v5, 0x2::coin::from_balance<T1>(v9, arg6));
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg3, arg1, v3, 0x2::balance::zero<T1>(), v8);
        } else {
            0x2::balance::destroy_zero<T0>(v3);
        };
        let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg3, arg1, &arg0, arg4, true, arg5);
        let v11 = 0x2::balance::value<T2>(&v10);
        if (v11 > 0) {
            let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg3, arg2, true, true, v11, v0, arg5);
            let v15 = v13;
            0x2::balance::destroy_zero<T2>(v12);
            0x2::balance::value<T1>(&v15);
            0x2::coin::join<T1>(&mut v5, 0x2::coin::from_balance<T1>(v15, arg6));
            0x2::coin::join<T1>(&mut v5, 0x2::coin::from_balance<T1>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T1>(arg3, arg1, &arg0, arg4, true, arg5), arg6));
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg3, arg2, v10, 0x2::balance::zero<T1>(), v14);
        } else {
            0x2::balance::destroy_zero<T2>(v10);
            0x2::coin::destroy_zero<T1>(0x2::coin::from_balance<T1>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T1>(arg3, arg1, &arg0, arg4, true, arg5), arg6));
        };
        let (v16, v17) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg3, arg1, &arg0, true);
        let v18 = v16;
        let v19 = 0x2::balance::value<T0>(&v18);
        if (v19 > 0) {
            let (v20, v21, v22) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg3, arg1, true, true, v19, v0, arg5);
            let v23 = v21;
            0x2::balance::destroy_zero<T0>(v20);
            0x2::balance::value<T1>(&v23);
            0x2::coin::join<T1>(&mut v5, 0x2::coin::from_balance<T1>(v17, arg6));
            0x2::coin::join<T1>(&mut v5, 0x2::coin::from_balance<T1>(v23, arg6));
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg3, arg1, v18, 0x2::balance::zero<T1>(), v22);
        } else {
            0x2::balance::destroy_zero<T0>(v18);
            0x2::coin::destroy_zero<T1>(0x2::coin::from_balance<T1>(v17, arg6));
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg3, arg1, arg0);
        v5
    }

    // decompiled from Move bytecode v6
}

