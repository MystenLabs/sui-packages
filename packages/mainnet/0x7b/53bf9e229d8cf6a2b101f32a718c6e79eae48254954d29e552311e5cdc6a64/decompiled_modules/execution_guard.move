module 0x7b53bf9e229d8cf6a2b101f32a718c6e79eae48254954d29e552311e5cdc6a64::execution_guard {
    struct GuardEvaluated has copy, drop, store {
        pool_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        client_order_id: u64,
        is_bid: bool,
        alpha_gate_enabled: bool,
        fair_price: u64,
        limit_price: u64,
        requested_base_quantity: u64,
        expected_executed_base_quantity: u64,
        expected_quote_quantity: u64,
        minimum_edge_ppm: u64,
        signal_timestamp_ms: u64,
        evaluated_at_ms: u64,
    }

    fun assert_limit_price(arg0: u64, arg1: u64, arg2: u64, arg3: bool) {
        assert!(arg0 > 0, 10);
        let v0 = 1000000;
        if (arg3) {
            assert!((arg0 as u128) * (v0 + (arg2 as u128)) <= (arg1 as u128) * v0, 10);
        } else {
            assert!((arg0 as u128) * v0 >= (arg1 as u128) * (v0 + (arg2 as u128)), 10);
        };
    }

    fun assert_minimum_edge(arg0: u64, arg1: u64, arg2: u64, arg3: bool) {
        assert!(arg0 > 0 && arg1 > 0, 8);
        let v0 = 1000000;
        if (arg3) {
            assert!((arg0 as u128) * v0 >= (arg1 as u128) * (v0 + (arg2 as u128)), 9);
        } else {
            assert!((arg1 as u128) * v0 >= (arg0 as u128) * (v0 + (arg2 as u128)), 9);
        };
    }

    public fun place_alpha_ioc<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        validate_common(arg4, arg6, arg7, arg8, arg9, arg10, arg11);
        assert_limit_price(arg3, arg6, arg7, arg5);
        let (v0, v1) = if (arg5) {
            let (v2, v3, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_in<T0, T1>(arg0, arg4, false, arg11);
            assert!(v2 > 0 && v3 > 0, 8);
            assert_minimum_edge(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v2, arg6), v3, arg7, true);
            (v2, v3)
        } else {
            let (v5, v6, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg0, arg4, arg11);
            let v8 = arg4 - v5;
            assert!(v8 > 0 && v6 > 0, 8);
            assert_minimum_edge(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v8, arg6), v6, arg7, false);
            (v8, v6)
        };
        let v9 = GuardEvaluated{
            pool_id                         : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            balance_manager_id              : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg1),
            client_order_id                 : arg2,
            is_bid                          : arg5,
            alpha_gate_enabled              : true,
            fair_price                      : arg6,
            limit_price                     : arg3,
            requested_base_quantity         : arg4,
            expected_executed_base_quantity : v0,
            expected_quote_quantity         : v1,
            minimum_edge_ppm                : arg7,
            signal_timestamp_ms             : arg8,
            evaluated_at_ms                 : 0x2::clock::timestamp_ms(arg11),
        };
        0x2::event::emit<GuardEvaluated>(v9);
        place_ioc<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg10, arg11, arg12)
    }

    fun place_ioc<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg8);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg1, &v0, arg2, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), arg3, arg4, arg5, false, arg6, arg7, arg8)
    }

    public fun place_risk_ioc<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        validate_common(arg4, arg6, 0, arg7, arg8, arg9, arg10);
        let v0 = GuardEvaluated{
            pool_id                         : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            balance_manager_id              : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg1),
            client_order_id                 : arg2,
            is_bid                          : arg5,
            alpha_gate_enabled              : false,
            fair_price                      : arg6,
            limit_price                     : arg3,
            requested_base_quantity         : arg4,
            expected_executed_base_quantity : 0,
            expected_quote_quantity         : 0,
            minimum_edge_ppm                : 0,
            signal_timestamp_ms             : arg7,
            evaluated_at_ms                 : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<GuardEvaluated>(v0);
        place_ioc<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg9, arg10, arg11)
    }

    fun validate_common(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        assert!(arg0 > 0, 0);
        assert!(arg1 > 0, 1);
        assert!(arg2 <= 100000, 2);
        assert!(arg4 > 0 && arg4 <= 5000, 3);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(arg3 <= v0, 4);
        assert!(v0 - arg3 <= arg4, 5);
        assert!(arg5 >= v0, 6);
        assert!(arg5 - v0 <= 10000, 7);
    }

    // decompiled from Move bytecode v6
}

