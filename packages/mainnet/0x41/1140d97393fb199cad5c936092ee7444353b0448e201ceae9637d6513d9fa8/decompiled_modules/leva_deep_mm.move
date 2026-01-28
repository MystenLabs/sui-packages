module 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::leva_deep_mm {
    public fun cancel_all_orders<T0, T1>(arg0: &0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::owner(arg0) == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg3, arg4);
        0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_orders_cancelled(0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg3));
    }

    public fun cancel_and_settle<T0, T1>(arg0: &0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::owner(arg0) == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg3, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg2, arg1, &v0);
        0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_orders_cancelled(0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg3));
    }

    public fun execute<T0, T1, T2, T3>(arg0: &mut 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::MMState, arg1: &0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_registry::MMRegistry, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: bool, arg19: u64, arg20: u64, arg21: bool, arg22: u64, arg23: vector<u64>, arg24: vector<u64>, arg25: vector<u64>, arg26: vector<u64>, arg27: vector<u64>, arg28: u64, arg29: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3);
        if (arg21) {
            let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg29);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg3, arg2, &v2, arg5, arg29);
            0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_orders_cancelled(0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::state_id(arg0), v1, v0);
            0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_log_bytes(b"cancel_only_executed");
            return
        };
        if (0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::is_trading_blocked(arg0, v0)) {
            0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_log_bytes(b"paused");
            return
        };
        let v3 = 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_registry::get_pool_config(arg1, v1);
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
        0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::update_price(arg0, v6, v8, arg11, v0);
        0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_execution(0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::state_id(arg0), v1, v6, v8, arg7 + arg8, arg11, 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::execution_count(arg0), v0);
        0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::record_execution(arg0);
        let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg29);
        let (v10, v11) = 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::get_existing_orders<T0, T1>(arg3, arg2, arg5);
        let v12 = v11;
        let v13 = v10;
        let v14 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v15 = 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::config::is_dry_run(v3);
        let v16 = if (0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::config::is_orderbook_analysis_enabled(v3)) {
            let v17 = 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::analyze_orderbook<T0, T1>(arg3, arg2, 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::config::min_significant_qty(v3), 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::config::l2_tick_count(v3), arg5);
            let v18 = if (0x1::vector::length<u64>(0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::bid_prices(&v17)) > 0) {
                *0x1::vector::borrow<u64>(0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::bid_prices(&v17), 0)
            } else {
                0
            };
            let v19 = if (0x1::vector::length<u64>(0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::ask_prices(&v17)) > 0) {
                *0x1::vector::borrow<u64>(0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::ask_prices(&v17), 0)
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
            0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_orderbook_analysis(v1, v0, 0x1::vector::length<u64>(0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::bid_prices(&v17)), 0x1::vector::length<u64>(0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::ask_prices(&v17)), v18, v19, v21, 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::own_bid_qty_filtered(&v17), 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::own_ask_qty_filtered(&v17), 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::own_orders_count(&v17), 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::best_bid(&v17), 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::best_ask(&v17), 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::spread_bps(&v17), 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::significant_bid(&v17), 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::significant_bid_qty(&v17), 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::significant_ask(&v17), 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::significant_ask_qty(&v17), 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::total_bid_depth(&v17), 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::total_ask_depth(&v17));
            0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_log_bytes(b"step_12b_orderbook_analyzed");
            0x1::option::some<0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::OrderbookSnapshot>(v17)
        } else {
            0x1::option::none<0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::OrderbookSnapshot>()
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
        let v38 = 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::config::enable_deep_payment(v3);
        let (v39, _, v41, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg3, 1, arg5);
        let v43 = v41;
        let v44 = v39;
        let v45 = if (0x1::vector::length<u64>(&v44) > 0) {
            *0x1::vector::borrow<u64>(&v44, 0)
        } else {
            0
        };
        let v46 = v45;
        let v47 = if (0x1::vector::length<u64>(&v43) > 0) {
            *0x1::vector::borrow<u64>(&v43, 0)
        } else {
            0
        };
        let v48 = v47;
        let v49 = if (arg22 > 0) {
            if (!v15) {
                0x1::option::is_some<0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::OrderbookSnapshot>(&v23)
            } else {
                false
            }
        } else {
            false
        };
        if (v49) {
            let v50 = 0x1::option::borrow<0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::OrderbookSnapshot>(&v23);
            let v51 = 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::best_bid(v50);
            let v52 = 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::best_ask(v50);
            let v53 = arg6 * (100 + arg22) / 100;
            let v54 = arg6 * 100 / (100 + arg22);
            let v55 = v51 > 0 && v51 > v53;
            let v56 = v52 > 0 && v52 < v54;
            if (v55) {
                let v57 = v53 / v35 * v35;
                let v58 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2) / v36 * v36;
                if (v57 >= v35 && v58 >= v37) {
                    let v59 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v9, arg13 + 1000000, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), v57, v58, false, v38, arg12, arg5, arg29);
                    let v60 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v59);
                    let v61 = if (v60 > 0) {
                        (v51 - arg6) * v60 / 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling()
                    } else {
                        0
                    };
                    0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_mispricing_sweep(v1, v0, true, v51, arg6, v51 * 100 / arg6, v57, v58, v60, v61);
                };
            };
            if (v56) {
                let v62 = (v54 + v35 - 1) / v35 * v35;
                let v63 = if (v52 > 0) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2) * 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() / v52
                } else {
                    0
                };
                let v64 = v63 / v36 * v36;
                if (v64 >= v37) {
                    let v65 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v9, arg13 + 2000000, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), v62, v64, true, v38, arg12, arg5, arg29);
                    let v66 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v65);
                    let v67 = if (v66 > 0) {
                        (arg6 - v52) * v66 / 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling()
                    } else {
                        0
                    };
                    0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_mispricing_sweep(v1, v0, false, v52, arg6, arg6 * 100 / v52, v62, v64, v66, v67);
                };
            };
            let (v68, _, v70, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg3, 1, arg5);
            let v72 = v70;
            let v73 = v68;
            let v74 = if (0x1::vector::length<u64>(&v73) > 0) {
                *0x1::vector::borrow<u64>(&v73, 0)
            } else {
                0
            };
            v46 = v74;
            let v75 = if (0x1::vector::length<u64>(&v72) > 0) {
                *0x1::vector::borrow<u64>(&v72, 0)
            } else {
                0
            };
            v48 = v75;
        };
        if (0x1::vector::length<u64>(&arg23) > 0) {
            let v76 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
            let v77 = 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::config::target_base_position(v3);
            let v78 = if (v77 > 0) {
                if (v76 >= v77) {
                    (v76 - v77) * 10000 / v77
                } else {
                    (v77 - v76) * 10000 / v77
                }
            } else {
                0
            };
            let v79 = *0x1::vector::borrow<u64>(&arg23, 0);
            let v80 = *0x1::vector::borrow<u64>(&arg24, 0);
            0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_execution_detail(0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::state_id(arg0), v1, arg11, 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::execution_count(arg0), v0, arg6, v6, 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orders::round_bid_price(v32 * (100000 - v79) / 100000, v35), 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orders::round_ask_price(v32 * (100000 + v80) / 100000, v35), v76, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), v77, v78, v76 > v77, v79, v80, *0x1::vector::borrow<u64>(&arg25, 0), *0x1::vector::borrow<u64>(&arg26, 0), 0, false, 0, arg13, true, true, v32, v25, v26, v30, v31);
            0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::multi_layer::process_layers<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, v32, arg9, arg10, arg13, arg12, &arg23, &arg24, &arg25, &arg26, &arg27, arg28, &v9, v3, v35, v37, v46, v48, arg29);
            return
        };
        let v81 = false;
        let v82 = false;
        let v83 = v33;
        let v84 = v34;
        if (v48 > 0 && v33 >= v48) {
            v81 = true;
            v83 = v48 * (100000 - arg9) / 100000;
        };
        if (v46 > 0 && v34 <= v46) {
            v82 = true;
            v84 = v46 * (100000 + arg10) / 100000;
        };
        if (v81 || v82) {
            0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_crossing_prevented(v1, v0, v81, v82, v33, v34, v83, v84, v46, v48, arg9, arg10);
        };
        let (v85, v86) = if (0x1::option::is_some<0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::OrderbookSnapshot>(&v23) && arg17 > 0) {
            let v87 = 0x1::option::borrow<0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::OrderbookSnapshot>(&v23);
            let (v88, v89) = 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::find_queue_snipe_price(v87, v83, true, v35, arg17);
            let v90 = if (v89) {
                1
            } else {
                0
            };
            let v91 = if (v89) {
                v88
            } else {
                0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orders::round_bid_price(v88, v35)
            };
            let v92 = 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orders::round_bid_price(v83, v35);
            let v93 = if (v91 > v92) {
                v91 - v92
            } else {
                v92 - v91
            };
            0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_order_placement_decision(v1, v0, true, arg6, v6, v92, 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::significant_bid(v87), 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::significant_bid_qty(v87), v91, v93 / v35, v91 > v92, v90);
            let (v94, v95) = 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::find_queue_snipe_price(v87, v84, false, v35, arg17);
            let v96 = if (v95) {
                1
            } else {
                0
            };
            let v97 = if (v95) {
                v94
            } else {
                0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orders::round_ask_price(v94, v35)
            };
            let v98 = 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orders::round_ask_price(v84, v35);
            let v99 = if (v97 < v98) {
                v98 - v97
            } else {
                v97 - v98
            };
            0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_order_placement_decision(v1, v0, false, arg6, v6, v98, 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::significant_ask(v87), 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::significant_ask_qty(v87), v97, v99 / v35, v97 < v98, v96);
            (v91, v97)
        } else {
            (0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orders::round_bid_price(v83, v35), 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orders::round_ask_price(v84, v35))
        };
        let (v100, v101) = if (0x1::option::is_some<0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::OrderbookSnapshot>(&v23)) {
            let v102 = 0x1::option::borrow<0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::OrderbookSnapshot>(&v23);
            let v103 = 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::best_bid(v102);
            let v104 = 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::best_ask(v102);
            let v105 = v85;
            let v106 = v86;
            if (v104 > 0 && v85 >= v104) {
                let v107 = if (v104 > v35) {
                    v104 - v35
                } else {
                    v35
                };
                v105 = v107;
                0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_log_bytes(b"bid_clamped_filtered_book");
            };
            if (v103 > 0 && v86 <= v103) {
                v106 = v103 + v35;
                0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_log_bytes(b"ask_clamped_filtered_book");
            };
            (v105, v106)
        } else {
            (v85, v86)
        };
        0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_debug_pool_params(v35, v36, v37, v83, v84, v100, v101);
        let v108 = if (arg14 >= 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::config::min_order_size(v3)) {
            if (arg14 >= v37) {
                v100 >= 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::config::min_price(v3)
            } else {
                false
            }
        } else {
            false
        };
        let v109 = if (arg15 >= 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::config::min_order_size(v3)) {
            if (arg15 >= v37) {
                v101 <= 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::config::max_price(v3)
            } else {
                false
            }
        } else {
            false
        };
        if (!v15) {
            if (0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::config::enable_deep_refill(v3)) {
                let (_, _) = 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::deep_manager::ensure_deep_balance<T0, T1, T2, T3>(arg3, arg4, arg2, &v9, arg14 + arg15, (v100 + v101) / 2, v3, arg5, arg29);
                0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_log_bytes(b"step_16a_deep_ensured");
            };
            let v112 = false;
            let v113 = false;
            if (0x1::option::is_some<0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::ExistingOrderInfo>(&v13)) {
                let v114 = 0x1::option::borrow<0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::ExistingOrderInfo>(&v13);
                let v115 = 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::price(v114);
                let v116 = v115 != v100;
                let v117 = !v116 && 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::should_refresh_order(v114, v0, 30000);
                let v118 = v109 && v101 <= v115;
                let v119 = if (v116) {
                    true
                } else if (v117) {
                    true
                } else {
                    v118
                };
                if (v119) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v9, 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::order_id(v114), arg5, arg29);
                    v112 = true;
                    if (v118) {
                        0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_log_bytes(b"bid_cancelled_would_cross_ask");
                    } else if (v116) {
                        0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_log_bytes(b"bid_diff_price_replace");
                    } else {
                        0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_log_bytes(b"bid_same_price_refresh");
                    };
                } else {
                    0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_log_bytes(b"bid_same_price_keep");
                };
            };
            if (0x1::option::is_some<0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::ExistingOrderInfo>(&v12)) {
                let v120 = 0x1::option::borrow<0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::ExistingOrderInfo>(&v12);
                let v121 = 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::price(v120);
                let v122 = v121 != v101;
                let v123 = !v122 && 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::should_refresh_order(v120, v0, 30000);
                let v124 = v108 && v100 >= v121;
                let v125 = if (v122) {
                    true
                } else if (v123) {
                    true
                } else {
                    v124
                };
                if (v125) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v9, 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::order_id(v120), arg5, arg29);
                    v113 = true;
                    if (v124) {
                        0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_log_bytes(b"ask_cancelled_would_cross_bid");
                    } else if (v122) {
                        0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_log_bytes(b"ask_diff_price_replace");
                    } else {
                        0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_log_bytes(b"ask_same_price_refresh");
                    };
                } else {
                    0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_log_bytes(b"ask_same_price_keep");
                };
            };
            if (v108 && (!0x1::option::is_some<0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::ExistingOrderInfo>(&v13) || v112)) {
                let v126 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v9, arg13, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v100, arg14, true, v38, arg12, arg5, arg29);
                0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_post_only_order(v1, true, v100, arg14, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v126), v6, arg7, v0, arg13);
            };
            if (v109 && (!0x1::option::is_some<0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::orderbook_analyzer::ExistingOrderInfo>(&v12) || v113)) {
                let v127 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v9, arg13, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v101, arg15, false, v38, arg12, arg5, arg29);
                0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_post_only_order(v1, false, v101, arg15, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v127), v6, arg8, v0, arg13);
            };
        } else {
            0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_log_bytes(b"dry_run_orders_skipped");
        };
        0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_orders_placed(0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::state_id(arg0), v1, v100, arg14, v101, arg15, v0);
        let v128 = 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::config::target_base_position(v3);
        let v129 = if (v128 > 0) {
            if (v14 >= v128) {
                (v14 - v128) * 10000 / v128
            } else {
                (v128 - v14) * 10000 / v128
            }
        } else {
            0
        };
        0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_execution_detail(0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::state_id(arg0), v1, arg11, 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::execution_count(arg0), v0, arg6, v6, v100, v101, v14, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), v128, v129, v14 > v128, arg7, arg8, arg14, arg15, 0, false, 0, arg13, v108, v109, v32, v25, v26, v30, v31);
        0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::record_order_time(arg0, v0);
    }

    public fun get_state_info(arg0: &0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::MMState) : (u64, u64, u64, bool) {
        (0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::current_price(arg0), 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::current_spread(arg0), 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::execution_count(arg0), 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::is_paused(arg0))
    }

    public fun pause_trading<T0, T1>(arg0: &mut 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::owner(arg0) == 0x2::tx_context::sender(arg5), 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v1, arg4, arg5);
        0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::events::emit_orders_cancelled(0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), v0);
        0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::pause(arg0, v0 + arg3, v0);
    }

    public fun resume_trading(arg0: &mut 0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::MMState, arg1: &0x2::tx_context::TxContext) {
        assert!(0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::owner(arg0) == 0x2::tx_context::sender(arg1), 1);
        0x411140d97393fb199cad5c936092ee7444353b0448e201ceae9637d6513d9fa8::mm_state::unpause(arg0);
    }

    // decompiled from Move bytecode v6
}

