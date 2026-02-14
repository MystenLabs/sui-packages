module 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::leva_deep_mm {
    public fun cancel_all_orders<T0, T1>(arg0: &mut 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::owner(arg0) == 0x2::tx_context::sender(arg5), 1);
        0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::advance_sequence(arg0, arg3);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg4, arg5);
        0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::events::emit_orders_cancelled(0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg4));
    }

    public fun cancel_and_settle<T0, T1>(arg0: &mut 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::owner(arg0) == 0x2::tx_context::sender(arg5), 1);
        0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::advance_sequence(arg0, arg3);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg4, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg2, arg1, &v0);
        0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::events::emit_orders_cancelled(0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg4));
    }

    public fun execute<T0, T1, T2, T3>(arg0: &mut 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::MMState, arg1: &0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_registry::MMRegistry, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: bool, arg19: bool, arg20: bool, arg21: u64, arg22: u64, arg23: u64, arg24: vector<u64>, arg25: vector<u64>, arg26: vector<u64>, arg27: vector<u64>, arg28: vector<u64>, arg29: u64, arg30: bool, arg31: u64, arg32: u64, arg33: u64, arg34: u64, arg35: u64, arg36: u64, arg37: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3);
        if (arg19) {
            0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::advance_sequence(arg0, arg11);
            let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg37);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg3, arg2, &v2, arg5, arg37);
            0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::events::emit_orders_cancelled(0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::state_id(arg0), v1, v0);
            return
        };
        if (0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::is_trading_blocked(arg0, v0)) {
            return
        };
        let v3 = 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_registry::get_pool_config(arg1, v1);
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
        assert!(0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::update_price(arg0, v6, (arg7 + arg8) / 2, arg11, v0), 3);
        0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::record_execution(arg0);
        let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg37);
        let (v9, v10) = 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orderbook_analyzer::get_existing_orders<T0, T1>(arg3, arg2, arg5);
        let v11 = v10;
        let v12 = v9;
        let v13 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v14 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2);
        let v15 = 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::config::is_dry_run(v3);
        let v16 = if (0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::config::is_orderbook_analysis_enabled(v3)) {
            0x1::option::some<0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orderbook_analyzer::OrderbookSnapshot>(0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orderbook_analyzer::analyze_orderbook<T0, T1>(arg3, arg2, 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::config::min_significant_qty(v3), 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::config::l2_tick_count(v3), arg5))
        } else {
            0x1::option::none<0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orderbook_analyzer::OrderbookSnapshot>()
        };
        let v17 = v16;
        let v18 = if (arg18) {
            arg6
        } else {
            v6
        };
        let (v19, v20) = if (arg30) {
            0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::inv_sizing::compute_multipliers(v13, v14, v18, arg36, arg31, arg32, arg33, arg34, arg35)
        } else {
            (0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::inv_sizing::scale(), 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::inv_sizing::scale())
        };
        let v21 = v18 * (100000 - arg7) / 100000;
        let v22 = v18 * (100000 + arg8) / 100000;
        let (v23, v24, v25) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg3);
        let v26 = 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::config::enable_deep_payment(v3);
        let (v27, _, v29, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg3, 1, arg5);
        let v31 = v29;
        let v32 = v27;
        let v33 = if (0x1::vector::length<u64>(&v32) > 0) {
            *0x1::vector::borrow<u64>(&v32, 0)
        } else {
            0
        };
        let v34 = v33;
        let v35 = if (0x1::vector::length<u64>(&v31) > 0) {
            *0x1::vector::borrow<u64>(&v31, 0)
        } else {
            0
        };
        let v36 = v35;
        let v37 = if (arg20) {
            if (!v15) {
                arg23 >= v25
            } else {
                false
            }
        } else {
            false
        };
        if (v37) {
            let v38 = arg23 / v24 * v24;
            if (v38 >= v25) {
                let v39 = 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orders::round_bid_price(v18 * (100000 - arg21) / 100000, v23);
                if (v39 >= v23) {
                    let v40 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v8, arg13 + 3000000, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v39, v38, true, v26, arg12, arg5, arg37);
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v40);
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v40);
                };
                let v41 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v8, arg13 + 4000000, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orders::round_ask_price(v18 * (100000 + arg22) / 100000, v23), v38, false, v26, arg12, arg5, arg37);
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v41);
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v41);
            };
            let (v42, _, v44, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg3, 1, arg5);
            let v46 = v44;
            let v47 = v42;
            let v48 = if (0x1::vector::length<u64>(&v47) > 0) {
                *0x1::vector::borrow<u64>(&v47, 0)
            } else {
                0
            };
            v34 = v48;
            let v49 = if (0x1::vector::length<u64>(&v46) > 0) {
                *0x1::vector::borrow<u64>(&v46, 0)
            } else {
                0
            };
            v36 = v49;
        };
        if (0x1::vector::length<u64>(&arg24) > 0) {
            let v50 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
            let v51 = 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::config::target_base_position(v3);
            let v52 = if (v51 > 0) {
                if (v50 >= v51) {
                    (v50 - v51) * 10000 / v51
                } else {
                    (v51 - v50) * 10000 / v51
                }
            } else {
                0
            };
            let v53 = *0x1::vector::borrow<u64>(&arg24, 0);
            let v54 = *0x1::vector::borrow<u64>(&arg25, 0);
            0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::events::emit_execution_detail(0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::state_id(arg0), v1, arg11, 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::execution_count(arg0), v0, arg6, v6, 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orders::round_bid_price(v18 * (100000 - v53) / 100000, v23), 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orders::round_ask_price(v18 * (100000 + v54) / 100000, v23), v50, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), v51, v52, v50 > v51, v53, v54, 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::inv_sizing::apply_multiplier(*0x1::vector::borrow<u64>(&arg26, 0), v19, v24, v25), 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::inv_sizing::apply_multiplier(*0x1::vector::borrow<u64>(&arg27, 0), v20, v24, v25), arg13, true, true, v18);
            0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::multi_layer::process_layers<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, v18, arg9, arg10, arg13, arg12, &arg24, &arg25, &arg26, &arg27, &arg28, arg29, v19, v20, &v8, v3, v23, v25, v34, v36, arg37);
            return
        };
        let v55 = if (v36 > 0 && v21 >= v36) {
            v36 * (100000 - arg9) / 100000
        } else {
            v21
        };
        let v56 = if (v34 > 0 && v22 <= v34) {
            v34 * (100000 + arg10) / 100000
        } else {
            v22
        };
        let (v57, v58) = if (0x1::option::is_some<0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orderbook_analyzer::OrderbookSnapshot>(&v17) && arg17 > 0) {
            let v59 = 0x1::option::borrow<0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orderbook_analyzer::OrderbookSnapshot>(&v17);
            let (v60, v61) = 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orderbook_analyzer::find_queue_snipe_price(v59, v55, true, v23, arg17);
            let v62 = if (v61) {
                v60
            } else {
                0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orders::round_bid_price(v60, v23)
            };
            let (v63, v64) = 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orderbook_analyzer::find_queue_snipe_price(v59, v56, false, v23, arg17);
            let v65 = if (v64) {
                v63
            } else {
                0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orders::round_ask_price(v63, v23)
            };
            (v62, v65)
        } else {
            (0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orders::round_bid_price(v55, v23), 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orders::round_ask_price(v56, v23))
        };
        let (v66, v67) = if (0x1::option::is_some<0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orderbook_analyzer::OrderbookSnapshot>(&v17)) {
            let v68 = 0x1::option::borrow<0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orderbook_analyzer::OrderbookSnapshot>(&v17);
            let v69 = 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orderbook_analyzer::best_bid(v68);
            let v70 = 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orderbook_analyzer::best_ask(v68);
            let v71 = v57;
            let v72 = v58;
            if (v70 > 0 && v57 >= v70) {
                let v73 = if (v70 > v23) {
                    v70 - v23
                } else {
                    v23
                };
                v71 = v73;
            };
            if (v69 > 0 && v58 <= v69) {
                v72 = v69 + v23;
            };
            (v71, v72)
        } else {
            (v57, v58)
        };
        let v74 = 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::inv_sizing::apply_multiplier(arg14, v19, v24, v25);
        let v75 = 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::inv_sizing::apply_multiplier(arg15, v20, v24, v25);
        let v76 = if (v74 >= 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::config::min_order_size(v3)) {
            if (v74 >= v25) {
                v66 >= 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::config::min_price(v3)
            } else {
                false
            }
        } else {
            false
        };
        let v77 = if (v75 >= 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::config::min_order_size(v3)) {
            if (v75 >= v25) {
                v67 <= 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::config::max_price(v3)
            } else {
                false
            }
        } else {
            false
        };
        if (!v15) {
            if (0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::config::enable_deep_refill(v3)) {
                let (_, _) = 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::deep_manager::ensure_deep_balance<T0, T1, T2, T3>(arg3, arg4, arg2, &v8, v74 + v75, (v66 + v67) / 2, v3, arg5, arg37);
            };
            let v80 = false;
            let v81 = false;
            if (0x1::option::is_some<0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orderbook_analyzer::ExistingOrderInfo>(&v12)) {
                let v82 = 0x1::option::borrow<0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orderbook_analyzer::ExistingOrderInfo>(&v12);
                let v83 = 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orderbook_analyzer::price(v82);
                let v84 = v83 != v66;
                let v85 = !v84 && 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orderbook_analyzer::should_refresh_order(v82, v0, 30000);
                let v86 = v77 && v67 <= v83;
                let v87 = if (v84) {
                    true
                } else if (v85) {
                    true
                } else {
                    v86
                };
                if (v87) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v8, 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orderbook_analyzer::order_id(v82), arg5, arg37);
                    v80 = true;
                };
            };
            if (0x1::option::is_some<0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orderbook_analyzer::ExistingOrderInfo>(&v11)) {
                let v88 = 0x1::option::borrow<0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orderbook_analyzer::ExistingOrderInfo>(&v11);
                let v89 = 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orderbook_analyzer::price(v88);
                let v90 = v89 != v67;
                let v91 = !v90 && 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orderbook_analyzer::should_refresh_order(v88, v0, 30000);
                let v92 = v76 && v66 >= v89;
                let v93 = if (v90) {
                    true
                } else if (v91) {
                    true
                } else {
                    v92
                };
                if (v93) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v8, 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orderbook_analyzer::order_id(v88), arg5, arg37);
                    v81 = true;
                };
            };
            if (v76 && (!0x1::option::is_some<0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orderbook_analyzer::ExistingOrderInfo>(&v12) || v80)) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v8, arg13, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v66, v74, true, v26, arg12, arg5, arg37);
            };
            if (v77 && (!0x1::option::is_some<0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::orderbook_analyzer::ExistingOrderInfo>(&v11) || v81)) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v8, arg13, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v67, v75, false, v26, arg12, arg5, arg37);
            };
        };
        let v94 = 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::config::target_base_position(v3);
        let v95 = if (v94 > 0) {
            if (v13 >= v94) {
                (v13 - v94) * 10000 / v94
            } else {
                (v94 - v13) * 10000 / v94
            }
        } else {
            0
        };
        0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::events::emit_execution_detail(0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::state_id(arg0), v1, arg11, 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::execution_count(arg0), v0, arg6, v6, v66, v67, v13, v14, v94, v95, v13 > v94, arg7, arg8, v74, v75, arg13, v76, v77, v18);
        0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::record_order_time(arg0, v0);
    }

    public fun get_state_info(arg0: &0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::MMState) : (u64, u64, u64, bool) {
        (0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::current_price(arg0), 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::current_spread(arg0), 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::execution_count(arg0), 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::is_paused(arg0))
    }

    public fun pause_trading<T0, T1>(arg0: &mut 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::owner(arg0) == 0x2::tx_context::sender(arg6), 1);
        0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::advance_sequence(arg0, arg4);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v1, arg5, arg6);
        0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::events::emit_orders_cancelled(0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), v0);
        0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::pause(arg0, v0 + arg3, v0);
    }

    public fun resume_trading(arg0: &mut 0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::MMState, arg1: &0x2::tx_context::TxContext) {
        assert!(0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::owner(arg0) == 0x2::tx_context::sender(arg1), 1);
        0xc83532926df6ad2eee752607e3c4bc099e839110f9454b8f4ff4bd21f301c888::mm_state::unpause(arg0);
    }

    // decompiled from Move bytecode v6
}

