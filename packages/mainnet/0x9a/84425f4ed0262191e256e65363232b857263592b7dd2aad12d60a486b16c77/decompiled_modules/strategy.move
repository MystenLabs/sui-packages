module 0x9a84425f4ed0262191e256e65363232b857263592b7dd2aad12d60a486b16c77::strategy {
    struct OrderCreatedEvent has copy, drop {
        user: address,
        spread_bps: u64,
        mid_price: u64,
        bid_price: u64,
        ask_price: u64,
        bid_quantity: u64,
        ask_quantity: u64,
        order_size: u64,
        created_at: u64,
        expires_at: u64,
    }

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
        let v8 = v3 - v7;
        let v9 = v3 + v7;
        let (v10, v11) = if (v6 == (v5 as u128)) {
            (arg4, arg4)
        } else if (v6 > (v5 as u128)) {
            let v12 = 0x1::u64::min(((100 * v6 / (v5 as u128) - 100) as u64), arg6);
            (arg4 * (100 + v12) / 100, arg4 * (100 - v12) / 100)
        } else {
            let v13 = 0x1::u64::min(((100 * v6 / (v5 as u128) - 100) as u64), arg6);
            (arg4 * (100 - v13) / 100, arg4 * (100 + v13) / 100)
        };
        assert!((v10 as u128) * (v1 as u128) <= (v4 as u128), 6);
        assert!((v11 as u128) * (v1 as u128) <= (v5 as u128), 7);
        let v14 = OrderCreatedEvent{
            user         : 0x2::tx_context::sender(arg10),
            spread_bps   : arg3,
            mid_price    : v3,
            bid_price    : v8,
            ask_price    : v9,
            bid_quantity : v11,
            ask_quantity : v10,
            order_size   : arg4,
            created_at   : 0x2::clock::timestamp_ms(arg9),
            expires_at   : arg8,
        };
        0x2::event::emit<OrderCreatedEvent>(v14);
        (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg2, arg0, arg1, 0, arg5, arg7, v8, v11, true, false, arg8, arg9, arg10), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg2, arg0, arg1, 0, arg5, arg7, v9, v10, false, false, arg8, arg9, arg10))
    }

    // decompiled from Move bytecode v6
}

