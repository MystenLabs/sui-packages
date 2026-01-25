module 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::leva_deep_mm {
    public fun cancel_all_orders<T0, T1>(arg0: &0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_state::owner(arg0) == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg3, arg4);
        0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::events::emit_orders_cancelled(0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg3));
    }

    public fun cancel_and_settle<T0, T1>(arg0: &0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_state::owner(arg0) == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg3, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg2, arg1, &v0);
        0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::events::emit_orders_cancelled(0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg3));
    }

    public fun execute<T0, T1, T2, T3>(arg0: &mut 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_state::MMState, arg1: &0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_registry::MMRegistry, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: bool, arg19: u64, arg20: u64, arg21: bool, arg22: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3);
        if (arg21) {
            let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg22);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg3, arg2, &v2, arg5, arg22);
            0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::events::emit_orders_cancelled(0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_state::state_id(arg0), v1, v0);
            0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::events::emit_log_bytes(b"cancel_only_executed");
            return
        };
        if (0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_state::is_trading_blocked(arg0, v0)) {
            0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::events::emit_log_bytes(b"paused");
            return
        };
        let v3 = 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_registry::get_pool_config(arg1, v1);
        let v4 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg3, arg5);
        let v5 = v4 == 0;
        let v6 = if (v5) {
            arg6
        } else {
            v4
        };
        if (!v5) {
            let v7 = if (v6 >= arg6) {
                (v6 - arg6) * 100000 / arg6
            } else {
                (arg6 - v6) * 100000 / arg6
            };
            assert!(v7 <= arg16, 2);
        };
        let v8 = (arg7 + arg8) / 2;
        0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_state::update_price(arg0, v6, v8, arg11, v0);
        0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::events::emit_execution(0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_state::state_id(arg0), v1, v6, v8, arg7 + arg8, arg11, 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_state::execution_count(arg0), v0);
        0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_state::record_execution(arg0);
        let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg22);
        let (v10, v11) = 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::get_existing_orders<T0, T1>(arg3, arg2, arg5);
        let v12 = v11;
        let v13 = v10;
        let v14 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v15 = if (0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::config::is_orderbook_analysis_enabled(v3)) {
            let v16 = 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::analyze_orderbook<T0, T1>(arg3, arg2, 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::config::min_significant_qty(v3), 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::config::l2_tick_count(v3), arg5);
            let v17 = if (0x1::vector::length<u64>(0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::bid_prices(&v16)) > 0) {
                *0x1::vector::borrow<u64>(0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::bid_prices(&v16), 0)
            } else {
                0
            };
            let v18 = if (0x1::vector::length<u64>(0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::ask_prices(&v16)) > 0) {
                *0x1::vector::borrow<u64>(0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::ask_prices(&v16), 0)
            } else {
                0
            };
            let v19 = if (v17 > 0) {
                if (v18 > 0) {
                    v18 > v17
                } else {
                    false
                }
            } else {
                false
            };
            let v20 = if (v19) {
                let v21 = (v17 + v18) / 2;
                if (v21 > 0) {
                    (v18 - v17) * 10000 / v21
                } else {
                    0
                }
            } else {
                0
            };
            0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::events::emit_orderbook_analysis(v1, v0, 0x1::vector::length<u64>(0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::bid_prices(&v16)), 0x1::vector::length<u64>(0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::ask_prices(&v16)), v17, v18, v20, 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::own_bid_qty_filtered(&v16), 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::own_ask_qty_filtered(&v16), 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::own_orders_count(&v16), 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::best_bid(&v16), 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::best_ask(&v16), 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::spread_bps(&v16), 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::significant_bid(&v16), 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::significant_bid_qty(&v16), 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::significant_ask(&v16), 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::significant_ask_qty(&v16), 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::total_bid_depth(&v16), 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::total_ask_depth(&v16));
            0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::events::emit_log_bytes(b"step_12b_orderbook_analyzed");
            0x1::option::some<0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::OrderbookSnapshot>(v16)
        } else {
            0x1::option::none<0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::OrderbookSnapshot>()
        };
        let v22 = v15;
        let v23 = if (arg18) {
            arg6
        } else {
            v6
        };
        let (v24, v25) = if (v6 >= arg6) {
            ((v6 - arg6) * 10000 / arg6, true)
        } else {
            ((arg6 - v6) * 10000 / arg6, false)
        };
        let v26 = arg20 * v24 / 1000;
        let (v27, v28) = if (arg19 >= 10000) {
            (arg19 - 10000, true)
        } else {
            (10000 - arg19, false)
        };
        let (v29, v30) = if (v28 && v25) {
            (v27 + v26, true)
        } else if (!v28 && !v25) {
            (v27 + v26, false)
        } else if (v28 && !v25) {
            if (v27 >= v26) {
                (v27 - v26, true)
            } else {
                (v26 - v27, false)
            }
        } else if (v26 >= v27) {
            (v26 - v27, true)
        } else {
            (v27 - v26, false)
        };
        let v31 = if (v30) {
            v23 * (100000 + v29) / 100000
        } else if (v29 < 100000) {
            v23 * (100000 - v29) / 100000
        } else {
            1
        };
        let v32 = v31 * (100000 - arg7) / 100000;
        let v33 = v31 * (100000 + arg8) / 100000;
        let (v34, v35, v36) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg3);
        let (v37, _, v39, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg3, 1, arg5);
        let v41 = v39;
        let v42 = v37;
        let v43 = if (0x1::vector::length<u64>(&v42) > 0) {
            *0x1::vector::borrow<u64>(&v42, 0)
        } else {
            0
        };
        let v44 = if (0x1::vector::length<u64>(&v41) > 0) {
            *0x1::vector::borrow<u64>(&v41, 0)
        } else {
            0
        };
        let v45 = false;
        let v46 = false;
        let v47 = v32;
        let v48 = v33;
        if (v44 > 0 && v32 >= v44) {
            v45 = true;
            v47 = v44 * (100000 - arg9) / 100000;
        };
        if (v43 > 0 && v33 <= v43) {
            v46 = true;
            v48 = v43 * (100000 + arg10) / 100000;
        };
        if (v45 || v46) {
            0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::events::emit_crossing_prevented(v1, v0, v45, v46, v32, v33, v47, v48, v43, v44, arg9, arg10);
        };
        let (v49, v50) = if (0x1::option::is_some<0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::OrderbookSnapshot>(&v22) && arg17 > 0) {
            let v51 = 0x1::option::borrow<0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::OrderbookSnapshot>(&v22);
            let (v52, v53) = 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::find_queue_snipe_price(v51, v47, true, v34, arg17);
            let v54 = if (v53) {
                1
            } else {
                0
            };
            let v55 = if (v53) {
                v52
            } else {
                0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orders::round_bid_price(v52, v34)
            };
            let v56 = 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orders::round_bid_price(v47, v34);
            let v57 = if (v55 > v56) {
                v55 - v56
            } else {
                v56 - v55
            };
            0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::events::emit_order_placement_decision(v1, v0, true, arg6, v6, v56, 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::significant_bid(v51), 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::significant_bid_qty(v51), v55, v57 / v34, v55 > v56, v54);
            let (v58, v59) = 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::find_queue_snipe_price(v51, v48, false, v34, arg17);
            let v60 = if (v59) {
                1
            } else {
                0
            };
            let v61 = if (v59) {
                v58
            } else {
                0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orders::round_ask_price(v58, v34)
            };
            let v62 = 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orders::round_ask_price(v48, v34);
            let v63 = if (v61 < v62) {
                v62 - v61
            } else {
                v61 - v62
            };
            0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::events::emit_order_placement_decision(v1, v0, false, arg6, v6, v62, 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::significant_ask(v51), 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::significant_ask_qty(v51), v61, v63 / v34, v61 < v62, v60);
            (v55, v61)
        } else {
            (0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orders::round_bid_price(v47, v34), 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orders::round_ask_price(v48, v34))
        };
        let (v64, v65) = if (0x1::option::is_some<0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::OrderbookSnapshot>(&v22)) {
            let v66 = 0x1::option::borrow<0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::OrderbookSnapshot>(&v22);
            let v67 = 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::best_bid(v66);
            let v68 = 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::best_ask(v66);
            let v69 = v49;
            let v70 = v50;
            if (v68 > 0 && v49 >= v68) {
                let v71 = if (v68 > v34) {
                    v68 - v34
                } else {
                    v34
                };
                v69 = v71;
                0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::events::emit_log_bytes(b"bid_clamped_filtered_book");
            };
            if (v67 > 0 && v50 <= v67) {
                v70 = v67 + v34;
                0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::events::emit_log_bytes(b"ask_clamped_filtered_book");
            };
            (v69, v70)
        } else {
            (v49, v50)
        };
        0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::events::emit_debug_pool_params(v34, v35, v36, v47, v48, v64, v65);
        let v72 = 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::config::enable_deep_payment(v3);
        let v73 = if (arg14 >= 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::config::min_order_size(v3)) {
            if (arg14 >= v36) {
                v64 >= 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::config::min_price(v3)
            } else {
                false
            }
        } else {
            false
        };
        let v74 = if (arg15 >= 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::config::min_order_size(v3)) {
            if (arg15 >= v36) {
                v65 <= 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::config::max_price(v3)
            } else {
                false
            }
        } else {
            false
        };
        if (!0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::config::is_dry_run(v3)) {
            if (0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::config::enable_deep_refill(v3)) {
                let (_, _) = 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::deep_manager::ensure_deep_balance<T0, T1, T2, T3>(arg3, arg4, arg2, &v9, arg14 + arg15, (v64 + v65) / 2, v3, arg5, arg22);
                0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::events::emit_log_bytes(b"step_16a_deep_ensured");
            };
            let v77 = false;
            let v78 = false;
            if (0x1::option::is_some<0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::ExistingOrderInfo>(&v13)) {
                let v79 = 0x1::option::borrow<0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::ExistingOrderInfo>(&v13);
                let v80 = 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::price(v79);
                let v81 = v80 != v64;
                let v82 = !v81 && 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::should_refresh_order(v79, v0, 30000);
                let v83 = v74 && v65 <= v80;
                let v84 = if (v81) {
                    true
                } else if (v82) {
                    true
                } else {
                    v83
                };
                if (v84) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v9, 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::order_id(v79), arg5, arg22);
                    v77 = true;
                    if (v83) {
                        0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::events::emit_log_bytes(b"bid_cancelled_would_cross_ask");
                    } else if (v81) {
                        0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::events::emit_log_bytes(b"bid_diff_price_replace");
                    } else {
                        0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::events::emit_log_bytes(b"bid_same_price_refresh");
                    };
                } else {
                    0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::events::emit_log_bytes(b"bid_same_price_keep");
                };
            };
            if (0x1::option::is_some<0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::ExistingOrderInfo>(&v12)) {
                let v85 = 0x1::option::borrow<0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::ExistingOrderInfo>(&v12);
                let v86 = 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::price(v85);
                let v87 = v86 != v65;
                let v88 = !v87 && 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::should_refresh_order(v85, v0, 30000);
                let v89 = v73 && v64 >= v86;
                let v90 = if (v87) {
                    true
                } else if (v88) {
                    true
                } else {
                    v89
                };
                if (v90) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v9, 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::order_id(v85), arg5, arg22);
                    v78 = true;
                    if (v89) {
                        0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::events::emit_log_bytes(b"ask_cancelled_would_cross_bid");
                    } else if (v87) {
                        0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::events::emit_log_bytes(b"ask_diff_price_replace");
                    } else {
                        0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::events::emit_log_bytes(b"ask_same_price_refresh");
                    };
                } else {
                    0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::events::emit_log_bytes(b"ask_same_price_keep");
                };
            };
            if (v73 && (!0x1::option::is_some<0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::ExistingOrderInfo>(&v13) || v77)) {
                let v91 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v9, arg13, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), v64, arg14, true, v72, arg12, arg5, arg22);
                0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::events::emit_post_only_order(v1, true, v64, arg14, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v91), v6, arg7, v0, arg13);
            };
            if (v74 && (!0x1::option::is_some<0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::orderbook_analyzer::ExistingOrderInfo>(&v12) || v78)) {
                let v92 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v9, arg13, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), v65, arg15, false, v72, arg12, arg5, arg22);
                0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::events::emit_post_only_order(v1, false, v65, arg15, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v92), v6, arg8, v0, arg13);
            };
        } else {
            0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::events::emit_log_bytes(b"dry_run_orders_skipped");
        };
        0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::events::emit_orders_placed(0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_state::state_id(arg0), v1, v64, arg14, v65, arg15, v0);
        let v93 = 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::config::target_base_position(v3);
        let v94 = if (v93 > 0) {
            if (v14 >= v93) {
                (v14 - v93) * 10000 / v93
            } else {
                (v93 - v14) * 10000 / v93
            }
        } else {
            0
        };
        0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::events::emit_execution_detail(0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_state::state_id(arg0), v1, arg11, 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_state::execution_count(arg0), v0, arg6, v6, v64, v65, v14, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), v93, v94, v14 > v93, arg7, arg8, arg14, arg15, 0, false, 0, arg13, v73, v74, v31, v24, v25, v29, v30);
        0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_state::record_order_time(arg0, v0);
    }

    public fun get_state_info(arg0: &0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_state::MMState) : (u64, u64, u64, bool) {
        (0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_state::current_price(arg0), 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_state::current_spread(arg0), 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_state::execution_count(arg0), 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_state::is_paused(arg0))
    }

    public fun pause_trading<T0, T1>(arg0: &mut 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_state::owner(arg0) == 0x2::tx_context::sender(arg5), 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v1, arg4, arg5);
        0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::events::emit_orders_cancelled(0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), v0);
        0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_state::pause(arg0, v0 + arg3, v0);
    }

    public fun resume_trading(arg0: &mut 0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_state::MMState, arg1: &0x2::tx_context::TxContext) {
        assert!(0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_state::owner(arg0) == 0x2::tx_context::sender(arg1), 1);
        0x14df6f1e839f7dec16510f120ddf859e97f2e717b9e9567797e7ebccd4587429::mm_state::unpause(arg0);
    }

    // decompiled from Move bytecode v6
}

