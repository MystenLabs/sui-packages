module 0xf0da6dece6721a7d3724847fe5e3eded874566e343a8c86f6d32aa59b338e72a::alphafi_swapper_utils {
    public(friend) fun get_bluefin_sqrt_price_limits<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) : (u128, u128) {
        get_price_limits_inner(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg0))
    }

    public(friend) fun get_mmt_sqrt_price_limits<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>) : (u128, u128) {
        get_price_limits_inner(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::swap_fee_rate<T0, T1>(arg0))
    }

    fun get_price_limits_inner(arg0: u128, arg1: u64) : (u128, u128) {
        let v0 = if (arg1 >= 100 && arg1 <= 500) {
            arg0 * 999499874 / 1000000000
        } else if (arg1 > 500 && arg1 <= 2500) {
            arg0 * 997496867 / 1000000000
        } else if (arg1 > 2500 && arg1 <= 10000) {
            arg0 * 992471662 / 1000000000
        } else {
            arg0 * 987420882 / 1000000000
        };
        let v1 = if (arg1 >= 100 && arg1 <= 500) {
            arg0 * 1000499875 / 1000000000
        } else if (arg1 > 500 && arg1 <= 2500) {
            arg0 * 1002496882 / 1000000000
        } else if (arg1 > 2500 && arg1 <= 10000) {
            arg0 * 1007472083 / 1000000000
        } else {
            arg0 * 1012422836 / 1000000000
        };
        (v0, v1)
    }

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

    public fun swap_bluefin<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::into_balance<T0>(arg0);
        let v1 = 0x2::coin::into_balance<T1>(arg1);
        if (arg4) {
            let v4 = 0x2::balance::value<T0>(&v0);
            assert!(0x2::balance::value<T1>(&v1) == 0, 1009);
            0x2::balance::destroy_zero<T1>(v1);
            assert!(v4 >= arg5, 1006);
            let (v5, _) = get_bluefin_sqrt_price_limits<T0, T1>(arg2);
            let (v7, v8) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg6, arg3, arg2, v0, 0x2::balance::zero<T1>(), true, true, v4, 0, v5);
            let v9 = v7;
            assert!(0x2::balance::value<T0>(&v9) == 0, 1007);
            0x2::balance::destroy_zero<T0>(v9);
            (0x2::coin::zero<T0>(arg7), 0x2::coin::from_balance<T1>(v8, arg7))
        } else {
            let v10 = 0x2::balance::value<T1>(&v1);
            assert!(0x2::balance::value<T0>(&v0) == 0, 1010);
            0x2::balance::destroy_zero<T0>(v0);
            assert!(v10 >= arg5, 1006);
            let (_, v12) = get_bluefin_sqrt_price_limits<T0, T1>(arg2);
            let (v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg6, arg3, arg2, 0x2::balance::zero<T0>(), v1, false, true, v10, 0, v12);
            let v15 = v14;
            assert!(0x2::balance::value<T1>(&v15) == 0, 1008);
            0x2::balance::destroy_zero<T1>(v15);
            (0x2::coin::from_balance<T0>(v13, arg7), 0x2::coin::zero<T1>(arg7))
        }
    }

    public fun swap_momentum<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: bool, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::into_balance<T0>(arg0);
        let v1 = 0x2::coin::into_balance<T1>(arg1);
        if (arg3) {
            let v4 = 0x2::balance::value<T0>(&v0);
            assert!(0x2::balance::value<T1>(&v1) == 0, 1009);
            0x2::balance::destroy_zero<T1>(v1);
            let (v5, _) = get_mmt_sqrt_price_limits<T0, T1>(arg2);
            let (v7, v8) = if (arg4) {
                assert!(v4 >= arg6, 1006);
                let (v9, v10, v11) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, arg3, arg4, v4, v5, arg7, arg8, arg9);
                let v12 = v9;
                assert!(0x2::balance::value<T0>(&v12) == 0, 1007);
                0x2::balance::destroy_zero<T0>(v12);
                (v10, v11)
            } else {
                assert!(arg5 > 0, 1011);
                let (v13, v14, v15) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, arg3, arg4, arg5, v5, arg7, arg8, arg9);
                let v16 = v14;
                assert!(0x2::balance::value<T1>(&v16) == arg5, 1007);
                0x2::balance::destroy_zero<T0>(v13);
                (v16, v15)
            };
            let v17 = v8;
            let (v18, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v17);
            assert!(v18 > v4, 1012);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v17, 0x2::balance::split<T0>(&mut v0, v18), 0x2::balance::zero<T1>(), arg8, arg9);
            (0x2::coin::from_balance<T0>(v0, arg9), 0x2::coin::from_balance<T1>(v7, arg9))
        } else {
            let v20 = 0x2::balance::value<T1>(&v1);
            assert!(0x2::balance::value<T0>(&v0) == 0, 1010);
            0x2::balance::destroy_zero<T0>(v0);
            let (_, v22) = get_mmt_sqrt_price_limits<T0, T1>(arg2);
            let (v23, v24) = if (arg4) {
                assert!(v20 >= arg6, 1006);
                let (v25, v26, v27) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, arg3, arg4, v20, v22, arg7, arg8, arg9);
                let v28 = v26;
                assert!(0x2::balance::value<T1>(&v28) == 0, 1008);
                0x2::balance::destroy_zero<T1>(v28);
                (v25, v27)
            } else {
                assert!(arg5 > 0, 1011);
                let (v29, v30, v31) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, arg3, arg4, arg5, v22, arg7, arg8, arg9);
                let v32 = v29;
                assert!(0x2::balance::value<T0>(&v32) == arg5, 1008);
                0x2::balance::destroy_zero<T1>(v30);
                (v32, v31)
            };
            let v33 = v24;
            let (_, v35) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v33);
            assert!(v35 > v20, 1012);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v33, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v1, v35), arg8, arg9);
            (0x2::coin::from_balance<T0>(v23, arg9), 0x2::coin::from_balance<T1>(v1, arg9))
        }
    }

    // decompiled from Move bytecode v6
}

