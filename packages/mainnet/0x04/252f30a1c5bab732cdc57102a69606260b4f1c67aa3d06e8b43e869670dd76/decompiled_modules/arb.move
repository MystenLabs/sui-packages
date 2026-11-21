module 0x4f26ec871b815fce8ff8c8a9c4eaf14c48607c661319b5e386cde012c2832dfd::arb {
    fun best_amount<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) : u64 {
        let v0 = arg3;
        let v1 = arg4;
        let v2 = 0;
        while (v2 < arg5 && v1 - v0 > 2) {
            let v3 = v0 + (v1 - v0) / 3;
            let v4 = v1 - (v1 - v0) / 3;
            if (gain<T0, T1, T2>(arg0, arg1, arg2, v3, arg6) < gain<T0, T1, T2>(arg0, arg1, arg2, v4, arg6)) {
                v0 = v3 + 1;
            } else {
                v1 = v4 - 1;
            };
            v2 = v2 + 1;
        };
        v0 + (v1 - v0) / 2
    }

    fun cost_of(arg0: &vector<u64>, arg1: &vector<u64>, arg2: u64) : (u256, u64) {
        let v0 = arg2;
        let v1 = 0;
        let v2 = 0;
        while (v0 > 0 && v2 < 0x1::vector::length<u64>(arg0)) {
            let v3 = if (*0x1::vector::borrow<u64>(arg1, v2) < v0) {
                *0x1::vector::borrow<u64>(arg1, v2)
            } else {
                v0
            };
            v1 = v1 + (v3 as u256) * (*0x1::vector::borrow<u64>(arg0, v2) as u256);
            v0 = v0 - v3;
            v2 = v2 + 1;
        };
        assert!(v0 == 0, 1);
        ((v1 + 1000000000 - 1) / 1000000000, v2)
    }

    fun couple(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256) : u256 {
        price_after_in(arg2, arg3, out_to(arg0, arg4, arg1) * (1000000 - arg5) / 1000000)
    }

    fun cycle_bm<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg5: u64, arg6: u64, arg7: u128, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T2, T0>(arg3, arg5, arg10);
        let v2 = 0x2::coin::into_balance<T0>(v0);
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, arg5, arg7, arg9);
        let v6 = v5;
        let v7 = v4;
        0x2::balance::destroy_zero<T0>(v3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v6)), 0x2::balance::zero<T1>(), v6);
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg2, true, true, 0x2::balance::value<T1>(&v7), arg8, arg9);
        let v11 = v10;
        let v12 = v9;
        0x2::balance::destroy_zero<T1>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg2, 0x2::balance::split<T1>(&mut v7, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v11)), 0x2::balance::zero<T2>(), v11);
        0x2::balance::destroy_zero<T1>(v7);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T2>(arg4, 0x2::coin::from_balance<T2>(v12, arg10), arg10);
        let (v13, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T2, T0>(arg3);
        let (_, v17, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T2, T0>(arg3);
        let v19 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg4, arg10);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T2, T0>(arg3, arg4, &v19, 0, 0, (((0x2::balance::value<T2>(&v12) as u128) * 1000000000 / (1000000000 + (v13 as u128) * 5 / 4)) as u64) / v17 * v17, false, false, arg9, arg10);
        let v20 = 0x2::balance::value<T0>(&v2);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg4) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg4) + v20 >= arg5 + arg6, 1);
        let v21 = 0x2::coin::from_balance<T0>(v2, arg10);
        0x2::coin::join<T0>(&mut v21, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg4, arg5 - v20, arg10));
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T2, T0>(arg3, v21, v1);
    }

    fun cycle_exact<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: u128, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg2, true, false, arg5, arg10, arg11);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v0);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v3);
        let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, v4, arg9, arg11);
        let v8 = v7;
        let v9 = v6;
        0x2::balance::destroy_zero<T0>(v5);
        let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg2, 0x2::balance::split<T1>(&mut v9, v4), 0x2::balance::zero<T2>(), v3);
        if (0x2::balance::value<T1>(&v9) == 0) {
            0x2::balance::destroy_zero<T1>(v9);
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg4, 0x2::coin::from_balance<T1>(v9, arg12), arg12);
        };
        let (v11, v12) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T2, T0>(arg3, v10, arg12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v11), 0x2::balance::zero<T1>(), v8);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T2>(arg4, 0x2::coin::from_balance<T2>(v1, arg12), arg12);
        let v13 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg4, arg12);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T2, T0>(arg3, arg4, &v13, 0, 0, arg6, false, arg8, arg11, arg12);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg4) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg4) >= v10 + arg7, 1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T2, T0>(arg3, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg4, v10, arg12), v12);
    }

    fun cycle_rev<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: u128, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg4);
        let (v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T2, T0>(arg3, arg5, arg12);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg4, v1, arg12);
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg4, arg12);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T2, T0>(arg3, arg4, &v3, 0, 0, arg6, true, arg8, arg11, arg12);
        let v4 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg4) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg4);
        let v5 = 0x2::coin::into_balance<T2>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T2>(arg4, v4, arg12));
        let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg2, false, true, v4, arg10, arg11);
        let v9 = v8;
        0x2::balance::destroy_zero<T2>(v7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg2, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v9)), v9);
        put_back<T2>(arg4, v5, arg12);
        let v10 = v6;
        let (v11, v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&v10), arg9, arg11);
        let v14 = v13;
        0x2::balance::destroy_zero<T1>(v12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v10, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v14)), v14);
        put_back<T1>(arg4, v10, arg12);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg4, 0x2::coin::from_balance<T0>(v11, arg12), arg12);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg4) >= v0 + arg5 + arg7, 1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T2, T0>(arg3, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg4, arg5, arg12), v2);
    }

    fun duo_deep<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: u64) : bool {
        if (arg3 == 0) {
            return false
        };
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T1, T0>(arg0);
        (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1) as u128) >= ((arg2 as u128) * (v0 as u128) + 999999999) / 1000000000 * (arg3 as u128)
    }

    public fun execute_book_bf_cetus_rev<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u128, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg13) == @0x1cd163400d605ff1e9d153a2867451fb7e3177a4a080d645b7046dcb043f8b4e, 2);
        let (_, _, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T2, T0>(arg4, arg7, arg12);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x1::vector::length<u64>(&v5);
        assert!(v6 > 0, 1);
        let (v7, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T2, T0>(arg4);
        let (_, v11, v12) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T2, T0>(arg4);
        let v13 = (v7 as u256) * 5 / 4;
        let v14 = 0;
        let v15 = 0;
        while (v15 < v6) {
            v14 = v14 + *0x1::vector::borrow<u64>(&v4, v15);
            v15 = v15 + 1;
        };
        let v16 = 0;
        let v17 = v14 / v11;
        while (v16 < v17) {
            let v18 = v16 + (v17 - v16 + 1) / 2;
            let v19 = xr_loan(&v5, &v4, v18 * v11, v13);
            if (v19 > 0 && v19 <= arg6) {
                v16 = v18;
                continue
            };
            v17 = v18 - 1;
        };
        assert!(v16 > 0, 1);
        let v20 = xr_best<T0, T1, T2>(arg3, arg1, &v5, &v4, v11, v16, arg8, v13, arg11);
        assert!(v20 >= v12, 1);
        let v21 = xr_loan(&v5, &v4, v20, v13);
        assert!(v21 > 0 && v21 <= arg6, 1);
        xr_cycle<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, v21, v20, arg9, arg10, arg11, arg12, arg13);
    }

    public fun execute_book_tri<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg4: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: u64, arg6: bool, arg7: u64, arg8: u128, arg9: u128, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        assert!(0x2::tx_context::sender(arg12) == @0x1cd163400d605ff1e9d153a2867451fb7e3177a4a080d645b7046dcb043f8b4e, 2);
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T2, T0>(arg3, arg5, arg12);
        let (v2, v3, v4) = if (arg6) {
            let v5 = 0x2::coin::into_balance<T0>(v0);
            let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, arg5, arg8, arg11);
            let v9 = v8;
            let v10 = v7;
            0x2::balance::destroy_zero<T0>(v6);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v9)), 0x2::balance::zero<T1>(), v9);
            let (v11, v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg2, true, true, 0x2::balance::value<T1>(&v10), arg9, arg11);
            let v14 = v13;
            0x2::balance::destroy_zero<T1>(v11);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg2, 0x2::balance::split<T1>(&mut v10, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v14)), 0x2::balance::zero<T2>(), v14);
            0x2::balance::destroy_zero<T1>(v10);
            let (v15, v16, v17) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T2, T0>(arg3, 0x2::coin::from_balance<T2>(v12, arg12), arg4, arg10, arg11, arg12);
            0x2::balance::join<T0>(&mut v5, 0x2::coin::into_balance<T0>(v16));
            (v5, v15, v17)
        } else {
            let (v18, v19, v20) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T2, T0>(arg3, v0, arg4, arg10, arg11, arg12);
            let v21 = 0x2::coin::into_balance<T0>(v19);
            let v22 = 0x2::coin::into_balance<T2>(v18);
            let (v23, v24, v25) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg2, false, true, 0x2::balance::value<T2>(&v22), arg9, arg11);
            let v26 = v25;
            let v27 = v23;
            0x2::balance::destroy_zero<T2>(v24);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg2, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut v22, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v26)), v26);
            let (v28, v29, v30) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&v27), arg8, arg11);
            let v31 = v30;
            0x2::balance::destroy_zero<T1>(v29);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v27, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v31)), v31);
            0x2::balance::destroy_zero<T1>(v27);
            0x2::balance::join<T0>(&mut v21, v28);
            (v21, 0x2::coin::from_balance<T2>(v22, arg12), v20)
        };
        let v32 = v2;
        assert!(0x2::balance::value<T0>(&v32) >= arg5 + arg7, 1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T2, T0>(arg3, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v32, arg5), arg12), v1);
        (0x2::coin::from_balance<T0>(v32, arg12), v3, v4)
    }

    public fun execute_book_tri_auto<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg12) == @0x1cd163400d605ff1e9d153a2867451fb7e3177a4a080d645b7046dcb043f8b4e, 2);
        let v0 = best_amount<T0, T1, T2>(arg1, arg2, arg3, arg5, arg6, arg7, arg11);
        assert!(gain<T0, T1, T2>(arg1, arg2, arg3, v0, arg11) >= arg8, 1);
        cycle_bm<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v0, arg8, arg9, arg10, arg11, arg12);
    }

    public fun execute_book_tri_bm<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg5: u64, arg6: u64, arg7: u128, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg10) == @0x1cd163400d605ff1e9d153a2867451fb7e3177a4a080d645b7046dcb043f8b4e, 2);
        cycle_bm<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun execute_book_tri_size_rev<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg11) == @0x1cd163400d605ff1e9d153a2867451fb7e3177a4a080d645b7046dcb043f8b4e, 2);
        let (_, _, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T2, T0>(arg3, arg6, arg10);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x1::vector::length<u64>(&v5);
        assert!(v6 > 0, 1);
        let (v7, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T2, T0>(arg3);
        let (_, v11, v12) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T2, T0>(arg3);
        let v13 = arg5 / v11 * v11;
        assert!(v13 >= v12, 1);
        let v14 = v13;
        let v15 = 0;
        let v16 = 0;
        while (v14 > 0 && v16 < v6) {
            let v17 = if (*0x1::vector::borrow<u64>(&v4, v16) < v14) {
                *0x1::vector::borrow<u64>(&v4, v16)
            } else {
                v14
            };
            v15 = v15 + (v17 as u256) * (*0x1::vector::borrow<u64>(&v5, v16) as u256);
            v14 = v14 - v17;
            v16 = v16 + 1;
        };
        assert!(v14 == 0, 1);
        let v18 = (v15 + 1000000000 - 1) / 1000000000;
        cycle_rev<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, ((v18 + (v18 * (v7 as u256) * 5 / 4 + 1000000000 - 1) / 1000000000 + (v16 as u256) + 1) as u64), v13, arg7, false, arg8, arg9, arg10, arg11);
    }

    public fun execute_book_tri_split<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u64, arg7: bool, arg8: u64, arg9: u128, arg10: u128, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        assert!(0x2::tx_context::sender(arg13) == @0x1cd163400d605ff1e9d153a2867451fb7e3177a4a080d645b7046dcb043f8b4e, 2);
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T3, T0>(arg3, arg6, arg13);
        let (v2, v3, v4) = if (arg7) {
            let v5 = 0x2::coin::into_balance<T0>(v0);
            let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, arg6, arg9, arg12);
            let v9 = v8;
            let v10 = v7;
            0x2::balance::destroy_zero<T0>(v6);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v9)), 0x2::balance::zero<T1>(), v9);
            let (v11, v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg2, true, true, 0x2::balance::value<T1>(&v10), arg10, arg12);
            let v14 = v13;
            0x2::balance::destroy_zero<T1>(v11);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg2, 0x2::balance::split<T1>(&mut v10, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v14)), 0x2::balance::zero<T2>(), v14);
            0x2::balance::destroy_zero<T1>(v10);
            let (v15, v16, v17) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T2, T0>(arg4, 0x2::coin::from_balance<T2>(v12, arg13), arg5, arg11, arg12, arg13);
            0x2::balance::join<T0>(&mut v5, 0x2::coin::into_balance<T0>(v16));
            (v5, v15, v17)
        } else {
            let (v18, v19, v20) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T2, T0>(arg4, v0, arg5, arg11, arg12, arg13);
            let v21 = 0x2::coin::into_balance<T0>(v19);
            let v22 = 0x2::coin::into_balance<T2>(v18);
            let (v23, v24, v25) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg2, false, true, 0x2::balance::value<T2>(&v22), arg10, arg12);
            let v26 = v25;
            let v27 = v23;
            0x2::balance::destroy_zero<T2>(v24);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg2, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut v22, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v26)), v26);
            let (v28, v29, v30) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&v27), arg9, arg12);
            let v31 = v30;
            0x2::balance::destroy_zero<T1>(v29);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v27, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v31)), v31);
            0x2::balance::destroy_zero<T1>(v27);
            0x2::balance::join<T0>(&mut v21, v28);
            (v21, 0x2::coin::from_balance<T2>(v22, arg13), v20)
        };
        let v32 = v2;
        assert!(0x2::balance::value<T0>(&v32) >= arg6 + arg8, 1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T3, T0>(arg3, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v32, arg6), arg13), v1);
        (0x2::coin::from_balance<T0>(v32, arg13), v3, v4)
    }

    public fun execute_book_tri_walk<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg11) == @0x1cd163400d605ff1e9d153a2867451fb7e3177a4a080d645b7046dcb043f8b4e, 2);
        let v0 = loan_by_walk<T0, T1, T2>(arg1, arg2, arg3, arg5, arg6, false, arg10);
        assert!(v0 > 0, 1);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, true, true, v0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T2>(arg2, true, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v1));
        let (v3, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T2, T0>(arg3);
        let (_, v7, v8) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T2, T0>(arg3);
        let v9 = (v3 as u128) * 5 / 4;
        let v10 = (((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v2) as u128) * 1000000000 / (1000000000 + v9)) as u64) / v7 * v7;
        assert!(v10 >= v8, 1);
        cycle_exact<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v10 + ((((v10 as u128) * v9 + 999999999) / 1000000000) as u64), v10, arg7, false, arg8, arg9, arg10, arg11);
    }

    public fun execute_book_tri_walk_deep<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg12) == @0x1cd163400d605ff1e9d153a2867451fb7e3177a4a080d645b7046dcb043f8b4e, 2);
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T2, T0>(arg3);
        let (_, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T2, T0>(arg3);
        let v6 = loan_by_walk<T0, T1, T2>(arg1, arg2, arg3, arg5, arg6, true, arg11);
        let v7 = ((((v6 as u128) * (v0 as u128) + 999999999) / 1000000000) as u64);
        if (v6 > 0 && (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4) as u128) >= (v7 as u128) * (arg8 as u128)) {
            let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, true, true, v6);
            let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T2>(arg2, true, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v8));
            let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v9) / v4 * v4;
            assert!(v10 >= v5, 1);
            cycle_exact<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v10, v10, arg7 + v7, true, arg9, arg10, arg11, arg12);
        } else {
            let v11 = loan_by_walk<T0, T1, T2>(arg1, arg2, arg3, arg5, arg6, false, arg11);
            assert!(v11 > 0, 1);
            let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, true, true, v11);
            let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T2>(arg2, true, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v12));
            let v14 = (v0 as u128) * 5 / 4;
            let v15 = (((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v13) as u128) * 1000000000 / (1000000000 + v14)) as u64) / v4 * v4;
            assert!(v15 >= v5, 1);
            cycle_exact<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v15 + ((((v15 as u128) * v14 + 999999999) / 1000000000) as u64), v15, arg7, false, arg9, arg10, arg11, arg12);
        };
    }

    public fun execute_book_tri_walk_deep_guard<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: u128, arg11: u128, arg12: u128, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg14) == @0x1cd163400d605ff1e9d153a2867451fb7e3177a4a080d645b7046dcb043f8b4e, 2);
        guard<T0, T1, T2>(arg1, arg2, arg11, arg12, true);
        execute_book_tri_walk_deep<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg13, arg14);
    }

    public fun execute_book_tri_walk_rev<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg11) == @0x1cd163400d605ff1e9d153a2867451fb7e3177a4a080d645b7046dcb043f8b4e, 2);
        let (v0, v1, v2) = loan_by_walk_rev<T0, T1, T2>(arg1, arg2, arg3, arg5, arg6, false, arg10);
        let v3 = v2;
        let v4 = v1;
        assert!(v0 > 0, 1);
        let (v5, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T2, T0>(arg3);
        let (_, v9, v10) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T2, T0>(arg3);
        let v11 = v0 / v9 * v9;
        assert!(v11 >= v10, 1);
        let v12 = v11;
        let v13 = 0;
        let v14 = 0;
        while (v12 > 0 && v14 < 0x1::vector::length<u64>(&v4)) {
            let v15 = if (*0x1::vector::borrow<u64>(&v3, v14) < v12) {
                *0x1::vector::borrow<u64>(&v3, v14)
            } else {
                v12
            };
            v13 = v13 + (v15 as u256) * (*0x1::vector::borrow<u64>(&v4, v14) as u256);
            v12 = v12 - v15;
            v14 = v14 + 1;
        };
        assert!(v12 == 0, 1);
        let v16 = (v13 + 1000000000 - 1) / 1000000000;
        cycle_rev<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, ((v16 + (v16 * (v5 as u256) * 5 / 4 + 1000000000 - 1) / 1000000000 + (v14 as u256) + 1) as u64), v11, arg7, false, arg8, arg9, arg10, arg11);
    }

    public fun execute_book_tri_walk_rev_deep<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg12) == @0x1cd163400d605ff1e9d153a2867451fb7e3177a4a080d645b7046dcb043f8b4e, 2);
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T2, T0>(arg3);
        let (_, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T2, T0>(arg3);
        let (v6, v7, v8) = loan_by_walk_rev<T0, T1, T2>(arg1, arg2, arg3, arg5, arg6, true, arg11);
        let v9 = v8;
        let v10 = v7;
        let v11 = v6 / v4 * v4;
        let v12 = false;
        if (v11 >= v5) {
            let (v13, v14) = cost_of(&v10, &v9, v11);
            let v15 = (((v13 * (v0 as u256) + 1000000000 - 1) / 1000000000) as u64);
            if ((0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4) as u128) >= (v15 as u128) * (arg8 as u128)) {
                cycle_rev<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, ((v13 + (v14 as u256) + 1) as u64), v11, arg7 + v15, true, arg9, arg10, arg11, arg12);
                v12 = true;
            };
        };
        if (!v12) {
            let (v16, v17, v18) = loan_by_walk_rev<T0, T1, T2>(arg1, arg2, arg3, arg5, arg6, false, arg11);
            let v19 = v18;
            let v20 = v17;
            assert!(v16 > 0, 1);
            let v21 = v16 / v4 * v4;
            assert!(v21 >= v5, 1);
            let (v22, v23) = cost_of(&v20, &v19, v21);
            cycle_rev<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, ((v22 + (v22 * (v0 as u256) * 5 / 4 + 1000000000 - 1) / 1000000000 + (v23 as u256) + 1) as u64), v21, arg7, false, arg9, arg10, arg11, arg12);
        };
    }

    public fun execute_book_tri_walk_rev_deep_guard<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: u128, arg11: u128, arg12: u128, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg14) == @0x1cd163400d605ff1e9d153a2867451fb7e3177a4a080d645b7046dcb043f8b4e, 2);
        guard<T0, T1, T2>(arg1, arg2, arg11, arg12, false);
        execute_book_tri_walk_rev_deep<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg13, arg14);
    }

    public fun execute_duo<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u128, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg8) == @0x1cd163400d605ff1e9d153a2867451fb7e3177a4a080d645b7046dcb043f8b4e, 2);
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = 0x2::coin::into_balance<T0>(arg3);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, v0, arg5, arg7);
        let v5 = v4;
        let v6 = v3;
        0x2::balance::destroy_zero<T0>(v2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5)), 0x2::balance::zero<T1>(), v5);
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, 0x2::balance::value<T1>(&v6), arg6, arg7);
        let v10 = v9;
        0x2::balance::destroy_zero<T1>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v10)), v10);
        0x2::balance::destroy_zero<T1>(v6);
        0x2::balance::join<T0>(&mut v1, v7);
        assert!(0x2::balance::value<T0>(&v1) >= v0 + arg4, 1);
        0x2::coin::from_balance<T0>(v1, arg8)
    }

    public fun execute_duo_book<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg10) == @0x1cd163400d605ff1e9d153a2867451fb7e3177a4a080d645b7046dcb043f8b4e, 2);
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T1, T0>(arg2);
        let (_, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T1, T0>(arg2);
        let v6 = duo_deep<T0, T1>(arg2, arg3, arg4, arg7);
        let v7 = if (v6) {
            (v0 as u256)
        } else {
            (v0 as u256) * 5 / 4
        };
        let v8 = (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg1) as u256);
        let (v9, _, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T1, T0>(arg2, 1, arg9);
        let v13 = v9;
        assert!(0x1::vector::length<u64>(&v13) > 0, 1);
        assert!(worth1((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1) as u256), (*0x1::vector::borrow<u64>(&v13, 0) as u256), v8, v7), 1);
        let (v14, v15, v16, _) = ladder<T0, T1>(arg1, arg4);
        let v18 = v16;
        let v19 = v15;
        let v20 = v14;
        let (v21, v22, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T1, T0>(arg2, arg5, arg9);
        let v25 = v22;
        let v26 = v21;
        let v27 = (walk1(&v20, &v19, &v18, v8, &v26, &v25, v7, (arg4 as u256)) as u64);
        assert!(v27 > 0, 1);
        let v28 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, true, true, v27);
        let v29 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v28);
        let v30 = v29 / v4 * v4;
        let v31 = v30;
        let v32 = v30;
        let v33 = 0;
        if (v6) {
            v33 = ((((v27 as u128) * (v0 as u128) + 999999999) / 1000000000) as u64);
        } else {
            let v34 = (v0 as u128) * 5 / 4;
            let v35 = (((v29 as u128) * 1000000000 / (1000000000 + v34)) as u64) / v4 * v4;
            v31 = v35;
            v32 = v35 + ((((v35 as u128) * v34 + 999999999) / 1000000000) as u64);
        };
        assert!(v31 >= v5, 1);
        let (v36, v37, v38) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, v32, arg8, arg9);
        let v39 = v38;
        0x2::balance::destroy_zero<T0>(v36);
        let v40 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v39);
        let (v41, v42) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T1, T0>(arg2, v40, arg10);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v41), 0x2::balance::zero<T1>(), v39);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg3, 0x2::coin::from_balance<T1>(v37, arg10), arg10);
        let v43 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg10);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T1, T0>(arg2, arg3, &v43, 0, 0, v31, false, v6, arg9, arg10);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg3) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg3) >= v40 + arg6 + v33, 1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T1, T0>(arg2, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg3, v40, arg10), v42);
    }

    public fun execute_duo_book_rev<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg10) == @0x1cd163400d605ff1e9d153a2867451fb7e3177a4a080d645b7046dcb043f8b4e, 2);
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T1, T0>(arg2);
        let (_, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T1, T0>(arg2);
        let v6 = duo_deep<T0, T1>(arg2, arg3, arg4, arg7);
        let v7 = if (v6) {
            (v0 as u256)
        } else {
            (v0 as u256) * 5 / 4
        };
        let v8 = (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg1) as u256);
        let (_, _, v11, v12) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T1, T0>(arg2, arg5, arg9);
        let v13 = v12;
        let v14 = v11;
        let v15 = 0x1::vector::length<u64>(&v14);
        assert!(v15 > 0, 1);
        assert!(worth1(340282366920938463463374607431768211456 / (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1) as u256), 1000000000 * 1000000000 / (*0x1::vector::borrow<u64>(&v14, 0) as u256), v8, v7), 1);
        let v16 = (arg4 as u256) * 1000000000 / (*0x1::vector::borrow<u64>(&v14, 0) as u256);
        assert!(v16 > 0, 1);
        let (v17, v18, v19, _) = ladder_rev<T0, T1>(arg1, (v16 as u64));
        let v21 = v19;
        let v22 = v18;
        let v23 = v17;
        let v24 = vector[];
        let v25 = vector[];
        let v26 = 0;
        while (v26 < v15) {
            let v27 = (*0x1::vector::borrow<u64>(&v14, v26) as u256);
            0x1::vector::push_back<u64>(&mut v24, ((1000000000 * 1000000000 / v27) as u64));
            0x1::vector::push_back<u64>(&mut v25, (((*0x1::vector::borrow<u64>(&v13, v26) as u256) * v27 / 1000000000) as u64));
            v26 = v26 + 1;
        };
        let v28 = (walk1(&v23, &v22, &v21, v8, &v24, &v25, v7, v16) as u64);
        assert!(v28 > 0, 1);
        let v29 = v28 / v4 * v4;
        assert!(v29 >= v5, 1);
        let (v30, v31) = cost_of(&v14, &v13, v29);
        let v32 = ((v30 + (v31 as u256) + 1) as u64);
        let v33 = 0;
        if (v6) {
            v33 = (((v30 * (v0 as u256) + 1000000000 - 1) / 1000000000) as u64);
        } else {
            v32 = ((v30 + (v30 * v7 + 1000000000 - 1) / 1000000000 + (v31 as u256) + 1) as u64);
        };
        let v34 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg3);
        let (v35, v36) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T1, T0>(arg2, v32, arg10);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg3, v35, arg10);
        let v37 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg10);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T1, T0>(arg2, arg3, &v37, 0, 0, v29, true, v6, arg9, arg10);
        let v38 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg3) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg3);
        let v39 = 0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(arg3, v38, arg10));
        let (v40, v41, v42) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, v38, arg8, arg9);
        let v43 = v42;
        0x2::balance::destroy_zero<T1>(v41);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v39, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v43)), v43);
        put_back<T1>(arg3, v39, arg10);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg3, 0x2::coin::from_balance<T0>(v40, arg10), arg10);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg3) >= v34 + v32 + arg6 + v33, 1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T1, T0>(arg2, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg3, v32, arg10), v36);
    }

    public fun execute_duo_pools<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: u64, arg5: u64, arg6: u128, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg9) == @0x1cd163400d605ff1e9d153a2867451fb7e3177a4a080d645b7046dcb043f8b4e, 2);
        let v0 = (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg1) as u256);
        let v1 = (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg2) as u256);
        assert!(worth2((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1) as u256), 340282366920938463463374607431768211456 / (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2) as u256), v0, v1), 1);
        let (v2, v3, v4, v5) = ladder<T0, T1>(arg1, arg4);
        let v6 = v4;
        let v7 = v3;
        let v8 = v2;
        let (v9, v10, v11, _) = ladder_rev<T0, T1>(arg2, v5);
        let v13 = v11;
        let v14 = v10;
        let v15 = v9;
        let v16 = (walk2(&v8, &v7, &v6, v0, &v15, &v14, &v13, v1, (arg4 as u256)) as u64);
        assert!(v16 > 0, 1);
        let (v17, v18, v19) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, v16, arg6, arg8);
        let v20 = v19;
        0x2::balance::destroy_zero<T0>(v17);
        let v21 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v20);
        let v22 = v18;
        let (v23, v24, v25) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, 0x2::balance::value<T1>(&v22), arg7, arg8);
        let v26 = v25;
        0x2::balance::destroy_zero<T1>(v24);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v22, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v26)), v26);
        put_back<T1>(arg3, v22, arg9);
        let v27 = v23;
        assert!(0x2::balance::value<T0>(&v27) >= v21 + arg5, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v27, v21), 0x2::balance::zero<T1>(), v20);
        put_back<T0>(arg3, v27, arg9);
    }

    public fun execute_tri<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: bool, arg6: u64, arg7: u128, arg8: u128, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg11) == @0x1cd163400d605ff1e9d153a2867451fb7e3177a4a080d645b7046dcb043f8b4e, 2);
        let v0 = 0x2::coin::value<T0>(&arg4);
        let v1 = 0x2::coin::into_balance<T0>(arg4);
        if (!arg5) {
            let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg3, true, true, v0, arg7, arg10);
            let v5 = v4;
            let v6 = v3;
            0x2::balance::destroy_zero<T0>(v2);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg3, 0x2::balance::split<T0>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5)), 0x2::balance::zero<T1>(), v5);
            let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg2, true, true, 0x2::balance::value<T1>(&v6), arg8, arg10);
            let v10 = v9;
            let v11 = v8;
            0x2::balance::destroy_zero<T1>(v7);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg2, 0x2::balance::split<T1>(&mut v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v10)), 0x2::balance::zero<T2>(), v10);
            0x2::balance::destroy_zero<T1>(v6);
            let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T2>(arg0, arg1, false, true, 0x2::balance::value<T2>(&v11), arg9, arg10);
            let v15 = v14;
            0x2::balance::destroy_zero<T2>(v13);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T2>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T2>(&mut v11, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T2>(&v15)), v15);
            0x2::balance::destroy_zero<T2>(v11);
            0x2::balance::join<T0>(&mut v1, v12);
        } else {
            let (v16, v17, v18) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T2>(arg0, arg1, true, true, v0, arg7, arg10);
            let v19 = v18;
            let v20 = v17;
            0x2::balance::destroy_zero<T0>(v16);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T2>(arg0, arg1, 0x2::balance::split<T0>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T2>(&v19)), 0x2::balance::zero<T2>(), v19);
            let (v21, v22, v23) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg2, false, true, 0x2::balance::value<T2>(&v20), arg8, arg10);
            let v24 = v23;
            let v25 = v21;
            0x2::balance::destroy_zero<T2>(v22);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg2, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut v20, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v24)), v24);
            0x2::balance::destroy_zero<T2>(v20);
            let (v26, v27, v28) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg3, false, true, 0x2::balance::value<T1>(&v25), arg9, arg10);
            let v29 = v28;
            0x2::balance::destroy_zero<T1>(v27);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v25, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v29)), v29);
            0x2::balance::destroy_zero<T1>(v25);
            0x2::balance::join<T0>(&mut v1, v26);
        };
        assert!(0x2::balance::value<T0>(&v1) >= v0 + arg6, 1);
        0x2::coin::from_balance<T0>(v1, arg11)
    }

    public fun execute_tri_flash<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u64, arg5: bool, arg6: u64, arg7: u128, arg8: u128, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg11) == @0x1cd163400d605ff1e9d153a2867451fb7e3177a4a080d645b7046dcb043f8b4e, 2);
        if (arg5) {
            let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T2>(arg0, arg1, true, true, arg4, arg7, arg10);
            let v4 = v3;
            let v5 = v2;
            0x2::balance::destroy_zero<T0>(v1);
            let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg2, false, true, 0x2::balance::value<T2>(&v5), arg8, arg10);
            let v9 = v8;
            let v10 = v6;
            0x2::balance::destroy_zero<T2>(v7);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg2, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v9)), v9);
            0x2::balance::destroy_zero<T2>(v5);
            let (v11, v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg3, false, true, 0x2::balance::value<T1>(&v10), arg9, arg10);
            let v14 = v13;
            0x2::balance::destroy_zero<T1>(v12);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v10, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v14)), v14);
            0x2::balance::destroy_zero<T1>(v10);
            let v15 = v11;
            let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T2>(&v4);
            assert!(0x2::balance::value<T0>(&v15) >= v16 + arg6, 1);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T2>(arg0, arg1, 0x2::balance::split<T0>(&mut v15, v16), 0x2::balance::zero<T2>(), v4);
            0x2::coin::from_balance<T0>(v15, arg11)
        } else {
            let (v17, v18, v19) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg3, true, true, arg4, arg7, arg10);
            let v20 = v19;
            let v21 = v18;
            0x2::balance::destroy_zero<T0>(v17);
            let (v22, v23, v24) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg2, true, true, 0x2::balance::value<T1>(&v21), arg8, arg10);
            let v25 = v24;
            let v26 = v23;
            0x2::balance::destroy_zero<T1>(v22);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg2, 0x2::balance::split<T1>(&mut v21, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v25)), 0x2::balance::zero<T2>(), v25);
            0x2::balance::destroy_zero<T1>(v21);
            let (v27, v28, v29) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T2>(arg0, arg1, false, true, 0x2::balance::value<T2>(&v26), arg9, arg10);
            let v30 = v29;
            0x2::balance::destroy_zero<T2>(v28);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T2>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T2>(&mut v26, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T2>(&v30)), v30);
            0x2::balance::destroy_zero<T2>(v26);
            let v31 = v27;
            let v32 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v20);
            assert!(0x2::balance::value<T0>(&v31) >= v32 + arg6, 1);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg3, 0x2::balance::split<T0>(&mut v31, v32), 0x2::balance::zero<T1>(), v20);
            0x2::coin::from_balance<T0>(v31, arg11)
        }
    }

    public fun execute_xdex<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: u128, arg11: u128, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg13) == @0x1cd163400d605ff1e9d153a2867451fb7e3177a4a080d645b7046dcb043f8b4e, 2);
        let v0 = xdex_best<T0, T1>(arg1, arg3, arg6, arg7, arg9, arg11);
        assert!(v0 > 0, 1);
        xdex_cycle<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    fun gain<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg3: u64, arg4: &0x2::clock::Clock) : u64 {
        let v0 = round_out<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
        if (v0 > arg3) {
            v0 - arg3
        } else {
            0
        }
    }

    fun guard<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: u128, arg3: u128, arg4: bool) {
        if (arg4) {
            assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0) >= arg2 && 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T2>(arg1) >= arg3, 4);
        } else {
            assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0) <= arg2 && 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T2>(arg1) <= arg3, 4);
        };
    }

    fun in_to(arg0: u256, arg1: u256, arg2: u256) : u256 {
        if (arg1 >= arg0 || arg2 == 0) {
            0
        } else {
            arg2 * (arg0 - arg1) * 18446744073709551616 / arg0 * arg1
        }
    }

    fun ladder<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64) : (vector<u256>, vector<u256>, vector<u256>, u64) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, true, true, arg1);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result_step_results(&v0);
        let v2 = vector[];
        let v3 = vector[];
        let v4 = vector[];
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::SwapStepResult>(v1)) {
            let v6 = 0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::SwapStepResult>(v1, v5);
            0x1::vector::push_back<u256>(&mut v2, (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::step_swap_result_current_sqrt_price(v6) as u256));
            0x1::vector::push_back<u256>(&mut v3, (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::step_swap_result_target_sqrt_price(v6) as u256));
            0x1::vector::push_back<u256>(&mut v4, (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::step_swap_result_current_liquidity(v6) as u256));
            v5 = v5 + 1;
        };
        (v2, v3, v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0))
    }

    fun ladder_rev<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64) : (vector<u256>, vector<u256>, vector<u256>, u64) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, false, true, arg1);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result_step_results(&v0);
        let v2 = vector[];
        let v3 = vector[];
        let v4 = vector[];
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::SwapStepResult>(v1)) {
            let v6 = 0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::SwapStepResult>(v1, v5);
            0x1::vector::push_back<u256>(&mut v2, 340282366920938463463374607431768211456 / (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::step_swap_result_current_sqrt_price(v6) as u256));
            0x1::vector::push_back<u256>(&mut v3, 340282366920938463463374607431768211456 / (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::step_swap_result_target_sqrt_price(v6) as u256));
            0x1::vector::push_back<u256>(&mut v4, (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::step_swap_result_current_liquidity(v6) as u256));
            v5 = v5 + 1;
        };
        (v2, v3, v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0))
    }

    fun loan_by_walk<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock) : u64 {
        let (v0, v1, v2, v3) = ladder<T0, T1>(arg0, arg3);
        let v4 = v2;
        let v5 = v1;
        let v6 = v0;
        let (v7, v8, v9, _) = ladder<T1, T2>(arg1, v3);
        let v11 = v9;
        let v12 = v8;
        let v13 = v7;
        let (v14, v15, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T2, T0>(arg2, arg4, arg6);
        let v18 = v15;
        let v19 = v14;
        let (v20, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T2, T0>(arg2);
        let v23 = if (arg5) {
            (v20 as u256)
        } else {
            (v20 as u256) * 5 / 4
        };
        (walk(&v6, &v5, &v4, (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0) as u256), &v13, &v12, &v11, (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T1, T2>(arg1) as u256), &v19, &v18, v23, (arg3 as u256)) as u64)
    }

    fun loan_by_walk_rev<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock) : (u64, vector<u64>, vector<u64>) {
        let (_, _, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T2, T0>(arg2, arg4, arg6);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x1::vector::length<u64>(&v5);
        if (v6 == 0) {
            return (0, v5, v4)
        };
        let v7 = (arg3 as u256) * 1000000000 / (*0x1::vector::borrow<u64>(&v5, 0) as u256);
        if (v7 == 0) {
            return (0, v5, v4)
        };
        let (v8, v9, v10, v11) = ladder_rev<T1, T2>(arg1, (v7 as u64));
        let v12 = v10;
        let v13 = v9;
        let v14 = v8;
        let (v15, v16, v17, _) = ladder_rev<T0, T1>(arg0, v11);
        let v19 = v17;
        let v20 = v16;
        let v21 = v15;
        let v22 = vector[];
        let v23 = vector[];
        let v24 = 0;
        while (v24 < v6) {
            let v25 = (*0x1::vector::borrow<u64>(&v5, v24) as u256);
            0x1::vector::push_back<u64>(&mut v22, ((1000000000 * 1000000000 / v25) as u64));
            0x1::vector::push_back<u64>(&mut v23, (((*0x1::vector::borrow<u64>(&v4, v24) as u256) * v25 / 1000000000) as u64));
            v24 = v24 + 1;
        };
        let (v26, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T2, T0>(arg2);
        let v29 = if (arg5) {
            (v26 as u256)
        } else {
            (v26 as u256) * 5 / 4
        };
        ((walk(&v14, &v13, &v12, (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T1, T2>(arg1) as u256), &v21, &v20, &v19, (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0) as u256), &v22, &v23, v29, v7) as u64), v5, v4)
    }

    fun max3(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = if (arg0 > arg1) {
            arg0
        } else {
            arg1
        };
        if (v0 > arg2) {
            v0
        } else {
            arg2
        }
    }

    fun min2(arg0: u256, arg1: u256) : u256 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun open_book_account(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x1cd163400d605ff1e9d153a2867451fb7e3177a4a080d645b7046dcb043f8b4e, 2);
        0x2::transfer::public_share_object<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg0));
    }

    fun out_to(arg0: u256, arg1: u256, arg2: u256) : u256 {
        if (arg1 >= arg0) {
            0
        } else {
            arg2 * (arg0 - arg1) / 18446744073709551616
        }
    }

    fun price_after_in(arg0: u256, arg1: u256, arg2: u256) : u256 {
        arg1 * arg0 * 18446744073709551616 / (arg1 * 18446744073709551616 + arg2 * arg0)
    }

    fun price_for_out(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = arg2 * 18446744073709551616 / arg1;
        if (v0 >= arg0) {
            0
        } else {
            arg0 - v0
        }
    }

    fun put_back<T0>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg0, 0x2::coin::from_balance<T0>(arg1, arg2), arg2);
        };
    }

    fun round_out<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg3: u64, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, true, true, arg3);
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v0)) {
            return 0
        };
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T2>(arg1, true, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0));
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v1)) {
            return 0
        };
        let (_, v3, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T2, T0>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v1), arg4);
        v3
    }

    fun walk(arg0: &vector<u256>, arg1: &vector<u256>, arg2: &vector<u256>, arg3: u256, arg4: &vector<u256>, arg5: &vector<u256>, arg6: &vector<u256>, arg7: u256, arg8: &vector<u64>, arg9: &vector<u64>, arg10: u256, arg11: u256) : u256 {
        let v0 = 0x1::vector::length<u256>(arg0);
        let v1 = 0x1::vector::length<u256>(arg4);
        let v2 = 0x1::vector::length<u64>(arg8);
        let v3 = if (v0 == 0) {
            true
        } else if (v1 == 0) {
            true
        } else {
            v2 == 0
        };
        if (v3) {
            return 0
        };
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = *0x1::vector::borrow<u256>(arg0, 0);
        let v8 = *0x1::vector::borrow<u256>(arg2, 0);
        let v9 = *0x1::vector::borrow<u256>(arg4, 0);
        let v10 = *0x1::vector::borrow<u256>(arg6, 0);
        let v11 = (*0x1::vector::borrow<u64>(arg9, 0) as u256);
        let v12 = 0;
        let v13;
        let v14;
        loop {
            if (v12 >= arg11) {
                return arg11
            };
            v13 = (*0x1::vector::borrow<u64>(arg8, v6) as u256);
            if (!worth(v7, v9, v13, arg3, arg7, arg10)) {
                return v12
            };
            if (v8 == 0) {
                let v15 = v4 + 1;
                v4 = v15;
                if (v15 == v0) {
                    return v12
                };
                v7 = *0x1::vector::borrow<u256>(arg0, v15);
                v8 = *0x1::vector::borrow<u256>(arg2, v15);
                continue
            };
            if (v10 == 0) {
                let v16 = v5 + 1;
                v5 = v16;
                if (v16 == v1) {
                    return v12
                };
                v9 = *0x1::vector::borrow<u256>(arg4, v16);
                v10 = *0x1::vector::borrow<u256>(arg6, v16);
                continue
            };
            let v17 = *0x1::vector::borrow<u256>(arg1, v4);
            let v18 = price_for_out(v7, v8, in_to(v9, *0x1::vector::borrow<u256>(arg5, v5), v10) * 1000000 / (1000000 - arg7));
            let v19 = price_for_out(v7, v8, in_to(v9, price_for_out(v9, v10, v11 * (1000000000 + arg10) / 1000000000), v10) * 1000000 / (1000000 - arg7));
            v14 = max3(v17, v18, v19);
            let v20 = couple(v7, v8, v9, v10, v14, arg7);
            if (worth(v14, v20, v13, arg3, arg7, arg10)) {
                let v21 = v12 + in_to(v7, v14, v8) * 1000000 / (1000000 - arg3);
                v12 = v21;
                let v22 = out_to(v9, v20, v10) * 1000000000 / (1000000000 + arg10);
                let v23 = if (v22 >= v11) {
                    0
                } else {
                    v11 - v22
                };
                v11 = v23;
                v9 = v20;
                v7 = v14;
                if (v14 == v17) {
                    let v24 = v4 + 1;
                    v4 = v24;
                    if (v24 == v0) {
                        return min2(v21, arg11)
                    };
                    v7 = *0x1::vector::borrow<u256>(arg0, v24);
                    v8 = *0x1::vector::borrow<u256>(arg2, v24);
                };
                if (v14 == v18) {
                    let v25 = v5 + 1;
                    v5 = v25;
                    if (v25 == v1) {
                        return min2(v21, arg11)
                    };
                    v9 = *0x1::vector::borrow<u256>(arg4, v25);
                    v10 = *0x1::vector::borrow<u256>(arg6, v25);
                };
                if (v14 == v19 || v23 == 0) {
                    let v26 = v6 + 1;
                    v6 = v26;
                    if (v26 == v2) {
                        return min2(v21, arg11)
                    };
                    v11 = (*0x1::vector::borrow<u64>(arg9, v26) as u256);
                };
            } else {
                break
            };
        };
        let v27 = v14;
        let v28 = v7;
        while (v28 - v27 > 1) {
            v27 = v27 + (v28 - v27) / 2;
            if (worth(v27, couple(v7, v8, v9, v10, v27, arg7), v13, arg3, arg7, arg10)) {
                v28 = v27;
                continue
            };
        };
        min2(v12 + in_to(v7, v28, v8) * 1000000 / (1000000 - arg3), arg11)
    }

    fun walk1(arg0: &vector<u256>, arg1: &vector<u256>, arg2: &vector<u256>, arg3: u256, arg4: &vector<u64>, arg5: &vector<u64>, arg6: u256, arg7: u256) : u256 {
        let v0 = 0x1::vector::length<u256>(arg0);
        let v1 = 0x1::vector::length<u64>(arg4);
        if (v0 == 0 || v1 == 0) {
            return 0
        };
        let v2 = 0;
        let v3 = 0;
        let v4 = *0x1::vector::borrow<u256>(arg0, 0);
        let v5 = *0x1::vector::borrow<u256>(arg2, 0);
        let v6 = (*0x1::vector::borrow<u64>(arg5, 0) as u256);
        let v7 = 0;
        let v8;
        let v9;
        loop {
            if (v7 >= arg7) {
                return arg7
            };
            v8 = (*0x1::vector::borrow<u64>(arg4, v3) as u256);
            if (!worth1(v4, v8, arg3, arg6)) {
                return v7
            };
            if (v5 == 0) {
                let v10 = v2 + 1;
                v2 = v10;
                if (v10 == v0) {
                    return v7
                };
                v4 = *0x1::vector::borrow<u256>(arg0, v10);
                v5 = *0x1::vector::borrow<u256>(arg2, v10);
                continue
            };
            if (v6 == 0) {
                v3 = v3 + 1;
                if (v3 == v1) {
                    return v7
                };
                v6 = (*0x1::vector::borrow<u64>(arg5, v3) as u256);
                continue
            };
            let v11 = *0x1::vector::borrow<u256>(arg1, v2);
            let v12 = price_for_out(v4, v5, v6 * (1000000000 + arg6) / 1000000000);
            if (v11 > v12) {
                v9 = v11;
            } else {
                v9 = v12;
            };
            if (worth1(v9, v8, arg3, arg6)) {
                let v13 = v7 + in_to(v4, v9, v5) * 1000000 / (1000000 - arg3);
                v7 = v13;
                let v14 = out_to(v4, v9, v5) * 1000000000 / (1000000000 + arg6);
                let v15 = if (v14 >= v6) {
                    0
                } else {
                    v6 - v14
                };
                v6 = v15;
                v4 = v9;
                if (v9 == v12) {
                    v6 = 0;
                };
                if (v9 == v11) {
                    let v16 = v2 + 1;
                    v2 = v16;
                    if (v16 == v0) {
                        return min2(v13, arg7)
                    };
                    v4 = *0x1::vector::borrow<u256>(arg0, v16);
                    v5 = *0x1::vector::borrow<u256>(arg2, v16);
                };
            } else {
                break
            };
        };
        let v17 = v9;
        let v18 = v4;
        while (v18 - v17 > 1) {
            v17 = v17 + (v18 - v17) / 2;
            if (worth1(v17, v8, arg3, arg6)) {
                v18 = v17;
                continue
            };
        };
        min2(v7 + in_to(v4, v18, v5) * 1000000 / (1000000 - arg3), arg7)
    }

    fun walk2(arg0: &vector<u256>, arg1: &vector<u256>, arg2: &vector<u256>, arg3: u256, arg4: &vector<u256>, arg5: &vector<u256>, arg6: &vector<u256>, arg7: u256, arg8: u256) : u256 {
        let v0 = 0x1::vector::length<u256>(arg0);
        let v1 = 0x1::vector::length<u256>(arg4);
        if (v0 == 0 || v1 == 0) {
            return 0
        };
        let v2 = 0;
        let v3 = 0;
        let v4 = *0x1::vector::borrow<u256>(arg0, 0);
        let v5 = *0x1::vector::borrow<u256>(arg2, 0);
        let v6 = *0x1::vector::borrow<u256>(arg4, 0);
        let v7 = *0x1::vector::borrow<u256>(arg6, 0);
        let v8 = 0;
        let v9;
        loop {
            if (v8 >= arg8) {
                return arg8
            };
            if (!worth2(v4, v6, arg3, arg7)) {
                return v8
            };
            if (v5 == 0) {
                let v10 = v2 + 1;
                v2 = v10;
                if (v10 == v0) {
                    return v8
                };
                v4 = *0x1::vector::borrow<u256>(arg0, v10);
                v5 = *0x1::vector::borrow<u256>(arg2, v10);
                continue
            };
            if (v7 == 0) {
                let v11 = v3 + 1;
                v3 = v11;
                if (v11 == v1) {
                    return v8
                };
                v6 = *0x1::vector::borrow<u256>(arg4, v11);
                v7 = *0x1::vector::borrow<u256>(arg6, v11);
                continue
            };
            let v12 = *0x1::vector::borrow<u256>(arg1, v2);
            let v13 = price_for_out(v4, v5, in_to(v6, *0x1::vector::borrow<u256>(arg5, v3), v7) * 1000000 / (1000000 - arg7));
            if (v12 > v13) {
                v9 = v12;
            } else {
                v9 = v13;
            };
            let v14 = couple(v4, v5, v6, v7, v9, arg7);
            if (worth2(v9, v14, arg3, arg7)) {
                let v15 = v8 + in_to(v4, v9, v5) * 1000000 / (1000000 - arg3);
                v8 = v15;
                v6 = v14;
                v4 = v9;
                if (v9 == v12) {
                    let v16 = v2 + 1;
                    v2 = v16;
                    if (v16 == v0) {
                        return min2(v15, arg8)
                    };
                    v4 = *0x1::vector::borrow<u256>(arg0, v16);
                    v5 = *0x1::vector::borrow<u256>(arg2, v16);
                };
                if (v9 == v13) {
                    let v17 = v3 + 1;
                    v3 = v17;
                    if (v17 == v1) {
                        return min2(v15, arg8)
                    };
                    v6 = *0x1::vector::borrow<u256>(arg4, v17);
                    v7 = *0x1::vector::borrow<u256>(arg6, v17);
                };
            } else {
                break
            };
        };
        let v18 = v9;
        let v19 = v4;
        while (v19 - v18 > 1) {
            v18 = v18 + (v19 - v18) / 2;
            if (worth2(v18, couple(v4, v5, v6, v7, v18, arg7), arg3, arg7)) {
                v19 = v18;
                continue
            };
        };
        min2(v8 + in_to(v4, v19, v5) * 1000000 / (1000000 - arg3), arg8)
    }

    fun worth(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256) : bool {
        arg0 * arg0 / 18446744073709551616 * arg1 * arg1 / 18446744073709551616 * (1000000 - arg3) * (1000000 - arg4) * arg2 > 18446744073709551616 * 18446744073709551616 * 1000000 * 1000000 * (1000000000 + arg5)
    }

    fun worth1(arg0: u256, arg1: u256, arg2: u256, arg3: u256) : bool {
        arg0 * arg0 / 18446744073709551616 * (1000000 - arg2) * arg1 > 18446744073709551616 * 1000000 * (1000000000 + arg3)
    }

    fun worth2(arg0: u256, arg1: u256, arg2: u256, arg3: u256) : bool {
        arg0 * arg0 / 18446744073709551616 * arg1 * arg1 / 18446744073709551616 * (1000000 - arg2) * (1000000 - arg3) > 18446744073709551616 * 18446744073709551616 * 1000000 * 1000000
    }

    fun xdex_best<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: u64, arg3: u64, arg4: bool, arg5: u128) : u64 {
        let v0 = 1;
        let v1 = v0;
        let v2 = arg2;
        if (arg2 <= v0) {
            return 0
        };
        let v3 = 0;
        while (v3 < arg3 && v2 - v1 > 2) {
            let v4 = v1 + (v2 - v1) / 3;
            let v5 = v2 - (v2 - v1) / 3;
            if (xdex_gain<T0, T1>(arg0, arg1, v4, arg4, arg5) < xdex_gain<T0, T1>(arg0, arg1, v5, arg4, arg5)) {
                v1 = v4 + 1;
            } else {
                v2 = v5 - 1;
            };
            if (v2 <= v1) {
                return 0
            };
            v3 = v3 + 1;
        };
        let v6 = v1 + (v2 - v1) / 2;
        if (xdex_gain<T0, T1>(arg0, arg1, v6, arg4, arg5) == 0) {
            0
        } else {
            v6
        }
    }

    fun xdex_cycle<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: u64, arg7: u64, arg8: bool, arg9: u128, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T2, T0>(arg4, arg6, arg12);
        let v2 = 0x2::coin::into_balance<T0>(v0);
        let v3 = if (arg8) {
            let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, arg6, arg9, arg11);
            let v7 = v6;
            let v8 = v5;
            0x2::balance::destroy_zero<T0>(v4);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v7)), 0x2::balance::zero<T1>(), v7);
            let (v9, v10, v11) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg11, arg2, arg3, true, true, 0x2::balance::value<T1>(&v8), arg10);
            0x2::balance::destroy_zero<T1>(v9);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg2, arg3, v8, 0x2::balance::zero<T0>(), v11);
            v10
        } else {
            let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg11, arg2, arg3, false, true, arg6, arg10);
            let v15 = v14;
            let v16 = v12;
            0x2::balance::destroy_zero<T0>(v13);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg2, arg3, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T0>(&v15)), v15);
            let (v17, v18, v19) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&v16), arg9, arg11);
            0x2::balance::destroy_zero<T1>(v18);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v16, v19);
            v17
        };
        let v20 = v3;
        0x2::balance::join<T0>(&mut v20, v2);
        assert!(0x2::balance::value<T0>(&v20) >= arg6 + arg7, 1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T2, T0>(arg4, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v20, arg6), arg12), v1);
        put_back<T0>(arg5, v20, arg12);
    }

    fun xdex_gain<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: u64, arg3: bool, arg4: u128) : u64 {
        let v0 = xdex_out<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        if (v0 > arg2) {
            v0 - arg2
        } else {
            0
        }
    }

    fun xdex_out<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: u64, arg3: bool, arg4: u128) : u64 {
        if (arg2 == 0) {
            return 0
        };
        if (arg3) {
            let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, true, true, arg2);
            if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v1)) {
                return 0
            };
            let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v1);
            if (v2 == 0) {
                return 0
            };
            let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T1, T0>(arg1, true, true, v2, arg4);
            if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v3)) {
                return 0
            };
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v3)
        } else {
            let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T1, T0>(arg1, false, true, arg2, arg4);
            if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v4)) {
                return 0
            };
            let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v4);
            if (v5 == 0) {
                return 0
            };
            let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, false, true, v5);
            if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v6)) {
                return 0
            };
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v6)
        }
    }

    fun xr_best<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: u64, arg5: u64, arg6: u64, arg7: u256, arg8: u128) : u64 {
        let v0 = 1;
        let v1 = v0;
        let v2 = arg5;
        if (arg5 < v0) {
            return 0
        };
        let v3 = 0;
        while (v3 < arg6 && v2 - v1 > 2) {
            let v4 = v1 + (v2 - v1) / 3;
            let v5 = v2 - (v2 - v1) / 3;
            if (xr_gain<T0, T1, T2>(arg0, arg1, arg2, arg3, v4 * arg4, arg7, arg8) < xr_gain<T0, T1, T2>(arg0, arg1, arg2, arg3, v5 * arg4, arg7, arg8)) {
                v1 = v4 + 1;
            } else {
                v2 = v5 - 1;
            };
            if (v2 < v1) {
                return 0
            };
            v3 = v3 + 1;
        };
        let v6 = v1 + (v2 - v1) / 2;
        if (xr_gain<T0, T1, T2>(arg0, arg1, arg2, arg3, v6 * arg4, arg7, arg8) == 0) {
            0
        } else {
            v6 * arg4
        }
    }

    fun xr_cycle<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg5);
        let (v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T2, T0>(arg4, arg6, arg12);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg5, v1, arg12);
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg5, arg12);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T2, T0>(arg4, arg5, &v3, 0, 0, arg7, true, false, arg11, arg12);
        let v4 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg5) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg5);
        assert!(v4 > 0, 1);
        let v5 = 0x2::coin::into_balance<T2>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T2>(arg5, v4, arg12));
        let (v6, v7, v8) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg11, arg2, arg3, true, true, v4, arg10);
        let v9 = v8;
        0x2::balance::destroy_zero<T2>(v6);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg2, arg3, 0x2::balance::split<T2>(&mut v5, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T1>(&v9)), 0x2::balance::zero<T1>(), v9);
        put_back<T2>(arg5, v5, arg12);
        let v10 = v7;
        let (v11, v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&v10), arg9, arg11);
        let v14 = v13;
        0x2::balance::destroy_zero<T1>(v12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v10, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v14)), v14);
        put_back<T1>(arg5, v10, arg12);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg5, 0x2::coin::from_balance<T0>(v11, arg12), arg12);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg5) >= v0 + arg6 + arg8, 1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T2, T0>(arg4, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg5, arg6, arg12), v2);
    }

    fun xr_gain<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: u64, arg5: u256, arg6: u128) : u64 {
        let v0 = xr_loan(arg2, arg3, arg4, arg5);
        if (v0 == 0) {
            return 0
        };
        let v1 = xr_out<T0, T1, T2>(arg0, arg1, arg4, arg6);
        if (v1 > v0) {
            v1 - v0
        } else {
            0
        }
    }

    fun xr_loan(arg0: &vector<u64>, arg1: &vector<u64>, arg2: u64, arg3: u256) : u64 {
        let v0 = arg2;
        let v1 = 0;
        let v2 = 0;
        while (v0 > 0 && v2 < 0x1::vector::length<u64>(arg0)) {
            let v3 = if (*0x1::vector::borrow<u64>(arg1, v2) < v0) {
                *0x1::vector::borrow<u64>(arg1, v2)
            } else {
                v0
            };
            v1 = v1 + (v3 as u256) * (*0x1::vector::borrow<u64>(arg0, v2) as u256);
            v0 = v0 - v3;
            v2 = v2 + 1;
        };
        if (v0 > 0) {
            return 0
        };
        let v4 = (v1 + 1000000000 - 1) / 1000000000;
        ((v4 + (v4 * arg3 + 1000000000 - 1) / 1000000000 + (v2 as u256) + 1) as u64)
    }

    fun xr_out<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64, arg3: u128) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T2, T1>(arg0, true, true, arg2, arg3);
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v0)) {
            return 0
        };
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v0);
        if (v1 == 0) {
            return 0
        };
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, false, true, v1);
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v2)) {
            return 0
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v2)
    }

    // decompiled from Move bytecode v7
}

