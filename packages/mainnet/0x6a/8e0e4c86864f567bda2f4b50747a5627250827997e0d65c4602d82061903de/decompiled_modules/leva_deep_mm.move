module 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::leva_deep_mm {
    public fun cancel_all_orders<T0, T1>(arg0: &0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_state::owner(arg0) == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg3, arg4);
        0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_orders_cancelled(0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg3));
    }

    public fun cancel_and_settle<T0, T1>(arg0: &0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_state::owner(arg0) == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg3, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg2, arg1, &v0);
        0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_orders_cancelled(0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg3));
    }

    public fun execute<T0, T1, T2, T3>(arg0: &mut 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_state::MMState, arg1: &0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_registry::MMRegistry, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: bool, arg19: u64, arg20: u64, arg21: bool, arg22: u64, arg23: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3);
        if (arg21) {
            let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg23);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg3, arg2, &v2, arg5, arg23);
            0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_orders_cancelled(0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_state::state_id(arg0), v1, v0);
            0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_log_bytes(b"cancel_only_executed");
            return
        };
        if (0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_state::is_trading_blocked(arg0, v0)) {
            0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_log_bytes(b"paused");
            return
        };
        let v3 = 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_registry::get_pool_config(arg1, v1);
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
        0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_state::update_price(arg0, v6, v8, arg11, v0);
        0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_execution(0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_state::state_id(arg0), v1, v6, v8, arg7 + arg8, arg11, 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_state::execution_count(arg0), v0);
        0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_state::record_execution(arg0);
        let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg23);
        let (v10, v11) = 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::get_existing_orders<T0, T1>(arg3, arg2, arg5);
        let v12 = v11;
        let v13 = v10;
        let v14 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v15 = 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::config::is_dry_run(v3);
        let v16 = if (0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::config::is_orderbook_analysis_enabled(v3)) {
            let v17 = 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::analyze_orderbook<T0, T1>(arg3, arg2, 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::config::min_significant_qty(v3), 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::config::l2_tick_count(v3), arg5);
            let v18 = if (0x1::vector::length<u64>(0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::bid_prices(&v17)) > 0) {
                *0x1::vector::borrow<u64>(0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::bid_prices(&v17), 0)
            } else {
                0
            };
            let v19 = if (0x1::vector::length<u64>(0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::ask_prices(&v17)) > 0) {
                *0x1::vector::borrow<u64>(0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::ask_prices(&v17), 0)
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
            0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_orderbook_analysis(v1, v0, 0x1::vector::length<u64>(0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::bid_prices(&v17)), 0x1::vector::length<u64>(0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::ask_prices(&v17)), v18, v19, v21, 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::own_bid_qty_filtered(&v17), 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::own_ask_qty_filtered(&v17), 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::own_orders_count(&v17), 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::best_bid(&v17), 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::best_ask(&v17), 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::spread_bps(&v17), 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::significant_bid(&v17), 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::significant_bid_qty(&v17), 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::significant_ask(&v17), 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::significant_ask_qty(&v17), 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::total_bid_depth(&v17), 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::total_ask_depth(&v17));
            0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_log_bytes(b"step_12b_orderbook_analyzed");
            0x1::option::some<0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::OrderbookSnapshot>(v17)
        } else {
            0x1::option::none<0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::OrderbookSnapshot>()
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
        let v38 = 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::config::enable_deep_payment(v3);
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
            let v51 = arg6 * (100 + arg22) / 100;
            let v52 = if (v47 > 0) {
                if (v47 > v51) {
                    0x1::vector::length<u64>(&v45) > 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v52) {
                let v53 = v51 / v35 * v35;
                let v54 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2) / v36 * v36;
                if (v53 >= v35 && v54 >= v37) {
                    let v55 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v9, arg13 + 1000000, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), v53, v54, false, v38, arg12, arg5, arg23);
                    let v56 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v55);
                    let v57 = if (v56 > 0) {
                        (v47 - arg6) * v56 / 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling()
                    } else {
                        0
                    };
                    0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_mispricing_sweep(v1, v0, true, v47, arg6, v47 * 100 / arg6, v53, v54, v56, v57);
                };
            };
            let v58 = arg6 * 100 / (100 + arg22);
            let v59 = if (v49 > 0) {
                if (v49 < v58) {
                    0x1::vector::length<u64>(&v43) > 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v59) {
                let v60 = (v58 + v35 - 1) / v35 * v35;
                let v61 = if (v49 > 0) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2) * 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() / v49
                } else {
                    0
                };
                let v62 = v61 / v36 * v36;
                if (v62 >= v37) {
                    let v63 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v9, arg13 + 2000000, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), v60, v62, true, v38, arg12, arg5, arg23);
                    let v64 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v63);
                    let v65 = if (v64 > 0) {
                        (arg6 - v49) * v64 / 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling()
                    } else {
                        0
                    };
                    0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_mispricing_sweep(v1, v0, false, v49, arg6, arg6 * 100 / v49, v60, v62, v64, v65);
                };
            };
            let (v66, _, v68, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg3, 1, arg5);
            let v70 = v68;
            let v71 = v66;
            let v72 = if (0x1::vector::length<u64>(&v71) > 0) {
                *0x1::vector::borrow<u64>(&v71, 0)
            } else {
                0
            };
            v48 = v72;
            let v73 = if (0x1::vector::length<u64>(&v70) > 0) {
                *0x1::vector::borrow<u64>(&v70, 0)
            } else {
                0
            };
            v50 = v73;
        };
        let v74 = false;
        let v75 = false;
        let v76 = v33;
        let v77 = v34;
        if (v50 > 0 && v33 >= v50) {
            v74 = true;
            v76 = v50 * (100000 - arg9) / 100000;
        };
        if (v48 > 0 && v34 <= v48) {
            v75 = true;
            v77 = v48 * (100000 + arg10) / 100000;
        };
        if (v74 || v75) {
            0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_crossing_prevented(v1, v0, v74, v75, v33, v34, v76, v77, v48, v50, arg9, arg10);
        };
        let (v78, v79) = if (0x1::option::is_some<0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::OrderbookSnapshot>(&v23) && arg17 > 0) {
            let v80 = 0x1::option::borrow<0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::OrderbookSnapshot>(&v23);
            let (v81, v82) = 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::find_queue_snipe_price(v80, v76, true, v35, arg17);
            let v83 = if (v82) {
                1
            } else {
                0
            };
            let v84 = if (v82) {
                v81
            } else {
                0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orders::round_bid_price(v81, v35)
            };
            let v85 = 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orders::round_bid_price(v76, v35);
            let v86 = if (v84 > v85) {
                v84 - v85
            } else {
                v85 - v84
            };
            0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_order_placement_decision(v1, v0, true, arg6, v6, v85, 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::significant_bid(v80), 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::significant_bid_qty(v80), v84, v86 / v35, v84 > v85, v83);
            let (v87, v88) = 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::find_queue_snipe_price(v80, v77, false, v35, arg17);
            let v89 = if (v88) {
                1
            } else {
                0
            };
            let v90 = if (v88) {
                v87
            } else {
                0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orders::round_ask_price(v87, v35)
            };
            let v91 = 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orders::round_ask_price(v77, v35);
            let v92 = if (v90 < v91) {
                v91 - v90
            } else {
                v90 - v91
            };
            0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_order_placement_decision(v1, v0, false, arg6, v6, v91, 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::significant_ask(v80), 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::significant_ask_qty(v80), v90, v92 / v35, v90 < v91, v89);
            (v84, v90)
        } else {
            (0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orders::round_bid_price(v76, v35), 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orders::round_ask_price(v77, v35))
        };
        let (v93, v94) = if (0x1::option::is_some<0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::OrderbookSnapshot>(&v23)) {
            let v95 = 0x1::option::borrow<0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::OrderbookSnapshot>(&v23);
            let v96 = 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::best_bid(v95);
            let v97 = 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::best_ask(v95);
            let v98 = v78;
            let v99 = v79;
            if (v97 > 0 && v78 >= v97) {
                let v100 = if (v97 > v35) {
                    v97 - v35
                } else {
                    v35
                };
                v98 = v100;
                0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_log_bytes(b"bid_clamped_filtered_book");
            };
            if (v96 > 0 && v79 <= v96) {
                v99 = v96 + v35;
                0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_log_bytes(b"ask_clamped_filtered_book");
            };
            (v98, v99)
        } else {
            (v78, v79)
        };
        0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_debug_pool_params(v35, v36, v37, v76, v77, v93, v94);
        let v101 = if (arg14 >= 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::config::min_order_size(v3)) {
            if (arg14 >= v37) {
                v93 >= 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::config::min_price(v3)
            } else {
                false
            }
        } else {
            false
        };
        let v102 = if (arg15 >= 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::config::min_order_size(v3)) {
            if (arg15 >= v37) {
                v94 <= 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::config::max_price(v3)
            } else {
                false
            }
        } else {
            false
        };
        if (!v15) {
            if (0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::config::enable_deep_refill(v3)) {
                let (_, _) = 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::deep_manager::ensure_deep_balance<T0, T1, T2, T3>(arg3, arg4, arg2, &v9, arg14 + arg15, (v93 + v94) / 2, v3, arg5, arg23);
                0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_log_bytes(b"step_16a_deep_ensured");
            };
            let v105 = false;
            let v106 = false;
            if (0x1::option::is_some<0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::ExistingOrderInfo>(&v13)) {
                let v107 = 0x1::option::borrow<0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::ExistingOrderInfo>(&v13);
                let v108 = 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::price(v107);
                let v109 = v108 != v93;
                let v110 = !v109 && 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::should_refresh_order(v107, v0, 30000);
                let v111 = v102 && v94 <= v108;
                let v112 = if (v109) {
                    true
                } else if (v110) {
                    true
                } else {
                    v111
                };
                if (v112) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v9, 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::order_id(v107), arg5, arg23);
                    v105 = true;
                    if (v111) {
                        0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_log_bytes(b"bid_cancelled_would_cross_ask");
                    } else if (v109) {
                        0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_log_bytes(b"bid_diff_price_replace");
                    } else {
                        0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_log_bytes(b"bid_same_price_refresh");
                    };
                } else {
                    0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_log_bytes(b"bid_same_price_keep");
                };
            };
            if (0x1::option::is_some<0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::ExistingOrderInfo>(&v12)) {
                let v113 = 0x1::option::borrow<0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::ExistingOrderInfo>(&v12);
                let v114 = 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::price(v113);
                let v115 = v114 != v94;
                let v116 = !v115 && 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::should_refresh_order(v113, v0, 30000);
                let v117 = v101 && v93 >= v114;
                let v118 = if (v115) {
                    true
                } else if (v116) {
                    true
                } else {
                    v117
                };
                if (v118) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v9, 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::order_id(v113), arg5, arg23);
                    v106 = true;
                    if (v117) {
                        0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_log_bytes(b"ask_cancelled_would_cross_bid");
                    } else if (v115) {
                        0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_log_bytes(b"ask_diff_price_replace");
                    } else {
                        0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_log_bytes(b"ask_same_price_refresh");
                    };
                } else {
                    0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_log_bytes(b"ask_same_price_keep");
                };
            };
            if (v101 && (!0x1::option::is_some<0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::ExistingOrderInfo>(&v13) || v105)) {
                let v119 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v9, arg13, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), v93, arg14, true, v38, arg12, arg5, arg23);
                0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_post_only_order(v1, true, v93, arg14, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v119), v6, arg7, v0, arg13);
            };
            if (v102 && (!0x1::option::is_some<0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::orderbook_analyzer::ExistingOrderInfo>(&v12) || v106)) {
                let v120 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v9, arg13, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), v94, arg15, false, v38, arg12, arg5, arg23);
                0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_post_only_order(v1, false, v94, arg15, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v120), v6, arg8, v0, arg13);
            };
        } else {
            0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_log_bytes(b"dry_run_orders_skipped");
        };
        0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_orders_placed(0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_state::state_id(arg0), v1, v93, arg14, v94, arg15, v0);
        let v121 = 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::config::target_base_position(v3);
        let v122 = if (v121 > 0) {
            if (v14 >= v121) {
                (v14 - v121) * 10000 / v121
            } else {
                (v121 - v14) * 10000 / v121
            }
        } else {
            0
        };
        0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_execution_detail(0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_state::state_id(arg0), v1, arg11, 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_state::execution_count(arg0), v0, arg6, v6, v93, v94, v14, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), v121, v122, v14 > v121, arg7, arg8, arg14, arg15, 0, false, 0, arg13, v101, v102, v32, v25, v26, v30, v31);
        0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_state::record_order_time(arg0, v0);
    }

    public fun get_state_info(arg0: &0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_state::MMState) : (u64, u64, u64, bool) {
        (0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_state::current_price(arg0), 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_state::current_spread(arg0), 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_state::execution_count(arg0), 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_state::is_paused(arg0))
    }

    public fun pause_trading<T0, T1>(arg0: &mut 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_state::owner(arg0) == 0x2::tx_context::sender(arg5), 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v1, arg4, arg5);
        0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::events::emit_orders_cancelled(0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), v0);
        0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_state::pause(arg0, v0 + arg3, v0);
    }

    public fun resume_trading(arg0: &mut 0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_state::MMState, arg1: &0x2::tx_context::TxContext) {
        assert!(0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_state::owner(arg0) == 0x2::tx_context::sender(arg1), 1);
        0x6a8e0e4c86864f567bda2f4b50747a5627250827997e0d65c4602d82061903de::mm_state::unpause(arg0);
    }

    // decompiled from Move bytecode v6
}

