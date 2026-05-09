module 0x9162b9926d073a97f7b1fc91692edf79f641779dbc8749f7d7b925fe93eeaf07::drain {
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
        let v35 = arg9 * 5 / (v32 + 70 * (v32 - v33)) / 1000000000;
        let v36 = v34 * 90 / 100 / v1 * v1;
        let v37 = if (v35 < v36) {
            v35 / v1 * v1
        } else {
            v36
        };
        let v38 = v37 * 999 / 1000 / v1 * v1;
        assert!(v37 > 0 && v38 > 0, 500);
        let v39 = arg9 + v8;
        let v40 = v37 / 1000 * v32 / 1000 / 1000;
        let v41 = v38 / 1000 * v33 / 1000 / 1000;
        let v42 = if (v40 > v41) {
            v40 - v41
        } else {
            1
        };
        let v43 = if (v39 > v40) {
            (v39 - v40) / v42
        } else {
            0
        };
        let v44 = if (arg11 < v43) {
            arg11
        } else {
            v43
        };
        assert!(v44 > 0, 800);
        assert!(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::quote_balance<T0, T1>(arg2) >= v40, 900);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg3) >= v37, 901);
        let v45 = 0;
        while (v45 < v44) {
            let v46 = v45 * 10;
            let v47 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg13);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg3, &v47, v46, 0, 0, v32, v37, false, false, 18446744073709551615, arg12, arg13);
            0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy::place_limit_order<T0, T1>(arg1, arg2, arg0, v46 + 1, 1, 0, v32, v37, true, false, 18446744073709551615, arg12, arg13);
            let v48 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg13);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg3, &v48, arg12, arg13);
            let v49 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg13);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg0, arg3, &v49);
            assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg3) > 0, 600);
            let v50 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg13);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg3, &v50, v46 + 2, 0, 0, v33, v38, true, false, 18446744073709551615, arg12, arg13);
            0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy::place_limit_order<T0, T1>(arg1, arg2, arg0, v46 + 3, 1, 0, v33, v38, false, false, 18446744073709551615, arg12, arg13);
            let v51 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg13);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg3, &v51, arg12, arg13);
            let v52 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg13);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg0, arg3, &v52);
            v45 = v45 + 1;
        };
        let v53 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg13);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg3, &v53, arg12, arg13);
        let v54 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg13);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg0, arg3, &v54);
        let v55 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T0>(arg3, arg13);
        let v56 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T1>(arg3, arg13);
        let v57 = 0x2::coin::value<T0>(&v55);
        if (v57 < v6) {
            let v58 = (v6 - v57) / 1000000 * 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg0, arg12) / 1000 * 115 / 100;
            if (v58 > 0 && 0x2::coin::value<T1>(&v56) >= v58) {
                let (v59, v60, v61) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, 0x2::coin::split<T1>(&mut v56, v58, arg13), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg13), 0, arg12, arg13);
                0x2::coin::join<T0>(&mut v55, v59);
                0x2::coin::join<T1>(&mut v56, v60);
                0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v61, 0x2::tx_context::sender(arg13));
            };
        };
        assert!(0x2::coin::value<T0>(&v55) >= v6, 700);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, 0x2::coin::split<T0>(&mut v55, v6, arg13), v10);
        0x2::coin::join<T1>(&mut v56, v21);
        assert!(0x2::coin::value<T1>(&v56) >= arg9, 701);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::split<T1>(&mut v56, arg9, arg13), v20);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v55, 0x2::tx_context::sender(arg13));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v56, 0x2::tx_context::sender(arg13));
    }

    // decompiled from Move bytecode v7
}

