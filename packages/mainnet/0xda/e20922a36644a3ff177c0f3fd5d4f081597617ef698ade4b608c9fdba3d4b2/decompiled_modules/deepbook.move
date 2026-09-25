module 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::deepbook {
    public(friend) fun borrow<T0>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<0x2::sui::SUI, T0>(arg0, arg1, arg2)
    }

    public(friend) fun buy<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, arg1, arg2, 1, arg3, arg4)
    }

    fun coverage(arg0: &vector<u64>) : u128 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            v0 = v0 + (*0x1::vector::borrow<u64>(arg0, v1) as u128);
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun quote<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: bool, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock) : (u64, u64) {
        if (arg1 == 0) {
            return (0, 0)
        };
        assert!(arg4 <= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_additional_taker_fee(), 2);
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        let (v3, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params_next<T0, T1>(arg0);
        let v6 = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::checked_sum(0x1::u64::max(v0, v3), arg4);
        let v7 = if (arg3) {
            arg1
        } else {
            0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::floor_mul_div(arg1, 1000000000 + 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::floor_mul_div(v0, 5, 4), 1000000000 + 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::ceil_mul_div(v6, 5, 4))
        };
        if (v7 == 0) {
            return (0, 0)
        };
        let (v8, v9) = if (arg3) {
            if (arg2) {
                let (v10, v11, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg0, v7, arg5);
                (v10, v11)
            } else {
                let (v13, v14, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg0, v7, arg5);
                (v13, v14)
            }
        } else if (arg2) {
            let (v16, v17, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg0, v7, arg5);
            (v16, v17)
        } else {
            let (v19, v20, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg0, v7, arg5);
            (v19, v20)
        };
        let v22 = if (arg2) {
            v9
        } else {
            v8
        };
        if (v22 == 0 || !arg3) {
            return (v22, 0)
        };
        let v23 = if (arg2) {
            v7 - v8
        } else {
            v8
        };
        let v24 = if (arg2) {
            v9
        } else {
            v7 - v9
        };
        let v25 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order_deep_price<T0, T1>(arg0);
        let v26 = if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::asset_is_base(&v25)) {
            v23
        } else {
            v24
        };
        (v22, 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::ceil_mul_div(0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::ceil_mul_div(v26, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::deep_per_asset(&v25), 1000000000), v6, 1000000000))
    }

    public(friend) fun rate_bound<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) : u64 {
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        let (v3, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params_next<T0, T1>(arg0);
        0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::checked_sum(0x1::u64::max(v0, v3), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_additional_taker_fee())
    }

    public(friend) fun repay<T0>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan, arg4: &mut 0x2::tx_context::TxContext) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<0x2::sui::SUI, T0>(arg0, 0x2::coin::split<0x2::sui::SUI>(arg1, arg2, arg4), arg3);
    }

    public(friend) fun sell<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, arg1, arg2, 1, arg3, arg4)
    }

    public(friend) fun value_deep(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = 1;
        let (_, _, v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>(arg0, v0, arg3);
        let v5 = v4;
        let v6 = v3;
        while (coverage(&v5) < (arg1 as u128) && v0 < 100) {
            let v7 = 0x1::u64::min(v0 * 2, 100);
            v0 = v7;
            let (_, _, v10, v11) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>(arg0, v7, arg3);
            v5 = v11;
            v6 = v10;
        };
        assert!(0x1::vector::length<u64>(&v6) == 0x1::vector::length<u64>(&v5), 1);
        let v12 = arg1;
        let v13 = 0;
        let v14 = 0;
        while (v12 > 0 && v14 < 0x1::vector::length<u64>(&v6)) {
            assert!(*0x1::vector::borrow<u64>(&v6, v14) > 0, 1);
            let v15 = 0x1::u64::min(v12, *0x1::vector::borrow<u64>(&v5, v14));
            v13 = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::checked_sum(v13, 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::ceil_mul_div(v15, *0x1::vector::borrow<u64>(&v6, v14), 1000000000));
            v12 = v12 - v15;
            v14 = v14 + 1;
        };
        assert!(v12 == 0, 1);
        let v16 = 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::checked_sum(v13, 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::ceil_mul_div(0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::ceil_mul_div(v13, 5, 4), rate_bound<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>(arg0), 1000000000));
        0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::checked_sum(v16, 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search::ceil_mul_div(v16, arg2, 10000))
    }

    // decompiled from Move bytecode v7
}

