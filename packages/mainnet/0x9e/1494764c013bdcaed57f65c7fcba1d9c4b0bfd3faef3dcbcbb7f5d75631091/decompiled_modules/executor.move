module 0xc5baa691ecbed8575d4bff750b80791d638ce1d1a5cb1942d85d4f6e9b7e808c::executor {
    struct ArbExecuted has copy, drop {
        buy_venue: vector<u8>,
        sell_venue: vector<u8>,
        a2b_buy: bool,
        amount_in: u64,
        amount_intermediate: u64,
        amount_out: u64,
        profit: u64,
    }

    struct ArbSkipped has copy, drop {
        buy_venue: vector<u8>,
        sell_venue: vector<u8>,
        reason: u8,
    }

    public fun bluefin_buy_cetus_sell<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: bool, arg6: u128, arg7: u64, arg8: u64, arg9: u64, arg10: u8, arg11: u8, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc5baa691ecbed8575d4bff750b80791d638ce1d1a5cb1942d85d4f6e9b7e808c::search::find_optimal_bluefin<T0, T1>(arg0, arg5, arg6, arg7, arg8, arg10, arg11);
        if (v0 < arg7) {
            let v1 = ArbSkipped{
                buy_venue  : b"bluefin",
                sell_venue : b"cetus",
                reason     : 0,
            };
            0x2::event::emit<ArbSkipped>(v1);
            return
        };
        let v2 = if (arg5) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let (v3, v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg1, arg0, arg5, true, v0, v2);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v6);
        let v10 = !arg5;
        let v11 = if (v10) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price()
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price()
        };
        let v12 = if (arg5) {
            0x2::balance::value<T1>(&v7)
        } else {
            0x2::balance::value<T0>(&v8)
        };
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg3, arg2, v10, true, v12, v11, arg4);
        let v16 = v15;
        let v17 = v14;
        let v18 = v13;
        let (v19, v20) = if (v10) {
            (0x2::balance::split<T0>(&mut v8, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v16)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v7, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v16)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg3, arg2, v19, v20, v16);
        let (v21, v22) = if (arg5) {
            0x2::balance::join<T0>(&mut v18, v8);
            assert!(0x2::balance::value<T0>(&v18) >= v9 + arg9, 1);
            (0x2::balance::split<T0>(&mut v18, v9), v7)
        } else {
            0x2::balance::join<T1>(&mut v17, v7);
            assert!(0x2::balance::value<T1>(&v17) >= v9 + arg9, 1);
            (v8, 0x2::balance::split<T1>(&mut v17, v9))
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg0, v21, v22, v6);
        let v23 = if (arg5) {
            0x2::balance::value<T0>(&v18)
        } else {
            0x2::balance::value<T1>(&v17)
        };
        let v24 = ArbExecuted{
            buy_venue           : b"bluefin",
            sell_venue          : b"cetus",
            a2b_buy             : arg5,
            amount_in           : v9,
            amount_intermediate : v12,
            amount_out          : v9 + v23,
            profit              : v23,
        };
        0x2::event::emit<ArbExecuted>(v24);
        if (arg5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v18, arg12), 0x2::tx_context::sender(arg12));
            0x2::balance::destroy_zero<T1>(v17);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v17, arg12), 0x2::tx_context::sender(arg12));
            0x2::balance::destroy_zero<T0>(v18);
        };
    }

    public fun bluefin_buy_cetus_sell_crossed<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: bool, arg6: u128, arg7: u64, arg8: u64, arg9: u64, arg10: u8, arg11: u8, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc5baa691ecbed8575d4bff750b80791d638ce1d1a5cb1942d85d4f6e9b7e808c::search::find_optimal_bluefin<T0, T1>(arg0, arg5, arg6, arg7, arg8, arg10, arg11);
        if (v0 < arg7) {
            let v1 = ArbSkipped{
                buy_venue  : b"bluefin",
                sell_venue : b"cetus",
                reason     : 0,
            };
            0x2::event::emit<ArbSkipped>(v1);
            return
        };
        let v2 = if (arg5) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let (v3, v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg1, arg0, arg5, true, v0, v2);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v6);
        let v10 = if (arg5) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price()
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price()
        };
        let v11 = if (arg5) {
            0x2::balance::value<T1>(&v7)
        } else {
            0x2::balance::value<T0>(&v8)
        };
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg3, arg2, arg5, true, v11, v10, arg4);
        let v15 = v14;
        let v16 = v13;
        let v17 = v12;
        let (v18, v19) = if (arg5) {
            (0x2::balance::split<T1>(&mut v7, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v15)), 0x2::balance::zero<T0>())
        } else {
            (0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v8, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v15)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg3, arg2, v18, v19, v15);
        let (v20, v21) = if (arg5) {
            0x2::balance::join<T0>(&mut v16, v8);
            assert!(0x2::balance::value<T0>(&v16) >= v9 + arg9, 1);
            (0x2::balance::split<T0>(&mut v16, v9), v7)
        } else {
            0x2::balance::join<T1>(&mut v17, v7);
            assert!(0x2::balance::value<T1>(&v17) >= v9 + arg9, 1);
            (v8, 0x2::balance::split<T1>(&mut v17, v9))
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg0, v20, v21, v6);
        let v22 = if (arg5) {
            0x2::balance::value<T0>(&v16)
        } else {
            0x2::balance::value<T1>(&v17)
        };
        let v23 = ArbExecuted{
            buy_venue           : b"bluefin",
            sell_venue          : b"cetus",
            a2b_buy             : arg5,
            amount_in           : v9,
            amount_intermediate : v11,
            amount_out          : v9 + v22,
            profit              : v22,
        };
        0x2::event::emit<ArbExecuted>(v23);
        if (arg5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v16, arg12), 0x2::tx_context::sender(arg12));
            0x2::balance::destroy_zero<T1>(v17);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v17, arg12), 0x2::tx_context::sender(arg12));
            0x2::balance::destroy_zero<T0>(v16);
        };
    }

    public fun bluefin_buy_haedal_sell<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: bool, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        if (arg7 == 0) {
            let v0 = ArbSkipped{
                buy_venue  : b"bluefin",
                sell_venue : b"haedal",
                reason     : 1,
            };
            0x2::event::emit<ArbSkipped>(v0);
            return
        };
        let v1 = if (arg6) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let (v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg5, arg1, arg0, arg6, true, arg7, v1);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let (v8, v9) = if (arg6) {
            0x2::balance::destroy_zero<T0>(v7);
            let v10 = 0x2::balance::value<T1>(&v6);
            let v11 = 0x2::coin::from_balance<T1>(v6, arg9);
            let v12 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_quote_coin<T0, T1>(arg2, arg5, arg3, arg4, &mut v11, v10, 0, arg9);
            0x2::coin::destroy_zero<T1>(v11);
            let v13 = 0x2::coin::into_balance<T0>(v12);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg0, 0x2::balance::split<T0>(&mut v13, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v5)), 0x2::balance::zero<T1>(), v5);
            assert!(0x2::balance::value<T0>(&v13) >= arg8, 1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v13, arg9), 0x2::tx_context::sender(arg9));
            (v10, 0x2::coin::value<T0>(&v12))
        } else {
            0x2::balance::destroy_zero<T1>(v6);
            let v14 = 0x2::balance::value<T0>(&v7);
            let v15 = 0x2::coin::from_balance<T0>(v7, arg9);
            let v16 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_base_coin<T0, T1>(arg2, arg5, arg3, arg4, &mut v15, v14, 0, arg9);
            0x2::coin::destroy_zero<T0>(v15);
            let v17 = 0x2::coin::into_balance<T1>(v16);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg0, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v17, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v5)), v5);
            assert!(0x2::balance::value<T1>(&v17) >= arg8, 1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v17, arg9), 0x2::tx_context::sender(arg9));
            (v14, 0x2::coin::value<T1>(&v16))
        };
        let v18 = ArbExecuted{
            buy_venue           : b"bluefin",
            sell_venue          : b"haedal",
            a2b_buy             : arg6,
            amount_in           : arg7,
            amount_intermediate : v8,
            amount_out          : v9,
            profit              : v9 - arg7,
        };
        0x2::event::emit<ArbExecuted>(v18);
    }

    public fun bluefin_buy_momentum_sell<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: bool, arg6: u128, arg7: u64, arg8: u64, arg9: u64, arg10: u8, arg11: u8, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc5baa691ecbed8575d4bff750b80791d638ce1d1a5cb1942d85d4f6e9b7e808c::search::find_optimal_bluefin<T0, T1>(arg0, arg5, arg6, arg7, arg8, arg10, arg11);
        if (v0 < arg7) {
            let v1 = ArbSkipped{
                buy_venue  : b"bluefin",
                sell_venue : b"momentum",
                reason     : 0,
            };
            0x2::event::emit<ArbSkipped>(v1);
            return
        };
        let v2 = if (arg5) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let (v3, v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg1, arg0, arg5, true, v0, v2);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v6);
        let v10 = !arg5;
        let v11 = if (v10) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let v12 = if (arg5) {
            0x2::balance::value<T1>(&v7)
        } else {
            0x2::balance::value<T0>(&v8)
        };
        let (v13, v14, v15) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, v10, true, v12, v11, arg4, arg3, arg12);
        let v16 = v15;
        let v17 = v14;
        let v18 = v13;
        let (v19, v20) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v16);
        let (v21, v22) = if (v10) {
            (0x2::balance::split<T0>(&mut v8, v19), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v7, v20))
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v16, v21, v22, arg3, arg12);
        let (v23, v24) = if (arg5) {
            0x2::balance::join<T0>(&mut v18, v8);
            assert!(0x2::balance::value<T0>(&v18) >= v9 + arg9, 1);
            (0x2::balance::split<T0>(&mut v18, v9), v7)
        } else {
            0x2::balance::join<T1>(&mut v17, v7);
            assert!(0x2::balance::value<T1>(&v17) >= v9 + arg9, 1);
            (v8, 0x2::balance::split<T1>(&mut v17, v9))
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg0, v23, v24, v6);
        let v25 = if (arg5) {
            0x2::balance::value<T0>(&v18)
        } else {
            0x2::balance::value<T1>(&v17)
        };
        let v26 = ArbExecuted{
            buy_venue           : b"bluefin",
            sell_venue          : b"momentum",
            a2b_buy             : arg5,
            amount_in           : v9,
            amount_intermediate : v12,
            amount_out          : v9 + v25,
            profit              : v25,
        };
        0x2::event::emit<ArbExecuted>(v26);
        if (arg5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v18, arg12), 0x2::tx_context::sender(arg12));
            0x2::balance::destroy_zero<T1>(v17);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v17, arg12), 0x2::tx_context::sender(arg12));
            0x2::balance::destroy_zero<T0>(v18);
        };
    }

    public fun cetus_buy_bluefin_sell<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: bool, arg6: u128, arg7: u64, arg8: u64, arg9: u64, arg10: u8, arg11: u8, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc5baa691ecbed8575d4bff750b80791d638ce1d1a5cb1942d85d4f6e9b7e808c::search::find_optimal_cetus<T0, T1>(arg0, arg5, arg6, arg7, arg8, arg10, arg11);
        if (v0 < arg7) {
            let v1 = ArbSkipped{
                buy_venue  : b"cetus",
                sell_venue : b"bluefin",
                reason     : 0,
            };
            0x2::event::emit<ArbSkipped>(v1);
            return
        };
        let v2 = if (arg5) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price()
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price()
        };
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg0, arg5, true, v0, v2, arg4);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v6);
        let v10 = !arg5;
        let v11 = if (v10) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let (v12, v13) = if (arg5) {
            (0x2::balance::zero<T0>(), 0x2::balance::withdraw_all<T1>(&mut v7))
        } else {
            (0x2::balance::withdraw_all<T0>(&mut v8), 0x2::balance::zero<T1>())
        };
        let v14 = v13;
        let v15 = v12;
        let v16 = if (arg5) {
            0x2::balance::value<T1>(&v14)
        } else {
            0x2::balance::value<T0>(&v15)
        };
        let (v17, v18) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg4, arg3, arg2, v15, v14, v10, true, v16, 0, v11);
        let v19 = v18;
        let v20 = v17;
        let (v21, v22) = if (arg5) {
            assert!(0x2::balance::value<T0>(&v20) >= v9 + arg9, 1);
            0x2::balance::join<T0>(&mut v20, v8);
            (0x2::balance::split<T0>(&mut v20, v9), v7)
        } else {
            assert!(0x2::balance::value<T1>(&v19) >= v9 + arg9, 1);
            0x2::balance::join<T1>(&mut v19, v7);
            (v8, 0x2::balance::split<T1>(&mut v19, v9))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg0, v21, v22, v6);
        let v23 = if (arg5) {
            0x2::balance::value<T0>(&v20)
        } else {
            0x2::balance::value<T1>(&v19)
        };
        let v24 = ArbExecuted{
            buy_venue           : b"cetus",
            sell_venue          : b"bluefin",
            a2b_buy             : arg5,
            amount_in           : v9,
            amount_intermediate : v16,
            amount_out          : v9 + v23,
            profit              : v23,
        };
        0x2::event::emit<ArbExecuted>(v24);
        if (arg5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v20, arg12), 0x2::tx_context::sender(arg12));
            0x2::balance::destroy_zero<T1>(v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v19, arg12), 0x2::tx_context::sender(arg12));
            0x2::balance::destroy_zero<T0>(v20);
        };
    }

    public fun cetus_buy_bluefin_sell_crossed<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: bool, arg6: u128, arg7: u64, arg8: u64, arg9: u64, arg10: u8, arg11: u8, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc5baa691ecbed8575d4bff750b80791d638ce1d1a5cb1942d85d4f6e9b7e808c::search::find_optimal_cetus<T0, T1>(arg0, arg5, arg6, arg7, arg8, arg10, arg11);
        if (v0 < arg7) {
            let v1 = ArbSkipped{
                buy_venue  : b"cetus",
                sell_venue : b"bluefin",
                reason     : 0,
            };
            0x2::event::emit<ArbSkipped>(v1);
            return
        };
        let v2 = if (arg5) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price()
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price()
        };
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg0, arg5, true, v0, v2, arg4);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v6);
        let v10 = if (arg5) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let (v11, v12) = if (arg5) {
            (0x2::balance::withdraw_all<T1>(&mut v7), 0x2::balance::zero<T0>())
        } else {
            (0x2::balance::zero<T1>(), 0x2::balance::withdraw_all<T0>(&mut v8))
        };
        let v13 = v12;
        let v14 = v11;
        let v15 = if (arg5) {
            0x2::balance::value<T1>(&v14)
        } else {
            0x2::balance::value<T0>(&v13)
        };
        let (v16, v17) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T1, T0>(arg4, arg3, arg2, v14, v13, arg5, true, v15, 0, v10);
        let v18 = v17;
        let v19 = v16;
        let (v20, v21) = if (arg5) {
            assert!(0x2::balance::value<T0>(&v18) >= v9 + arg9, 1);
            0x2::balance::join<T0>(&mut v18, v8);
            (0x2::balance::split<T0>(&mut v18, v9), v7)
        } else {
            assert!(0x2::balance::value<T1>(&v19) >= v9 + arg9, 1);
            0x2::balance::join<T1>(&mut v19, v7);
            (v8, 0x2::balance::split<T1>(&mut v19, v9))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg0, v20, v21, v6);
        let v22 = if (arg5) {
            0x2::balance::value<T0>(&v18)
        } else {
            0x2::balance::value<T1>(&v19)
        };
        let v23 = ArbExecuted{
            buy_venue           : b"cetus",
            sell_venue          : b"bluefin",
            a2b_buy             : arg5,
            amount_in           : v9,
            amount_intermediate : v15,
            amount_out          : v9 + v22,
            profit              : v22,
        };
        0x2::event::emit<ArbExecuted>(v23);
        if (arg5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v18, arg12), 0x2::tx_context::sender(arg12));
            0x2::balance::destroy_zero<T1>(v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v19, arg12), 0x2::tx_context::sender(arg12));
            0x2::balance::destroy_zero<T0>(v18);
        };
    }

    public fun cetus_buy_cetus_sell<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: bool, arg5: u128, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: u8, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc5baa691ecbed8575d4bff750b80791d638ce1d1a5cb1942d85d4f6e9b7e808c::search::find_optimal_cetus<T0, T1>(arg0, arg4, arg5, arg6, arg7, arg9, arg10);
        if (v0 < arg6) {
            let v1 = ArbSkipped{
                buy_venue  : b"cetus",
                sell_venue : b"cetus",
                reason     : 0,
            };
            0x2::event::emit<ArbSkipped>(v1);
            return
        };
        let v2 = if (arg4) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price()
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price()
        };
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg2, arg0, arg4, true, v0, v2, arg3);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v6);
        let v10 = !arg4;
        let v11 = if (v10) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price()
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price()
        };
        let v12 = if (arg4) {
            0x2::balance::value<T1>(&v7)
        } else {
            0x2::balance::value<T0>(&v8)
        };
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg2, arg1, v10, true, v12, v11, arg3);
        let v16 = v15;
        let v17 = v14;
        let v18 = v13;
        let (v19, v20) = if (v10) {
            (0x2::balance::split<T0>(&mut v8, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v16)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v7, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v16)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg2, arg1, v19, v20, v16);
        if (arg4) {
            0x2::balance::join<T0>(&mut v18, v8);
            assert!(0x2::balance::value<T0>(&v18) >= v9 + arg8, 1);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg2, arg0, 0x2::balance::split<T0>(&mut v18, v9), v7, v6);
            let v21 = 0x2::balance::value<T0>(&v18);
            let v22 = ArbExecuted{
                buy_venue           : b"cetus",
                sell_venue          : b"cetus",
                a2b_buy             : arg4,
                amount_in           : v9,
                amount_intermediate : v12,
                amount_out          : v9 + v21,
                profit              : v21,
            };
            0x2::event::emit<ArbExecuted>(v22);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v18, arg11), 0x2::tx_context::sender(arg11));
            0x2::balance::destroy_zero<T1>(v17);
        } else {
            0x2::balance::join<T1>(&mut v17, v7);
            assert!(0x2::balance::value<T1>(&v17) >= v9 + arg8, 1);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg2, arg0, v8, 0x2::balance::split<T1>(&mut v17, v9), v6);
            let v23 = 0x2::balance::value<T1>(&v17);
            let v24 = ArbExecuted{
                buy_venue           : b"cetus",
                sell_venue          : b"cetus",
                a2b_buy             : arg4,
                amount_in           : v9,
                amount_intermediate : v12,
                amount_out          : v9 + v23,
                profit              : v23,
            };
            0x2::event::emit<ArbExecuted>(v24);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v17, arg11), 0x2::tx_context::sender(arg11));
            0x2::balance::destroy_zero<T0>(v18);
        };
    }

    public fun cetus_buy_haedal_sell<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: bool, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        if (arg7 == 0) {
            let v0 = ArbSkipped{
                buy_venue  : b"cetus",
                sell_venue : b"haedal",
                reason     : 1,
            };
            0x2::event::emit<ArbSkipped>(v0);
            return
        };
        let v1 = if (arg6) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price() + 1
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price() - 1
        };
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg0, arg6, true, arg7, v1, arg5);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let (v8, v9) = if (arg6) {
            0x2::balance::destroy_zero<T0>(v7);
            let v10 = 0x2::balance::value<T1>(&v6);
            let v11 = 0x2::coin::from_balance<T1>(v6, arg9);
            let v12 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_quote_coin<T0, T1>(arg2, arg5, arg3, arg4, &mut v11, v10, 0, arg9);
            0x2::coin::destroy_zero<T1>(v11);
            let v13 = 0x2::coin::into_balance<T0>(v12);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg0, 0x2::balance::split<T0>(&mut v13, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5)), 0x2::balance::zero<T1>(), v5);
            assert!(0x2::balance::value<T0>(&v13) >= arg8, 1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v13, arg9), 0x2::tx_context::sender(arg9));
            (v10, 0x2::coin::value<T0>(&v12))
        } else {
            0x2::balance::destroy_zero<T1>(v6);
            let v14 = 0x2::balance::value<T0>(&v7);
            let v15 = 0x2::coin::from_balance<T0>(v7, arg9);
            let v16 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_base_coin<T0, T1>(arg2, arg5, arg3, arg4, &mut v15, v14, 0, arg9);
            0x2::coin::destroy_zero<T0>(v15);
            let v17 = 0x2::coin::into_balance<T1>(v16);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg0, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v17, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5)), v5);
            assert!(0x2::balance::value<T1>(&v17) >= arg8, 1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v17, arg9), 0x2::tx_context::sender(arg9));
            (v14, 0x2::coin::value<T1>(&v16))
        };
        let v18 = ArbExecuted{
            buy_venue           : b"cetus",
            sell_venue          : b"haedal",
            a2b_buy             : arg6,
            amount_in           : arg7,
            amount_intermediate : v8,
            amount_out          : v9,
            profit              : v9 - arg7,
        };
        0x2::event::emit<ArbExecuted>(v18);
    }

    public fun cetus_buy_momentum_sell<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: bool, arg6: u128, arg7: u64, arg8: u64, arg9: u64, arg10: u8, arg11: u8, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc5baa691ecbed8575d4bff750b80791d638ce1d1a5cb1942d85d4f6e9b7e808c::search::find_optimal_cetus<T0, T1>(arg0, arg5, arg6, arg7, arg8, arg10, arg11);
        if (v0 < arg7) {
            let v1 = ArbSkipped{
                buy_venue  : b"cetus",
                sell_venue : b"momentum",
                reason     : 0,
            };
            0x2::event::emit<ArbSkipped>(v1);
            return
        };
        let v2 = if (arg5) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price()
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price()
        };
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg0, arg5, true, v0, v2, arg4);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v6);
        let v10 = !arg5;
        let v11 = if (v10) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let v12 = if (arg5) {
            0x2::balance::value<T1>(&v7)
        } else {
            0x2::balance::value<T0>(&v8)
        };
        let (v13, v14, v15) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, v10, true, v12, v11, arg4, arg3, arg12);
        let v16 = v15;
        let v17 = v14;
        let v18 = v13;
        let (v19, v20) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v16);
        let (v21, v22) = if (v10) {
            (0x2::balance::split<T0>(&mut v8, v19), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v7, v20))
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v16, v21, v22, arg3, arg12);
        let (v23, v24) = if (arg5) {
            0x2::balance::join<T0>(&mut v18, v8);
            assert!(0x2::balance::value<T0>(&v18) >= v9 + arg9, 1);
            (0x2::balance::split<T0>(&mut v18, v9), v7)
        } else {
            0x2::balance::join<T1>(&mut v17, v7);
            assert!(0x2::balance::value<T1>(&v17) >= v9 + arg9, 1);
            (v8, 0x2::balance::split<T1>(&mut v17, v9))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg0, v23, v24, v6);
        let v25 = if (arg5) {
            0x2::balance::value<T0>(&v18)
        } else {
            0x2::balance::value<T1>(&v17)
        };
        let v26 = ArbExecuted{
            buy_venue           : b"cetus",
            sell_venue          : b"momentum",
            a2b_buy             : arg5,
            amount_in           : v9,
            amount_intermediate : v12,
            amount_out          : v9 + v25,
            profit              : v25,
        };
        0x2::event::emit<ArbExecuted>(v26);
        if (arg5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v18, arg12), 0x2::tx_context::sender(arg12));
            0x2::balance::destroy_zero<T1>(v17);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v17, arg12), 0x2::tx_context::sender(arg12));
            0x2::balance::destroy_zero<T0>(v18);
        };
    }

    public fun momentum_buy_bluefin_sell<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: bool, arg6: u128, arg7: u64, arg8: u64, arg9: u64, arg10: u8, arg11: u8, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc5baa691ecbed8575d4bff750b80791d638ce1d1a5cb1942d85d4f6e9b7e808c::search::find_optimal_momentum<T0, T1>(arg0, arg5, arg6, arg7, arg8, arg10, arg11);
        if (v0 < arg7) {
            let v1 = ArbSkipped{
                buy_venue  : b"momentum",
                sell_venue : b"bluefin",
                reason     : 0,
            };
            0x2::event::emit<ArbSkipped>(v1);
            return
        };
        let v2 = if (arg5) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let (v3, v4, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, arg5, true, v0, v2, arg4, arg1, arg12);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let (v9, v10) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v6);
        let v11 = !arg5;
        let v12 = if (v11) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let v13 = if (arg5) {
            0x2::balance::value<T1>(&v7)
        } else {
            0x2::balance::value<T0>(&v8)
        };
        let (v14, v15) = if (arg5) {
            (0x2::balance::zero<T0>(), 0x2::balance::withdraw_all<T1>(&mut v7))
        } else {
            (0x2::balance::withdraw_all<T0>(&mut v8), 0x2::balance::zero<T1>())
        };
        let (v16, v17) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg4, arg3, arg2, v14, v15, v11, true, v13, 0, v12);
        let v18 = v17;
        let v19 = v16;
        let (v20, v21) = if (arg5) {
            0x2::balance::join<T0>(&mut v19, v8);
            assert!(0x2::balance::value<T0>(&v19) >= v9 + arg9, 1);
            (0x2::balance::split<T0>(&mut v19, v9), v7)
        } else {
            0x2::balance::join<T1>(&mut v18, v7);
            assert!(0x2::balance::value<T1>(&v18) >= v10 + arg9, 1);
            (v8, 0x2::balance::split<T1>(&mut v18, v10))
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v6, v20, v21, arg1, arg12);
        let v22 = if (arg5) {
            0x2::balance::value<T0>(&v19)
        } else {
            0x2::balance::value<T1>(&v18)
        };
        let v23 = if (arg5) {
            v9
        } else {
            v10
        };
        let v24 = if (arg5) {
            v9
        } else {
            v10
        };
        let v25 = ArbExecuted{
            buy_venue           : b"momentum",
            sell_venue          : b"bluefin",
            a2b_buy             : arg5,
            amount_in           : v23,
            amount_intermediate : v13,
            amount_out          : v24 + v22,
            profit              : v22,
        };
        0x2::event::emit<ArbExecuted>(v25);
        if (arg5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v19, arg12), 0x2::tx_context::sender(arg12));
            0x2::balance::destroy_zero<T1>(v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v18, arg12), 0x2::tx_context::sender(arg12));
            0x2::balance::destroy_zero<T0>(v19);
        };
    }

    public fun momentum_buy_cetus_sell<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: bool, arg6: u128, arg7: u64, arg8: u64, arg9: u64, arg10: u8, arg11: u8, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc5baa691ecbed8575d4bff750b80791d638ce1d1a5cb1942d85d4f6e9b7e808c::search::find_optimal_momentum<T0, T1>(arg0, arg5, arg6, arg7, arg8, arg10, arg11);
        if (v0 < arg7) {
            let v1 = ArbSkipped{
                buy_venue  : b"momentum",
                sell_venue : b"cetus",
                reason     : 0,
            };
            0x2::event::emit<ArbSkipped>(v1);
            return
        };
        let v2 = if (arg5) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let (v3, v4, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, arg5, true, v0, v2, arg4, arg1, arg12);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let (v9, v10) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v6);
        let v11 = !arg5;
        let v12 = if (v11) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price()
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price()
        };
        let v13 = if (arg5) {
            0x2::balance::value<T1>(&v7)
        } else {
            0x2::balance::value<T0>(&v8)
        };
        let (v14, v15, v16) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg3, arg2, v11, true, v13, v12, arg4);
        let v17 = v16;
        let v18 = v15;
        let v19 = v14;
        let (v20, v21) = if (v11) {
            (0x2::balance::split<T0>(&mut v8, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v17)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v7, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v17)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg3, arg2, v20, v21, v17);
        let (v22, v23) = if (arg5) {
            0x2::balance::join<T0>(&mut v19, v8);
            assert!(0x2::balance::value<T0>(&v19) >= v9 + arg9, 1);
            (0x2::balance::split<T0>(&mut v19, v9), v7)
        } else {
            0x2::balance::join<T1>(&mut v18, v7);
            assert!(0x2::balance::value<T1>(&v18) >= v10 + arg9, 1);
            (v8, 0x2::balance::split<T1>(&mut v18, v10))
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v6, v22, v23, arg1, arg12);
        let v24 = if (arg5) {
            0x2::balance::value<T0>(&v19)
        } else {
            0x2::balance::value<T1>(&v18)
        };
        let v25 = if (arg5) {
            v9
        } else {
            v10
        };
        let v26 = if (arg5) {
            v9
        } else {
            v10
        };
        let v27 = ArbExecuted{
            buy_venue           : b"momentum",
            sell_venue          : b"cetus",
            a2b_buy             : arg5,
            amount_in           : v25,
            amount_intermediate : v13,
            amount_out          : v26 + v24,
            profit              : v24,
        };
        0x2::event::emit<ArbExecuted>(v27);
        if (arg5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v19, arg12), 0x2::tx_context::sender(arg12));
            0x2::balance::destroy_zero<T1>(v18);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v18, arg12), 0x2::tx_context::sender(arg12));
            0x2::balance::destroy_zero<T0>(v19);
        };
    }

    public fun momentum_buy_haedal_sell<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: bool, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        if (arg7 == 0) {
            let v0 = ArbSkipped{
                buy_venue  : b"momentum",
                sell_venue : b"haedal",
                reason     : 1,
            };
            0x2::event::emit<ArbSkipped>(v0);
            return
        };
        let v1 = if (arg6) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let (v2, v3, v4) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, arg6, true, arg7, v1, arg5, arg1, arg9);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let (v8, v9) = if (arg6) {
            0x2::balance::destroy_zero<T0>(v7);
            let v10 = 0x2::balance::value<T1>(&v6);
            let v11 = 0x2::coin::from_balance<T1>(v6, arg9);
            let v12 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_quote_coin<T0, T1>(arg2, arg5, arg3, arg4, &mut v11, v10, 0, arg9);
            0x2::coin::destroy_zero<T1>(v11);
            let v13 = 0x2::coin::into_balance<T0>(v12);
            let (v14, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v5);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v5, 0x2::balance::split<T0>(&mut v13, v14), 0x2::balance::zero<T1>(), arg1, arg9);
            assert!(0x2::balance::value<T0>(&v13) >= arg8, 1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v13, arg9), 0x2::tx_context::sender(arg9));
            (v10, 0x2::coin::value<T0>(&v12))
        } else {
            0x2::balance::destroy_zero<T1>(v6);
            let v16 = 0x2::balance::value<T0>(&v7);
            let v17 = 0x2::coin::from_balance<T0>(v7, arg9);
            let v18 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_base_coin<T0, T1>(arg2, arg5, arg3, arg4, &mut v17, v16, 0, arg9);
            0x2::coin::destroy_zero<T0>(v17);
            let v19 = 0x2::coin::into_balance<T1>(v18);
            let (_, v21) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v5);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v5, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v19, v21), arg1, arg9);
            assert!(0x2::balance::value<T1>(&v19) >= arg8, 1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v19, arg9), 0x2::tx_context::sender(arg9));
            (v16, 0x2::coin::value<T1>(&v18))
        };
        let v22 = ArbExecuted{
            buy_venue           : b"momentum",
            sell_venue          : b"haedal",
            a2b_buy             : arg6,
            amount_in           : arg7,
            amount_intermediate : v8,
            amount_out          : v9,
            profit              : v9 - arg7,
        };
        0x2::event::emit<ArbExecuted>(v22);
    }

    // decompiled from Move bytecode v6
}

