module 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::leva_deep_mm {
    public fun cancel_all_orders<T0, T1>(arg0: &0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::owner(arg0) == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg3, arg4);
        0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_orders_cancelled(0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg3));
    }

    public fun cancel_and_settle<T0, T1>(arg0: &0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::owner(arg0) == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg3, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg2, arg1, &v0);
        0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_orders_cancelled(0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg3));
    }

    public fun execute<T0, T1, T2, T3, T4>(arg0: &mut 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::MMState, arg1: &0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_registry::MMRegistry, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T4>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: bool, arg24: u64, arg25: u64, arg26: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3);
        if (!0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_registry::is_pool_enabled(arg1, v1)) {
            0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_log_bytes(b"pool_not_enabled");
            return
        };
        if (0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::is_trading_blocked(arg0, v0)) {
            0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_log_bytes(b"paused");
            return
        };
        let v2 = 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_registry::get_pool_config(arg1, v1);
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg3, arg7);
        let v4 = if (v3 >= arg8) {
            (v3 - arg8) * 100000 / arg8
        } else {
            (arg8 - v3) * 100000 / arg8
        };
        assert!(v4 <= arg18, 2);
        let v5 = (arg9 + arg10) / 2;
        0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::update_price(arg0, v3, v5, arg13, v0);
        0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_execution(0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::state_id(arg0), v1, v3, v5, arg9 + arg10, arg13, 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::execution_count(arg0), v0);
        0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::record_execution(arg0);
        let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg26);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg3, arg2, &v6, arg7, arg26);
        0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_orders_cancelled(0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::state_id(arg0), v1, v0);
        let v7 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v8 = 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::cetus_hedger::sqrt_price_to_price(0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::cetus_hedger::read_cetus_sqrt_price<T2, 0x2::sui::SUI>(arg5));
        0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_log_bytes(b"step_12a_cetus_price_read");
        let v9 = 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::config::is_dry_run(v2);
        if (0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::config::is_arbitrage_enabled(v2)) {
            let (v10, v11, v12, v13, v14, v15) = 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::arbitrage_router::execute_arbitrage_analysis<T2>(v1, arg5, v3, 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::config::min_arb_profit_bps(v2), 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::last_arb_timestamp(arg0), 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::config::arb_cooldown_ms(v2), arg7);
            let v16 = if (0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::config::max_arb_amount(v2) > 0) {
                0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::config::max_arb_amount(v2)
            } else {
                0
            };
            if ((v10 || v11) && v16 > 0) {
                0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_log_bytes(b"arb_opportunity_found_skipping_mm");
                let v17 = if (v10) {
                    if (v12 == 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::arbitrage_router::pool_cetus()) {
                        !v9
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v17) {
                    let (_, v19, v20) = 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::arbitrage_router::execute_cetus_buy<T2>(v1, arg2, arg5, arg6, v16, v13, v3, 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::config::arb_slippage_bps(v2), arg7, arg26);
                    0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_log_bytes(b"arb_cetus_buy_executed");
                    if (v20 && v19 > 0) {
                        let (_, v22, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg3);
                        let v24 = 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orders::round_to_lot(v19, v22);
                        if (v24 > 0) {
                            let (v25, v26) = 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::arbitrage_router::execute_deepbook_ioc<T0, T1>(false, arg3, arg2, &v6, v3, v24, v2, arg7, arg26);
                            if (v26) {
                                0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_log_bytes(b"arb_deepbook_ioc_sell_filled");
                                0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_arb_ioc_executed(v1, false, v3, v24, v25, v13, v0);
                            } else {
                                0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_log_bytes(b"arb_deepbook_ioc_sell_unfilled");
                            };
                        };
                    };
                    0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::record_arb_time(arg0, v0);
                    0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_log_bytes(b"arb_buy_executed_early_return");
                } else if (v10 && v9) {
                    0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_log_bytes(b"dry_run_arb_buy_skipped");
                };
                let v27 = if (v11) {
                    if (v14 == 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::arbitrage_router::pool_cetus()) {
                        !v9
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v27) {
                    let (v28, _, v30) = 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::arbitrage_router::execute_cetus_sell<T2>(v1, arg2, arg5, arg6, v16, v15, v3, 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::config::arb_slippage_bps(v2), arg7, arg26);
                    0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_log_bytes(b"arb_cetus_sell_executed");
                    if (v30 && v28 > 0) {
                        let (_, v32, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg3);
                        let v34 = 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orders::round_to_lot(v28, v32);
                        if (v34 > 0) {
                            let (v35, v36) = 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::arbitrage_router::execute_deepbook_ioc<T0, T1>(true, arg3, arg2, &v6, v3, v34, v2, arg7, arg26);
                            if (v36) {
                                0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_log_bytes(b"arb_deepbook_ioc_buy_filled");
                                0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_arb_ioc_executed(v1, true, v3, v34, v35, v15, v0);
                            } else {
                                0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_log_bytes(b"arb_deepbook_ioc_buy_unfilled");
                            };
                        };
                    };
                    0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::record_arb_time(arg0, v0);
                    0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_log_bytes(b"arb_sell_executed_early_return");
                } else if (v11 && v9) {
                    0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_log_bytes(b"dry_run_arb_sell_skipped");
                };
                let v37 = 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::config::target_base_position(v2);
                let v38 = if (v37 > 0) {
                    if (v7 >= v37) {
                        (v7 - v37) * 10000 / v37
                    } else {
                        (v37 - v7) * 10000 / v37
                    }
                } else {
                    0
                };
                0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_execution_detail(0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::state_id(arg0), v1, arg13, 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::execution_count(arg0), v0, arg8, v3, 0, 0, v7, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), v37, v38, false, arg9, arg10, 0, 0, v8, false, 0, arg15, false, false, 0, 0, 0, 0, 0, 0, arg8, 0, true, 0, true);
                0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::record_order_time(arg0, v0);
                return
            };
        };
        0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_log_bytes(b"no_arb_continuing_with_mm");
        let v39 = if (0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::config::is_orderbook_analysis_enabled(v2)) {
            let v40 = 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orderbook_analyzer::analyze_orderbook<T0, T1>(arg3, arg2, 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::config::min_significant_qty(v2), 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::config::l2_tick_count(v2), arg7);
            let v41 = if (0x1::vector::length<u64>(0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orderbook_analyzer::bid_prices(&v40)) > 0) {
                *0x1::vector::borrow<u64>(0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orderbook_analyzer::bid_prices(&v40), 0)
            } else {
                0
            };
            let v42 = if (0x1::vector::length<u64>(0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orderbook_analyzer::ask_prices(&v40)) > 0) {
                *0x1::vector::borrow<u64>(0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orderbook_analyzer::ask_prices(&v40), 0)
            } else {
                0
            };
            let v43 = if (v41 > 0) {
                if (v42 > 0) {
                    v42 > v41
                } else {
                    false
                }
            } else {
                false
            };
            let v44 = if (v43) {
                let v45 = (v41 + v42) / 2;
                if (v45 > 0) {
                    (v42 - v41) * 10000 / v45
                } else {
                    0
                }
            } else {
                0
            };
            0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_orderbook_analysis(v1, v0, 0x1::vector::length<u64>(0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orderbook_analyzer::bid_prices(&v40)), 0x1::vector::length<u64>(0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orderbook_analyzer::ask_prices(&v40)), v41, v42, v44, 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orderbook_analyzer::own_bid_qty_filtered(&v40), 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orderbook_analyzer::own_ask_qty_filtered(&v40), 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orderbook_analyzer::own_orders_count(&v40), 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orderbook_analyzer::best_bid(&v40), 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orderbook_analyzer::best_ask(&v40), 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orderbook_analyzer::spread_bps(&v40), 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orderbook_analyzer::significant_bid(&v40), 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orderbook_analyzer::significant_bid_qty(&v40), 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orderbook_analyzer::significant_ask(&v40), 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orderbook_analyzer::significant_ask_qty(&v40), 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orderbook_analyzer::total_bid_depth(&v40), 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orderbook_analyzer::total_ask_depth(&v40));
            0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_log_bytes(b"step_12b_orderbook_analyzed");
            0x1::option::some<0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orderbook_analyzer::OrderbookSnapshot>(v40)
        } else {
            0x1::option::none<0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orderbook_analyzer::OrderbookSnapshot>()
        };
        let v46 = v39;
        let v47 = if (arg23) {
            arg8
        } else {
            v3
        };
        let (v48, v49) = if (v3 >= arg8) {
            ((v3 - arg8) * 10000 / arg8, true)
        } else {
            ((arg8 - v3) * 10000 / arg8, false)
        };
        let v50 = arg25 * v48 / 1000;
        let (v51, v52) = if (arg24 >= 10000) {
            (arg24 - 10000, true)
        } else {
            (10000 - arg24, false)
        };
        let (v53, v54) = if (v52 && v49) {
            (v51 + v50, true)
        } else if (!v52 && !v49) {
            (v51 + v50, false)
        } else if (v52 && !v49) {
            if (v51 >= v50) {
                (v51 - v50, true)
            } else {
                (v50 - v51, false)
            }
        } else if (v50 >= v51) {
            (v50 - v51, true)
        } else {
            (v51 - v50, false)
        };
        let v55 = if (v54) {
            v47 * (100000 + v53) / 100000
        } else if (v53 < 100000) {
            v47 * (100000 - v53) / 100000
        } else {
            1
        };
        let v56 = v55 * (100000 - arg9) / 100000;
        let v57 = v55 * (100000 + arg10) / 100000;
        let (v58, v59, v60) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg3);
        let (v61, _, v63, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg3, 1, arg7);
        let v65 = v63;
        let v66 = v61;
        let v67 = if (0x1::vector::length<u64>(&v66) > 0) {
            *0x1::vector::borrow<u64>(&v66, 0)
        } else {
            0
        };
        let v68 = if (0x1::vector::length<u64>(&v65) > 0) {
            *0x1::vector::borrow<u64>(&v65, 0)
        } else {
            0
        };
        let v69 = false;
        let v70 = false;
        let v71 = v56;
        let v72 = v57;
        if (v68 > 0 && v56 >= v68) {
            v69 = true;
            v71 = v68 * (100000 - arg11) / 100000;
        };
        if (v67 > 0 && v57 <= v67) {
            v70 = true;
            v72 = v67 * (100000 + arg12) / 100000;
        };
        if (v69 || v70) {
            0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_crossing_prevented(v1, v0, v69, v70, v56, v57, v71, v72, v67, v68, arg11, arg12);
        };
        let (v73, v74) = if (0x1::option::is_some<0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orderbook_analyzer::OrderbookSnapshot>(&v46) && arg22 > 0) {
            let v75 = 0x1::option::borrow<0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orderbook_analyzer::OrderbookSnapshot>(&v46);
            let (v76, v77) = 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orderbook_analyzer::find_queue_snipe_price(v75, v71, true, v58, arg22);
            let v78 = if (v77) {
                1
            } else {
                0
            };
            let v79 = 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orders::round_bid_price(v76, v58);
            let v80 = 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orders::round_bid_price(v71, v58);
            let v81 = if (v79 > v80) {
                v79 - v80
            } else {
                v80 - v79
            };
            0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_order_placement_decision(v1, v0, true, arg8, v3, v80, 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orderbook_analyzer::significant_bid(v75), 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orderbook_analyzer::significant_bid_qty(v75), v79, v81 / v58, v79 > v80, v78);
            let (v82, v83) = 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orderbook_analyzer::find_queue_snipe_price(v75, v72, false, v58, arg22);
            let v84 = if (v83) {
                1
            } else {
                0
            };
            let v85 = 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orders::round_ask_price(v82, v58);
            let v86 = 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orders::round_ask_price(v72, v58);
            let v87 = if (v85 < v86) {
                v86 - v85
            } else {
                v85 - v86
            };
            0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_order_placement_decision(v1, v0, false, arg8, v3, v86, 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orderbook_analyzer::significant_ask(v75), 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orderbook_analyzer::significant_ask_qty(v75), v85, v87 / v58, v85 < v86, v84);
            (v79, v85)
        } else {
            (0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orders::round_bid_price(v71, v58), 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orders::round_ask_price(v72, v58))
        };
        0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_debug_pool_params(v58, v59, v60, v71, v72, v73, v74);
        let v88 = if (v3 > v73) {
            (v3 - v73) * 100000 / v3
        } else {
            0
        };
        let v89 = if (v74 > v3) {
            (v74 - v3) * 100000 / v3
        } else {
            0
        };
        let v90 = arg19 == 0 || v88 >= arg19;
        let v91 = arg19 == 0 || v89 >= arg19;
        assert!(v90 || v91, 3);
        let v92 = if (!v90) {
            true
        } else if (arg20 == 0) {
            true
        } else {
            v88 >= arg20
        };
        let v93 = if (v92) {
            arg16
        } else {
            arg16 * (arg21 + (v88 - arg19) * (100 - arg21) / (arg20 - arg19)) / 100
        };
        let v94 = if (!v91) {
            true
        } else if (arg20 == 0) {
            true
        } else {
            v89 >= arg20
        };
        let v95 = if (v94) {
            arg17
        } else {
            arg17 * (arg21 + (v89 - arg19) * (100 - arg21) / (arg20 - arg19)) / 100
        };
        let v96 = 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orders::round_to_lot(v93, v59);
        let v97 = 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::orders::round_to_lot(v95, v59);
        let v98 = 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::config::enable_deep_payment(v2);
        if (!v9) {
            if (0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::config::enable_deep_refill(v2)) {
                let (_, _) = 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::deep_manager::ensure_deep_balance<T0, T1, T3, T4>(arg3, arg4, arg2, &v6, v96 + v97, (v73 + v74) / 2, v2, arg7, arg26);
                0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_log_bytes(b"step_16a_deep_ensured");
            };
            let v101 = if (v90) {
                if (v96 >= 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::config::min_order_size(v2)) {
                    if (v96 >= v60) {
                        v73 >= 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::config::min_price(v2)
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v101) {
                let v102 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v6, arg15, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), v73, v96, true, v98, arg14, arg7, arg26);
                0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_post_only_order(v1, true, v73, v96, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v102), v3, arg9, v0, arg15);
            };
            let v103 = if (v91) {
                if (v97 >= 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::config::min_order_size(v2)) {
                    if (v97 >= v60) {
                        v74 <= 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::config::max_price(v2)
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v103) {
                let v104 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v6, arg15, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), v74, v97, false, v98, arg14, arg7, arg26);
                0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_post_only_order(v1, false, v74, v97, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v104), v3, arg10, v0, arg15);
            };
        } else {
            0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_log_bytes(b"dry_run_orders_skipped");
        };
        0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_orders_placed(0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::state_id(arg0), v1, v73, v96, v74, v97, v0);
        let v105 = 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::config::target_base_position(v2);
        let v106 = false;
        let v107 = 0;
        let v108 = v8;
        if (0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::config::is_hedge_enabled(v2)) {
            let (v109, v110) = 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::cetus_hedger::calculate_hedge_amount(v7, v105, 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::config::max_hedge_pct(v2), 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::config::min_hedge_amount(v2));
            if (v109 > 0) {
                let v111 = 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::cetus_hedger::apply_cetus_fee(v8, 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::cetus_hedger::read_cetus_fee_rate<T2, 0x2::sui::SUI>(arg5), v110);
                v108 = v111;
                let v112 = v110 && 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::cetus_hedger::should_hedge_sell(v111, arg8, 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::config::min_hedge_profit_bps(v2)) || 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::cetus_hedger::should_hedge_buy(v111, arg8, 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::config::min_hedge_profit_bps(v2));
                let v113 = 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::cetus_hedger::calculate_hedge_profit_bps(v111, arg8, v110);
                v107 = v113;
                0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_hedge_opportunity(0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::state_id(arg0), v1, arg8, v8, v111, v109, v110, v112, v113, v0);
                if (v112 && !v9) {
                    if (v110) {
                        let (_, _) = 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::cetus_hedger::flash_swap_sell_sui<T2>(arg2, arg5, arg6, v109, v109 * v111 / 1000000000 * 99 / 100, arg7, arg26);
                        v106 = true;
                        0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_log_bytes(b"hedge_sell_executed");
                    } else {
                        let (_, _) = 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::cetus_hedger::flash_swap_buy_sui<T2>(arg2, arg5, arg6, v109, v109 * v111 / 1000000000 * 101 / 100, arg7, arg26);
                        v106 = true;
                        0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_log_bytes(b"hedge_buy_executed");
                    };
                } else if (v112 && v9) {
                    0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_log_bytes(b"dry_run_hedge_skipped");
                };
            };
        };
        let v118 = if (v105 > 0) {
            if (v7 >= v105) {
                (v7 - v105) * 10000 / v105
            } else {
                (v105 - v7) * 10000 / v105
            }
        } else {
            0
        };
        let v119 = if (arg20 == 0) {
            100
        } else {
            let v120 = if (!v90 || v88 >= arg20) {
                100
            } else {
                arg21 + (v88 - arg19) * (100 - arg21) / (arg20 - arg19)
            };
            let v121 = if (!v91 || v89 >= arg20) {
                100
            } else {
                arg21 + (v89 - arg19) * (100 - arg21) / (arg20 - arg19)
            };
            (v120 + v121) / 2
        };
        0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_execution_detail(0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::state_id(arg0), v1, arg13, 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::execution_count(arg0), v0, arg8, v3, v73, v74, v7, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), v105, v118, v7 > v105, arg9, arg10, v96, v97, v108, v106, v107, arg15, v90, v91, v88, v89, arg19, arg20, arg21, v119, v55, v48, v49, v53, v54);
        0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::record_order_time(arg0, v0);
    }

    public fun get_state_info(arg0: &0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::MMState) : (u64, u64, u64, bool) {
        (0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::current_price(arg0), 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::current_spread(arg0), 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::execution_count(arg0), 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::is_paused(arg0))
    }

    public fun pause_trading<T0, T1>(arg0: &mut 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::owner(arg0) == 0x2::tx_context::sender(arg5), 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v1, arg4, arg5);
        0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::events::emit_orders_cancelled(0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), v0);
        0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::pause(arg0, v0 + arg3, v0);
    }

    public fun resume_trading(arg0: &mut 0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::MMState, arg1: &0x2::tx_context::TxContext) {
        assert!(0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::owner(arg0) == 0x2::tx_context::sender(arg1), 1);
        0x57000f97f67c19dd812743ff6bd545d65994ad4ab77949d420e10e4984ae091c::mm_state::unpause(arg0);
    }

    // decompiled from Move bytecode v6
}

