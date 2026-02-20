module 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::leva_deep_mm {
    public fun cancel_all_orders<T0, T1>(arg0: &mut 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::owner(arg0) == 0x2::tx_context::sender(arg5), 1);
        0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::advance_sequence(arg0, arg3);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg4, arg5);
        0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::events::emit_orders_cancelled(0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg4));
    }

    public fun cancel_and_settle<T0, T1>(arg0: &mut 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::owner(arg0) == 0x2::tx_context::sender(arg5), 1);
        0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::advance_sequence(arg0, arg3);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg4, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg2, arg1, &v0);
        0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::events::emit_orders_cancelled(0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg4));
    }

    public fun execute<T0, T1, T2, T3>(arg0: &mut 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::MMState, arg1: &0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_registry::MMRegistry, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: bool, arg19: bool, arg20: bool, arg21: u64, arg22: u64, arg23: u64, arg24: vector<u64>, arg25: vector<u64>, arg26: vector<u64>, arg27: vector<u64>, arg28: vector<u64>, arg29: u64, arg30: bool, arg31: u64, arg32: u64, arg33: u64, arg34: u64, arg35: u64, arg36: u64, arg37: &mut 0x2::tx_context::TxContext) {
        assert!(0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::owner(arg0) == 0x2::tx_context::sender(arg37), 1);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3);
        if (arg19) {
            0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::advance_sequence(arg0, arg11);
            let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg37);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg3, arg2, &v2, arg5, arg37);
            0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::events::emit_orders_cancelled(0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::state_id(arg0), v1, v0);
            return
        };
        if (0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::is_trading_blocked(arg0, v0)) {
            return
        };
        let v3 = 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_registry::get_pool_config(arg1, v1);
        let v4 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg3, arg5);
        let v5 = if (v4 == 0) {
            arg6
        } else {
            v4
        };
        if (!arg18) {
            let v6 = if (v5 >= arg6) {
                (v5 - arg6) * 100000 / arg6
            } else {
                (arg6 - v5) * 100000 / arg6
            };
            assert!(v6 <= arg16, 2);
        };
        assert!(0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::update_price(arg0, v5, (arg7 + arg8) / 2, arg11, v0), 3);
        0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::record_execution(arg0);
        let v7 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg37);
        let (v8, v9) = 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orderbook_analyzer::get_existing_orders<T0, T1>(arg3, arg2, arg5);
        let v10 = v9;
        let v11 = v8;
        let v12 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v13 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2);
        let v14 = 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::config::is_dry_run(v3);
        let v15 = if (0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::config::is_orderbook_analysis_enabled(v3)) {
            0x1::option::some<0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orderbook_analyzer::OrderbookSnapshot>(0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orderbook_analyzer::analyze_orderbook<T0, T1>(arg3, arg2, 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::config::min_significant_qty(v3), 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::config::l2_tick_count(v3), arg5))
        } else {
            0x1::option::none<0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orderbook_analyzer::OrderbookSnapshot>()
        };
        let v16 = v15;
        let v17 = if (arg18) {
            arg6
        } else {
            v5
        };
        let (v18, v19) = if (arg30) {
            0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::inv_sizing::compute_multipliers(v12, v13, v17, arg36, arg31, arg32, arg33, arg34, arg35)
        } else {
            (0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::inv_sizing::scale(), 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::inv_sizing::scale())
        };
        let v20 = v17 * (100000 - arg7) / 100000;
        let v21 = v17 * (100000 + arg8) / 100000;
        let (v22, v23, v24) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg3);
        let v25 = 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::config::enable_deep_payment(v3);
        let (v26, _, v28, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg3, 1, arg5);
        let v30 = v28;
        let v31 = v26;
        let v32 = if (0x1::vector::length<u64>(&v31) > 0) {
            *0x1::vector::borrow<u64>(&v31, 0)
        } else {
            0
        };
        let v33 = v32;
        let v34 = if (0x1::vector::length<u64>(&v30) > 0) {
            *0x1::vector::borrow<u64>(&v30, 0)
        } else {
            0
        };
        let v35 = v34;
        if (arg20 && !v14 && arg23 >= v24) {
            let v36 = arg23 / v23 * v23;
            if (v36 >= v24) {
                let v37 = 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orders::round_bid_price(v17 * (100000 - arg21) / 100000, v22);
                if (v37 >= v22) {
                    if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2) >= (((v36 as u128) * (v37 as u128) / 1000000000) as u64)) {
                        let v38 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v7, arg13 + 3000000, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v37, v36, true, v25, arg12, arg5, arg37);
                        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v38);
                        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v38);
                    };
                };
                if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2) >= v36) {
                    let v39 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v7, arg13 + 4000000, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orders::round_ask_price(v17 * (100000 + arg22) / 100000, v22), v36, false, v25, arg12, arg5, arg37);
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v39);
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v39);
                };
            };
            let (v40, _, v42, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg3, 1, arg5);
            let v44 = v42;
            let v45 = v40;
            let v46 = if (0x1::vector::length<u64>(&v45) > 0) {
                *0x1::vector::borrow<u64>(&v45, 0)
            } else {
                0
            };
            v33 = v46;
            let v47 = if (0x1::vector::length<u64>(&v44) > 0) {
                *0x1::vector::borrow<u64>(&v44, 0)
            } else {
                0
            };
            v35 = v47;
        };
        if (0x1::vector::length<u64>(&arg24) > 0) {
            let v48 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
            let v49 = 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::config::target_base_position(v3);
            let v50 = if (v49 > 0) {
                if (v48 >= v49) {
                    (v48 - v49) * 10000 / v49
                } else {
                    (v49 - v48) * 10000 / v49
                }
            } else {
                0
            };
            let v51 = *0x1::vector::borrow<u64>(&arg24, 0);
            let v52 = *0x1::vector::borrow<u64>(&arg25, 0);
            0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::events::emit_execution_detail(0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::state_id(arg0), v1, arg11, 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::execution_count(arg0), v0, arg6, v5, 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orders::round_bid_price(v17 * (100000 - v51) / 100000, v22), 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orders::round_ask_price(v17 * (100000 + v52) / 100000, v22), v48, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), v49, v50, v48 > v49, v51, v52, 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::inv_sizing::apply_multiplier(*0x1::vector::borrow<u64>(&arg26, 0), v18, v23, v24), 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::inv_sizing::apply_multiplier(*0x1::vector::borrow<u64>(&arg27, 0), v19, v23, v24), arg13, true, true, v17);
            0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::multi_layer::process_layers<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, v17, arg9, arg10, arg13, arg12, &arg24, &arg25, &arg26, &arg27, &arg28, arg29, v18, v19, &v7, v3, v22, v24, v33, v35, arg37);
            return
        };
        let v53 = if (v35 > 0 && v20 >= v35) {
            v35 * (100000 - arg9) / 100000
        } else {
            v20
        };
        let v54 = if (v33 > 0 && v21 <= v33) {
            v33 * (100000 + arg10) / 100000
        } else {
            v21
        };
        let (v55, v56) = if (0x1::option::is_some<0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orderbook_analyzer::OrderbookSnapshot>(&v16) && arg17 > 0) {
            let v57 = 0x1::option::borrow<0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orderbook_analyzer::OrderbookSnapshot>(&v16);
            let (v58, v59) = 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orderbook_analyzer::find_queue_snipe_price(v57, v53, true, v22, arg17);
            let v60 = if (v59) {
                v58
            } else {
                0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orders::round_bid_price(v58, v22)
            };
            let (v61, v62) = 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orderbook_analyzer::find_queue_snipe_price(v57, v54, false, v22, arg17);
            let v63 = if (v62) {
                v61
            } else {
                0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orders::round_ask_price(v61, v22)
            };
            (v60, v63)
        } else {
            (0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orders::round_bid_price(v53, v22), 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orders::round_ask_price(v54, v22))
        };
        let (v64, v65) = if (0x1::option::is_some<0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orderbook_analyzer::OrderbookSnapshot>(&v16)) {
            let v66 = 0x1::option::borrow<0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orderbook_analyzer::OrderbookSnapshot>(&v16);
            let v67 = 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orderbook_analyzer::best_bid(v66);
            let v68 = 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orderbook_analyzer::best_ask(v66);
            let v69 = v55;
            let v70 = v56;
            if (v68 > 0 && v55 >= v68) {
                let v71 = if (v68 > v22) {
                    v68 - v22
                } else {
                    v22
                };
                v69 = v71;
            };
            if (v67 > 0 && v56 <= v67) {
                v70 = v67 + v22;
            };
            (v69, v70)
        } else {
            (v55, v56)
        };
        let v72 = 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::inv_sizing::apply_multiplier(arg14, v18, v23, v24);
        let v73 = 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::inv_sizing::apply_multiplier(arg15, v19, v23, v24);
        let v74 = v72 >= 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::config::min_order_size(v3) && v72 >= v24 && v64 >= 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::config::min_price(v3);
        let v75 = v73 >= 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::config::min_order_size(v3) && v73 >= v24 && v65 <= 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::config::max_price(v3);
        if (!v14) {
            if (0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::config::enable_deep_refill(v3)) {
                let (_, _) = 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::deep_manager::ensure_deep_balance<T0, T1, T2, T3>(arg3, arg4, arg2, &v7, v72 + v73, (v64 + v65) / 2, v3, arg5, arg37);
            };
            let v78 = false;
            let v79 = false;
            if (0x1::option::is_some<0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orderbook_analyzer::ExistingOrderInfo>(&v11)) {
                let v80 = 0x1::option::borrow<0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orderbook_analyzer::ExistingOrderInfo>(&v11);
                let v81 = 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orderbook_analyzer::price(v80);
                let v82 = v81 != v64;
                let v83 = !v82 && 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orderbook_analyzer::should_refresh_order(v80, v0, 30000);
                let v84 = v75 && v65 <= v81;
                if (v82 || v83 || v84) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v7, 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orderbook_analyzer::order_id(v80), arg5, arg37);
                    v78 = true;
                };
            };
            if (0x1::option::is_some<0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orderbook_analyzer::ExistingOrderInfo>(&v10)) {
                let v85 = 0x1::option::borrow<0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orderbook_analyzer::ExistingOrderInfo>(&v10);
                let v86 = 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orderbook_analyzer::price(v85);
                let v87 = v86 != v65;
                let v88 = !v87 && 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orderbook_analyzer::should_refresh_order(v85, v0, 30000);
                let v89 = v74 && v64 >= v86;
                if (v87 || v88 || v89) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v7, 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orderbook_analyzer::order_id(v85), arg5, arg37);
                    v79 = true;
                };
            };
            if (v74 && (!0x1::option::is_some<0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orderbook_analyzer::ExistingOrderInfo>(&v11) || v78)) {
                if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2) >= (((v72 as u128) * (v64 as u128) / 1000000000) as u64)) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v7, arg13, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v64, v72, true, v25, arg12, arg5, arg37);
                };
            };
            if (v75 && (!0x1::option::is_some<0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::orderbook_analyzer::ExistingOrderInfo>(&v10) || v79)) {
                if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2) >= v73) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v7, arg13, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v65, v73, false, v25, arg12, arg5, arg37);
                };
            };
        };
        let v90 = 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::config::target_base_position(v3);
        let v91 = if (v90 > 0) {
            if (v12 >= v90) {
                (v12 - v90) * 10000 / v90
            } else {
                (v90 - v12) * 10000 / v90
            }
        } else {
            0
        };
        0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::events::emit_execution_detail(0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::state_id(arg0), v1, arg11, 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::execution_count(arg0), v0, arg6, v5, v64, v65, v12, v13, v90, v91, v12 > v90, arg7, arg8, v72, v73, arg13, v74, v75, v17);
        0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::record_order_time(arg0, v0);
    }

    public fun get_state_info(arg0: &0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::MMState) : (u64, u64, u64, bool) {
        (0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::current_price(arg0), 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::current_spread(arg0), 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::execution_count(arg0), 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::is_paused(arg0))
    }

    public fun pause_trading<T0, T1>(arg0: &mut 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::owner(arg0) == 0x2::tx_context::sender(arg6), 1);
        0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::advance_sequence(arg0, arg4);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v1, arg5, arg6);
        0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::events::emit_orders_cancelled(0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), v0);
        0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::pause(arg0, v0 + arg3, v0);
    }

    public fun resume_trading(arg0: &mut 0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::MMState, arg1: &0x2::tx_context::TxContext) {
        assert!(0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::owner(arg0) == 0x2::tx_context::sender(arg1), 1);
        0xceacb3de3e57db56696c448c22c26bbc60e003e1ec1e1ca9f3bf7c0d8f8bfde0::mm_state::unpause(arg0);
    }

    // decompiled from Move bytecode v6
}

