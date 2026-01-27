module 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::leva_deep_mm {
    public fun cancel_all_orders<T0, T1>(arg0: &0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_state::owner(arg0) == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg3, arg4);
        0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_orders_cancelled(0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg3));
    }

    public fun cancel_and_settle<T0, T1>(arg0: &0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_state::owner(arg0) == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg3, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg2, arg1, &v0);
        0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_orders_cancelled(0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg3));
    }

    public fun execute<T0, T1, T2, T3>(arg0: &mut 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_state::MMState, arg1: &0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_registry::MMRegistry, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: bool, arg19: u64, arg20: u64, arg21: bool, arg22: u64, arg23: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3);
        if (arg21) {
            let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg23);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg3, arg2, &v2, arg5, arg23);
            0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_orders_cancelled(0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_state::state_id(arg0), v1, v0);
            0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_log_bytes(b"cancel_only_executed");
            return
        };
        if (0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_state::is_trading_blocked(arg0, v0)) {
            0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_log_bytes(b"paused");
            return
        };
        let v3 = 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_registry::get_pool_config(arg1, v1);
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
        0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_state::update_price(arg0, v6, v8, arg11, v0);
        0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_execution(0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_state::state_id(arg0), v1, v6, v8, arg7 + arg8, arg11, 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_state::execution_count(arg0), v0);
        0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_state::record_execution(arg0);
        let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg23);
        let (v10, v11) = 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::get_existing_orders<T0, T1>(arg3, arg2, arg5);
        let v12 = v11;
        let v13 = v10;
        let v14 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v15 = 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::config::is_dry_run(v3);
        let v16 = if (0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::config::is_orderbook_analysis_enabled(v3)) {
            let v17 = 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::analyze_orderbook<T0, T1>(arg3, arg2, 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::config::min_significant_qty(v3), 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::config::l2_tick_count(v3), arg5);
            let v18 = if (0x1::vector::length<u64>(0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::bid_prices(&v17)) > 0) {
                *0x1::vector::borrow<u64>(0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::bid_prices(&v17), 0)
            } else {
                0
            };
            let v19 = if (0x1::vector::length<u64>(0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::ask_prices(&v17)) > 0) {
                *0x1::vector::borrow<u64>(0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::ask_prices(&v17), 0)
            } else {
                0
            };
            let v20 = if (v18 > 0) {
                if (v19 > 0) {
                    v19 > v18
                } else {
                    false
                }
            } else {
                false
            };
            let v21 = if (v20) {
                let v22 = (v18 + v19) / 2;
                if (v22 > 0) {
                    (v19 - v18) * 10000 / v22
                } else {
                    0
                }
            } else {
                0
            };
            0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_orderbook_analysis(v1, v0, 0x1::vector::length<u64>(0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::bid_prices(&v17)), 0x1::vector::length<u64>(0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::ask_prices(&v17)), v18, v19, v21, 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::own_bid_qty_filtered(&v17), 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::own_ask_qty_filtered(&v17), 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::own_orders_count(&v17), 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::best_bid(&v17), 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::best_ask(&v17), 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::spread_bps(&v17), 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::significant_bid(&v17), 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::significant_bid_qty(&v17), 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::significant_ask(&v17), 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::significant_ask_qty(&v17), 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::total_bid_depth(&v17), 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::total_ask_depth(&v17));
            0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_log_bytes(b"step_12b_orderbook_analyzed");
            0x1::option::some<0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::OrderbookSnapshot>(v17)
        } else {
            0x1::option::none<0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::OrderbookSnapshot>()
        };
        let v23 = v16;
        let v24 = if (arg18) {
            arg6
        } else {
            v6
        };
        let (v25, v26) = if (v6 >= arg6) {
            ((v6 - arg6) * 10000 / arg6, true)
        } else {
            ((arg6 - v6) * 10000 / arg6, false)
        };
        let v27 = arg20 * v25 / 1000;
        let (v28, v29) = if (arg19 >= 10000) {
            (arg19 - 10000, true)
        } else {
            (10000 - arg19, false)
        };
        let (v30, v31) = if (v29 && v26) {
            (v28 + v27, true)
        } else if (!v29 && !v26) {
            (v28 + v27, false)
        } else if (v29 && !v26) {
            if (v28 >= v27) {
                (v28 - v27, true)
            } else {
                (v27 - v28, false)
            }
        } else if (v27 >= v28) {
            (v27 - v28, true)
        } else {
            (v28 - v27, false)
        };
        let v32 = if (v31) {
            v24 * (100000 + v30) / 100000
        } else if (v30 < 100000) {
            v24 * (100000 - v30) / 100000
        } else {
            1
        };
        let v33 = v32 * (100000 - arg7) / 100000;
        let v34 = v32 * (100000 + arg8) / 100000;
        let (v35, v36, v37) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg3);
        let v38 = 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::config::enable_deep_payment(v3);
        let (v39, v40, v41, v42) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg3, 1, arg5);
        let v43 = v42;
        let v44 = v41;
        let v45 = v40;
        let v46 = v39;
        let v47 = if (0x1::vector::length<u64>(&v46) > 0) {
            *0x1::vector::borrow<u64>(&v46, 0)
        } else {
            0
        };
        let v48 = v47;
        let v49 = if (0x1::vector::length<u64>(&v44) > 0) {
            *0x1::vector::borrow<u64>(&v44, 0)
        } else {
            0
        };
        let v50 = v49;
        if (arg22 > 0 && !v15) {
            let v51 = if (v47 > 0) {
                if (v47 > arg6 * (100 + arg22) / 100) {
                    0x1::vector::length<u64>(&v45) > 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v51) {
                let v52 = arg6 / 2 / v35 * v35;
                let v53 = *0x1::vector::borrow<u64>(&v45, 0) / v36 * v36;
                if (v52 >= v35 && v53 >= v37) {
                    let v54 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v9, arg13 + 1000000, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), v52, v53, false, v38, arg12, arg5, arg23);
                    let v55 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v54);
                    let v56 = if (v55 > 0) {
                        (v47 - arg6) * v55 / 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling()
                    } else {
                        0
                    };
                    0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_mispricing_sweep(v1, v0, true, v47, arg6, v47 * 100 / arg6, v52, v53, v55, v56);
                };
            };
            let v57 = if (v49 > 0) {
                if (v49 < arg6 * 100 / (100 + arg22)) {
                    0x1::vector::length<u64>(&v43) > 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v57) {
                let v58 = (arg6 * 2 + v35 - 1) / v35 * v35;
                let v59 = *0x1::vector::borrow<u64>(&v43, 0) / v36 * v36;
                if (v59 >= v37) {
                    let v60 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v9, arg13 + 2000000, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), v58, v59, true, v38, arg12, arg5, arg23);
                    let v61 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v60);
                    let v62 = if (v61 > 0) {
                        (arg6 - v49) * v61 / 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling()
                    } else {
                        0
                    };
                    0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_mispricing_sweep(v1, v0, false, v49, arg6, arg6 * 100 / v49, v58, v59, v61, v62);
                };
            };
            let (v63, _, v65, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg3, 1, arg5);
            let v67 = v65;
            let v68 = v63;
            let v69 = if (0x1::vector::length<u64>(&v68) > 0) {
                *0x1::vector::borrow<u64>(&v68, 0)
            } else {
                0
            };
            v48 = v69;
            let v70 = if (0x1::vector::length<u64>(&v67) > 0) {
                *0x1::vector::borrow<u64>(&v67, 0)
            } else {
                0
            };
            v50 = v70;
        };
        let v71 = false;
        let v72 = false;
        let v73 = v33;
        let v74 = v34;
        if (v50 > 0 && v33 >= v50) {
            v71 = true;
            v73 = v50 * (100000 - arg9) / 100000;
        };
        if (v48 > 0 && v34 <= v48) {
            v72 = true;
            v74 = v48 * (100000 + arg10) / 100000;
        };
        if (v71 || v72) {
            0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_crossing_prevented(v1, v0, v71, v72, v33, v34, v73, v74, v48, v50, arg9, arg10);
        };
        let (v75, v76) = if (0x1::option::is_some<0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::OrderbookSnapshot>(&v23) && arg17 > 0) {
            let v77 = 0x1::option::borrow<0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::OrderbookSnapshot>(&v23);
            let (v78, v79) = 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::find_queue_snipe_price(v77, v73, true, v35, arg17);
            let v80 = if (v79) {
                1
            } else {
                0
            };
            let v81 = if (v79) {
                v78
            } else {
                0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orders::round_bid_price(v78, v35)
            };
            let v82 = 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orders::round_bid_price(v73, v35);
            let v83 = if (v81 > v82) {
                v81 - v82
            } else {
                v82 - v81
            };
            0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_order_placement_decision(v1, v0, true, arg6, v6, v82, 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::significant_bid(v77), 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::significant_bid_qty(v77), v81, v83 / v35, v81 > v82, v80);
            let (v84, v85) = 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::find_queue_snipe_price(v77, v74, false, v35, arg17);
            let v86 = if (v85) {
                1
            } else {
                0
            };
            let v87 = if (v85) {
                v84
            } else {
                0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orders::round_ask_price(v84, v35)
            };
            let v88 = 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orders::round_ask_price(v74, v35);
            let v89 = if (v87 < v88) {
                v88 - v87
            } else {
                v87 - v88
            };
            0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_order_placement_decision(v1, v0, false, arg6, v6, v88, 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::significant_ask(v77), 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::significant_ask_qty(v77), v87, v89 / v35, v87 < v88, v86);
            (v81, v87)
        } else {
            (0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orders::round_bid_price(v73, v35), 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orders::round_ask_price(v74, v35))
        };
        let (v90, v91) = if (0x1::option::is_some<0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::OrderbookSnapshot>(&v23)) {
            let v92 = 0x1::option::borrow<0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::OrderbookSnapshot>(&v23);
            let v93 = 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::best_bid(v92);
            let v94 = 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::best_ask(v92);
            let v95 = v75;
            let v96 = v76;
            if (v94 > 0 && v75 >= v94) {
                let v97 = if (v94 > v35) {
                    v94 - v35
                } else {
                    v35
                };
                v95 = v97;
                0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_log_bytes(b"bid_clamped_filtered_book");
            };
            if (v93 > 0 && v76 <= v93) {
                v96 = v93 + v35;
                0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_log_bytes(b"ask_clamped_filtered_book");
            };
            (v95, v96)
        } else {
            (v75, v76)
        };
        0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_debug_pool_params(v35, v36, v37, v73, v74, v90, v91);
        let v98 = if (arg14 >= 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::config::min_order_size(v3)) {
            if (arg14 >= v37) {
                v90 >= 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::config::min_price(v3)
            } else {
                false
            }
        } else {
            false
        };
        let v99 = if (arg15 >= 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::config::min_order_size(v3)) {
            if (arg15 >= v37) {
                v91 <= 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::config::max_price(v3)
            } else {
                false
            }
        } else {
            false
        };
        if (!v15) {
            if (0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::config::enable_deep_refill(v3)) {
                let (_, _) = 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::deep_manager::ensure_deep_balance<T0, T1, T2, T3>(arg3, arg4, arg2, &v9, arg14 + arg15, (v90 + v91) / 2, v3, arg5, arg23);
                0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_log_bytes(b"step_16a_deep_ensured");
            };
            let v102 = false;
            let v103 = false;
            if (0x1::option::is_some<0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::ExistingOrderInfo>(&v13)) {
                let v104 = 0x1::option::borrow<0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::ExistingOrderInfo>(&v13);
                let v105 = 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::price(v104);
                let v106 = v105 != v90;
                let v107 = !v106 && 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::should_refresh_order(v104, v0, 30000);
                let v108 = v99 && v91 <= v105;
                let v109 = if (v106) {
                    true
                } else if (v107) {
                    true
                } else {
                    v108
                };
                if (v109) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v9, 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::order_id(v104), arg5, arg23);
                    v102 = true;
                    if (v108) {
                        0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_log_bytes(b"bid_cancelled_would_cross_ask");
                    } else if (v106) {
                        0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_log_bytes(b"bid_diff_price_replace");
                    } else {
                        0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_log_bytes(b"bid_same_price_refresh");
                    };
                } else {
                    0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_log_bytes(b"bid_same_price_keep");
                };
            };
            if (0x1::option::is_some<0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::ExistingOrderInfo>(&v12)) {
                let v110 = 0x1::option::borrow<0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::ExistingOrderInfo>(&v12);
                let v111 = 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::price(v110);
                let v112 = v111 != v91;
                let v113 = !v112 && 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::should_refresh_order(v110, v0, 30000);
                let v114 = v98 && v90 >= v111;
                let v115 = if (v112) {
                    true
                } else if (v113) {
                    true
                } else {
                    v114
                };
                if (v115) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v9, 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::order_id(v110), arg5, arg23);
                    v103 = true;
                    if (v114) {
                        0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_log_bytes(b"ask_cancelled_would_cross_bid");
                    } else if (v112) {
                        0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_log_bytes(b"ask_diff_price_replace");
                    } else {
                        0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_log_bytes(b"ask_same_price_refresh");
                    };
                } else {
                    0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_log_bytes(b"ask_same_price_keep");
                };
            };
            if (v98 && (!0x1::option::is_some<0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::ExistingOrderInfo>(&v13) || v102)) {
                let v116 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v9, arg13, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), v90, arg14, true, v38, arg12, arg5, arg23);
                0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_post_only_order(v1, true, v90, arg14, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v116), v6, arg7, v0, arg13);
            };
            if (v99 && (!0x1::option::is_some<0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::orderbook_analyzer::ExistingOrderInfo>(&v12) || v103)) {
                let v117 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v9, arg13, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), v91, arg15, false, v38, arg12, arg5, arg23);
                0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_post_only_order(v1, false, v91, arg15, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v117), v6, arg8, v0, arg13);
            };
        } else {
            0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_log_bytes(b"dry_run_orders_skipped");
        };
        0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_orders_placed(0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_state::state_id(arg0), v1, v90, arg14, v91, arg15, v0);
        let v118 = 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::config::target_base_position(v3);
        let v119 = if (v118 > 0) {
            if (v14 >= v118) {
                (v14 - v118) * 10000 / v118
            } else {
                (v118 - v14) * 10000 / v118
            }
        } else {
            0
        };
        0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_execution_detail(0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_state::state_id(arg0), v1, arg11, 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_state::execution_count(arg0), v0, arg6, v6, v90, v91, v14, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), v118, v119, v14 > v118, arg7, arg8, arg14, arg15, 0, false, 0, arg13, v98, v99, v32, v25, v26, v30, v31);
        0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_state::record_order_time(arg0, v0);
    }

    public fun get_state_info(arg0: &0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_state::MMState) : (u64, u64, u64, bool) {
        (0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_state::current_price(arg0), 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_state::current_spread(arg0), 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_state::execution_count(arg0), 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_state::is_paused(arg0))
    }

    public fun pause_trading<T0, T1>(arg0: &mut 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_state::owner(arg0) == 0x2::tx_context::sender(arg5), 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v1, arg4, arg5);
        0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::events::emit_orders_cancelled(0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), v0);
        0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_state::pause(arg0, v0 + arg3, v0);
    }

    public fun resume_trading(arg0: &mut 0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_state::MMState, arg1: &0x2::tx_context::TxContext) {
        assert!(0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_state::owner(arg0) == 0x2::tx_context::sender(arg1), 1);
        0xdbff02f847f0d2125f2d3c3f45c333a10cbacb577098fda954b7b43fd6b888ee::mm_state::unpause(arg0);
    }

    // decompiled from Move bytecode v6
}

