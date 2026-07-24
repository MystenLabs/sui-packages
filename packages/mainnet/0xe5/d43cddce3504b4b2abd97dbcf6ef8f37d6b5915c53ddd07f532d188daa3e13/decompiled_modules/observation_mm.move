module 0xbf734447e017feb7c92ea93953f18b65dbe4dea472dad2da00d4d8fe0ca6e163::observation_mm {
    struct Observation has copy, drop, store {
        publisher_sequence: u64,
        source_event_ms: u64,
        local_received_ms: u64,
        calculated_ms: u64,
        landed_ms: u64,
        fair_price: u64,
        alpha_direction: u8,
        alpha_bps_e6: u64,
        microprice_direction: u8,
        microprice_bps_e6: u64,
        ofi_direction: u8,
        ofi_e6: u64,
        vpin_e6: u64,
        active_feeds: u8,
    }

    struct StrategyState<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        publisher: address,
        pool_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        paused: bool,
        latest_publisher_sequence: u64,
        latest: Observation,
        accepted_observations: u64,
        dropped_observations: u64,
        quantity: u64,
        order_ttl_ms: u64,
        max_observation_age_ms: u64,
        max_future_skew_ms: u64,
        minimum_active_feeds: u8,
        minimum_edge_bps_e6: u64,
        withdraw_alpha_bps_e6: u64,
        high_vpin_e6: u64,
        high_vpin_withdraw_alpha_bps_e6: u64,
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
        observation: Observation,
        accepted: bool,
        reason: u8,
        observed_bid: u64,
        observed_ask: u64,
        target_bid: u64,
        target_ask: u64,
        bid_edge_bps_e6: u64,
        ask_edge_bps_e6: u64,
        placed_bid: bool,
        placed_ask: bool,
        canceled_orders: u64,
    }

    fun assert_publisher<T0, T1>(arg0: &StrategyState<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.publisher == 0x2::tx_context::sender(arg1), 0);
    }

    public fun create_strategy<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u8, arg12: u64, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::owner(arg1) == 0x2::tx_context::sender(arg15), 0);
        validate_config(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg13);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg0);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::id(arg1);
        let v2 = 0x2::tx_context::sender(arg15);
        let v3 = Observation{
            publisher_sequence   : 0,
            source_event_ms      : 0,
            local_received_ms    : 0,
            calculated_ms        : 0,
            landed_ms            : 0,
            fair_price           : 0,
            alpha_direction      : 1,
            alpha_bps_e6         : 0,
            microprice_direction : 1,
            microprice_bps_e6    : 0,
            ofi_direction        : 1,
            ofi_e6               : 0,
            vpin_e6              : 0,
            active_feeds         : 0,
        };
        let v4 = StrategyState<T0, T1>{
            id                              : 0x2::object::new(arg15),
            publisher                       : v2,
            pool_id                         : v0,
            balance_manager_id              : v1,
            paused                          : false,
            latest_publisher_sequence       : 0,
            latest                          : v3,
            accepted_observations           : 0,
            dropped_observations            : 0,
            quantity                        : arg2,
            order_ttl_ms                    : arg3,
            max_observation_age_ms          : arg4,
            max_future_skew_ms              : arg5,
            minimum_active_feeds            : arg6,
            minimum_edge_bps_e6             : arg7,
            withdraw_alpha_bps_e6           : arg8,
            high_vpin_e6                    : arg9,
            high_vpin_withdraw_alpha_bps_e6 : arg10,
            quote_offset                    : arg11,
            inventory_target_base           : arg12,
            inventory_guard_base            : arg13,
        };
        let v5 = StrategyCreated<T0, T1>{
            strategy_id        : 0x2::object::uid_to_inner(&v4.id),
            publisher          : v2,
            pool_id            : v0,
            balance_manager_id : v1,
            timestamp_ms       : 0x2::clock::timestamp_ms(arg14),
        };
        0x2::event::emit<StrategyCreated<T0, T1>>(v5);
        0x2::transfer::share_object<StrategyState<T0, T1>>(v4);
    }

    public fun direction_down() : u8 {
        0
    }

    public fun direction_neutral() : u8 {
        1
    }

    public fun direction_up() : u8 {
        2
    }

    public fun edge_bps_e6(arg0: u64, arg1: u64, arg2: bool) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let (v0, v1) = if (arg2) {
            if (arg1 <= arg0) {
                return 0
            };
            (arg1 - arg0, arg0)
        } else {
            if (arg0 <= arg1) {
                return 0
            };
            (arg0 - arg1, arg1)
        };
        (((v0 as u128) * 10000000000 / (v1 as u128)) as u64)
    }

    fun emit_decision<T0, T1>(arg0: &StrategyState<T0, T1>, arg1: Observation, arg2: bool, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: bool, arg11: bool, arg12: u64) {
        let v0 = ObservationDecision<T0, T1>{
            strategy_id     : 0x2::object::uid_to_inner(&arg0.id),
            observation     : arg1,
            accepted        : arg2,
            reason          : arg3,
            observed_bid    : arg4,
            observed_ask    : arg5,
            target_bid      : arg6,
            target_ask      : arg7,
            bid_edge_bps_e6 : arg8,
            ask_edge_bps_e6 : arg9,
            placed_bid      : arg10,
            placed_ask      : arg11,
            canceled_orders : arg12,
        };
        0x2::event::emit<ObservationDecision<T0, T1>>(v0);
    }

    public fun observe_and_quote<T0, T1>(arg0: &mut StrategyState<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: u64, arg10: u8, arg11: u64, arg12: u8, arg13: u64, arg14: u64, arg15: u8, arg16: bool, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        assert_publisher<T0, T1>(arg0, arg18);
        assert!(arg0.pool_id == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg1), 1);
        assert!(arg0.balance_manager_id == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::id(arg2), 2);
        validate_observation(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        let v0 = 0x2::clock::timestamp_ms(arg17);
        let v1 = Observation{
            publisher_sequence   : arg3,
            source_event_ms      : arg4,
            local_received_ms    : arg5,
            calculated_ms        : arg6,
            landed_ms            : v0,
            fair_price           : arg7,
            alpha_direction      : arg8,
            alpha_bps_e6         : arg9,
            microprice_direction : arg10,
            microprice_bps_e6    : arg11,
            ofi_direction        : arg12,
            ofi_e6               : arg13,
            vpin_e6              : arg14,
            active_feeds         : arg15,
        };
        if (arg3 <= arg0.latest_publisher_sequence) {
            arg0.dropped_observations = arg0.dropped_observations + 1;
            emit_decision<T0, T1>(arg0, v1, false, 1, 0, 0, 0, 0, 0, 0, false, false, 0);
            return
        };
        arg0.latest_publisher_sequence = arg3;
        arg0.latest = v1;
        arg0.accepted_observations = arg0.accepted_observations + 1;
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg18);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg1, arg2, &v2);
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg1, arg2);
        let v4 = arg6 > v0 && arg6 - v0 > arg0.max_future_skew_ms;
        let v5 = v0 >= arg6 && v0 - arg6 > arg0.max_observation_age_ms;
        let v6 = if (v4) {
            5
        } else if (v5) {
            2
        } else if (arg0.paused) {
            3
        } else if (arg15 < arg0.minimum_active_feeds) {
            4
        } else {
            0
        };
        if (v6 != 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg1, arg2, &v2, arg17, arg18);
            emit_decision<T0, T1>(arg0, v1, true, v6, 0, 0, 0, 0, 0, 0, false, false, 0x2::vec_set::length<u128>(&v3));
            return
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg1, arg2, &v2, arg17, arg18);
        let (v7, _, v9, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg1, 1, arg17);
        let v11 = v9;
        let v12 = v7;
        assert!(!0x1::vector::is_empty<u64>(&v12) && !0x1::vector::is_empty<u64>(&v11), 4);
        let v13 = *0x1::vector::borrow<u64>(&v12, 0);
        let v14 = *0x1::vector::borrow<u64>(&v11, 0);
        let (v15, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg1);
        let (v18, v19) = 0xbf734447e017feb7c92ea93953f18b65dbe4dea472dad2da00d4d8fe0ca6e163::router::target_prices(v13, v14, v15, arg0.quote_offset, arg0.quote_offset, true, true);
        let (v20, v21, v22, v23) = select_sides(v18, v19, arg7, arg8, arg9, arg10, arg11, arg14, arg0.minimum_edge_bps_e6, arg0.withdraw_alpha_bps_e6, arg0.high_vpin_e6, arg0.high_vpin_withdraw_alpha_bps_e6);
        let v24 = v21;
        let v25 = v20;
        let v26 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        if (v26 >= arg0.inventory_target_base && v26 - arg0.inventory_target_base >= arg0.inventory_guard_base) {
            v25 = false;
        };
        if (arg0.inventory_target_base >= v26 && arg0.inventory_target_base - v26 >= arg0.inventory_guard_base) {
            v24 = false;
        };
        let v27 = v0 + arg0.order_ttl_ms;
        if (v25 && !0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::can_place_limit_order<T0, T1>(arg1, arg2, v18, arg0.quantity, true, arg16, v27, arg17)) {
            v25 = false;
        };
        if (v24 && !0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::can_place_limit_order<T0, T1>(arg1, arg2, v19, arg0.quantity, false, arg16, v27, arg17)) {
            v24 = false;
        };
        let v28 = arg3 * 2;
        if (v25) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg1, arg2, &v2, v28, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v18, arg0.quantity, true, arg16, v27, arg17, arg18);
        };
        if (v24) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg1, arg2, &v2, v28 + 1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v19, arg0.quantity, false, arg16, v27, arg17, arg18);
        };
        emit_decision<T0, T1>(arg0, v1, true, 0, v13, v14, v18, v19, v22, v23, v25, v24, 0x2::vec_set::length<u128>(&v3));
    }

    public fun risk_signal(arg0: u8, arg1: u64, arg2: u8, arg3: u64) : (u8, u64) {
        validate_direction(arg0);
        validate_direction(arg2);
        if (arg0 == 1) {
            return (arg2, arg3)
        };
        let v0 = if (arg0 == arg2 && arg3 > arg1) {
            arg3
        } else {
            arg1
        };
        (arg0, v0)
    }

    public fun select_sides(arg0: u64, arg1: u64, arg2: u64, arg3: u8, arg4: u64, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64) : (bool, bool, u64, u64) {
        let v0 = edge_bps_e6(arg0, arg2, true);
        let v1 = edge_bps_e6(arg1, arg2, false);
        let v2 = v0 >= arg8;
        let v3 = v1 >= arg8;
        let v4 = if (arg7 >= arg10) {
            arg11
        } else {
            arg9
        };
        let (v5, v6) = risk_signal(arg3, arg4, arg5, arg6);
        if (v6 >= v4 && v5 == 2) {
            v3 = false;
        };
        if (v6 >= v4 && v5 == 0) {
            v2 = false;
        };
        (v2, v3, v0, v1)
    }

    public fun set_paused<T0, T1>(arg0: &mut StrategyState<T0, T1>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert_publisher<T0, T1>(arg0, arg2);
        arg0.paused = arg1;
    }

    fun validate_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: u64) {
        let v0 = if (arg0 > 0) {
            if (arg1 > arg2) {
                if (arg2 > 0) {
                    if (arg3 <= 5000) {
                        if (arg4 > 0) {
                            if (arg5 <= 10000000) {
                                if (arg6 > 0) {
                                    if (arg6 <= 10000000) {
                                        if (arg7 <= 1000000) {
                                            if (arg8 > 0) {
                                                if (arg8 <= arg6) {
                                                    if (arg9 <= 2) {
                                                        arg10 > 0
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
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3);
    }

    fun validate_direction(arg0: u8) {
        assert!(arg0 <= 2, 4);
    }

    fun validate_observation(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: u64, arg7: u8, arg8: u64, arg9: u8, arg10: u64, arg11: u64) {
        validate_direction(arg5);
        validate_direction(arg7);
        validate_direction(arg9);
        let v0 = if (arg0 > 0) {
            if (arg0 <= 9223372036854775807) {
                if (arg1 > 0) {
                    if (arg2 > 0) {
                        if (arg3 >= arg2) {
                            if (arg4 > 0) {
                                if (arg6 <= 10000000) {
                                    if (arg8 <= 10000000) {
                                        if (arg10 <= 1000000) {
                                            arg11 <= 1000000
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
        assert!(v0, 4);
    }

    // decompiled from Move bytecode v6
}

