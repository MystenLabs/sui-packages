module 0xc3033f9dccfa0ee3b9bcbacf4c9173de13c39537fc94dfd355fc1f9266ed7449::strategy {
    public fun create_spread_order<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u8, arg6: u64, arg7: u8, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo) {
        assert!(arg3 > 0, 4);
        assert!(arg8 > 0x2::clock::timestamp_ms(arg9), 5);
        let (_, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg2);
        assert!(arg4 * v1 >= v2, 0);
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg2, arg9);
        let v4 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg0);
        let v5 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg0);
        let v6 = (v4 as u128) * (v3 as u128);
        let v7 = v3 * arg3 / 100 / 100 / 2;
        let (v8, v9) = if (v6 == (v5 as u128)) {
            (arg4, arg4)
        } else if (v6 > (v5 as u128)) {
            let v10 = 0x1::u64::min(((100 * v6 / (v5 as u128) - 100) as u64), arg6);
            (arg4 * (100 + v10) / 100, arg4 * (100 - v10) / 100)
        } else {
            let v11 = 0x1::u64::min(((100 * v6 / (v5 as u128) - 100) as u64), arg6);
            (arg4 * (100 - v11) / 100, arg4 * (100 + v11) / 100)
        };
        assert!((v8 as u128) * (v1 as u128) <= (v4 as u128), 6);
        assert!((v9 as u128) * (v1 as u128) <= (v5 as u128), 7);
        (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg2, arg0, arg1, 0, arg5, arg7, v3 - v7, v9, true, false, arg8, arg9, arg10), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg2, arg0, arg1, 0, arg5, arg7, v3 + v7, v8, false, false, arg8, arg9, arg10))
    }

    // decompiled from Move bytecode v6
}

