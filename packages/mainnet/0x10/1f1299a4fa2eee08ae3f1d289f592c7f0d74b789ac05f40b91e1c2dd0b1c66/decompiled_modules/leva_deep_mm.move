module 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::leva_deep_mm {
    public fun cancel_all_orders<T0, T1>(arg0: &0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::owner(arg0) == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg3, arg4);
        0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_orders_cancelled(0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg3));
    }

    public fun cancel_and_settle<T0, T1>(arg0: &0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::owner(arg0) == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg3, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg2, arg1, &v0);
        0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_orders_cancelled(0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg3));
    }

    public fun execute<T0, T1, T2, T3, T4>(arg0: &mut 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::MMState, arg1: &0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_registry::MMRegistry, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T4>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3);
        if (!0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_registry::is_pool_enabled(arg1, v1)) {
            0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_log_bytes(b"pool_not_enabled");
            return
        };
        if (0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::is_trading_blocked(arg0, v0)) {
            0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_log_bytes(b"paused");
            return
        };
        let v2 = 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_registry::get_pool_config(arg1, v1);
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg3, arg7);
        let v4 = if (v3 >= arg8) {
            (v3 - arg8) * 100000 / arg8
        } else {
            (arg8 - v3) * 100000 / arg8
        };
        assert!(v4 <= arg18, 2);
        let v5 = (arg9 + arg10) / 2;
        0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::update_price(arg0, v3, v5, arg13, v0);
        0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_execution(0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::state_id(arg0), v1, v3, v5, arg9 + arg10, arg13, 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::execution_count(arg0), v0);
        0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::record_execution(arg0);
        let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg23);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg3, arg2, &v6, arg7, arg23);
        0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_orders_cancelled(0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::state_id(arg0), v1, v0);
        let v7 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v8 = 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::cetus_hedger::sqrt_price_to_price(0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::cetus_hedger::read_cetus_sqrt_price<T2, 0x2::sui::SUI>(arg5));
        0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_log_bytes(b"step_12a_cetus_price_read");
        let v9 = 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::config::is_dry_run(v2);
        if (0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::config::is_arbitrage_enabled(v2)) {
            let (v10, v11, v12, v13, v14, v15) = 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::arbitrage_router::execute_arbitrage_analysis<T2>(v1, arg5, v3, 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::config::min_arb_profit_bps(v2), 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::last_arb_timestamp(arg0), 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::config::arb_cooldown_ms(v2), arg7);
            let v16 = if (0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::config::max_arb_amount(v2) > 0) {
                0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::config::max_arb_amount(v2)
            } else {
                0
            };
            if ((v10 || v11) && v16 > 0) {
                0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_log_bytes(b"arb_opportunity_found_skipping_mm");
                let v17 = if (v10) {
                    if (v12 == 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::arbitrage_router::pool_cetus()) {
                        !v9
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v17) {
                    let (_, v19, v20) = 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::arbitrage_router::execute_cetus_buy<T2>(v1, arg2, arg5, arg6, v16, v13, v3, 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::config::arb_slippage_bps(v2), arg7, arg23);
                    0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_log_bytes(b"arb_cetus_buy_executed");
                    if (v20 && v19 > 0) {
                        let (_, v22, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg3);
                        let v24 = 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orders::round_to_lot(v19, v22);
                        if (v24 > 0) {
                            let (v25, v26) = 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::arbitrage_router::execute_deepbook_ioc<T0, T1>(false, arg3, arg2, &v6, v3, v24, v2, arg7, arg23);
                            if (v26) {
                                0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_log_bytes(b"arb_deepbook_ioc_sell_filled");
                                0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_arb_ioc_executed(v1, false, v3, v24, v25, v13, v0);
                            } else {
                                0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_log_bytes(b"arb_deepbook_ioc_sell_unfilled");
                            };
                        };
                    };
                    0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::record_arb_time(arg0, v0);
                    0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_log_bytes(b"arb_buy_executed_early_return");
                } else if (v10 && v9) {
                    0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_log_bytes(b"dry_run_arb_buy_skipped");
                };
                let v27 = if (v11) {
                    if (v14 == 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::arbitrage_router::pool_cetus()) {
                        !v9
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v27) {
                    let (v28, _, v30) = 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::arbitrage_router::execute_cetus_sell<T2>(v1, arg2, arg5, arg6, v16, v15, v3, 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::config::arb_slippage_bps(v2), arg7, arg23);
                    0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_log_bytes(b"arb_cetus_sell_executed");
                    if (v30 && v28 > 0) {
                        let (_, v32, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg3);
                        let v34 = 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orders::round_to_lot(v28, v32);
                        if (v34 > 0) {
                            let (v35, v36) = 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::arbitrage_router::execute_deepbook_ioc<T0, T1>(true, arg3, arg2, &v6, v3, v34, v2, arg7, arg23);
                            if (v36) {
                                0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_log_bytes(b"arb_deepbook_ioc_buy_filled");
                                0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_arb_ioc_executed(v1, true, v3, v34, v35, v15, v0);
                            } else {
                                0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_log_bytes(b"arb_deepbook_ioc_buy_unfilled");
                            };
                        };
                    };
                    0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::record_arb_time(arg0, v0);
                    0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_log_bytes(b"arb_sell_executed_early_return");
                } else if (v11 && v9) {
                    0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_log_bytes(b"dry_run_arb_sell_skipped");
                };
                let v37 = 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::config::target_base_position(v2);
                let v38 = if (v37 > 0) {
                    if (v7 >= v37) {
                        (v7 - v37) * 10000 / v37
                    } else {
                        (v37 - v7) * 10000 / v37
                    }
                } else {
                    0
                };
                0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_execution_detail(0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::state_id(arg0), v1, arg13, 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::execution_count(arg0), v0, arg8, v3, 0, 0, v7, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), v37, v38, false, arg9, arg10, 0, 0, v8, false, 0, arg15, false, false, 0, 0, 0, 0, 0, 0);
                0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::record_order_time(arg0, v0);
                return
            };
        };
        0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_log_bytes(b"no_arb_continuing_with_mm");
        let v39 = if (0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::config::is_orderbook_analysis_enabled(v2)) {
            let v40 = 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orderbook_analyzer::analyze_orderbook<T0, T1>(arg3, arg2, 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::config::min_significant_qty(v2), 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::config::l2_tick_count(v2), arg7);
            let v41 = if (0x1::vector::length<u64>(0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orderbook_analyzer::bid_prices(&v40)) > 0) {
                *0x1::vector::borrow<u64>(0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orderbook_analyzer::bid_prices(&v40), 0)
            } else {
                0
            };
            let v42 = if (0x1::vector::length<u64>(0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orderbook_analyzer::ask_prices(&v40)) > 0) {
                *0x1::vector::borrow<u64>(0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orderbook_analyzer::ask_prices(&v40), 0)
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
            0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_orderbook_analysis(v1, v0, 0x1::vector::length<u64>(0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orderbook_analyzer::bid_prices(&v40)), 0x1::vector::length<u64>(0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orderbook_analyzer::ask_prices(&v40)), v41, v42, v44, 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orderbook_analyzer::own_bid_qty_filtered(&v40), 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orderbook_analyzer::own_ask_qty_filtered(&v40), 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orderbook_analyzer::own_orders_count(&v40), 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orderbook_analyzer::best_bid(&v40), 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orderbook_analyzer::best_ask(&v40), 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orderbook_analyzer::spread_bps(&v40), 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orderbook_analyzer::significant_bid(&v40), 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orderbook_analyzer::significant_bid_qty(&v40), 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orderbook_analyzer::significant_ask(&v40), 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orderbook_analyzer::significant_ask_qty(&v40), 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orderbook_analyzer::total_bid_depth(&v40), 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orderbook_analyzer::total_ask_depth(&v40));
            0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_log_bytes(b"step_12b_orderbook_analyzed");
            0x1::option::some<0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orderbook_analyzer::OrderbookSnapshot>(v40)
        } else {
            0x1::option::none<0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orderbook_analyzer::OrderbookSnapshot>()
        };
        let v46 = v39;
        let v47 = v3 * (100000 - arg9) / 100000;
        let v48 = v3 * (100000 + arg10) / 100000;
        let (v49, v50, v51) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg3);
        let (v52, _, v54, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg3, 1, arg7);
        let v56 = v54;
        let v57 = v52;
        let v58 = if (0x1::vector::length<u64>(&v57) > 0) {
            *0x1::vector::borrow<u64>(&v57, 0)
        } else {
            0
        };
        let v59 = if (0x1::vector::length<u64>(&v56) > 0) {
            *0x1::vector::borrow<u64>(&v56, 0)
        } else {
            0
        };
        let v60 = false;
        let v61 = false;
        let v62 = v47;
        let v63 = v48;
        if (v59 > 0 && v47 >= v59) {
            v60 = true;
            v62 = v59 * (100000 - arg11) / 100000;
        };
        if (v58 > 0 && v48 <= v58) {
            v61 = true;
            v63 = v58 * (100000 + arg12) / 100000;
        };
        if (v60 || v61) {
            0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_crossing_prevented(v1, v0, v60, v61, v47, v48, v62, v63, v58, v59, arg11, arg12);
        };
        let (v64, v65) = if (0x1::option::is_some<0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orderbook_analyzer::OrderbookSnapshot>(&v46) && arg22 > 0) {
            let v66 = 0x1::option::borrow<0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orderbook_analyzer::OrderbookSnapshot>(&v46);
            let (v67, v68) = 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orderbook_analyzer::find_queue_snipe_price(v66, v62, true, v49, arg22);
            let v69 = if (v68) {
                1
            } else {
                0
            };
            let v70 = 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orders::round_bid_price(v67, v49);
            let v71 = 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orders::round_bid_price(v62, v49);
            let v72 = if (v70 > v71) {
                v70 - v71
            } else {
                v71 - v70
            };
            0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_order_placement_decision(v1, v0, true, arg8, v3, v71, 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orderbook_analyzer::significant_bid(v66), 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orderbook_analyzer::significant_bid_qty(v66), v70, v72 / v49, v70 > v71, v69);
            let (v73, v74) = 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orderbook_analyzer::find_queue_snipe_price(v66, v63, false, v49, arg22);
            let v75 = if (v74) {
                1
            } else {
                0
            };
            let v76 = 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orders::round_ask_price(v73, v49);
            let v77 = 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orders::round_ask_price(v63, v49);
            let v78 = if (v76 < v77) {
                v77 - v76
            } else {
                v76 - v77
            };
            0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_order_placement_decision(v1, v0, false, arg8, v3, v77, 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orderbook_analyzer::significant_ask(v66), 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orderbook_analyzer::significant_ask_qty(v66), v76, v78 / v49, v76 < v77, v75);
            (v70, v76)
        } else {
            (0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orders::round_bid_price(v62, v49), 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orders::round_ask_price(v63, v49))
        };
        0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_debug_pool_params(v49, v50, v51, v62, v63, v64, v65);
        let v79 = if (v3 > v64) {
            (v3 - v64) * 100000 / v3
        } else {
            0
        };
        let v80 = if (v65 > v3) {
            (v65 - v3) * 100000 / v3
        } else {
            0
        };
        let v81 = arg19 == 0 || v79 >= arg19;
        let v82 = arg19 == 0 || v80 >= arg19;
        assert!(v81 || v82, 3);
        let v83 = if (!v81) {
            true
        } else if (arg20 == 0) {
            true
        } else {
            v79 >= arg20
        };
        let v84 = if (v83) {
            arg16
        } else {
            arg16 * (arg21 + (v79 - arg19) * (100 - arg21) / (arg20 - arg19)) / 100
        };
        let v85 = if (!v82) {
            true
        } else if (arg20 == 0) {
            true
        } else {
            v80 >= arg20
        };
        let v86 = if (v85) {
            arg17
        } else {
            arg17 * (arg21 + (v80 - arg19) * (100 - arg21) / (arg20 - arg19)) / 100
        };
        let v87 = 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orders::round_to_lot(v84, v50);
        let v88 = 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::orders::round_to_lot(v86, v50);
        let v89 = 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::config::enable_deep_payment(v2);
        if (!v9) {
            if (0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::config::enable_deep_refill(v2)) {
                let (_, _) = 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::deep_manager::ensure_deep_balance<T0, T1, T3, T4>(arg3, arg4, arg2, &v6, v87 + v88, (v64 + v65) / 2, v2, arg7, arg23);
                0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_log_bytes(b"step_16a_deep_ensured");
            };
            let v92 = if (v81) {
                if (v87 >= 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::config::min_order_size(v2)) {
                    if (v87 >= v51) {
                        v64 >= 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::config::min_price(v2)
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v92) {
                let v93 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v6, arg15, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), v64, v87, true, v89, arg14, arg7, arg23);
                0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_post_only_order(v1, true, v64, v87, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v93), v3, arg9, v0, arg15);
            };
            let v94 = if (v82) {
                if (v88 >= 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::config::min_order_size(v2)) {
                    if (v88 >= v51) {
                        v65 <= 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::config::max_price(v2)
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v94) {
                let v95 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v6, arg15, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), v65, v88, false, v89, arg14, arg7, arg23);
                0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_post_only_order(v1, false, v65, v88, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v95), v3, arg10, v0, arg15);
            };
        } else {
            0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_log_bytes(b"dry_run_orders_skipped");
        };
        0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_orders_placed(0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::state_id(arg0), v1, v64, v87, v65, v88, v0);
        let v96 = 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::config::target_base_position(v2);
        let v97 = false;
        let v98 = 0;
        let v99 = v8;
        if (0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::config::is_hedge_enabled(v2)) {
            let (v100, v101) = 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::cetus_hedger::calculate_hedge_amount(v7, v96, 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::config::max_hedge_pct(v2), 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::config::min_hedge_amount(v2));
            if (v100 > 0) {
                let v102 = 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::cetus_hedger::apply_cetus_fee(v8, 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::cetus_hedger::read_cetus_fee_rate<T2, 0x2::sui::SUI>(arg5), v101);
                v99 = v102;
                let v103 = v101 && 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::cetus_hedger::should_hedge_sell(v102, arg8, 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::config::min_hedge_profit_bps(v2)) || 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::cetus_hedger::should_hedge_buy(v102, arg8, 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::config::min_hedge_profit_bps(v2));
                let v104 = 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::cetus_hedger::calculate_hedge_profit_bps(v102, arg8, v101);
                v98 = v104;
                0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_hedge_opportunity(0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::state_id(arg0), v1, arg8, v8, v102, v100, v101, v103, v104, v0);
                if (v103 && !v9) {
                    if (v101) {
                        let (_, _) = 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::cetus_hedger::flash_swap_sell_sui<T2>(arg2, arg5, arg6, v100, v100 * v102 / 1000000000 * 99 / 100, arg7, arg23);
                        v97 = true;
                        0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_log_bytes(b"hedge_sell_executed");
                    } else {
                        let (_, _) = 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::cetus_hedger::flash_swap_buy_sui<T2>(arg2, arg5, arg6, v100, v100 * v102 / 1000000000 * 101 / 100, arg7, arg23);
                        v97 = true;
                        0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_log_bytes(b"hedge_buy_executed");
                    };
                } else if (v103 && v9) {
                    0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_log_bytes(b"dry_run_hedge_skipped");
                };
            };
        };
        let v109 = if (v96 > 0) {
            if (v7 >= v96) {
                (v7 - v96) * 10000 / v96
            } else {
                (v96 - v7) * 10000 / v96
            }
        } else {
            0
        };
        let v110 = if (arg20 == 0) {
            100
        } else {
            let v111 = if (!v81 || v79 >= arg20) {
                100
            } else {
                arg21 + (v79 - arg19) * (100 - arg21) / (arg20 - arg19)
            };
            let v112 = if (!v82 || v80 >= arg20) {
                100
            } else {
                arg21 + (v80 - arg19) * (100 - arg21) / (arg20 - arg19)
            };
            (v111 + v112) / 2
        };
        0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_execution_detail(0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::state_id(arg0), v1, arg13, 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::execution_count(arg0), v0, arg8, v3, v64, v65, v7, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), v96, v109, v7 > v96, arg9, arg10, v87, v88, v99, v97, v98, arg15, v81, v82, v79, v80, arg19, arg20, arg21, v110);
        0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::record_order_time(arg0, v0);
    }

    public fun get_state_info(arg0: &0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::MMState) : (u64, u64, u64, bool) {
        (0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::current_price(arg0), 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::current_spread(arg0), 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::execution_count(arg0), 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::is_paused(arg0))
    }

    public fun pause_trading<T0, T1>(arg0: &mut 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::owner(arg0) == 0x2::tx_context::sender(arg5), 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v1, arg4, arg5);
        0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::events::emit_orders_cancelled(0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), v0);
        0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::pause(arg0, v0 + arg3, v0);
    }

    public fun resume_trading(arg0: &mut 0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::MMState, arg1: &0x2::tx_context::TxContext) {
        assert!(0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::owner(arg0) == 0x2::tx_context::sender(arg1), 1);
        0x101f1299a4fa2eee08ae3f1d289f592c7f0d74b789ac05f40b91e1c2dd0b1c66::mm_state::unpause(arg0);
    }

    // decompiled from Move bytecode v6
}

