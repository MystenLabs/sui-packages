module 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::leva_deep_mm {
    public fun cancel_all_orders<T0, T1>(arg0: &0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::owner(arg0) == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg3, arg4);
        0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_orders_cancelled(0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg3));
    }

    public fun cancel_and_settle<T0, T1>(arg0: &0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::owner(arg0) == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg3, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg2, arg1, &v0);
        0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_orders_cancelled(0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg3));
    }

    public fun execute<T0, T1, T2, T3, T4>(arg0: &mut 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::MMState, arg1: &0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_registry::MMRegistry, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T4>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3);
        if (!0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_registry::is_pool_enabled(arg1, v1)) {
            0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_log_bytes(b"pool_not_enabled");
            return
        };
        if (0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::is_trading_blocked(arg0, v0)) {
            0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_log_bytes(b"paused");
            return
        };
        let v2 = 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_registry::get_pool_config(arg1, v1);
        let v3 = (arg9 + arg10) / 2;
        0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::update_price(arg0, arg8, v3, arg11, v0);
        0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_execution(0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::state_id(arg0), v1, arg8, v3, arg9 + arg10, arg11, 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::execution_count(arg0), v0);
        0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::record_execution(arg0);
        let v4 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg16);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg3, arg2, &v4, arg7, arg16);
        0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_orders_cancelled(0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::state_id(arg0), v1, v0);
        let v5 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v6 = 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::cetus_hedger::sqrt_price_to_price(0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::cetus_hedger::read_cetus_sqrt_price<T2, 0x2::sui::SUI>(arg5));
        0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_log_bytes(b"step_12a_cetus_price_read");
        let v7 = 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::config::is_dry_run(v2);
        if (0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::config::is_arbitrage_enabled(v2)) {
            let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg3, arg7);
            let (v9, v10, v11, v12, v13, v14) = 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::arbitrage_router::execute_arbitrage_analysis<T2>(v1, arg5, v8, 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::config::min_arb_profit_bps(v2), 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::last_arb_timestamp(arg0), 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::config::arb_cooldown_ms(v2), arg7);
            let v15 = if (0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::config::max_arb_amount(v2) > 0) {
                0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::config::max_arb_amount(v2)
            } else {
                0
            };
            if ((v9 || v10) && v15 > 0) {
                0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_log_bytes(b"arb_opportunity_found_skipping_mm");
                let v16 = if (v9) {
                    if (v11 == 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::arbitrage_router::pool_cetus()) {
                        !v7
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v16) {
                    let (_, v18, v19) = 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::arbitrage_router::execute_cetus_buy<T2>(v1, arg2, arg5, arg6, v15, v12, v8, 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::config::arb_slippage_bps(v2), arg7, arg16);
                    0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_log_bytes(b"arb_cetus_buy_executed");
                    if (v19 && v18 > 0) {
                        let (_, v21, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg3);
                        let v23 = 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orders::round_to_lot(v18, v21);
                        if (v23 > 0) {
                            let (v24, v25) = 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::arbitrage_router::execute_deepbook_ioc<T0, T1>(false, arg3, arg2, &v4, v8, v23, v2, arg7, arg16);
                            if (v25) {
                                0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_log_bytes(b"arb_deepbook_ioc_sell_filled");
                                0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_arb_ioc_executed(v1, false, v8, v23, v24, v12, v0);
                            } else {
                                0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_log_bytes(b"arb_deepbook_ioc_sell_unfilled");
                            };
                        };
                    };
                    0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::record_arb_time(arg0, v0);
                    0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_log_bytes(b"arb_buy_executed_early_return");
                } else if (v9 && v7) {
                    0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_log_bytes(b"dry_run_arb_buy_skipped");
                };
                let v26 = if (v10) {
                    if (v13 == 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::arbitrage_router::pool_cetus()) {
                        !v7
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v26) {
                    let (v27, _, v29) = 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::arbitrage_router::execute_cetus_sell<T2>(v1, arg2, arg5, arg6, v15, v14, v8, 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::config::arb_slippage_bps(v2), arg7, arg16);
                    0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_log_bytes(b"arb_cetus_sell_executed");
                    if (v29 && v27 > 0) {
                        let (_, v31, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg3);
                        let v33 = 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orders::round_to_lot(v27, v31);
                        if (v33 > 0) {
                            let (v34, v35) = 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::arbitrage_router::execute_deepbook_ioc<T0, T1>(true, arg3, arg2, &v4, v8, v33, v2, arg7, arg16);
                            if (v35) {
                                0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_log_bytes(b"arb_deepbook_ioc_buy_filled");
                                0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_arb_ioc_executed(v1, true, v8, v33, v34, v14, v0);
                            } else {
                                0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_log_bytes(b"arb_deepbook_ioc_buy_unfilled");
                            };
                        };
                    };
                    0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::record_arb_time(arg0, v0);
                    0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_log_bytes(b"arb_sell_executed_early_return");
                } else if (v10 && v7) {
                    0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_log_bytes(b"dry_run_arb_sell_skipped");
                };
                let v36 = 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::config::target_base_position(v2);
                let v37 = if (v36 > 0) {
                    if (v5 >= v36) {
                        (v5 - v36) * 10000 / v36
                    } else {
                        (v36 - v5) * 10000 / v36
                    }
                } else {
                    0
                };
                0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_execution_detail(0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::state_id(arg0), v1, arg11, 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::execution_count(arg0), v0, arg8, arg8, 0, 0, v5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), v36, v37, false, arg9, arg10, 0, 0, v6, false, 0, arg13);
                0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::record_order_time(arg0, v0);
                return
            };
        };
        0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_log_bytes(b"no_arb_continuing_with_mm");
        let v38 = if (0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::config::is_orderbook_analysis_enabled(v2)) {
            let v39 = 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orderbook_analyzer::analyze_orderbook<T0, T1>(arg3, arg2, 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::config::min_significant_qty(v2), 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::config::l2_tick_count(v2), arg7);
            let v40 = if (0x1::vector::length<u64>(0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orderbook_analyzer::bid_prices(&v39)) > 0) {
                *0x1::vector::borrow<u64>(0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orderbook_analyzer::bid_prices(&v39), 0)
            } else {
                0
            };
            let v41 = if (0x1::vector::length<u64>(0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orderbook_analyzer::ask_prices(&v39)) > 0) {
                *0x1::vector::borrow<u64>(0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orderbook_analyzer::ask_prices(&v39), 0)
            } else {
                0
            };
            let v42 = if (v40 > 0) {
                if (v41 > 0) {
                    v41 > v40
                } else {
                    false
                }
            } else {
                false
            };
            let v43 = if (v42) {
                let v44 = (v40 + v41) / 2;
                if (v44 > 0) {
                    (v41 - v40) * 10000 / v44
                } else {
                    0
                }
            } else {
                0
            };
            0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_orderbook_analysis(v1, v0, 0x1::vector::length<u64>(0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orderbook_analyzer::bid_prices(&v39)), 0x1::vector::length<u64>(0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orderbook_analyzer::ask_prices(&v39)), v40, v41, v43, 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orderbook_analyzer::own_bid_qty_filtered(&v39), 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orderbook_analyzer::own_ask_qty_filtered(&v39), 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orderbook_analyzer::own_orders_count(&v39), 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orderbook_analyzer::best_bid(&v39), 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orderbook_analyzer::best_ask(&v39), 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orderbook_analyzer::spread_bps(&v39), 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orderbook_analyzer::significant_bid(&v39), 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orderbook_analyzer::significant_bid_qty(&v39), 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orderbook_analyzer::significant_ask(&v39), 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orderbook_analyzer::significant_ask_qty(&v39), 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orderbook_analyzer::total_bid_depth(&v39), 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orderbook_analyzer::total_ask_depth(&v39));
            0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_log_bytes(b"step_12b_orderbook_analyzed");
            0x1::option::some<0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orderbook_analyzer::OrderbookSnapshot>(v39)
        } else {
            0x1::option::none<0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orderbook_analyzer::OrderbookSnapshot>()
        };
        let v45 = v38;
        let v46 = arg8 * (10000 - arg9) / 10000;
        let v47 = arg8 * (10000 + arg10) / 10000;
        let (v48, v49, v50) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg3);
        let (v51, v52) = if (0x1::option::is_some<0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orderbook_analyzer::OrderbookSnapshot>(&v45)) {
            let v53 = 0x1::option::borrow<0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orderbook_analyzer::OrderbookSnapshot>(&v45);
            let v54 = 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::config::price_offset_ticks(v2) * v48;
            let (v55, v56) = 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orderbook_analyzer::find_optimal_price_with_reason(v53, v46, true, v54, 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::config::min_significant_qty(v2));
            let v57 = 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orders::round_bid_price(v55, v48);
            let v58 = 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orders::round_bid_price(v46, v48);
            let v59 = if (v57 > v58) {
                v57 - v58
            } else {
                v58 - v57
            };
            0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_order_placement_decision(v1, v0, true, arg8, arg8, v58, 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orderbook_analyzer::significant_bid(v53), 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orderbook_analyzer::significant_bid_qty(v53), v57, v59 / v48, v57 > v58, v56);
            let (v60, v61) = 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orderbook_analyzer::find_optimal_price_with_reason(v53, v47, false, v54, 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::config::min_significant_qty(v2));
            let v62 = 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orders::round_ask_price(v60, v48);
            let v63 = 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orders::round_ask_price(v47, v48);
            let v64 = if (v62 < v63) {
                v63 - v62
            } else {
                v62 - v63
            };
            0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_order_placement_decision(v1, v0, false, arg8, arg8, v63, 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orderbook_analyzer::significant_ask(v53), 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orderbook_analyzer::significant_ask_qty(v53), v62, v64 / v48, v62 < v63, v61);
            (v57, v62)
        } else {
            (0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orders::round_bid_price(v46, v48), 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orders::round_ask_price(v47, v48))
        };
        0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_debug_pool_params(v48, v49, v50, v46, v47, v51, v52);
        let v65 = 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orders::round_to_lot(arg14, v49);
        let v66 = 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::orders::round_to_lot(arg15, v49);
        let v67 = 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::config::enable_deep_payment(v2);
        if (!v7) {
            if (0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::config::enable_deep_refill(v2)) {
                let (_, _) = 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::deep_manager::ensure_deep_balance<T0, T1, T3, T4>(arg3, arg4, arg2, &v4, v65 + v66, (v51 + v52) / 2, v2, arg7, arg16);
                0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_log_bytes(b"step_16a_deep_ensured");
            };
            if (v65 >= 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::config::min_order_size(v2) && v51 >= 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::config::min_price(v2)) {
                let v70 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v4, arg13, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), v51, v65, true, v67, arg12, arg7, arg16);
                0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_post_only_order(v1, true, v51, v65, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v70), arg8, arg9, v0, arg13);
            };
            if (v66 >= 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::config::min_order_size(v2) && v52 <= 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::config::max_price(v2)) {
                let v71 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v4, arg13, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), v52, v66, false, v67, arg12, arg7, arg16);
                0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_post_only_order(v1, false, v52, v66, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v71), arg8, arg10, v0, arg13);
            };
        } else {
            0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_log_bytes(b"dry_run_orders_skipped");
        };
        0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_orders_placed(0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::state_id(arg0), v1, v51, v65, v52, v66, v0);
        let v72 = 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::config::target_base_position(v2);
        let v73 = false;
        let v74 = 0;
        let v75 = v6;
        if (0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::config::is_hedge_enabled(v2)) {
            let (v76, v77) = 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::cetus_hedger::calculate_hedge_amount(v5, v72, 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::config::max_hedge_pct(v2), 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::config::min_hedge_amount(v2));
            if (v76 > 0) {
                let v78 = 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::cetus_hedger::apply_cetus_fee(v6, 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::cetus_hedger::read_cetus_fee_rate<T2, 0x2::sui::SUI>(arg5), v77);
                v75 = v78;
                let v79 = v77 && 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::cetus_hedger::should_hedge_sell(v78, arg8, 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::config::min_hedge_profit_bps(v2)) || 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::cetus_hedger::should_hedge_buy(v78, arg8, 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::config::min_hedge_profit_bps(v2));
                let v80 = 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::cetus_hedger::calculate_hedge_profit_bps(v78, arg8, v77);
                v74 = v80;
                0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_hedge_opportunity(0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::state_id(arg0), v1, arg8, v6, v78, v76, v77, v79, v80, v0);
                if (v79 && !v7) {
                    if (v77) {
                        let (_, _) = 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::cetus_hedger::flash_swap_sell_sui<T2>(arg2, arg5, arg6, v76, v76 * v78 / 1000000000 * 99 / 100, arg7, arg16);
                        v73 = true;
                        0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_log_bytes(b"hedge_sell_executed");
                    } else {
                        let (_, _) = 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::cetus_hedger::flash_swap_buy_sui<T2>(arg2, arg5, arg6, v76, v76 * v78 / 1000000000 * 101 / 100, arg7, arg16);
                        v73 = true;
                        0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_log_bytes(b"hedge_buy_executed");
                    };
                } else if (v79 && v7) {
                    0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_log_bytes(b"dry_run_hedge_skipped");
                };
            };
        };
        let v85 = if (v72 > 0) {
            if (v5 >= v72) {
                (v5 - v72) * 10000 / v72
            } else {
                (v72 - v5) * 10000 / v72
            }
        } else {
            0
        };
        0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_execution_detail(0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::state_id(arg0), v1, arg11, 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::execution_count(arg0), v0, arg8, arg8, v51, v52, v5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), v72, v85, v5 > v72, arg9, arg10, v65, v66, v75, v73, v74, arg13);
        0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::record_order_time(arg0, v0);
    }

    public fun get_state_info(arg0: &0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::MMState) : (u64, u64, u64, bool) {
        (0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::current_price(arg0), 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::current_spread(arg0), 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::execution_count(arg0), 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::is_paused(arg0))
    }

    public fun pause_trading<T0, T1>(arg0: &mut 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::owner(arg0) == 0x2::tx_context::sender(arg5), 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v1, arg4, arg5);
        0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::events::emit_orders_cancelled(0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), v0);
        0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::pause(arg0, v0 + arg3, v0);
    }

    public fun resume_trading(arg0: &mut 0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::MMState, arg1: &0x2::tx_context::TxContext) {
        assert!(0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::owner(arg0) == 0x2::tx_context::sender(arg1), 1);
        0x8eff7e3a6831d428db2edb670809e5f4f3f6aa3705d34560f183cfb1d86cc25a::mm_state::unpause(arg0);
    }

    // decompiled from Move bytecode v6
}

