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

    struct BalanceSizedOrderEvaluated has copy, drop, store {
        pool_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        client_order_id: u64,
        is_bid: bool,
        alpha_gate_enabled: bool,
        order_submitted: bool,
        decision_code: u8,
        fair_price: u64,
        limit_price: u64,
        base_balance: u64,
        quote_balance: u64,
        quote_budget: u64,
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

    fun emit_balance_sized_evaluation<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: bool, arg4: bool, arg5: bool, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: &0x2::clock::Clock) {
        let v0 = BalanceSizedOrderEvaluated{
            pool_id                         : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            balance_manager_id              : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg1),
            client_order_id                 : arg2,
            is_bid                          : arg3,
            alpha_gate_enabled              : arg4,
            order_submitted                 : arg5,
            decision_code                   : arg6,
            fair_price                      : arg7,
            limit_price                     : arg8,
            base_balance                    : arg9,
            quote_balance                   : arg10,
            quote_budget                    : arg11,
            requested_base_quantity         : arg12,
            expected_executed_base_quantity : arg13,
            expected_quote_quantity         : arg14,
            minimum_edge_ppm                : arg15,
            signal_timestamp_ms             : arg16,
            evaluated_at_ms                 : 0x2::clock::timestamp_ms(arg17),
        };
        0x2::event::emit<BalanceSizedOrderEvaluated>(v0);
    }

    fun has_minimum_edge(arg0: u64, arg1: u64, arg2: u64, arg3: bool) : bool {
        if (arg0 == 0 || arg1 == 0) {
            return false
        };
        let v0 = 1000000;
        arg3 && (arg0 as u128) * v0 >= (arg1 as u128) * (v0 + (arg2 as u128)) || (arg1 as u128) * v0 >= (arg0 as u128) * (v0 + (arg2 as u128))
    }

    fun maximum_bid_limit_price(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        round_down_to_increment((((arg0 as u128) * 1000000 / (1000000 + (arg1 as u128))) as u64), arg2)
    }

    fun minimum_ask_limit_price(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = (((arg0 as u128) * (1000000 - (arg1 as u128)) / 1000000) as u64);
        if (v0 == 0) {
            return 0
        };
        (v0 + arg2 - 1) / arg2 * arg2
    }

    public fun place_alpha_from_balance<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) : 0x1::option::Option<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo> {
        validate_common(1, arg3, arg5, arg6, arg7, arg8, arg9);
        assert!(arg4 > 0 && arg4 <= 1000000, 11);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1);
        let v1 = (((v0 as u128) * (arg4 as u128) / (1000000 as u128)) as u64);
        let (v2, v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v5 = maximum_bid_limit_price(arg3, arg5, v2);
        if (v1 == 0 || v5 == 0) {
            emit_balance_sized_evaluation<T0, T1>(arg0, arg1, arg2, true, true, false, 1, arg3, v5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1), v0, v1, 0, 0, 0, arg5, arg6, arg9);
            return 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo>()
        };
        let (v6, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg0, v1, arg9);
        let v9 = round_down_to_increment(v6, v3);
        if (v9 < v4) {
            emit_balance_sized_evaluation<T0, T1>(arg0, arg1, arg2, true, true, false, 2, arg3, v5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1), v0, v1, v9, 0, 0, arg5, arg6, arg9);
            return 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo>()
        };
        let (v10, v11, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_in<T0, T1>(arg0, v9, false, arg9);
        let v13 = if (v10 < v9) {
            true
        } else if (v11 == 0) {
            true
        } else {
            v11 > v1
        };
        if (v13) {
            emit_balance_sized_evaluation<T0, T1>(arg0, arg1, arg2, true, true, false, 3, arg3, v5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1), v0, v1, v9, v10, v11, arg5, arg6, arg9);
            return 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo>()
        };
        if (!has_minimum_edge(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v10, arg3), v11, arg5, true)) {
            emit_balance_sized_evaluation<T0, T1>(arg0, arg1, arg2, true, true, false, 4, arg3, v5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1), v0, v1, v9, v10, v11, arg5, arg6, arg9);
            return 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo>()
        };
        if (!0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::can_place_limit_order<T0, T1>(arg0, arg1, v5, v9, true, false, arg8, arg9)) {
            emit_balance_sized_evaluation<T0, T1>(arg0, arg1, arg2, true, true, false, 5, arg3, v5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1), v0, v1, v9, v10, v11, arg5, arg6, arg9);
            return 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo>()
        };
        emit_balance_sized_evaluation<T0, T1>(arg0, arg1, arg2, true, true, true, 0, arg3, v5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1), v0, v1, v9, v10, v11, arg5, arg6, arg9);
        let v14 = GuardEvaluated{
            pool_id                         : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            balance_manager_id              : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg1),
            client_order_id                 : arg2,
            is_bid                          : true,
            alpha_gate_enabled              : true,
            fair_price                      : arg3,
            limit_price                     : v5,
            requested_base_quantity         : v9,
            expected_executed_base_quantity : v10,
            expected_quote_quantity         : v11,
            minimum_edge_ppm                : arg5,
            signal_timestamp_ms             : arg6,
            evaluated_at_ms                 : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<GuardEvaluated>(v14);
        0x1::option::some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo>(place_ioc<T0, T1>(arg0, arg1, arg2, v5, v9, true, arg8, arg9, arg10))
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

    public fun place_risk_from_balance<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) : 0x1::option::Option<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo> {
        validate_common(arg4, arg3, 0, arg6, arg7, arg8, arg9);
        assert!(arg5 <= 100000, 12);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1);
        let (v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let (v4, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        let v7 = round_down_to_increment(0x1::u64::min(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::div(v0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::fee_penalty_multiplier(), v4)), arg4), v2);
        let v8 = minimum_ask_limit_price(arg3, arg5, v1);
        if (v7 < v3) {
            emit_balance_sized_evaluation<T0, T1>(arg0, arg1, arg2, false, false, false, 2, arg3, v8, v0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1), 0, v7, 0, 0, 0, arg6, arg9);
            return 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo>()
        };
        if (!0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::can_place_limit_order<T0, T1>(arg0, arg1, v8, v7, false, false, arg8, arg9)) {
            emit_balance_sized_evaluation<T0, T1>(arg0, arg1, arg2, false, false, false, 5, arg3, v8, v0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1), 0, v7, 0, 0, 0, arg6, arg9);
            return 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo>()
        };
        emit_balance_sized_evaluation<T0, T1>(arg0, arg1, arg2, false, false, true, 0, arg3, v8, v0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1), 0, v7, 0, 0, 0, arg6, arg9);
        let v9 = GuardEvaluated{
            pool_id                         : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            balance_manager_id              : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg1),
            client_order_id                 : arg2,
            is_bid                          : false,
            alpha_gate_enabled              : false,
            fair_price                      : arg3,
            limit_price                     : v8,
            requested_base_quantity         : v7,
            expected_executed_base_quantity : 0,
            expected_quote_quantity         : 0,
            minimum_edge_ppm                : 0,
            signal_timestamp_ms             : arg6,
            evaluated_at_ms                 : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<GuardEvaluated>(v9);
        0x1::option::some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo>(place_ioc<T0, T1>(arg0, arg1, arg2, v8, v7, false, arg8, arg9, arg10))
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

    fun round_down_to_increment(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            arg0 - arg0 % arg1
        }
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

    // decompiled from Move bytecode v7
}

