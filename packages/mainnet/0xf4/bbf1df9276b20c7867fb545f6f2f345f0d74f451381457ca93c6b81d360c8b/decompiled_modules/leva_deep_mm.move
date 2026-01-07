module 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::leva_deep_mm {
    public fun cancel_all_orders<T0, T1>(arg0: &0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::owner(arg0) == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg3, arg4);
        0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_orders_cancelled(0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg3));
    }

    public fun cancel_and_settle<T0, T1>(arg0: &0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::owner(arg0) == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg3, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg2, arg1, &v0);
        0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_orders_cancelled(0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg3));
    }

    public fun execute<T0, T1, T2, T3, T4>(arg0: &mut 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::MMState, arg1: &0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_registry::MMRegistry, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T4>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: bool, arg21: u64, arg22: u64, arg23: bool, arg24: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3);
        if (arg23) {
            let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg24);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg3, arg2, &v2, arg7, arg24);
            0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_orders_cancelled(0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::state_id(arg0), v1, v0);
            0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_log_bytes(b"cancel_only_executed");
            return
        };
        if (!0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_registry::is_pool_enabled(arg1, v1)) {
            0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_log_bytes(b"pool_not_enabled");
            return
        };
        if (0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::is_trading_blocked(arg0, v0)) {
            0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_log_bytes(b"paused");
            return
        };
        let v3 = 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_registry::get_pool_config(arg1, v1);
        let v4 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg3, arg7);
        let v5 = if (v4 >= arg8) {
            (v4 - arg8) * 100000 / arg8
        } else {
            (arg8 - v4) * 100000 / arg8
        };
        assert!(v5 <= arg18, 2);
        let v6 = (arg9 + arg10) / 2;
        0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::update_price(arg0, v4, v6, arg13, v0);
        0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_execution(0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::state_id(arg0), v1, v4, v6, arg9 + arg10, arg13, 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::execution_count(arg0), v0);
        0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::record_execution(arg0);
        let v7 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg24);
        let (v8, v9) = 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::get_existing_orders<T0, T1>(arg3, arg2, arg7);
        let v10 = v9;
        let v11 = v8;
        let v12 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v13 = 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::cetus_hedger::sqrt_price_to_price(0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::cetus_hedger::read_cetus_sqrt_price<T2, 0x2::sui::SUI>(arg5));
        0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_log_bytes(b"step_12a_cetus_price_read");
        let v14 = 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::config::is_dry_run(v3);
        if (0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::config::is_arbitrage_enabled(v3)) {
            let (v15, v16, v17, v18, v19, v20) = 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::arbitrage_router::execute_arbitrage_analysis<T2>(v1, arg5, v4, 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::config::min_arb_profit_bps(v3), 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::last_arb_timestamp(arg0), 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::config::arb_cooldown_ms(v3), arg7);
            let v21 = if (0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::config::max_arb_amount(v3) > 0) {
                0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::config::max_arb_amount(v3)
            } else {
                0
            };
            if ((v15 || v16) && v21 > 0) {
                0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_log_bytes(b"arb_opportunity_found_skipping_mm");
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg3, arg2, &v7, arg7, arg24);
                0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_orders_cancelled(0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::state_id(arg0), v1, v0);
                let v22 = if (v15) {
                    if (v17 == 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::arbitrage_router::pool_cetus()) {
                        !v14
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v22) {
                    let (_, v24, v25) = 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::arbitrage_router::execute_cetus_buy<T2>(v1, arg2, arg5, arg6, v21, v18, v4, 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::config::arb_slippage_bps(v3), arg7, arg24);
                    0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_log_bytes(b"arb_cetus_buy_executed");
                    if (v25 && v24 > 0) {
                        let (_, v27, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg3);
                        let v29 = 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orders::round_to_lot(v24, v27);
                        if (v29 > 0) {
                            let (v30, v31) = 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::arbitrage_router::execute_deepbook_ioc<T0, T1>(false, arg3, arg2, &v7, v4, v29, v3, arg7, arg24);
                            if (v31) {
                                0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_log_bytes(b"arb_deepbook_ioc_sell_filled");
                                0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_arb_ioc_executed(v1, false, v4, v29, v30, v18, v0);
                            } else {
                                0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_log_bytes(b"arb_deepbook_ioc_sell_unfilled");
                            };
                        };
                    };
                    0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::record_arb_time(arg0, v0);
                    0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_log_bytes(b"arb_buy_executed_early_return");
                } else if (v15 && v14) {
                    0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_log_bytes(b"dry_run_arb_buy_skipped");
                };
                let v32 = if (v16) {
                    if (v19 == 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::arbitrage_router::pool_cetus()) {
                        !v14
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v32) {
                    let (v33, _, v35) = 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::arbitrage_router::execute_cetus_sell<T2>(v1, arg2, arg5, arg6, v21, v20, v4, 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::config::arb_slippage_bps(v3), arg7, arg24);
                    0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_log_bytes(b"arb_cetus_sell_executed");
                    if (v35 && v33 > 0) {
                        let (_, v37, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg3);
                        let v39 = 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orders::round_to_lot(v33, v37);
                        if (v39 > 0) {
                            let (v40, v41) = 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::arbitrage_router::execute_deepbook_ioc<T0, T1>(true, arg3, arg2, &v7, v4, v39, v3, arg7, arg24);
                            if (v41) {
                                0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_log_bytes(b"arb_deepbook_ioc_buy_filled");
                                0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_arb_ioc_executed(v1, true, v4, v39, v40, v20, v0);
                            } else {
                                0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_log_bytes(b"arb_deepbook_ioc_buy_unfilled");
                            };
                        };
                    };
                    0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::record_arb_time(arg0, v0);
                    0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_log_bytes(b"arb_sell_executed_early_return");
                } else if (v16 && v14) {
                    0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_log_bytes(b"dry_run_arb_sell_skipped");
                };
                let v42 = 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::config::target_base_position(v3);
                let v43 = if (v42 > 0) {
                    if (v12 >= v42) {
                        (v12 - v42) * 10000 / v42
                    } else {
                        (v42 - v12) * 10000 / v42
                    }
                } else {
                    0
                };
                0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_execution_detail(0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::state_id(arg0), v1, arg13, 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::execution_count(arg0), v0, arg8, v4, 0, 0, v12, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), v42, v43, false, arg9, arg10, 0, 0, v13, false, 0, arg15, false, false, arg8, 0, true, 0, true);
                0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::record_order_time(arg0, v0);
                return
            };
        };
        0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_log_bytes(b"no_arb_continuing_with_mm");
        let v44 = if (0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::config::is_orderbook_analysis_enabled(v3)) {
            let v45 = 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::analyze_orderbook<T0, T1>(arg3, arg2, 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::config::min_significant_qty(v3), 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::config::l2_tick_count(v3), arg7);
            let v46 = if (0x1::vector::length<u64>(0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::bid_prices(&v45)) > 0) {
                *0x1::vector::borrow<u64>(0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::bid_prices(&v45), 0)
            } else {
                0
            };
            let v47 = if (0x1::vector::length<u64>(0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::ask_prices(&v45)) > 0) {
                *0x1::vector::borrow<u64>(0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::ask_prices(&v45), 0)
            } else {
                0
            };
            let v48 = if (v46 > 0) {
                if (v47 > 0) {
                    v47 > v46
                } else {
                    false
                }
            } else {
                false
            };
            let v49 = if (v48) {
                let v50 = (v46 + v47) / 2;
                if (v50 > 0) {
                    (v47 - v46) * 10000 / v50
                } else {
                    0
                }
            } else {
                0
            };
            0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_orderbook_analysis(v1, v0, 0x1::vector::length<u64>(0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::bid_prices(&v45)), 0x1::vector::length<u64>(0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::ask_prices(&v45)), v46, v47, v49, 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::own_bid_qty_filtered(&v45), 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::own_ask_qty_filtered(&v45), 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::own_orders_count(&v45), 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::best_bid(&v45), 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::best_ask(&v45), 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::spread_bps(&v45), 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::significant_bid(&v45), 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::significant_bid_qty(&v45), 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::significant_ask(&v45), 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::significant_ask_qty(&v45), 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::total_bid_depth(&v45), 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::total_ask_depth(&v45));
            0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_log_bytes(b"step_12b_orderbook_analyzed");
            0x1::option::some<0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::OrderbookSnapshot>(v45)
        } else {
            0x1::option::none<0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::OrderbookSnapshot>()
        };
        let v51 = v44;
        let v52 = if (arg20) {
            arg8
        } else {
            v4
        };
        let (v53, v54) = if (v4 >= arg8) {
            ((v4 - arg8) * 10000 / arg8, true)
        } else {
            ((arg8 - v4) * 10000 / arg8, false)
        };
        let v55 = arg22 * v53 / 1000;
        let (v56, v57) = if (arg21 >= 10000) {
            (arg21 - 10000, true)
        } else {
            (10000 - arg21, false)
        };
        let (v58, v59) = if (v57 && v54) {
            (v56 + v55, true)
        } else if (!v57 && !v54) {
            (v56 + v55, false)
        } else if (v57 && !v54) {
            if (v56 >= v55) {
                (v56 - v55, true)
            } else {
                (v55 - v56, false)
            }
        } else if (v55 >= v56) {
            (v55 - v56, true)
        } else {
            (v56 - v55, false)
        };
        let v60 = if (v59) {
            v52 * (100000 + v58) / 100000
        } else if (v58 < 100000) {
            v52 * (100000 - v58) / 100000
        } else {
            1
        };
        let v61 = v60 * (100000 - arg9) / 100000;
        let v62 = v60 * (100000 + arg10) / 100000;
        let (v63, v64, v65) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg3);
        let (v66, _, v68, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg3, 1, arg7);
        let v70 = v68;
        let v71 = v66;
        let v72 = if (0x1::vector::length<u64>(&v71) > 0) {
            *0x1::vector::borrow<u64>(&v71, 0)
        } else {
            0
        };
        let v73 = if (0x1::vector::length<u64>(&v70) > 0) {
            *0x1::vector::borrow<u64>(&v70, 0)
        } else {
            0
        };
        let v74 = false;
        let v75 = false;
        let v76 = v61;
        let v77 = v62;
        if (v73 > 0 && v61 >= v73) {
            v74 = true;
            v76 = v73 * (100000 - arg11) / 100000;
        };
        if (v72 > 0 && v62 <= v72) {
            v75 = true;
            v77 = v72 * (100000 + arg12) / 100000;
        };
        if (v74 || v75) {
            0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_crossing_prevented(v1, v0, v74, v75, v61, v62, v76, v77, v72, v73, arg11, arg12);
        };
        let (v78, v79) = if (0x1::option::is_some<0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::OrderbookSnapshot>(&v51) && arg19 > 0) {
            let v80 = 0x1::option::borrow<0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::OrderbookSnapshot>(&v51);
            let (v81, v82) = 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::find_queue_snipe_price(v80, v76, true, v63, arg19);
            let v83 = if (v82) {
                1
            } else {
                0
            };
            let v84 = if (v82) {
                v81
            } else {
                0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orders::round_bid_price(v81, v63)
            };
            let v85 = 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orders::round_bid_price(v76, v63);
            let v86 = if (v84 > v85) {
                v84 - v85
            } else {
                v85 - v84
            };
            0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_order_placement_decision(v1, v0, true, arg8, v4, v85, 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::significant_bid(v80), 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::significant_bid_qty(v80), v84, v86 / v63, v84 > v85, v83);
            let (v87, v88) = 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::find_queue_snipe_price(v80, v77, false, v63, arg19);
            let v89 = if (v88) {
                1
            } else {
                0
            };
            let v90 = if (v88) {
                v87
            } else {
                0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orders::round_ask_price(v87, v63)
            };
            let v91 = 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orders::round_ask_price(v77, v63);
            let v92 = if (v90 < v91) {
                v91 - v90
            } else {
                v90 - v91
            };
            0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_order_placement_decision(v1, v0, false, arg8, v4, v91, 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::significant_ask(v80), 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::significant_ask_qty(v80), v90, v92 / v63, v90 < v91, v89);
            (v84, v90)
        } else {
            (0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orders::round_bid_price(v76, v63), 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orders::round_ask_price(v77, v63))
        };
        0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_debug_pool_params(v63, v64, v65, v76, v77, v78, v79);
        let v93 = 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::config::enable_deep_payment(v3);
        let v94 = if (arg16 >= 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::config::min_order_size(v3)) {
            if (arg16 >= v65) {
                v78 >= 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::config::min_price(v3)
            } else {
                false
            }
        } else {
            false
        };
        let v95 = if (arg17 >= 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::config::min_order_size(v3)) {
            if (arg17 >= v65) {
                v79 <= 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::config::max_price(v3)
            } else {
                false
            }
        } else {
            false
        };
        if (!v14) {
            if (0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::config::enable_deep_refill(v3)) {
                let (_, _) = 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::deep_manager::ensure_deep_balance<T0, T1, T3, T4>(arg3, arg4, arg2, &v7, arg16 + arg17, (v78 + v79) / 2, v3, arg7, arg24);
                0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_log_bytes(b"step_16a_deep_ensured");
            };
            if (v94) {
                let v98 = true;
                if (0x1::option::is_some<0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::ExistingOrderInfo>(&v11)) {
                    let v99 = 0x1::option::borrow<0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::ExistingOrderInfo>(&v11);
                    if (0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::price(v99) == v78) {
                        if (!0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::should_refresh_order(v99, v0, 30000)) {
                            v98 = false;
                            0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_log_bytes(b"bid_same_price_keep");
                        } else {
                            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v7, 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::order_id(v99), arg7, arg24);
                            0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_log_bytes(b"bid_same_price_refresh");
                        };
                    } else {
                        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v7, 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::order_id(v99), arg7, arg24);
                        0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_log_bytes(b"bid_diff_price_replace");
                    };
                };
                if (v98) {
                    let v100 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v7, arg15, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), v78, arg16, true, v93, arg14, arg7, arg24);
                    0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_post_only_order(v1, true, v78, arg16, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v100), v4, arg9, v0, arg15);
                };
            };
            if (v95) {
                let v101 = true;
                if (0x1::option::is_some<0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::ExistingOrderInfo>(&v10)) {
                    let v102 = 0x1::option::borrow<0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::ExistingOrderInfo>(&v10);
                    if (0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::price(v102) == v79) {
                        if (!0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::should_refresh_order(v102, v0, 30000)) {
                            v101 = false;
                            0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_log_bytes(b"ask_same_price_keep");
                        } else {
                            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v7, 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::order_id(v102), arg7, arg24);
                            0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_log_bytes(b"ask_same_price_refresh");
                        };
                    } else {
                        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v7, 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::orderbook_analyzer::order_id(v102), arg7, arg24);
                        0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_log_bytes(b"ask_diff_price_replace");
                    };
                };
                if (v101) {
                    let v103 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v7, arg15, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), v79, arg17, false, v93, arg14, arg7, arg24);
                    0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_post_only_order(v1, false, v79, arg17, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v103), v4, arg10, v0, arg15);
                };
            };
        } else {
            0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_log_bytes(b"dry_run_orders_skipped");
        };
        0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_orders_placed(0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::state_id(arg0), v1, v78, arg16, v79, arg17, v0);
        let v104 = 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::config::target_base_position(v3);
        let v105 = false;
        let v106 = 0;
        let v107 = v13;
        if (0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::config::is_hedge_enabled(v3)) {
            let (v108, v109) = 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::cetus_hedger::calculate_hedge_amount(v12, v104, 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::config::max_hedge_pct(v3), 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::config::min_hedge_amount(v3));
            if (v108 > 0) {
                let v110 = 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::cetus_hedger::apply_cetus_fee(v13, 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::cetus_hedger::read_cetus_fee_rate<T2, 0x2::sui::SUI>(arg5), v109);
                v107 = v110;
                let v111 = v109 && 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::cetus_hedger::should_hedge_sell(v110, arg8, 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::config::min_hedge_profit_bps(v3)) || 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::cetus_hedger::should_hedge_buy(v110, arg8, 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::config::min_hedge_profit_bps(v3));
                let v112 = 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::cetus_hedger::calculate_hedge_profit_bps(v110, arg8, v109);
                v106 = v112;
                0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_hedge_opportunity(0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::state_id(arg0), v1, arg8, v13, v110, v108, v109, v111, v112, v0);
                if (v111 && !v14) {
                    if (v109) {
                        let (_, _) = 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::cetus_hedger::flash_swap_sell_sui<T2>(arg2, arg5, arg6, v108, v108 * v110 / 1000000000 * 99 / 100, arg7, arg24);
                        v105 = true;
                        0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_log_bytes(b"hedge_sell_executed");
                    } else {
                        let (_, _) = 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::cetus_hedger::flash_swap_buy_sui<T2>(arg2, arg5, arg6, v108, v108 * v110 / 1000000000 * 101 / 100, arg7, arg24);
                        v105 = true;
                        0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_log_bytes(b"hedge_buy_executed");
                    };
                } else if (v111 && v14) {
                    0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_log_bytes(b"dry_run_hedge_skipped");
                };
            };
        };
        let v117 = if (v104 > 0) {
            if (v12 >= v104) {
                (v12 - v104) * 10000 / v104
            } else {
                (v104 - v12) * 10000 / v104
            }
        } else {
            0
        };
        0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_execution_detail(0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::state_id(arg0), v1, arg13, 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::execution_count(arg0), v0, arg8, v4, v78, v79, v12, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), v104, v117, v12 > v104, arg9, arg10, arg16, arg17, v107, v105, v106, arg15, v94, v95, v60, v53, v54, v58, v59);
        0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::record_order_time(arg0, v0);
    }

    public fun get_state_info(arg0: &0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::MMState) : (u64, u64, u64, bool) {
        (0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::current_price(arg0), 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::current_spread(arg0), 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::execution_count(arg0), 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::is_paused(arg0))
    }

    public fun pause_trading<T0, T1>(arg0: &mut 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::owner(arg0) == 0x2::tx_context::sender(arg5), 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v1, arg4, arg5);
        0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::events::emit_orders_cancelled(0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), v0);
        0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::pause(arg0, v0 + arg3, v0);
    }

    public fun resume_trading(arg0: &mut 0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::MMState, arg1: &0x2::tx_context::TxContext) {
        assert!(0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::owner(arg0) == 0x2::tx_context::sender(arg1), 1);
        0xf4bbf1df9276b20c7867fb545f6f2f345f0d74f451381457ca93c6b81d360c8b::mm_state::unpause(arg0);
    }

    // decompiled from Move bytecode v6
}

