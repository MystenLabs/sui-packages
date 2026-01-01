module 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::leva_deep_mm {
    public fun cancel_all_orders<T0, T1>(arg0: &0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::owner(arg0) == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg3, arg4);
        0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_orders_cancelled(0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg3));
    }

    public fun cancel_and_settle<T0, T1>(arg0: &0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::owner(arg0) == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg3, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg2, arg1, &v0);
        0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_orders_cancelled(0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg3));
    }

    public fun execute<T0, T1, T2, T3, T4>(arg0: &mut 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::MMState, arg1: &0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_registry::MMRegistry, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T4>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: bool, arg24: u64, arg25: u64, arg26: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3);
        if (!0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_registry::is_pool_enabled(arg1, v1)) {
            0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_log_bytes(b"pool_not_enabled");
            return
        };
        if (0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::is_trading_blocked(arg0, v0)) {
            0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_log_bytes(b"paused");
            return
        };
        let v2 = 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_registry::get_pool_config(arg1, v1);
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg3, arg7);
        let v4 = if (v3 >= arg8) {
            (v3 - arg8) * 100000 / arg8
        } else {
            (arg8 - v3) * 100000 / arg8
        };
        assert!(v4 <= arg18, 2);
        let v5 = (arg9 + arg10) / 2;
        0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::update_price(arg0, v3, v5, arg13, v0);
        0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_execution(0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::state_id(arg0), v1, v3, v5, arg9 + arg10, arg13, 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::execution_count(arg0), v0);
        0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::record_execution(arg0);
        let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg26);
        let (v7, v8) = 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::get_existing_orders<T0, T1>(arg3, arg2, arg7);
        let v9 = v8;
        let v10 = v7;
        let v11 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v12 = 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::cetus_hedger::sqrt_price_to_price(0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::cetus_hedger::read_cetus_sqrt_price<T2, 0x2::sui::SUI>(arg5));
        0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_log_bytes(b"step_12a_cetus_price_read");
        let v13 = 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::config::is_dry_run(v2);
        if (0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::config::is_arbitrage_enabled(v2)) {
            let (v14, v15, v16, v17, v18, v19) = 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::arbitrage_router::execute_arbitrage_analysis<T2>(v1, arg5, v3, 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::config::min_arb_profit_bps(v2), 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::last_arb_timestamp(arg0), 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::config::arb_cooldown_ms(v2), arg7);
            let v20 = if (0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::config::max_arb_amount(v2) > 0) {
                0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::config::max_arb_amount(v2)
            } else {
                0
            };
            if ((v14 || v15) && v20 > 0) {
                0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_log_bytes(b"arb_opportunity_found_skipping_mm");
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg3, arg2, &v6, arg7, arg26);
                0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_orders_cancelled(0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::state_id(arg0), v1, v0);
                let v21 = if (v14) {
                    if (v16 == 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::arbitrage_router::pool_cetus()) {
                        !v13
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v21) {
                    let (_, v23, v24) = 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::arbitrage_router::execute_cetus_buy<T2>(v1, arg2, arg5, arg6, v20, v17, v3, 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::config::arb_slippage_bps(v2), arg7, arg26);
                    0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_log_bytes(b"arb_cetus_buy_executed");
                    if (v24 && v23 > 0) {
                        let (_, v26, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg3);
                        let v28 = 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orders::round_to_lot(v23, v26);
                        if (v28 > 0) {
                            let (v29, v30) = 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::arbitrage_router::execute_deepbook_ioc<T0, T1>(false, arg3, arg2, &v6, v3, v28, v2, arg7, arg26);
                            if (v30) {
                                0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_log_bytes(b"arb_deepbook_ioc_sell_filled");
                                0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_arb_ioc_executed(v1, false, v3, v28, v29, v17, v0);
                            } else {
                                0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_log_bytes(b"arb_deepbook_ioc_sell_unfilled");
                            };
                        };
                    };
                    0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::record_arb_time(arg0, v0);
                    0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_log_bytes(b"arb_buy_executed_early_return");
                } else if (v14 && v13) {
                    0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_log_bytes(b"dry_run_arb_buy_skipped");
                };
                let v31 = if (v15) {
                    if (v18 == 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::arbitrage_router::pool_cetus()) {
                        !v13
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v31) {
                    let (v32, _, v34) = 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::arbitrage_router::execute_cetus_sell<T2>(v1, arg2, arg5, arg6, v20, v19, v3, 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::config::arb_slippage_bps(v2), arg7, arg26);
                    0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_log_bytes(b"arb_cetus_sell_executed");
                    if (v34 && v32 > 0) {
                        let (_, v36, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg3);
                        let v38 = 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orders::round_to_lot(v32, v36);
                        if (v38 > 0) {
                            let (v39, v40) = 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::arbitrage_router::execute_deepbook_ioc<T0, T1>(true, arg3, arg2, &v6, v3, v38, v2, arg7, arg26);
                            if (v40) {
                                0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_log_bytes(b"arb_deepbook_ioc_buy_filled");
                                0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_arb_ioc_executed(v1, true, v3, v38, v39, v19, v0);
                            } else {
                                0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_log_bytes(b"arb_deepbook_ioc_buy_unfilled");
                            };
                        };
                    };
                    0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::record_arb_time(arg0, v0);
                    0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_log_bytes(b"arb_sell_executed_early_return");
                } else if (v15 && v13) {
                    0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_log_bytes(b"dry_run_arb_sell_skipped");
                };
                let v41 = 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::config::target_base_position(v2);
                let v42 = if (v41 > 0) {
                    if (v11 >= v41) {
                        (v11 - v41) * 10000 / v41
                    } else {
                        (v41 - v11) * 10000 / v41
                    }
                } else {
                    0
                };
                0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_execution_detail(0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::state_id(arg0), v1, arg13, 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::execution_count(arg0), v0, arg8, v3, 0, 0, v11, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), v41, v42, false, arg9, arg10, 0, 0, v12, false, 0, arg15, false, false, 0, 0, 0, 0, 0, 0, arg8, 0, true, 0, true);
                0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::record_order_time(arg0, v0);
                return
            };
        };
        0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_log_bytes(b"no_arb_continuing_with_mm");
        let v43 = if (0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::config::is_orderbook_analysis_enabled(v2)) {
            let v44 = 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::analyze_orderbook<T0, T1>(arg3, arg2, 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::config::min_significant_qty(v2), 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::config::l2_tick_count(v2), arg7);
            let v45 = if (0x1::vector::length<u64>(0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::bid_prices(&v44)) > 0) {
                *0x1::vector::borrow<u64>(0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::bid_prices(&v44), 0)
            } else {
                0
            };
            let v46 = if (0x1::vector::length<u64>(0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::ask_prices(&v44)) > 0) {
                *0x1::vector::borrow<u64>(0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::ask_prices(&v44), 0)
            } else {
                0
            };
            let v47 = if (v45 > 0) {
                if (v46 > 0) {
                    v46 > v45
                } else {
                    false
                }
            } else {
                false
            };
            let v48 = if (v47) {
                let v49 = (v45 + v46) / 2;
                if (v49 > 0) {
                    (v46 - v45) * 10000 / v49
                } else {
                    0
                }
            } else {
                0
            };
            0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_orderbook_analysis(v1, v0, 0x1::vector::length<u64>(0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::bid_prices(&v44)), 0x1::vector::length<u64>(0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::ask_prices(&v44)), v45, v46, v48, 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::own_bid_qty_filtered(&v44), 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::own_ask_qty_filtered(&v44), 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::own_orders_count(&v44), 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::best_bid(&v44), 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::best_ask(&v44), 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::spread_bps(&v44), 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::significant_bid(&v44), 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::significant_bid_qty(&v44), 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::significant_ask(&v44), 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::significant_ask_qty(&v44), 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::total_bid_depth(&v44), 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::total_ask_depth(&v44));
            0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_log_bytes(b"step_12b_orderbook_analyzed");
            0x1::option::some<0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::OrderbookSnapshot>(v44)
        } else {
            0x1::option::none<0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::OrderbookSnapshot>()
        };
        let v50 = v43;
        let v51 = if (arg23) {
            arg8
        } else {
            v3
        };
        let (v52, v53) = if (v3 >= arg8) {
            ((v3 - arg8) * 10000 / arg8, true)
        } else {
            ((arg8 - v3) * 10000 / arg8, false)
        };
        let v54 = arg25 * v52 / 1000;
        let (v55, v56) = if (arg24 >= 10000) {
            (arg24 - 10000, true)
        } else {
            (10000 - arg24, false)
        };
        let (v57, v58) = if (v56 && v53) {
            (v55 + v54, true)
        } else if (!v56 && !v53) {
            (v55 + v54, false)
        } else if (v56 && !v53) {
            if (v55 >= v54) {
                (v55 - v54, true)
            } else {
                (v54 - v55, false)
            }
        } else if (v54 >= v55) {
            (v54 - v55, true)
        } else {
            (v55 - v54, false)
        };
        let v59 = if (v58) {
            v51 * (100000 + v57) / 100000
        } else if (v57 < 100000) {
            v51 * (100000 - v57) / 100000
        } else {
            1
        };
        let v60 = v59 * (100000 - arg9) / 100000;
        let v61 = v59 * (100000 + arg10) / 100000;
        let (v62, v63, v64) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg3);
        let (v65, _, v67, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg3, 1, arg7);
        let v69 = v67;
        let v70 = v65;
        let v71 = if (0x1::vector::length<u64>(&v70) > 0) {
            *0x1::vector::borrow<u64>(&v70, 0)
        } else {
            0
        };
        let v72 = if (0x1::vector::length<u64>(&v69) > 0) {
            *0x1::vector::borrow<u64>(&v69, 0)
        } else {
            0
        };
        let v73 = false;
        let v74 = false;
        let v75 = v60;
        let v76 = v61;
        if (v72 > 0 && v60 >= v72) {
            v73 = true;
            v75 = v72 * (100000 - arg11) / 100000;
        };
        if (v71 > 0 && v61 <= v71) {
            v74 = true;
            v76 = v71 * (100000 + arg12) / 100000;
        };
        if (v73 || v74) {
            0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_crossing_prevented(v1, v0, v73, v74, v60, v61, v75, v76, v71, v72, arg11, arg12);
        };
        let (v77, v78) = if (0x1::option::is_some<0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::OrderbookSnapshot>(&v50) && arg22 > 0) {
            let v79 = 0x1::option::borrow<0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::OrderbookSnapshot>(&v50);
            let (v80, v81) = 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::find_queue_snipe_price(v79, v75, true, v62, arg22);
            let v82 = if (v81) {
                1
            } else {
                0
            };
            let v83 = if (v81) {
                v80
            } else {
                0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orders::round_bid_price(v80, v62)
            };
            let v84 = 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orders::round_bid_price(v75, v62);
            let v85 = if (v83 > v84) {
                v83 - v84
            } else {
                v84 - v83
            };
            0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_order_placement_decision(v1, v0, true, arg8, v3, v84, 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::significant_bid(v79), 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::significant_bid_qty(v79), v83, v85 / v62, v83 > v84, v82);
            let (v86, v87) = 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::find_queue_snipe_price(v79, v76, false, v62, arg22);
            let v88 = if (v87) {
                1
            } else {
                0
            };
            let v89 = if (v87) {
                v86
            } else {
                0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orders::round_ask_price(v86, v62)
            };
            let v90 = 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orders::round_ask_price(v76, v62);
            let v91 = if (v89 < v90) {
                v90 - v89
            } else {
                v89 - v90
            };
            0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_order_placement_decision(v1, v0, false, arg8, v3, v90, 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::significant_ask(v79), 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::significant_ask_qty(v79), v89, v91 / v62, v89 < v90, v88);
            (v83, v89)
        } else {
            (0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orders::round_bid_price(v75, v62), 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orders::round_ask_price(v76, v62))
        };
        0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_debug_pool_params(v62, v63, v64, v75, v76, v77, v78);
        let v92 = if (v3 > v77) {
            (v3 - v77) * 100000 / v3
        } else {
            0
        };
        let v93 = if (v78 > v3) {
            (v78 - v3) * 100000 / v3
        } else {
            0
        };
        let v94 = arg19 == 0 || v92 >= arg19;
        let v95 = arg19 == 0 || v93 >= arg19;
        assert!(v94 || v95, 3);
        let v96 = if (!v94) {
            true
        } else if (arg20 == 0) {
            true
        } else {
            v92 >= arg20
        };
        let v97 = if (v96) {
            arg16
        } else {
            arg16 * (arg21 + (v92 - arg19) * (100 - arg21) / (arg20 - arg19)) / 100
        };
        let v98 = if (!v95) {
            true
        } else if (arg20 == 0) {
            true
        } else {
            v93 >= arg20
        };
        let v99 = if (v98) {
            arg17
        } else {
            arg17 * (arg21 + (v93 - arg19) * (100 - arg21) / (arg20 - arg19)) / 100
        };
        let v100 = 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orders::round_to_lot(v97, v63);
        let v101 = 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orders::round_to_lot(v99, v63);
        let v102 = 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::config::enable_deep_payment(v2);
        if (!v13) {
            if (0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::config::enable_deep_refill(v2)) {
                let (_, _) = 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::deep_manager::ensure_deep_balance<T0, T1, T3, T4>(arg3, arg4, arg2, &v6, v100 + v101, (v77 + v78) / 2, v2, arg7, arg26);
                0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_log_bytes(b"step_16a_deep_ensured");
            };
            let v105 = if (v94) {
                if (v100 >= 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::config::min_order_size(v2)) {
                    if (v100 >= v64) {
                        v77 >= 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::config::min_price(v2)
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v105) {
                let v106 = true;
                if (0x1::option::is_some<0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::ExistingOrderInfo>(&v10)) {
                    let v107 = 0x1::option::borrow<0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::ExistingOrderInfo>(&v10);
                    if (0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::price(v107) == v77) {
                        if (!0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::should_refresh_order(v107, v0, 30000)) {
                            v106 = false;
                            0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_log_bytes(b"bid_same_price_keep");
                        } else {
                            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v6, 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::order_id(v107), arg7, arg26);
                            0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_log_bytes(b"bid_same_price_refresh");
                        };
                    } else {
                        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v6, 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::order_id(v107), arg7, arg26);
                        0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_log_bytes(b"bid_diff_price_replace");
                    };
                };
                if (v106) {
                    let v108 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v6, arg15, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), v77, v100, true, v102, arg14, arg7, arg26);
                    0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_post_only_order(v1, true, v77, v100, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v108), v3, arg9, v0, arg15);
                };
            };
            let v109 = if (v95) {
                if (v101 >= 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::config::min_order_size(v2)) {
                    if (v101 >= v64) {
                        v78 <= 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::config::max_price(v2)
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v109) {
                let v110 = true;
                if (0x1::option::is_some<0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::ExistingOrderInfo>(&v9)) {
                    let v111 = 0x1::option::borrow<0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::ExistingOrderInfo>(&v9);
                    if (0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::price(v111) == v78) {
                        if (!0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::should_refresh_order(v111, v0, 30000)) {
                            v110 = false;
                            0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_log_bytes(b"ask_same_price_keep");
                        } else {
                            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v6, 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::order_id(v111), arg7, arg26);
                            0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_log_bytes(b"ask_same_price_refresh");
                        };
                    } else {
                        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v6, 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::orderbook_analyzer::order_id(v111), arg7, arg26);
                        0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_log_bytes(b"ask_diff_price_replace");
                    };
                };
                if (v110) {
                    let v112 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v6, arg15, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), v78, v101, false, v102, arg14, arg7, arg26);
                    0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_post_only_order(v1, false, v78, v101, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v112), v3, arg10, v0, arg15);
                };
            };
        } else {
            0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_log_bytes(b"dry_run_orders_skipped");
        };
        0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_orders_placed(0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::state_id(arg0), v1, v77, v100, v78, v101, v0);
        let v113 = 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::config::target_base_position(v2);
        let v114 = false;
        let v115 = 0;
        let v116 = v12;
        if (0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::config::is_hedge_enabled(v2)) {
            let (v117, v118) = 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::cetus_hedger::calculate_hedge_amount(v11, v113, 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::config::max_hedge_pct(v2), 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::config::min_hedge_amount(v2));
            if (v117 > 0) {
                let v119 = 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::cetus_hedger::apply_cetus_fee(v12, 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::cetus_hedger::read_cetus_fee_rate<T2, 0x2::sui::SUI>(arg5), v118);
                v116 = v119;
                let v120 = v118 && 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::cetus_hedger::should_hedge_sell(v119, arg8, 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::config::min_hedge_profit_bps(v2)) || 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::cetus_hedger::should_hedge_buy(v119, arg8, 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::config::min_hedge_profit_bps(v2));
                let v121 = 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::cetus_hedger::calculate_hedge_profit_bps(v119, arg8, v118);
                v115 = v121;
                0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_hedge_opportunity(0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::state_id(arg0), v1, arg8, v12, v119, v117, v118, v120, v121, v0);
                if (v120 && !v13) {
                    if (v118) {
                        let (_, _) = 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::cetus_hedger::flash_swap_sell_sui<T2>(arg2, arg5, arg6, v117, v117 * v119 / 1000000000 * 99 / 100, arg7, arg26);
                        v114 = true;
                        0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_log_bytes(b"hedge_sell_executed");
                    } else {
                        let (_, _) = 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::cetus_hedger::flash_swap_buy_sui<T2>(arg2, arg5, arg6, v117, v117 * v119 / 1000000000 * 101 / 100, arg7, arg26);
                        v114 = true;
                        0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_log_bytes(b"hedge_buy_executed");
                    };
                } else if (v120 && v13) {
                    0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_log_bytes(b"dry_run_hedge_skipped");
                };
            };
        };
        let v126 = if (v113 > 0) {
            if (v11 >= v113) {
                (v11 - v113) * 10000 / v113
            } else {
                (v113 - v11) * 10000 / v113
            }
        } else {
            0
        };
        let v127 = if (arg20 == 0) {
            100
        } else {
            let v128 = if (!v94 || v92 >= arg20) {
                100
            } else {
                arg21 + (v92 - arg19) * (100 - arg21) / (arg20 - arg19)
            };
            let v129 = if (!v95 || v93 >= arg20) {
                100
            } else {
                arg21 + (v93 - arg19) * (100 - arg21) / (arg20 - arg19)
            };
            (v128 + v129) / 2
        };
        0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_execution_detail(0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::state_id(arg0), v1, arg13, 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::execution_count(arg0), v0, arg8, v3, v77, v78, v11, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), v113, v126, v11 > v113, arg9, arg10, v100, v101, v116, v114, v115, arg15, v94, v95, v92, v93, arg19, arg20, arg21, v127, v59, v52, v53, v57, v58);
        0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::record_order_time(arg0, v0);
    }

    public fun get_state_info(arg0: &0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::MMState) : (u64, u64, u64, bool) {
        (0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::current_price(arg0), 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::current_spread(arg0), 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::execution_count(arg0), 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::is_paused(arg0))
    }

    public fun pause_trading<T0, T1>(arg0: &mut 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::owner(arg0) == 0x2::tx_context::sender(arg5), 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v1, arg4, arg5);
        0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::events::emit_orders_cancelled(0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), v0);
        0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::pause(arg0, v0 + arg3, v0);
    }

    public fun resume_trading(arg0: &mut 0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::MMState, arg1: &0x2::tx_context::TxContext) {
        assert!(0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::owner(arg0) == 0x2::tx_context::sender(arg1), 1);
        0xffe200971a7615fc54114736ae3a17832da38e84f83304a47fd6984393c95729::mm_state::unpause(arg0);
    }

    // decompiled from Move bytecode v6
}

