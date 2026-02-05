module 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::leva_deep_mm {
    public fun cancel_all_orders<T0, T1>(arg0: &0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::owner(arg0) == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg3, arg4);
        0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_orders_cancelled(0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg3));
    }

    public fun cancel_and_settle<T0, T1>(arg0: &0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::owner(arg0) == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg3, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg2, arg1, &v0);
        0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_orders_cancelled(0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg3));
    }

    public fun execute<T0, T1, T2, T3>(arg0: &mut 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::MMState, arg1: &0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_registry::MMRegistry, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: bool, arg19: u64, arg20: u64, arg21: bool, arg22: bool, arg23: u64, arg24: u64, arg25: u64, arg26: vector<u64>, arg27: vector<u64>, arg28: vector<u64>, arg29: vector<u64>, arg30: vector<u64>, arg31: u64, arg32: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3);
        if (arg21) {
            let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg32);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg3, arg2, &v2, arg5, arg32);
            0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_orders_cancelled(0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::state_id(arg0), v1, v0);
            0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_log_bytes(b"cancel_only_executed");
            return
        };
        if (0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::is_trading_blocked(arg0, v0)) {
            0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_log_bytes(b"paused");
            return
        };
        let v3 = 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_registry::get_pool_config(arg1, v1);
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
        0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::update_price(arg0, v6, v8, arg11, v0);
        0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_execution(0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::state_id(arg0), v1, v6, v8, arg7 + arg8, arg11, 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::execution_count(arg0), v0);
        0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::record_execution(arg0);
        let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg32);
        let (v10, v11) = 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::get_existing_orders<T0, T1>(arg3, arg2, arg5);
        let v12 = v11;
        let v13 = v10;
        let v14 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v15 = 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::config::is_dry_run(v3);
        let v16 = if (0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::config::is_orderbook_analysis_enabled(v3)) {
            let v17 = 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::analyze_orderbook<T0, T1>(arg3, arg2, 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::config::min_significant_qty(v3), 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::config::l2_tick_count(v3), arg5);
            let v18 = if (0x1::vector::length<u64>(0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::bid_prices(&v17)) > 0) {
                *0x1::vector::borrow<u64>(0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::bid_prices(&v17), 0)
            } else {
                0
            };
            let v19 = if (0x1::vector::length<u64>(0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::ask_prices(&v17)) > 0) {
                *0x1::vector::borrow<u64>(0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::ask_prices(&v17), 0)
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
            0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_orderbook_analysis(v1, v0, 0x1::vector::length<u64>(0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::bid_prices(&v17)), 0x1::vector::length<u64>(0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::ask_prices(&v17)), v18, v19, v21, 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::own_bid_qty_filtered(&v17), 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::own_ask_qty_filtered(&v17), 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::own_orders_count(&v17), 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::best_bid(&v17), 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::best_ask(&v17), 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::spread_bps(&v17), 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::significant_bid(&v17), 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::significant_bid_qty(&v17), 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::significant_ask(&v17), 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::significant_ask_qty(&v17), 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::total_bid_depth(&v17), 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::total_ask_depth(&v17));
            0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_log_bytes(b"step_12b_orderbook_analyzed");
            0x1::option::some<0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::OrderbookSnapshot>(v17)
        } else {
            0x1::option::none<0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::OrderbookSnapshot>()
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
        let v38 = 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::config::enable_deep_payment(v3);
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
        let v49 = if (arg22) {
            if (!v15) {
                arg25 >= v37
            } else {
                false
            }
        } else {
            false
        };
        if (v49) {
            let v50 = arg25 / v36 * v36;
            if (v50 >= v37) {
                let v51 = 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orders::round_bid_price(v32 * (100000 - arg23) / 100000, v35);
                if (v51 >= v35) {
                    let v52 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v9, arg13 + 3000000, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v51, v50, true, v38, arg12, arg5, arg32);
                    let v53 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v52);
                    let v54 = if (v53 > 0) {
                        arg23
                    } else {
                        0
                    };
                    0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_taker_order(v1, v0, true, v51, v50, v53, v32, arg23, v54, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v52));
                    if (v53 > 0) {
                        0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_log_bytes(b"taker_bid_filled");
                    };
                };
                let v55 = 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orders::round_ask_price(v32 * (100000 + arg24) / 100000, v35);
                let v56 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v9, arg13 + 4000000, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v55, v50, false, v38, arg12, arg5, arg32);
                let v57 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v56);
                let v58 = if (v57 > 0) {
                    arg24
                } else {
                    0
                };
                0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_taker_order(v1, v0, false, v55, v50, v57, v32, arg24, v58, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v56));
                if (v57 > 0) {
                    0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_log_bytes(b"taker_ask_filled");
                };
            };
            let (v59, _, v61, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg3, 1, arg5);
            let v63 = v61;
            let v64 = v59;
            let v65 = if (0x1::vector::length<u64>(&v64) > 0) {
                *0x1::vector::borrow<u64>(&v64, 0)
            } else {
                0
            };
            v46 = v65;
            let v66 = if (0x1::vector::length<u64>(&v63) > 0) {
                *0x1::vector::borrow<u64>(&v63, 0)
            } else {
                0
            };
            v48 = v66;
        };
        if (0x1::vector::length<u64>(&arg26) > 0) {
            let v67 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
            let v68 = 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::config::target_base_position(v3);
            let v69 = if (v68 > 0) {
                if (v67 >= v68) {
                    (v67 - v68) * 10000 / v68
                } else {
                    (v68 - v67) * 10000 / v68
                }
            } else {
                0
            };
            let v70 = *0x1::vector::borrow<u64>(&arg26, 0);
            let v71 = *0x1::vector::borrow<u64>(&arg27, 0);
            0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_execution_detail(0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::state_id(arg0), v1, arg11, 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::execution_count(arg0), v0, arg6, v6, 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orders::round_bid_price(v32 * (100000 - v70) / 100000, v35), 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orders::round_ask_price(v32 * (100000 + v71) / 100000, v35), v67, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), v68, v69, v67 > v68, v70, v71, *0x1::vector::borrow<u64>(&arg28, 0), *0x1::vector::borrow<u64>(&arg29, 0), 0, false, 0, arg13, true, true, v32, v25, v26, v30, v31);
            0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::multi_layer::process_layers<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, v32, arg9, arg10, arg13, arg12, &arg26, &arg27, &arg28, &arg29, &arg30, arg31, &v9, v3, v35, v37, v46, v48, arg32);
            return
        };
        let v72 = false;
        let v73 = false;
        let v74 = v33;
        let v75 = v34;
        if (v48 > 0 && v33 >= v48) {
            v72 = true;
            v74 = v48 * (100000 - arg9) / 100000;
        };
        if (v46 > 0 && v34 <= v46) {
            v73 = true;
            v75 = v46 * (100000 + arg10) / 100000;
        };
        if (v72 || v73) {
            0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_crossing_prevented(v1, v0, v72, v73, v33, v34, v74, v75, v46, v48, arg9, arg10);
        };
        let (v76, v77) = if (0x1::option::is_some<0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::OrderbookSnapshot>(&v23) && arg17 > 0) {
            let v78 = 0x1::option::borrow<0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::OrderbookSnapshot>(&v23);
            let (v79, v80) = 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::find_queue_snipe_price(v78, v74, true, v35, arg17);
            let v81 = if (v80) {
                1
            } else {
                0
            };
            let v82 = if (v80) {
                v79
            } else {
                0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orders::round_bid_price(v79, v35)
            };
            let v83 = 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orders::round_bid_price(v74, v35);
            let v84 = if (v82 > v83) {
                v82 - v83
            } else {
                v83 - v82
            };
            0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_order_placement_decision(v1, v0, true, arg6, v6, v83, 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::significant_bid(v78), 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::significant_bid_qty(v78), v82, v84 / v35, v82 > v83, v81);
            let (v85, v86) = 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::find_queue_snipe_price(v78, v75, false, v35, arg17);
            let v87 = if (v86) {
                1
            } else {
                0
            };
            let v88 = if (v86) {
                v85
            } else {
                0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orders::round_ask_price(v85, v35)
            };
            let v89 = 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orders::round_ask_price(v75, v35);
            let v90 = if (v88 < v89) {
                v89 - v88
            } else {
                v88 - v89
            };
            0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_order_placement_decision(v1, v0, false, arg6, v6, v89, 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::significant_ask(v78), 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::significant_ask_qty(v78), v88, v90 / v35, v88 < v89, v87);
            (v82, v88)
        } else {
            (0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orders::round_bid_price(v74, v35), 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orders::round_ask_price(v75, v35))
        };
        let (v91, v92) = if (0x1::option::is_some<0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::OrderbookSnapshot>(&v23)) {
            let v93 = 0x1::option::borrow<0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::OrderbookSnapshot>(&v23);
            let v94 = 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::best_bid(v93);
            let v95 = 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::best_ask(v93);
            let v96 = v76;
            let v97 = v77;
            if (v95 > 0 && v76 >= v95) {
                let v98 = if (v95 > v35) {
                    v95 - v35
                } else {
                    v35
                };
                v96 = v98;
                0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_log_bytes(b"bid_clamped_filtered_book");
            };
            if (v94 > 0 && v77 <= v94) {
                v97 = v94 + v35;
                0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_log_bytes(b"ask_clamped_filtered_book");
            };
            (v96, v97)
        } else {
            (v76, v77)
        };
        0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_debug_pool_params(v35, v36, v37, v74, v75, v91, v92);
        let v99 = if (arg14 >= 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::config::min_order_size(v3)) {
            if (arg14 >= v37) {
                v91 >= 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::config::min_price(v3)
            } else {
                false
            }
        } else {
            false
        };
        let v100 = if (arg15 >= 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::config::min_order_size(v3)) {
            if (arg15 >= v37) {
                v92 <= 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::config::max_price(v3)
            } else {
                false
            }
        } else {
            false
        };
        if (!v15) {
            if (0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::config::enable_deep_refill(v3)) {
                let (_, _) = 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::deep_manager::ensure_deep_balance<T0, T1, T2, T3>(arg3, arg4, arg2, &v9, arg14 + arg15, (v91 + v92) / 2, v3, arg5, arg32);
                0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_log_bytes(b"step_16a_deep_ensured");
            };
            let v103 = false;
            let v104 = false;
            if (0x1::option::is_some<0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::ExistingOrderInfo>(&v13)) {
                let v105 = 0x1::option::borrow<0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::ExistingOrderInfo>(&v13);
                let v106 = 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::price(v105);
                let v107 = v106 != v91;
                let v108 = !v107 && 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::should_refresh_order(v105, v0, 30000);
                let v109 = v100 && v92 <= v106;
                let v110 = if (v107) {
                    true
                } else if (v108) {
                    true
                } else {
                    v109
                };
                if (v110) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v9, 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::order_id(v105), arg5, arg32);
                    v103 = true;
                    if (v109) {
                        0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_log_bytes(b"bid_cancelled_would_cross_ask");
                    } else if (v107) {
                        0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_log_bytes(b"bid_diff_price_replace");
                    } else {
                        0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_log_bytes(b"bid_same_price_refresh");
                    };
                } else {
                    0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_log_bytes(b"bid_same_price_keep");
                };
            };
            if (0x1::option::is_some<0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::ExistingOrderInfo>(&v12)) {
                let v111 = 0x1::option::borrow<0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::ExistingOrderInfo>(&v12);
                let v112 = 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::price(v111);
                let v113 = v112 != v92;
                let v114 = !v113 && 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::should_refresh_order(v111, v0, 30000);
                let v115 = v99 && v91 >= v112;
                let v116 = if (v113) {
                    true
                } else if (v114) {
                    true
                } else {
                    v115
                };
                if (v116) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v9, 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::order_id(v111), arg5, arg32);
                    v104 = true;
                    if (v115) {
                        0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_log_bytes(b"ask_cancelled_would_cross_bid");
                    } else if (v113) {
                        0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_log_bytes(b"ask_diff_price_replace");
                    } else {
                        0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_log_bytes(b"ask_same_price_refresh");
                    };
                } else {
                    0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_log_bytes(b"ask_same_price_keep");
                };
            };
            if (v99 && (!0x1::option::is_some<0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::ExistingOrderInfo>(&v13) || v103)) {
                let v117 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v9, arg13, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v91, arg14, true, v38, arg12, arg5, arg32);
                0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_post_only_order(v1, true, v91, arg14, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v117), v6, arg7, v0, arg13);
            };
            if (v100 && (!0x1::option::is_some<0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::orderbook_analyzer::ExistingOrderInfo>(&v12) || v104)) {
                let v118 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v9, arg13, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v92, arg15, false, v38, arg12, arg5, arg32);
                0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_post_only_order(v1, false, v92, arg15, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v118), v6, arg8, v0, arg13);
            };
        } else {
            0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_log_bytes(b"dry_run_orders_skipped");
        };
        0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_orders_placed(0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::state_id(arg0), v1, v91, arg14, v92, arg15, v0);
        let v119 = 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::config::target_base_position(v3);
        let v120 = if (v119 > 0) {
            if (v14 >= v119) {
                (v14 - v119) * 10000 / v119
            } else {
                (v119 - v14) * 10000 / v119
            }
        } else {
            0
        };
        0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_execution_detail(0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::state_id(arg0), v1, arg11, 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::execution_count(arg0), v0, arg6, v6, v91, v92, v14, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), v119, v120, v14 > v119, arg7, arg8, arg14, arg15, 0, false, 0, arg13, v99, v100, v32, v25, v26, v30, v31);
        0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::record_order_time(arg0, v0);
    }

    public fun get_state_info(arg0: &0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::MMState) : (u64, u64, u64, bool) {
        (0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::current_price(arg0), 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::current_spread(arg0), 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::execution_count(arg0), 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::is_paused(arg0))
    }

    public fun pause_trading<T0, T1>(arg0: &mut 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::owner(arg0) == 0x2::tx_context::sender(arg5), 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v1, arg4, arg5);
        0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::events::emit_orders_cancelled(0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), v0);
        0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::pause(arg0, v0 + arg3, v0);
    }

    public fun resume_trading(arg0: &mut 0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::MMState, arg1: &0x2::tx_context::TxContext) {
        assert!(0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::owner(arg0) == 0x2::tx_context::sender(arg1), 1);
        0x5c92999cde01cedd970c7c2e67605f6351350595c681eaab8f7c535673f4a1ef::mm_state::unpause(arg0);
    }

    // decompiled from Move bytecode v6
}

