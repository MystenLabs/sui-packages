module 0x46c36b06c3e0dd8c4eafcf836fe10d7dc321e5a1be91a15289d3f59f8f61391a::h_h_1 {
    public fun arb<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg5);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x2::coin::from_balance<T0>(v0, arg7);
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::coin::value<T0>(&v3), 4295048016, arg6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v3), 0x2::balance::zero<T1>(), v6);
        0x2::balance::destroy_zero<T0>(v4);
        let v7 = 0x2::coin::from_balance<T1>(v5, arg7);
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg6, arg2, arg3, true, true, 0x2::coin::value<T1>(&v7), 4295048017);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg2, arg3, 0x2::coin::into_balance<T1>(v7), 0x2::balance::zero<T2>(), v10);
        0x2::balance::destroy_zero<T1>(v8);
        let v11 = 0x2::coin::from_balance<T2>(v9, arg7);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T0>(arg0, arg4, true, true, 0x2::coin::value<T2>(&v11), 4295048016, arg6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T0>(arg0, arg4, 0x2::coin::into_balance<T2>(v11), 0x2::balance::zero<T0>(), v14);
        0x2::balance::destroy_zero<T2>(v12);
        let v15 = 0x2::coin::into_balance<T0>(0x2::coin::from_balance<T0>(v13, arg7));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v15, arg5), 0x2::balance::zero<T1>(), v2);
        let v16 = 0x2::coin::from_balance<T0>(v15, arg7);
        assert!(0x2::coin::value<T0>(&v16) > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v16, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

