module 0x876ddf5e82284ca236c59f1cea301d1421f241f3986264c3ed7247ed28099dc6::deep_manager {
    public fun calculate_deep_required<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : (u64, u64) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order_deep_required<T0, T1>(arg0, arg1, arg2)
    }

    public fun ensure_deep_balance<T0, T1, T2, T3>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: u64, arg5: u64, arg6: &0x876ddf5e82284ca236c59f1cea301d1421f241f3986264c3ed7247ed28099dc6::config::MMConfig, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : (u64, bool) {
        if (!0x876ddf5e82284ca236c59f1cea301d1421f241f3986264c3ed7247ed28099dc6::config::enable_deep_payment(arg6)) {
            return (0, false)
        };
        let (v0, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order_deep_required<T0, T1>(arg0, arg4, arg5);
        let v2 = v0 * 0x876ddf5e82284ca236c59f1cea301d1421f241f3986264c3ed7247ed28099dc6::config::deep_buffer_multiplier(arg6) / 10;
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg2);
        if (v3 >= v2) {
            0x876ddf5e82284ca236c59f1cea301d1421f241f3986264c3ed7247ed28099dc6::events::emit_deep_balance_check(v3, v2, 0, arg4, arg5, v0, 0x2::clock::timestamp_ms(arg7));
            return (v3, false)
        };
        let v4 = 0x876ddf5e82284ca236c59f1cea301d1421f241f3986264c3ed7247ed28099dc6::config::min_deep_purchase(arg6);
        let v5 = (v2 - v3) * 2;
        let v6 = v5;
        if (v5 < v4) {
            v6 = v4;
        };
        0x876ddf5e82284ca236c59f1cea301d1421f241f3986264c3ed7247ed28099dc6::events::emit_deep_balance_check(v3, v2, 1, arg4, arg5, v0, 0x2::clock::timestamp_ms(arg7));
        let (_, v8, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T2, T3>(arg1);
        let v10 = v6 / v8 * v8;
        if (v10 == 0) {
            return (v3, false)
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T2, T3>(arg1, arg2, arg3, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v10, true, false, arg7, arg8);
        let v11 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg2);
        let v12 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T3>(arg2);
        let v13 = v11 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg2);
        0x876ddf5e82284ca236c59f1cea301d1421f241f3986264c3ed7247ed28099dc6::events::emit_deep_purchase(v10, v13, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T3>(arg2) - v12, v11, v12, v13 > 0, 0x2::clock::timestamp_ms(arg7));
        (v11, true)
    }

    public fun get_deep_balance<T0>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager) : u64 {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg0)
    }

    public fun should_topup_deep<T0>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: u64) : bool {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg0) < arg1
    }

    // decompiled from Move bytecode v6
}

