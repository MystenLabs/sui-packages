module 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::leva_deep_mm {
    public fun cancel_all_orders<T0, T1>(arg0: &mut 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::owner(arg0) == 0x2::tx_context::sender(arg5), 1);
        0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::advance_sequence(arg0, arg3);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg4, arg5);
        0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::events::emit_orders_cancelled(0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg4));
    }

    public fun cancel_and_settle<T0, T1>(arg0: &mut 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::owner(arg0) == 0x2::tx_context::sender(arg5), 1);
        0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::advance_sequence(arg0, arg3);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg4, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg2, arg1, &v0);
        0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::events::emit_orders_cancelled(0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg4));
    }

    public fun execute<T0, T1, T2, T3>(arg0: &mut 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::MMState, arg1: &0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_registry::MMRegistry, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: bool, arg19: bool, arg20: bool, arg21: bool, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: vector<u64>, arg28: vector<u64>, arg29: vector<u64>, arg30: vector<u64>, arg31: vector<u64>, arg32: u64, arg33: bool, arg34: u64, arg35: u64, arg36: u64, arg37: u64, arg38: u64, arg39: u64, arg40: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3);
        if (arg19) {
            0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::advance_sequence(arg0, arg11);
            let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg40);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg3, arg2, &v2, arg5, arg40);
            0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::events::emit_orders_cancelled(0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::state_id(arg0), v1, v0);
            return
        };
        if (0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::is_trading_blocked(arg0, v0)) {
            return
        };
        let v3 = 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_registry::get_pool_config(arg1, v1);
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
        assert!(0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::update_price(arg0, v6, (arg7 + arg8) / 2, arg11, v0), 3);
        0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::record_execution(arg0);
        let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg40);
        let (v9, v10) = 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orderbook_analyzer::get_existing_orders<T0, T1>(arg3, arg2, arg5);
        let v11 = v10;
        let v12 = v9;
        let v13 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v14 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2);
        let v15 = 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::config::is_dry_run(v3);
        let v16 = if (0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::config::is_orderbook_analysis_enabled(v3)) {
            0x1::option::some<0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orderbook_analyzer::OrderbookSnapshot>(0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orderbook_analyzer::analyze_orderbook<T0, T1>(arg3, arg2, 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::config::min_significant_qty(v3), 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::config::l2_tick_count(v3), arg5))
        } else {
            0x1::option::none<0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orderbook_analyzer::OrderbookSnapshot>()
        };
        let v17 = v16;
        let v18 = if (arg18) {
            arg6
        } else {
            v6
        };
        let (v19, v20) = if (arg39 > 0 && v18 > 0) {
            let v21 = (v13 as u128) * (v18 as u128);
            let v22 = v21 + (v14 as u128) * (arg39 as u128);
            if (v22 > 0) {
                let v23 = ((v21 * 10000 / v22) as u64);
                let v24 = if (arg34 > 0) {
                    arg34
                } else {
                    5000
                };
                let (v25, v26) = if (v23 > v24 + arg25) {
                    (false, true)
                } else {
                    let (v27, v28) = if (v24 > v23 + arg25) {
                        (false, true)
                    } else {
                        (false, false)
                    };
                    (v28, v27)
                };
                (v26, v25)
            } else {
                (false, false)
            }
        } else {
            (false, false)
        };
        let (v29, v30) = if (arg33) {
            0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::inv_sizing::compute_multipliers(v13, v14, v18, arg39, arg34, arg35, arg36, arg37, arg38)
        } else {
            (0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::inv_sizing::scale(), 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::inv_sizing::scale())
        };
        let v31 = v18 * (100000 - arg7) / 100000;
        let v32 = v18 * (100000 + arg8) / 100000;
        let (v33, v34, v35) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg3);
        let v36 = 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::config::enable_deep_payment(v3);
        let (v37, _, v39, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg3, 1, arg5);
        let v41 = v39;
        let v42 = v37;
        let v43 = if (0x1::vector::length<u64>(&v42) > 0) {
            *0x1::vector::borrow<u64>(&v42, 0)
        } else {
            0
        };
        let v44 = v43;
        let v45 = if (0x1::vector::length<u64>(&v41) > 0) {
            *0x1::vector::borrow<u64>(&v41, 0)
        } else {
            0
        };
        let v46 = v45;
        let v47 = if (arg21) {
            if (!v15) {
                arg24 >= v35
            } else {
                false
            }
        } else {
            false
        };
        if (v47) {
            let v48 = arg24 / v34 * v34;
            if (v48 >= v35) {
                if (!v19) {
                    let v49 = 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orders::round_bid_price(arg26 * (100000 - arg22) / 100000, v33);
                    if (v49 >= v33) {
                        let v50 = (((v14 as u128) * 990000000 / (v49 as u128)) as u64);
                        let v51 = if (v48 < v50) {
                            v48
                        } else {
                            v50
                        };
                        let v52 = v51 / v34 * v34;
                        if (v52 >= v35) {
                            let v53 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v8, arg13 + 3000000, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v49, v52, true, v36, arg12, arg5, arg40);
                            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v53);
                            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v53);
                        };
                    };
                };
                if (!v20) {
                    let v54 = v13 * 99 / 100;
                    let v55 = if (v48 < v54) {
                        v48
                    } else {
                        v54
                    };
                    let v56 = v55 / v34 * v34;
                    if (v56 >= v35) {
                        let v57 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v8, arg13 + 4000000, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orders::round_ask_price(arg26 * (100000 + arg23) / 100000, v33), v56, false, v36, arg12, arg5, arg40);
                        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v57);
                        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v57);
                    };
                };
            };
            let (v58, _, v60, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg3, 1, arg5);
            let v62 = v60;
            let v63 = v58;
            let v64 = if (0x1::vector::length<u64>(&v63) > 0) {
                *0x1::vector::borrow<u64>(&v63, 0)
            } else {
                0
            };
            v44 = v64;
            let v65 = if (0x1::vector::length<u64>(&v62) > 0) {
                *0x1::vector::borrow<u64>(&v62, 0)
            } else {
                0
            };
            v46 = v65;
        };
        if (!arg20) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg3, arg2, &v8, arg5, arg40);
            let v66 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
            let v67 = 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::config::target_base_position(v3);
            let v68 = if (v67 > 0) {
                if (v66 >= v67) {
                    (v66 - v67) * 10000 / v67
                } else {
                    (v67 - v66) * 10000 / v67
                }
            } else {
                0
            };
            0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::events::emit_execution_detail(0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::state_id(arg0), v1, arg11, 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::execution_count(arg0), v0, arg6, v6, 0, 0, v66, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), v67, v68, v66 > v67, arg7, arg8, 0, 0, arg13, false, false, v18, arg26);
            0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::record_order_time(arg0, v0);
            return
        };
        if (0x1::vector::length<u64>(&arg27) > 0) {
            let v69 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
            let v70 = 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::config::target_base_position(v3);
            let v71 = if (v70 > 0) {
                if (v69 >= v70) {
                    (v69 - v70) * 10000 / v70
                } else {
                    (v70 - v69) * 10000 / v70
                }
            } else {
                0
            };
            let v72 = *0x1::vector::borrow<u64>(&arg27, 0);
            let v73 = *0x1::vector::borrow<u64>(&arg28, 0);
            0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::events::emit_execution_detail(0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::state_id(arg0), v1, arg11, 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::execution_count(arg0), v0, arg6, v6, 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orders::round_bid_price(v18 * (100000 - v72) / 100000, v33), 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orders::round_ask_price(v18 * (100000 + v73) / 100000, v33), v69, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), v70, v71, v69 > v70, v72, v73, 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::inv_sizing::apply_multiplier(*0x1::vector::borrow<u64>(&arg29, 0), v29, v34, v35), 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::inv_sizing::apply_multiplier(*0x1::vector::borrow<u64>(&arg30, 0), v30, v34, v35), arg13, true, true, v18, arg26);
            0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::multi_layer::process_layers<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, v18, arg9, arg10, arg13, arg12, &arg27, &arg28, &arg29, &arg30, &arg31, arg32, v29, v30, &v8, v3, v33, v35, v44, v46, arg40);
            return
        };
        let v74 = if (v46 > 0 && v31 >= v46) {
            v46 * (100000 - arg9) / 100000
        } else {
            v31
        };
        let v75 = if (v44 > 0 && v32 <= v44) {
            v44 * (100000 + arg10) / 100000
        } else {
            v32
        };
        let (v76, v77) = if (0x1::option::is_some<0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orderbook_analyzer::OrderbookSnapshot>(&v17) && arg17 > 0) {
            let v78 = 0x1::option::borrow<0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orderbook_analyzer::OrderbookSnapshot>(&v17);
            let (v79, v80) = 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orderbook_analyzer::find_queue_snipe_price(v78, v74, true, v33, arg17);
            let v81 = if (v80) {
                v79
            } else {
                0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orders::round_bid_price(v79, v33)
            };
            let (v82, v83) = 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orderbook_analyzer::find_queue_snipe_price(v78, v75, false, v33, arg17);
            let v84 = if (v83) {
                v82
            } else {
                0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orders::round_ask_price(v82, v33)
            };
            (v81, v84)
        } else {
            (0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orders::round_bid_price(v74, v33), 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orders::round_ask_price(v75, v33))
        };
        let (v85, v86) = if (0x1::option::is_some<0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orderbook_analyzer::OrderbookSnapshot>(&v17)) {
            let v87 = 0x1::option::borrow<0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orderbook_analyzer::OrderbookSnapshot>(&v17);
            let v88 = 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orderbook_analyzer::best_bid(v87);
            let v89 = 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orderbook_analyzer::best_ask(v87);
            let v90 = v76;
            let v91 = v77;
            if (v89 > 0 && v76 >= v89) {
                let v92 = if (v89 > v33) {
                    v89 - v33
                } else {
                    v33
                };
                v90 = v92;
            };
            if (v88 > 0 && v77 <= v88) {
                v91 = v88 + v33;
            };
            (v90, v91)
        } else {
            (v76, v77)
        };
        let v93 = 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::inv_sizing::apply_multiplier(arg14, v29, v34, v35);
        let v94 = 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::inv_sizing::apply_multiplier(arg15, v30, v34, v35);
        let v95 = if (v93 >= 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::config::min_order_size(v3)) {
            if (v93 >= v35) {
                v85 >= 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::config::min_price(v3)
            } else {
                false
            }
        } else {
            false
        };
        let v96 = if (v94 >= 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::config::min_order_size(v3)) {
            if (v94 >= v35) {
                v86 <= 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::config::max_price(v3)
            } else {
                false
            }
        } else {
            false
        };
        if (!v15) {
            if (0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::config::enable_deep_refill(v3)) {
                let (_, _) = 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::deep_manager::ensure_deep_balance<T0, T1, T2, T3>(arg3, arg4, arg2, &v8, v93 + v94, (v85 + v86) / 2, v3, arg5, arg40);
            };
            let v99 = false;
            let v100 = false;
            if (0x1::option::is_some<0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orderbook_analyzer::ExistingOrderInfo>(&v12)) {
                let v101 = 0x1::option::borrow<0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orderbook_analyzer::ExistingOrderInfo>(&v12);
                let v102 = 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orderbook_analyzer::price(v101);
                let v103 = v102 != v85;
                let v104 = !v103 && 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orderbook_analyzer::should_refresh_order(v101, v0, 30000);
                let v105 = v96 && v86 <= v102;
                let v106 = if (v103) {
                    true
                } else if (v104) {
                    true
                } else {
                    v105
                };
                if (v106) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v8, 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orderbook_analyzer::order_id(v101), arg5, arg40);
                    v99 = true;
                };
            };
            if (0x1::option::is_some<0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orderbook_analyzer::ExistingOrderInfo>(&v11)) {
                let v107 = 0x1::option::borrow<0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orderbook_analyzer::ExistingOrderInfo>(&v11);
                let v108 = 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orderbook_analyzer::price(v107);
                let v109 = v108 != v86;
                let v110 = !v109 && 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orderbook_analyzer::should_refresh_order(v107, v0, 30000);
                let v111 = v95 && v85 >= v108;
                let v112 = if (v109) {
                    true
                } else if (v110) {
                    true
                } else {
                    v111
                };
                if (v112) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v8, 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orderbook_analyzer::order_id(v107), arg5, arg40);
                    v100 = true;
                };
            };
            if (v95 && (!0x1::option::is_some<0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orderbook_analyzer::ExistingOrderInfo>(&v12) || v99)) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v8, arg13, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v85, v93, true, v36, arg12, arg5, arg40);
            };
            if (v96 && (!0x1::option::is_some<0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::orderbook_analyzer::ExistingOrderInfo>(&v11) || v100)) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v8, arg13, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v86, v94, false, v36, arg12, arg5, arg40);
            };
        };
        let v113 = 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::config::target_base_position(v3);
        let v114 = if (v113 > 0) {
            if (v13 >= v113) {
                (v13 - v113) * 10000 / v113
            } else {
                (v113 - v13) * 10000 / v113
            }
        } else {
            0
        };
        0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::events::emit_execution_detail(0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::state_id(arg0), v1, arg11, 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::execution_count(arg0), v0, arg6, v6, v85, v86, v13, v14, v113, v114, v13 > v113, arg7, arg8, v93, v94, arg13, v95, v96, v18, arg26);
        0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::record_order_time(arg0, v0);
    }

    public fun get_state_info(arg0: &0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::MMState) : (u64, u64, u64, bool) {
        (0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::current_price(arg0), 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::current_spread(arg0), 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::execution_count(arg0), 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::is_paused(arg0))
    }

    public fun pause_trading<T0, T1>(arg0: &mut 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::owner(arg0) == 0x2::tx_context::sender(arg6), 1);
        0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::advance_sequence(arg0, arg4);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v1, arg5, arg6);
        0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::events::emit_orders_cancelled(0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), v0);
        0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::pause(arg0, v0 + arg3, v0);
    }

    public fun resume_trading(arg0: &mut 0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::MMState, arg1: &0x2::tx_context::TxContext) {
        assert!(0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::owner(arg0) == 0x2::tx_context::sender(arg1), 1);
        0x8e5df33cdf58389097b9c6d81b99e4e193ec24bc21b26b6163546cc1c627da98::mm_state::unpause(arg0);
    }

    // decompiled from Move bytecode v6
}

