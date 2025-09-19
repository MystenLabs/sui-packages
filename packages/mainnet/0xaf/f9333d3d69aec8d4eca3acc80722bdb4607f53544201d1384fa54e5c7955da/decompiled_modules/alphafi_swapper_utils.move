module 0xaff9333d3d69aec8d4eca3acc80722bdb4607f53544201d1384fa54e5c7955da::alphafi_swapper_utils {
    public fun get_total_balance_in_ratio_with_limit<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u32, arg3: u32, arg4: u32, arg5: u128, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64, u64, u64, u64) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::coin::value<T1>(&arg1);
        if (v0 == 0 && v1 != 0) {
            assert!(arg4 >= arg3, 1);
        };
        if (v1 == 0 && v0 != 0) {
            assert!(arg4 < arg2, 2);
        };
        if (v0 == 0 || v1 == 0) {
            return (arg0, arg1, 0x2::coin::zero<T0>(arg6), 0x2::coin::zero<T1>(arg6), v0, v1, 0, 0)
        };
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg2);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3);
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg4);
        let (_, _, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v2, v3, v4, arg5, 0x2::coin::value<T0>(&arg0), true);
        let (_, v9, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v2, v3, v4, arg5, 0x2::coin::value<T1>(&arg1), false);
        if (v7 > 0x2::coin::value<T1>(&arg1) && v9 > 0x2::coin::value<T0>(&arg0)) {
            abort 1
        };
        let (v11, v12, v13, arg0, arg1, v14, v15, v16) = if (v7 <= 0x2::coin::value<T1>(&arg1)) {
            let v17 = 0x2::coin::split<T1>(&mut arg1, v7, arg6);
            (0x2::coin::value<T1>(&arg1), 0, 0x2::coin::value<T1>(&v17), arg0, arg1, 0x2::coin::zero<T0>(arg6), v17, v0)
        } else {
            let v18 = 0x2::coin::split<T0>(&mut arg0, v9, arg6);
            (v1, 0x2::coin::value<T0>(&v18), 0, arg0, arg1, v18, 0x2::coin::zero<T1>(arg6), 0x2::coin::value<T0>(&arg0))
        };
        (arg0, arg1, v14, v15, v16, v11, v12, v13)
    }

    // decompiled from Move bytecode v6
}

