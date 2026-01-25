module 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::leva_deep_mm {
    public fun cancel_all_orders<T0, T1>(arg0: &0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::owner(arg0) == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg3, arg4);
        0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_orders_cancelled(0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg3));
    }

    public fun cancel_and_settle<T0, T1>(arg0: &0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::owner(arg0) == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg3, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg2, arg1, &v0);
        0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_orders_cancelled(0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg3));
    }

    public fun execute<T0, T1, T2, T3, T4>(arg0: &mut 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::MMState, arg1: &0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_registry::MMRegistry, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T4>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: bool, arg21: u64, arg22: u64, arg23: bool, arg24: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3);
        if (arg23) {
            let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg24);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg3, arg2, &v2, arg7, arg24);
            0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_orders_cancelled(0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::state_id(arg0), v1, v0);
            0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"cancel_only_executed");
            return
        };
        if (!0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_registry::is_pool_enabled(arg1, v1)) {
            0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"pool_not_enabled");
            return
        };
        if (0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::is_trading_blocked(arg0, v0)) {
            0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"paused");
            return
        };
        let v3 = 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_registry::get_pool_config(arg1, v1);
        let v4 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg3, arg7);
        let v5 = v4 == 0;
        let v6 = if (v5) {
            arg8
        } else {
            v4
        };
        if (!v5) {
            let v7 = if (v6 >= arg8) {
                (v6 - arg8) * 100000 / arg8
            } else {
                (arg8 - v6) * 100000 / arg8
            };
            assert!(v7 <= arg18, 2);
        };
        let v8 = (arg9 + arg10) / 2;
        0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::update_price(arg0, v6, v8, arg13, v0);
        0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_execution(0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::state_id(arg0), v1, v6, v8, arg9 + arg10, arg13, 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::execution_count(arg0), v0);
        0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::record_execution(arg0);
        let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg24);
        let (v10, v11) = 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::get_existing_orders<T0, T1>(arg3, arg2, arg7);
        let v12 = v11;
        let v13 = v10;
        let v14 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v15 = 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::cetus_hedger::sqrt_price_to_price(0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::cetus_hedger::read_cetus_sqrt_price<T2, 0x2::sui::SUI>(arg5));
        0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"step_12a_cetus_price_read");
        let v16 = 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::config::is_dry_run(v3);
        if (0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::config::is_arbitrage_enabled(v3)) {
            let (v17, v18, v19, v20, v21, v22) = 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::arbitrage_router::execute_arbitrage_analysis<T2>(v1, arg5, v6, 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::config::min_arb_profit_bps(v3), 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::last_arb_timestamp(arg0), 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::config::arb_cooldown_ms(v3), arg7);
            let v23 = if (0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::config::max_arb_amount(v3) > 0) {
                0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::config::max_arb_amount(v3)
            } else {
                0
            };
            if ((v17 || v18) && v23 > 0) {
                0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"arb_opportunity_found_skipping_mm");
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg3, arg2, &v9, arg7, arg24);
                0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_orders_cancelled(0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::state_id(arg0), v1, v0);
                let v24 = if (v17) {
                    if (v19 == 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::arbitrage_router::pool_cetus()) {
                        !v16
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v24) {
                    let (_, v26, v27) = 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::arbitrage_router::execute_cetus_buy<T2>(v1, arg2, arg5, arg6, v23, v20, v6, 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::config::arb_slippage_bps(v3), arg7, arg24);
                    0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"arb_cetus_buy_executed");
                    if (v27 && v26 > 0) {
                        let (_, v29, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg3);
                        let v31 = 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orders::round_to_lot(v26, v29);
                        if (v31 > 0) {
                            let (v32, v33) = 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::arbitrage_router::execute_deepbook_ioc<T0, T1>(false, arg3, arg2, &v9, v6, v31, v3, arg7, arg24);
                            if (v33) {
                                0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"arb_deepbook_ioc_sell_filled");
                                0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_arb_ioc_executed(v1, false, v6, v31, v32, v20, v0);
                            } else {
                                0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"arb_deepbook_ioc_sell_unfilled");
                            };
                        };
                    };
                    0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::record_arb_time(arg0, v0);
                    0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"arb_buy_executed_early_return");
                } else if (v17 && v16) {
                    0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"dry_run_arb_buy_skipped");
                };
                let v34 = if (v18) {
                    if (v21 == 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::arbitrage_router::pool_cetus()) {
                        !v16
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v34) {
                    let (v35, _, v37) = 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::arbitrage_router::execute_cetus_sell<T2>(v1, arg2, arg5, arg6, v23, v22, v6, 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::config::arb_slippage_bps(v3), arg7, arg24);
                    0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"arb_cetus_sell_executed");
                    if (v37 && v35 > 0) {
                        let (_, v39, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg3);
                        let v41 = 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orders::round_to_lot(v35, v39);
                        if (v41 > 0) {
                            let (v42, v43) = 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::arbitrage_router::execute_deepbook_ioc<T0, T1>(true, arg3, arg2, &v9, v6, v41, v3, arg7, arg24);
                            if (v43) {
                                0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"arb_deepbook_ioc_buy_filled");
                                0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_arb_ioc_executed(v1, true, v6, v41, v42, v22, v0);
                            } else {
                                0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"arb_deepbook_ioc_buy_unfilled");
                            };
                        };
                    };
                    0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::record_arb_time(arg0, v0);
                    0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"arb_sell_executed_early_return");
                } else if (v18 && v16) {
                    0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"dry_run_arb_sell_skipped");
                };
                let v44 = 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::config::target_base_position(v3);
                let v45 = if (v44 > 0) {
                    if (v14 >= v44) {
                        (v14 - v44) * 10000 / v44
                    } else {
                        (v44 - v14) * 10000 / v44
                    }
                } else {
                    0
                };
                0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_execution_detail(0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::state_id(arg0), v1, arg13, 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::execution_count(arg0), v0, arg8, v6, 0, 0, v14, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), v44, v45, false, arg9, arg10, 0, 0, v15, false, 0, arg15, false, false, arg8, 0, true, 0, true);
                0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::record_order_time(arg0, v0);
                return
            };
        };
        0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"no_arb_continuing_with_mm");
        let v46 = if (0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::config::is_orderbook_analysis_enabled(v3)) {
            let v47 = 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::analyze_orderbook<T0, T1>(arg3, arg2, 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::config::min_significant_qty(v3), 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::config::l2_tick_count(v3), arg7);
            let v48 = if (0x1::vector::length<u64>(0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::bid_prices(&v47)) > 0) {
                *0x1::vector::borrow<u64>(0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::bid_prices(&v47), 0)
            } else {
                0
            };
            let v49 = if (0x1::vector::length<u64>(0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::ask_prices(&v47)) > 0) {
                *0x1::vector::borrow<u64>(0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::ask_prices(&v47), 0)
            } else {
                0
            };
            let v50 = if (v48 > 0) {
                if (v49 > 0) {
                    v49 > v48
                } else {
                    false
                }
            } else {
                false
            };
            let v51 = if (v50) {
                let v52 = (v48 + v49) / 2;
                if (v52 > 0) {
                    (v49 - v48) * 10000 / v52
                } else {
                    0
                }
            } else {
                0
            };
            0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_orderbook_analysis(v1, v0, 0x1::vector::length<u64>(0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::bid_prices(&v47)), 0x1::vector::length<u64>(0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::ask_prices(&v47)), v48, v49, v51, 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::own_bid_qty_filtered(&v47), 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::own_ask_qty_filtered(&v47), 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::own_orders_count(&v47), 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::best_bid(&v47), 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::best_ask(&v47), 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::spread_bps(&v47), 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::significant_bid(&v47), 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::significant_bid_qty(&v47), 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::significant_ask(&v47), 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::significant_ask_qty(&v47), 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::total_bid_depth(&v47), 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::total_ask_depth(&v47));
            0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"step_12b_orderbook_analyzed");
            0x1::option::some<0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::OrderbookSnapshot>(v47)
        } else {
            0x1::option::none<0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::OrderbookSnapshot>()
        };
        let v53 = v46;
        let v54 = if (arg20) {
            arg8
        } else {
            v6
        };
        let (v55, v56) = if (v6 >= arg8) {
            ((v6 - arg8) * 10000 / arg8, true)
        } else {
            ((arg8 - v6) * 10000 / arg8, false)
        };
        let v57 = arg22 * v55 / 1000;
        let (v58, v59) = if (arg21 >= 10000) {
            (arg21 - 10000, true)
        } else {
            (10000 - arg21, false)
        };
        let (v60, v61) = if (v59 && v56) {
            (v58 + v57, true)
        } else if (!v59 && !v56) {
            (v58 + v57, false)
        } else if (v59 && !v56) {
            if (v58 >= v57) {
                (v58 - v57, true)
            } else {
                (v57 - v58, false)
            }
        } else if (v57 >= v58) {
            (v57 - v58, true)
        } else {
            (v58 - v57, false)
        };
        let v62 = if (v61) {
            v54 * (100000 + v60) / 100000
        } else if (v60 < 100000) {
            v54 * (100000 - v60) / 100000
        } else {
            1
        };
        let v63 = v62 * (100000 - arg9) / 100000;
        let v64 = v62 * (100000 + arg10) / 100000;
        let (v65, v66, v67) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg3);
        let (v68, _, v70, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg3, 1, arg7);
        let v72 = v70;
        let v73 = v68;
        let v74 = if (0x1::vector::length<u64>(&v73) > 0) {
            *0x1::vector::borrow<u64>(&v73, 0)
        } else {
            0
        };
        let v75 = if (0x1::vector::length<u64>(&v72) > 0) {
            *0x1::vector::borrow<u64>(&v72, 0)
        } else {
            0
        };
        let v76 = false;
        let v77 = false;
        let v78 = v63;
        let v79 = v64;
        if (v75 > 0 && v63 >= v75) {
            v76 = true;
            v78 = v75 * (100000 - arg11) / 100000;
        };
        if (v74 > 0 && v64 <= v74) {
            v77 = true;
            v79 = v74 * (100000 + arg12) / 100000;
        };
        if (v76 || v77) {
            0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_crossing_prevented(v1, v0, v76, v77, v63, v64, v78, v79, v74, v75, arg11, arg12);
        };
        let (v80, v81) = if (0x1::option::is_some<0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::OrderbookSnapshot>(&v53) && arg19 > 0) {
            let v82 = 0x1::option::borrow<0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::OrderbookSnapshot>(&v53);
            let (v83, v84) = 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::find_queue_snipe_price(v82, v78, true, v65, arg19);
            let v85 = if (v84) {
                1
            } else {
                0
            };
            let v86 = if (v84) {
                v83
            } else {
                0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orders::round_bid_price(v83, v65)
            };
            let v87 = 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orders::round_bid_price(v78, v65);
            let v88 = if (v86 > v87) {
                v86 - v87
            } else {
                v87 - v86
            };
            0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_order_placement_decision(v1, v0, true, arg8, v6, v87, 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::significant_bid(v82), 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::significant_bid_qty(v82), v86, v88 / v65, v86 > v87, v85);
            let (v89, v90) = 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::find_queue_snipe_price(v82, v79, false, v65, arg19);
            let v91 = if (v90) {
                1
            } else {
                0
            };
            let v92 = if (v90) {
                v89
            } else {
                0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orders::round_ask_price(v89, v65)
            };
            let v93 = 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orders::round_ask_price(v79, v65);
            let v94 = if (v92 < v93) {
                v93 - v92
            } else {
                v92 - v93
            };
            0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_order_placement_decision(v1, v0, false, arg8, v6, v93, 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::significant_ask(v82), 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::significant_ask_qty(v82), v92, v94 / v65, v92 < v93, v91);
            (v86, v92)
        } else {
            (0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orders::round_bid_price(v78, v65), 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orders::round_ask_price(v79, v65))
        };
        let (v95, v96) = if (0x1::option::is_some<0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::OrderbookSnapshot>(&v53)) {
            let v97 = 0x1::option::borrow<0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::OrderbookSnapshot>(&v53);
            let v98 = 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::best_bid(v97);
            let v99 = 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::best_ask(v97);
            let v100 = v80;
            let v101 = v81;
            if (v99 > 0 && v80 >= v99) {
                let v102 = if (v99 > v65) {
                    v99 - v65
                } else {
                    v65
                };
                v100 = v102;
                0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"bid_clamped_filtered_book");
            };
            if (v98 > 0 && v81 <= v98) {
                v101 = v98 + v65;
                0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"ask_clamped_filtered_book");
            };
            (v100, v101)
        } else {
            (v80, v81)
        };
        0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_debug_pool_params(v65, v66, v67, v78, v79, v95, v96);
        let v103 = 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::config::enable_deep_payment(v3);
        let v104 = if (arg16 >= 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::config::min_order_size(v3)) {
            if (arg16 >= v67) {
                v95 >= 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::config::min_price(v3)
            } else {
                false
            }
        } else {
            false
        };
        let v105 = if (arg17 >= 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::config::min_order_size(v3)) {
            if (arg17 >= v67) {
                v96 <= 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::config::max_price(v3)
            } else {
                false
            }
        } else {
            false
        };
        if (!v16) {
            if (0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::config::enable_deep_refill(v3)) {
                let (_, _) = 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::deep_manager::ensure_deep_balance<T0, T1, T3, T4>(arg3, arg4, arg2, &v9, arg16 + arg17, (v95 + v96) / 2, v3, arg7, arg24);
                0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"step_16a_deep_ensured");
            };
            let v108 = false;
            let v109 = false;
            if (0x1::option::is_some<0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::ExistingOrderInfo>(&v13)) {
                let v110 = 0x1::option::borrow<0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::ExistingOrderInfo>(&v13);
                let v111 = 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::price(v110);
                let v112 = v111 != v95;
                let v113 = !v112 && 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::should_refresh_order(v110, v0, 30000);
                let v114 = v105 && v96 <= v111;
                let v115 = if (v112) {
                    true
                } else if (v113) {
                    true
                } else {
                    v114
                };
                if (v115) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v9, 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::order_id(v110), arg7, arg24);
                    v108 = true;
                    if (v114) {
                        0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"bid_cancelled_would_cross_ask");
                    } else if (v112) {
                        0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"bid_diff_price_replace");
                    } else {
                        0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"bid_same_price_refresh");
                    };
                } else {
                    0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"bid_same_price_keep");
                };
            };
            if (0x1::option::is_some<0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::ExistingOrderInfo>(&v12)) {
                let v116 = 0x1::option::borrow<0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::ExistingOrderInfo>(&v12);
                let v117 = 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::price(v116);
                let v118 = v117 != v96;
                let v119 = !v118 && 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::should_refresh_order(v116, v0, 30000);
                let v120 = v104 && v95 >= v117;
                let v121 = if (v118) {
                    true
                } else if (v119) {
                    true
                } else {
                    v120
                };
                if (v121) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v9, 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::order_id(v116), arg7, arg24);
                    v109 = true;
                    if (v120) {
                        0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"ask_cancelled_would_cross_bid");
                    } else if (v118) {
                        0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"ask_diff_price_replace");
                    } else {
                        0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"ask_same_price_refresh");
                    };
                } else {
                    0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"ask_same_price_keep");
                };
            };
            if (v104 && (!0x1::option::is_some<0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::ExistingOrderInfo>(&v13) || v108)) {
                let v122 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v9, arg15, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), v95, arg16, true, v103, arg14, arg7, arg24);
                0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_post_only_order(v1, true, v95, arg16, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v122), v6, arg9, v0, arg15);
            };
            if (v105 && (!0x1::option::is_some<0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::orderbook_analyzer::ExistingOrderInfo>(&v12) || v109)) {
                let v123 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v9, arg15, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), v96, arg17, false, v103, arg14, arg7, arg24);
                0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_post_only_order(v1, false, v96, arg17, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v123), v6, arg10, v0, arg15);
            };
        } else {
            0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"dry_run_orders_skipped");
        };
        0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_orders_placed(0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::state_id(arg0), v1, v95, arg16, v96, arg17, v0);
        let v124 = 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::config::target_base_position(v3);
        let v125 = false;
        let v126 = 0;
        let v127 = v15;
        if (0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::config::is_hedge_enabled(v3)) {
            let (v128, v129) = 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::cetus_hedger::calculate_hedge_amount(v14, v124, 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::config::max_hedge_pct(v3), 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::config::min_hedge_amount(v3));
            if (v128 > 0) {
                let v130 = 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::cetus_hedger::apply_cetus_fee(v15, 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::cetus_hedger::read_cetus_fee_rate<T2, 0x2::sui::SUI>(arg5), v129);
                v127 = v130;
                let v131 = v129 && 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::cetus_hedger::should_hedge_sell(v130, arg8, 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::config::min_hedge_profit_bps(v3)) || 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::cetus_hedger::should_hedge_buy(v130, arg8, 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::config::min_hedge_profit_bps(v3));
                let v132 = 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::cetus_hedger::calculate_hedge_profit_bps(v130, arg8, v129);
                v126 = v132;
                0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_hedge_opportunity(0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::state_id(arg0), v1, arg8, v15, v130, v128, v129, v131, v132, v0);
                if (v131 && !v16) {
                    if (v129) {
                        let (_, _) = 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::cetus_hedger::flash_swap_sell_sui<T2>(arg2, arg5, arg6, v128, v128 * v130 / 1000000000 * 99 / 100, arg7, arg24);
                        v125 = true;
                        0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"hedge_sell_executed");
                    } else {
                        let (_, _) = 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::cetus_hedger::flash_swap_buy_sui<T2>(arg2, arg5, arg6, v128, v128 * v130 / 1000000000 * 101 / 100, arg7, arg24);
                        v125 = true;
                        0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"hedge_buy_executed");
                    };
                } else if (v131 && v16) {
                    0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_log_bytes(b"dry_run_hedge_skipped");
                };
            };
        };
        let v137 = if (v124 > 0) {
            if (v14 >= v124) {
                (v14 - v124) * 10000 / v124
            } else {
                (v124 - v14) * 10000 / v124
            }
        } else {
            0
        };
        0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_execution_detail(0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::state_id(arg0), v1, arg13, 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::execution_count(arg0), v0, arg8, v6, v95, v96, v14, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), v124, v137, v14 > v124, arg9, arg10, arg16, arg17, v127, v125, v126, arg15, v104, v105, v62, v55, v56, v60, v61);
        0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::record_order_time(arg0, v0);
    }

    public fun get_state_info(arg0: &0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::MMState) : (u64, u64, u64, bool) {
        (0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::current_price(arg0), 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::current_spread(arg0), 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::execution_count(arg0), 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::is_paused(arg0))
    }

    public fun pause_trading<T0, T1>(arg0: &mut 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::owner(arg0) == 0x2::tx_context::sender(arg5), 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v1, arg4, arg5);
        0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::events::emit_orders_cancelled(0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), v0);
        0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::pause(arg0, v0 + arg3, v0);
    }

    public fun resume_trading(arg0: &mut 0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::MMState, arg1: &0x2::tx_context::TxContext) {
        assert!(0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::owner(arg0) == 0x2::tx_context::sender(arg1), 1);
        0x49364e6de60339b1885b4d57fe7c073acee55e8d27884d115d625e1ae7951329::mm_state::unpause(arg0);
    }

    // decompiled from Move bytecode v6
}

