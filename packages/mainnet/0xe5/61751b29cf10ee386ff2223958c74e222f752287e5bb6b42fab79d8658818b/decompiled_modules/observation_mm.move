module 0xe561751b29cf10ee386ff2223958c74e222f752287e5bb6b42fab79d8658818b::observation_mm {
    struct StrategyState<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        publisher: address,
        pool_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        paused: bool,
        latest_publisher_sequence: u64,
        accepted_observations: u64,
        dropped_observations: u64,
        quantity: u64,
        order_ttl_ms: u64,
        max_observation_age_ms: u64,
        max_future_skew_ms: u64,
        quote_offset: u8,
        inventory_target_base: u64,
        inventory_guard_base: u64,
    }

    struct StrategyCreated<phantom T0, phantom T1> has copy, drop {
        strategy_id: 0x2::object::ID,
        publisher: address,
        pool_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct ObservationDecision<phantom T0, phantom T1> has copy, drop {
        strategy_id: 0x2::object::ID,
        publisher_sequence: u64,
        landed_ms: u64,
        accepted: bool,
        reason: u8,
        placed_bid: bool,
        placed_ask: bool,
        canceled_orders: u64,
    }

    fun assert_publisher<T0, T1>(arg0: &StrategyState<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.publisher == 0x2::tx_context::sender(arg1), 0);
    }

    public fun create_strategy<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::owner(arg1) == 0x2::tx_context::sender(arg10), 0);
        validate_config(arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg0);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::id(arg1);
        let v2 = 0x2::tx_context::sender(arg10);
        let v3 = StrategyState<T0, T1>{
            id                        : 0x2::object::new(arg10),
            publisher                 : v2,
            pool_id                   : v0,
            balance_manager_id        : v1,
            paused                    : false,
            latest_publisher_sequence : 0,
            accepted_observations     : 0,
            dropped_observations      : 0,
            quantity                  : arg2,
            order_ttl_ms              : arg3,
            max_observation_age_ms    : arg4,
            max_future_skew_ms        : arg5,
            quote_offset              : arg6,
            inventory_target_base     : arg7,
            inventory_guard_base      : arg8,
        };
        let v4 = StrategyCreated<T0, T1>{
            strategy_id        : 0x2::object::uid_to_inner(&v3.id),
            publisher          : v2,
            pool_id            : v0,
            balance_manager_id : v1,
            timestamp_ms       : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<StrategyCreated<T0, T1>>(v4);
        0x2::transfer::share_object<StrategyState<T0, T1>>(v3);
    }

    fun emit_decision<T0, T1>(arg0: &StrategyState<T0, T1>, arg1: u64, arg2: u64, arg3: bool, arg4: u8, arg5: bool, arg6: bool, arg7: u64) {
        let v0 = ObservationDecision<T0, T1>{
            strategy_id        : 0x2::object::uid_to_inner(&arg0.id),
            publisher_sequence : arg1,
            landed_ms          : arg2,
            accepted           : arg3,
            reason             : arg4,
            placed_bid         : arg5,
            placed_ask         : arg6,
            canceled_orders    : arg7,
        };
        0x2::event::emit<ObservationDecision<T0, T1>>(v0);
    }

    public(friend) fun inventory_sides(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: bool) : (bool, bool) {
        if ((arg0 as u128) + (arg1 as u128) > (arg2 as u128) + (arg3 as u128)) {
            arg4 = false;
        };
        let v0 = if (arg2 > arg3) {
            arg2 - arg3
        } else {
            0
        };
        if (arg0 < arg1 || arg0 - arg1 < v0) {
            arg5 = false;
        };
        (arg4, arg5)
    }

    public(friend) fun observation_timing(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (bool, bool) {
        let v0 = if (arg0 < arg1) {
            arg0
        } else {
            arg1
        };
        let v1 = if (arg0 > arg1) {
            arg0
        } else {
            arg1
        };
        let v2 = v1 > arg2 && v1 - arg2 > arg4;
        let v3 = arg2 >= v0 && arg2 - v0 > arg3;
        (v3, v2)
    }

    public fun observe_and_quote<T0, T1>(arg0: &mut StrategyState<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_publisher<T0, T1>(arg0, arg11);
        assert!(arg0.pool_id == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg1), 1);
        assert!(arg0.balance_manager_id == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::id(arg2), 2);
        validate_observation(arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v0 = 0x2::clock::timestamp_ms(arg10);
        if (arg3 <= arg0.latest_publisher_sequence) {
            arg0.dropped_observations = arg0.dropped_observations + 1;
            emit_decision<T0, T1>(arg0, arg3, v0, false, 1, false, false, 0);
            return
        };
        arg0.latest_publisher_sequence = arg3;
        arg0.accepted_observations = arg0.accepted_observations + 1;
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg11);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg1, arg2, &v1);
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg1, arg2);
        let (v3, v4) = observation_timing(arg4, arg6, v0, arg0.max_observation_age_ms, arg0.max_future_skew_ms);
        let v5 = if (v4) {
            5
        } else if (v3) {
            2
        } else if (arg0.paused) {
            3
        } else if (arg9 == 0) {
            4
        } else {
            0
        };
        if (v5 != 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg1, arg2, &v1, arg10, arg11);
            emit_decision<T0, T1>(arg0, arg3, v0, true, v5, false, false, 0x2::vec_set::length<u128>(&v2));
            return
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg1, arg2, &v1, arg10, arg11);
        let (v6, _, v8, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg1, 1, arg10);
        let v10 = v8;
        let v11 = v6;
        assert!(!0x1::vector::is_empty<u64>(&v11) && !0x1::vector::is_empty<u64>(&v10), 4);
        let (v12, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg1);
        let (v15, v16) = 0xe561751b29cf10ee386ff2223958c74e222f752287e5bb6b42fab79d8658818b::router::target_prices(*0x1::vector::borrow<u64>(&v11, 0), *0x1::vector::borrow<u64>(&v10, 0), v12, arg0.quote_offset, arg0.quote_offset, true, true);
        let (v17, v18) = select_sides(v15, v16, arg7, arg8, arg9);
        let (v19, v20) = inventory_sides(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2), arg0.quantity, arg0.inventory_target_base, arg0.inventory_guard_base, v17, v18);
        let v21 = v19;
        let v22 = v20;
        assert!(v0 <= 18446744073709551615 - arg0.order_ttl_ms, 3);
        let v23 = v0 + arg0.order_ttl_ms;
        if (v19 && !0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::can_place_limit_order<T0, T1>(arg1, arg2, v15, arg0.quantity, true, false, v23, arg10)) {
            v21 = false;
        };
        if (v20 && !0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::can_place_limit_order<T0, T1>(arg1, arg2, v16, arg0.quantity, false, false, v23, arg10)) {
            v22 = false;
        };
        let v24 = arg3 * 2;
        if (v21) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg1, arg2, &v1, v24, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v15, arg0.quantity, true, false, v23, arg10, arg11);
        };
        if (v22) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg1, arg2, &v1, v24 + 1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v16, arg0.quantity, false, false, v23, arg10, arg11);
        };
        emit_decision<T0, T1>(arg0, arg3, v0, true, 0, v21, v22, 0x2::vec_set::length<u128>(&v2));
    }

    public(friend) fun select_sides(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u8) : (bool, bool) {
        assert!(arg4 <= 3, 4);
        let v0 = arg4 & 1 != 0 && arg0 <= arg2;
        let v1 = arg4 & 2 != 0 && arg1 >= arg3;
        (v0, v1)
    }

    public fun set_paused<T0, T1>(arg0: &mut StrategyState<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_publisher<T0, T1>(arg0, arg5);
        assert!(arg0.pool_id == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg1), 1);
        assert!(arg0.balance_manager_id == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::id(arg2), 2);
        arg0.paused = arg3;
        if (arg3) {
            let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg5);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg1, arg2, &v0);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg1, arg2, &v0, arg4, arg5);
        };
    }

    public(friend) fun side_ask() : u8 {
        2
    }

    public(friend) fun side_bid() : u8 {
        1
    }

    public(friend) fun side_both() : u8 {
        3
    }

    fun validate_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: u64) {
        let v0 = if (arg0 > 0) {
            if (arg0 <= 2000000000) {
                if (arg1 > arg2) {
                    if (arg1 <= 10000) {
                        if (arg2 > 0) {
                            if (arg2 <= 2000) {
                                if (arg3 <= 2000) {
                                    if (arg4 <= 2) {
                                        if (arg5 <= 20000000000) {
                                            if (arg6 > 0) {
                                                arg6 <= 20000000000
                                            } else {
                                                false
                                            }
                                        } else {
                                            false
                                        }
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3);
    }

    fun validate_observation(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u8) {
        let v0 = if (arg0 > 0) {
            if (arg0 <= 9223372036854775807) {
                if (arg1 > 0) {
                    if (arg2 > 0) {
                        if (arg3 >= arg2) {
                            if (arg1 <= arg3 || arg1 - arg3 <= 2000) {
                                arg6 <= 3
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 4);
        let v1 = arg6 & 1 != 0;
        let v2 = arg6 & 2 != 0;
        assert!(v1 && arg4 > 0 || !v1 && arg4 == 0, 4);
        assert!(v2 && arg5 > 0 || !v2 && arg5 == 0, 4);
        if (v1 && v2) {
            assert!(arg5 > arg4, 4);
        };
        assert!(arg4 <= 10000000 && arg5 <= 10000000, 4);
    }

    // decompiled from Move bytecode v6
}

