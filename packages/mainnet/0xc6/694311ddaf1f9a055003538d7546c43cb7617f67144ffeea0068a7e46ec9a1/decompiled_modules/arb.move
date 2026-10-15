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

    fun cycle_exact<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg2, true, false, arg5, arg9, arg10);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v0);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v3);
        let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, v4, arg8, arg10);
        let v8 = v7;
        let v9 = v6;
        0x2::balance::destroy_zero<T0>(v5);
        let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg2, 0x2::balance::split<T1>(&mut v9, v4), 0x2::balance::zero<T2>(), v3);
        if (0x2::balance::value<T1>(&v9) == 0) {
            0x2::balance::destroy_zero<T1>(v9);
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg4, 0x2::coin::from_balance<T1>(v9, arg11), arg11);
        };
        let (v11, v12) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T2, T0>(arg3, v10, arg11);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v11), 0x2::balance::zero<T1>(), v8);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T2>(arg4, 0x2::coin::from_balance<T2>(v1, arg11), arg11);
        let v13 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg4, arg11);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T2, T0>(arg3, arg4, &v13, 0, 0, arg6, false, false, arg10, arg11);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg4) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg4) >= v10 + arg7, 1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T2, T0>(arg3, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg4, v10, arg11), v12);
    }

    fun cycle_rev<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg4);
        let (v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T2, T0>(arg3, arg5, arg11);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg4, v1, arg11);
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg4, arg11);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T2, T0>(arg3, arg4, &v3, 0, 0, arg6, true, false, arg10, arg11);
        let v4 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg4) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg4);
        let v5 = 0x2::coin::into_balance<T2>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T2>(arg4, v4, arg11));
        let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg2, false, true, v4, arg9, arg10);
        let v9 = v8;
        0x2::balance::destroy_zero<T2>(v7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg2, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v9)), v9);
        put_back<T2>(arg4, v5, arg11);
        let v10 = v6;
        let (v11, v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&v10), arg8, arg10);
        let v14 = v13;
        0x2::balance::destroy_zero<T1>(v12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v10, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v14)), v14);
        put_back<T1>(arg4, v10, arg11);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg4, 0x2::coin::from_balance<T0>(v11, arg11), arg11);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg4) >= v0 + arg5 + arg7, 1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T2, T0>(arg3, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg4, arg5, arg11), v2);
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
        let v0 = loan_by_walk<T0, T1, T2>(arg1, arg2, arg3, arg5, arg6, arg10);
        assert!(v0 > 0, 1);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, true, true, v0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T2>(arg2, true, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v1));
        let (v3, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T2, T0>(arg3);
        let (_, v7, v8) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T2, T0>(arg3);
        let v9 = (v3 as u128) * 5 / 4;
        let v10 = (((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v2) as u128) * 1000000000 / (1000000000 + v9)) as u64) / v7 * v7;
        assert!(v10 >= v8, 1);
        cycle_exact<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v10 + ((((v10 as u128) * v9 + 999999999) / 1000000000) as u64), v10, arg7, arg8, arg9, arg10, arg11);
    }

    public fun execute_book_tri_walk_rev<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg11) == @0x1cd163400d605ff1e9d153a2867451fb7e3177a4a080d645b7046dcb043f8b4e, 2);
        let (v0, v1, v2) = loan_by_walk_rev<T0, T1, T2>(arg1, arg2, arg3, arg5, arg6, arg10);
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
        cycle_rev<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, ((v16 + (v16 * (v5 as u256) * 5 / 4 + 1000000000 - 1) / 1000000000 + (v14 as u256) + 1) as u64), v11, arg7, arg8, arg9, arg10, arg11);
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

    fun gain<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg3: u64, arg4: &0x2::clock::Clock) : u64 {
        let v0 = round_out<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
        if (v0 > arg3) {
            v0 - arg3
        } else {
            0
        }
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

    fun loan_by_walk<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : u64 {
        let (v0, v1, v2, v3) = ladder<T0, T1>(arg0, arg3);
        let v4 = v2;
        let v5 = v1;
        let v6 = v0;
        let (v7, v8, v9, _) = ladder<T1, T2>(arg1, v3);
        let v11 = v9;
        let v12 = v8;
        let v13 = v7;
        let (v14, v15, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T2, T0>(arg2, arg4, arg5);
        let v18 = v15;
        let v19 = v14;
        let (v20, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T2, T0>(arg2);
        (walk(&v6, &v5, &v4, (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0) as u256), &v13, &v12, &v11, (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T1, T2>(arg1) as u256), &v19, &v18, (v20 as u256) * 5 / 4, (arg3 as u256)) as u64)
    }

    fun loan_by_walk_rev<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : (u64, vector<u64>, vector<u64>) {
        let (_, _, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T2, T0>(arg2, arg4, arg5);
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
        ((walk(&v14, &v13, &v12, (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T1, T2>(arg1) as u256), &v21, &v20, &v19, (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0) as u256), &v22, &v23, (v26 as u256) * 5 / 4, v7) as u64), v5, v4)
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

    fun worth(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256) : bool {
        arg0 * arg0 / 18446744073709551616 * arg1 * arg1 / 18446744073709551616 * (1000000 - arg3) * (1000000 - arg4) * arg2 > 18446744073709551616 * 18446744073709551616 * 1000000 * 1000000 * (1000000000 + arg5)
    }

    // decompiled from Move bytecode v7
}

