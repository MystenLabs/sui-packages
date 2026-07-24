module 0xbf734447e017feb7c92ea93953f18b65dbe4dea472dad2da00d4d8fe0ca6e163::router {
    struct QuoteDecision<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        observed_bid: u64,
        observed_ask: u64,
        target_bid: u64,
        target_ask: u64,
        bid_offset: u8,
        ask_offset: u8,
        placed_bid: bool,
        placed_ask: bool,
        canceled_orders: u64,
        signal_deadline_ms: u64,
        timestamp_ms: u64,
    }

    public fun quote_bbo<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: vector<u128>, arg3: bool, arg4: bool, arg5: u8, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: bool, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 <= 2, 0);
        assert!(arg6 <= 2, 0);
        let v0 = 0x2::clock::timestamp_ms(arg13);
        assert!(v0 <= arg12, 3);
        assert!(arg11 > v0, 4);
        let v1 = 0x1::vector::length<u128>(&arg2);
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg14);
        if (v1 > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_live_orders<T0, T1>(arg0, arg1, &v2, arg2, arg13, arg14);
        };
        if (!arg3 && !arg4) {
            let v3 = QuoteDecision<T0, T1>{
                pool_id            : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg0),
                balance_manager_id : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::id(arg1),
                observed_bid       : 0,
                observed_ask       : 0,
                target_bid         : 0,
                target_ask         : 0,
                bid_offset         : arg5,
                ask_offset         : arg6,
                placed_bid         : false,
                placed_ask         : false,
                canceled_orders    : v1,
                signal_deadline_ms : arg12,
                timestamp_ms       : v0,
            };
            0x2::event::emit<QuoteDecision<T0, T1>>(v3);
            return
        };
        let (v4, _, v6, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg13);
        let v8 = v6;
        let v9 = v4;
        assert!(!0x1::vector::is_empty<u64>(&v9) && !0x1::vector::is_empty<u64>(&v8), 1);
        let v10 = *0x1::vector::borrow<u64>(&v9, 0);
        let v11 = *0x1::vector::borrow<u64>(&v8, 0);
        let (v12, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let (v15, v16) = target_prices(v10, v11, v12, arg5, arg6, arg3, arg4);
        if (arg3) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg1, &v2, arg7, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v15, arg9, true, arg10, arg11, arg13, arg14);
        };
        if (arg4) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg1, &v2, arg8, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v16, arg9, false, arg10, arg11, arg13, arg14);
        };
        let v17 = QuoteDecision<T0, T1>{
            pool_id            : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg0),
            balance_manager_id : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::id(arg1),
            observed_bid       : v10,
            observed_ask       : v11,
            target_bid         : v15,
            target_ask         : v16,
            bid_offset         : arg5,
            ask_offset         : arg6,
            placed_bid         : arg3,
            placed_ask         : arg4,
            canceled_orders    : v1,
            signal_deadline_ms : arg12,
            timestamp_ms       : v0,
        };
        0x2::event::emit<QuoteDecision<T0, T1>>(v17);
    }

    public fun target_prices(arg0: u64, arg1: u64, arg2: u64, arg3: u8, arg4: u8, arg5: bool, arg6: bool) : (u64, u64) {
        assert!(arg3 <= 2, 0);
        assert!(arg4 <= 2, 0);
        assert!(arg2 > 0 && arg0 < arg1, 2);
        let v0 = if (arg3 == 0) {
            assert!(arg0 >= arg2, 2);
            arg0 - arg2
        } else if (arg3 == 1) {
            arg0
        } else {
            let v1 = arg0 + arg2;
            let v2 = arg1 - arg2;
            if (v1 < v2) {
                v1
            } else {
                v2
            }
        };
        let v3 = v0;
        let v4 = if (arg4 == 0) {
            arg1 + arg2
        } else if (arg4 == 1) {
            arg1
        } else {
            let v5 = arg1 - arg2;
            let v6 = arg0 + arg2;
            if (v5 > v6) {
                v5
            } else {
                v6
            }
        };
        let v7 = v4;
        let v8 = if (arg5) {
            if (arg6) {
                v0 >= v4
            } else {
                false
            }
        } else {
            false
        };
        if (v8) {
            v3 = arg0;
            v7 = arg1;
        };
        (v3, v7)
    }

    // decompiled from Move bytecode v7
}

