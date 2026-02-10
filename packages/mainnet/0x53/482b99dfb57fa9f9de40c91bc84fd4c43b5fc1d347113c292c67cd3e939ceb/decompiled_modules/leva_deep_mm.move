module 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::leva_deep_mm {
    public fun cancel_all_orders<T0, T1>(arg0: &0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_state::owner(arg0) == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg3, arg4);
        0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::events::emit_orders_cancelled(0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg3));
    }

    public fun cancel_and_settle<T0, T1>(arg0: &0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_state::owner(arg0) == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg3, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg2, arg1, &v0);
        0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::events::emit_orders_cancelled(0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg3));
    }

    public fun execute<T0, T1, T2, T3>(arg0: &mut 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_state::MMState, arg1: &0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_registry::MMRegistry, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: bool, arg19: bool, arg20: bool, arg21: u64, arg22: u64, arg23: u64, arg24: vector<u64>, arg25: vector<u64>, arg26: vector<u64>, arg27: vector<u64>, arg28: vector<u64>, arg29: u64, arg30: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3);
        if (arg19) {
            let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg30);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg3, arg2, &v2, arg5, arg30);
            0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::events::emit_orders_cancelled(0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_state::state_id(arg0), v1, v0);
            return
        };
        if (0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_state::is_trading_blocked(arg0, v0)) {
            return
        };
        let v3 = 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_registry::get_pool_config(arg1, v1);
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
        0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_state::update_price(arg0, v6, (arg7 + arg8) / 2, arg11, v0);
        0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_state::record_execution(arg0);
        let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg30);
        let (v9, v10) = 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orderbook_analyzer::get_existing_orders<T0, T1>(arg3, arg2, arg5);
        let v11 = v10;
        let v12 = v9;
        let v13 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v14 = 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::config::is_dry_run(v3);
        let v15 = if (0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::config::is_orderbook_analysis_enabled(v3)) {
            0x1::option::some<0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orderbook_analyzer::OrderbookSnapshot>(0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orderbook_analyzer::analyze_orderbook<T0, T1>(arg3, arg2, 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::config::min_significant_qty(v3), 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::config::l2_tick_count(v3), arg5))
        } else {
            0x1::option::none<0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orderbook_analyzer::OrderbookSnapshot>()
        };
        let v16 = v15;
        let v17 = if (arg18) {
            arg6
        } else {
            v6
        };
        let v18 = v17 * (100000 - arg7) / 100000;
        let v19 = v17 * (100000 + arg8) / 100000;
        let (v20, v21, v22) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg3);
        let v23 = 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::config::enable_deep_payment(v3);
        let (v24, _, v26, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg3, 1, arg5);
        let v28 = v26;
        let v29 = v24;
        let v30 = if (0x1::vector::length<u64>(&v29) > 0) {
            *0x1::vector::borrow<u64>(&v29, 0)
        } else {
            0
        };
        let v31 = v30;
        let v32 = if (0x1::vector::length<u64>(&v28) > 0) {
            *0x1::vector::borrow<u64>(&v28, 0)
        } else {
            0
        };
        let v33 = v32;
        let v34 = if (arg20) {
            if (!v14) {
                arg23 >= v22
            } else {
                false
            }
        } else {
            false
        };
        if (v34) {
            let v35 = arg23 / v21 * v21;
            if (v35 >= v22) {
                let v36 = 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orders::round_bid_price(v17 * (100000 - arg21) / 100000, v20);
                if (v36 >= v20) {
                    let v37 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v8, arg13 + 3000000, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v36, v35, true, v23, arg12, arg5, arg30);
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v37);
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v37);
                };
                let v38 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v8, arg13 + 4000000, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orders::round_ask_price(v17 * (100000 + arg22) / 100000, v20), v35, false, v23, arg12, arg5, arg30);
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v38);
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v38);
            };
            let (v39, _, v41, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg3, 1, arg5);
            let v43 = v41;
            let v44 = v39;
            let v45 = if (0x1::vector::length<u64>(&v44) > 0) {
                *0x1::vector::borrow<u64>(&v44, 0)
            } else {
                0
            };
            v31 = v45;
            let v46 = if (0x1::vector::length<u64>(&v43) > 0) {
                *0x1::vector::borrow<u64>(&v43, 0)
            } else {
                0
            };
            v33 = v46;
        };
        if (0x1::vector::length<u64>(&arg24) > 0) {
            let v47 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
            let v48 = 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::config::target_base_position(v3);
            let v49 = if (v48 > 0) {
                if (v47 >= v48) {
                    (v47 - v48) * 10000 / v48
                } else {
                    (v48 - v47) * 10000 / v48
                }
            } else {
                0
            };
            let v50 = *0x1::vector::borrow<u64>(&arg24, 0);
            let v51 = *0x1::vector::borrow<u64>(&arg25, 0);
            0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::events::emit_execution_detail(0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_state::state_id(arg0), v1, arg11, 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_state::execution_count(arg0), v0, arg6, v6, 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orders::round_bid_price(v17 * (100000 - v50) / 100000, v20), 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orders::round_ask_price(v17 * (100000 + v51) / 100000, v20), v47, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), v48, v49, v47 > v48, v50, v51, *0x1::vector::borrow<u64>(&arg26, 0), *0x1::vector::borrow<u64>(&arg27, 0), arg13, true, true, v17);
            0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::multi_layer::process_layers<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, v17, arg9, arg10, arg13, arg12, &arg24, &arg25, &arg26, &arg27, &arg28, arg29, &v8, v3, v20, v22, v31, v33, arg30);
            return
        };
        let v52 = if (v33 > 0 && v18 >= v33) {
            v33 * (100000 - arg9) / 100000
        } else {
            v18
        };
        let v53 = if (v31 > 0 && v19 <= v31) {
            v31 * (100000 + arg10) / 100000
        } else {
            v19
        };
        let (v54, v55) = if (0x1::option::is_some<0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orderbook_analyzer::OrderbookSnapshot>(&v16) && arg17 > 0) {
            let v56 = 0x1::option::borrow<0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orderbook_analyzer::OrderbookSnapshot>(&v16);
            let (v57, v58) = 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orderbook_analyzer::find_queue_snipe_price(v56, v52, true, v20, arg17);
            let v59 = if (v58) {
                v57
            } else {
                0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orders::round_bid_price(v57, v20)
            };
            let (v60, v61) = 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orderbook_analyzer::find_queue_snipe_price(v56, v53, false, v20, arg17);
            let v62 = if (v61) {
                v60
            } else {
                0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orders::round_ask_price(v60, v20)
            };
            (v59, v62)
        } else {
            (0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orders::round_bid_price(v52, v20), 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orders::round_ask_price(v53, v20))
        };
        let (v63, v64) = if (0x1::option::is_some<0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orderbook_analyzer::OrderbookSnapshot>(&v16)) {
            let v65 = 0x1::option::borrow<0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orderbook_analyzer::OrderbookSnapshot>(&v16);
            let v66 = 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orderbook_analyzer::best_bid(v65);
            let v67 = 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orderbook_analyzer::best_ask(v65);
            let v68 = v54;
            let v69 = v55;
            if (v67 > 0 && v54 >= v67) {
                let v70 = if (v67 > v20) {
                    v67 - v20
                } else {
                    v20
                };
                v68 = v70;
            };
            if (v66 > 0 && v55 <= v66) {
                v69 = v66 + v20;
            };
            (v68, v69)
        } else {
            (v54, v55)
        };
        let v71 = if (arg14 >= 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::config::min_order_size(v3)) {
            if (arg14 >= v22) {
                v63 >= 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::config::min_price(v3)
            } else {
                false
            }
        } else {
            false
        };
        let v72 = if (arg15 >= 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::config::min_order_size(v3)) {
            if (arg15 >= v22) {
                v64 <= 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::config::max_price(v3)
            } else {
                false
            }
        } else {
            false
        };
        if (!v14) {
            if (0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::config::enable_deep_refill(v3)) {
                let (_, _) = 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::deep_manager::ensure_deep_balance<T0, T1, T2, T3>(arg3, arg4, arg2, &v8, arg14 + arg15, (v63 + v64) / 2, v3, arg5, arg30);
            };
            let v75 = false;
            let v76 = false;
            if (0x1::option::is_some<0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orderbook_analyzer::ExistingOrderInfo>(&v12)) {
                let v77 = 0x1::option::borrow<0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orderbook_analyzer::ExistingOrderInfo>(&v12);
                let v78 = 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orderbook_analyzer::price(v77);
                let v79 = v78 != v63;
                let v80 = !v79 && 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orderbook_analyzer::should_refresh_order(v77, v0, 30000);
                let v81 = v72 && v64 <= v78;
                let v82 = if (v79) {
                    true
                } else if (v80) {
                    true
                } else {
                    v81
                };
                if (v82) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v8, 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orderbook_analyzer::order_id(v77), arg5, arg30);
                    v75 = true;
                };
            };
            if (0x1::option::is_some<0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orderbook_analyzer::ExistingOrderInfo>(&v11)) {
                let v83 = 0x1::option::borrow<0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orderbook_analyzer::ExistingOrderInfo>(&v11);
                let v84 = 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orderbook_analyzer::price(v83);
                let v85 = v84 != v64;
                let v86 = !v85 && 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orderbook_analyzer::should_refresh_order(v83, v0, 30000);
                let v87 = v71 && v63 >= v84;
                let v88 = if (v85) {
                    true
                } else if (v86) {
                    true
                } else {
                    v87
                };
                if (v88) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v8, 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orderbook_analyzer::order_id(v83), arg5, arg30);
                    v76 = true;
                };
            };
            if (v71 && (!0x1::option::is_some<0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orderbook_analyzer::ExistingOrderInfo>(&v12) || v75)) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v8, arg13, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v63, arg14, true, v23, arg12, arg5, arg30);
            };
            if (v72 && (!0x1::option::is_some<0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::orderbook_analyzer::ExistingOrderInfo>(&v11) || v76)) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v8, arg13, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v64, arg15, false, v23, arg12, arg5, arg30);
            };
        };
        let v89 = 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::config::target_base_position(v3);
        let v90 = if (v89 > 0) {
            if (v13 >= v89) {
                (v13 - v89) * 10000 / v89
            } else {
                (v89 - v13) * 10000 / v89
            }
        } else {
            0
        };
        0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::events::emit_execution_detail(0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_state::state_id(arg0), v1, arg11, 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_state::execution_count(arg0), v0, arg6, v6, v63, v64, v13, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), v89, v90, v13 > v89, arg7, arg8, arg14, arg15, arg13, v71, v72, v17);
        0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_state::record_order_time(arg0, v0);
    }

    public fun get_state_info(arg0: &0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_state::MMState) : (u64, u64, u64, bool) {
        (0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_state::current_price(arg0), 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_state::current_spread(arg0), 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_state::execution_count(arg0), 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_state::is_paused(arg0))
    }

    public fun pause_trading<T0, T1>(arg0: &mut 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_state::owner(arg0) == 0x2::tx_context::sender(arg5), 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v1, arg4, arg5);
        0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::events::emit_orders_cancelled(0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), v0);
        0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_state::pause(arg0, v0 + arg3, v0);
    }

    public fun resume_trading(arg0: &mut 0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_state::MMState, arg1: &0x2::tx_context::TxContext) {
        assert!(0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_state::owner(arg0) == 0x2::tx_context::sender(arg1), 1);
        0x53482b99dfb57fa9f9de40c91bc84fd4c43b5fc1d347113c292c67cd3e939ceb::mm_state::unpause(arg0);
    }

    // decompiled from Move bytecode v6
}

