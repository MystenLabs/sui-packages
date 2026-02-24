module 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::leva_deep_mm {
    public fun cancel_all_orders<T0, T1>(arg0: &mut 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::owner(arg0) == 0x2::tx_context::sender(arg5), 1);
        0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::advance_sequence(arg0, arg3);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg4, arg5);
        0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::events::emit_orders_cancelled(0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg4));
    }

    public fun cancel_and_settle<T0, T1>(arg0: &mut 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::owner(arg0) == 0x2::tx_context::sender(arg5), 1);
        0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::advance_sequence(arg0, arg3);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v0, arg4, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg2, arg1, &v0);
        0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::events::emit_orders_cancelled(0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg4));
    }

    public fun execute<T0, T1, T2, T3>(arg0: &mut 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::MMState, arg1: &0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_registry::MMRegistry, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: bool, arg19: bool, arg20: bool, arg21: u64, arg22: u64, arg23: u64, arg24: vector<u64>, arg25: vector<u64>, arg26: vector<u64>, arg27: vector<u64>, arg28: vector<u64>, arg29: u64, arg30: bool, arg31: u64, arg32: u64, arg33: u64, arg34: u64, arg35: u64, arg36: u64, arg37: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3);
        if (arg19) {
            0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::advance_sequence(arg0, arg11);
            let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg37);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg3, arg2, &v2, arg5, arg37);
            0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::events::emit_orders_cancelled(0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::state_id(arg0), v1, v0);
            return
        };
        if (0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::is_trading_blocked(arg0, v0)) {
            return
        };
        let v3 = 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_registry::get_pool_config(arg1, v1);
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
        assert!(0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::update_price(arg0, v6, (arg7 + arg8) / 2, arg11, v0), 3);
        0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::record_execution(arg0);
        let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg37);
        let (v9, v10) = 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orderbook_analyzer::get_existing_orders<T0, T1>(arg3, arg2, arg5);
        let v11 = v10;
        let v12 = v9;
        let v13 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v14 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2);
        let v15 = 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::config::is_dry_run(v3);
        let v16 = if (0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::config::is_orderbook_analysis_enabled(v3)) {
            0x1::option::some<0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orderbook_analyzer::OrderbookSnapshot>(0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orderbook_analyzer::analyze_orderbook<T0, T1>(arg3, arg2, 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::config::min_significant_qty(v3), 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::config::l2_tick_count(v3), arg5))
        } else {
            0x1::option::none<0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orderbook_analyzer::OrderbookSnapshot>()
        };
        let v17 = v16;
        let v18 = if (arg18) {
            arg6
        } else {
            v6
        };
        let (v19, v20) = if (arg36 > 0 && v18 > 0) {
            let v21 = (v13 as u128) * (v18 as u128);
            let v22 = v21 + (v14 as u128) * (arg36 as u128);
            if (v22 > 0) {
                let v23 = ((v21 * 10000 / v22) as u64);
                let v24 = if (arg31 > 0) {
                    arg31
                } else {
                    5000
                };
                let (v25, v26) = if (v23 > v24 + 100) {
                    (false, true)
                } else {
                    let (v27, v28) = if (v24 > v23 + 100) {
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
        let (v29, v30) = if (arg30) {
            0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::inv_sizing::compute_multipliers(v13, v14, v18, arg36, arg31, arg32, arg33, arg34, arg35)
        } else {
            (0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::inv_sizing::scale(), 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::inv_sizing::scale())
        };
        let v31 = v18 * (100000 - arg7) / 100000;
        let v32 = v18 * (100000 + arg8) / 100000;
        let (v33, v34, v35) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg3);
        let v36 = 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::config::enable_deep_payment(v3);
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
        let v47 = if (arg20) {
            if (!v15) {
                arg23 >= v35
            } else {
                false
            }
        } else {
            false
        };
        if (v47) {
            let v48 = arg23 / v34 * v34;
            if (v48 >= v35) {
                if (v20) {
                    let v49 = 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orders::round_bid_price(v18 * (100000 - arg21) / 100000, v33);
                    if (v49 >= v33) {
                        let v50 = (((v14 as u128) * 990000000 / (v49 as u128)) as u64);
                        let v51 = if (v48 < v50) {
                            v48
                        } else {
                            v50
                        };
                        let v52 = v51 / v34 * v34;
                        if (v52 >= v35) {
                            let v53 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v8, arg13 + 3000000, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v49, v52, true, v36, arg12, arg5, arg37);
                            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v53);
                            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v53);
                        };
                    };
                };
                if (v19) {
                    let v54 = v13 * 99 / 100;
                    let v55 = if (v48 < v54) {
                        v48
                    } else {
                        v54
                    };
                    let v56 = v55 / v34 * v34;
                    if (v56 >= v35) {
                        let v57 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v8, arg13 + 4000000, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orders::round_ask_price(v18 * (100000 + arg22) / 100000, v33), v56, false, v36, arg12, arg5, arg37);
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
        if (0x1::vector::length<u64>(&arg24) > 0) {
            let v66 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
            let v67 = 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::config::target_base_position(v3);
            let v68 = if (v67 > 0) {
                if (v66 >= v67) {
                    (v66 - v67) * 10000 / v67
                } else {
                    (v67 - v66) * 10000 / v67
                }
            } else {
                0
            };
            let v69 = *0x1::vector::borrow<u64>(&arg24, 0);
            let v70 = *0x1::vector::borrow<u64>(&arg25, 0);
            0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::events::emit_execution_detail(0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::state_id(arg0), v1, arg11, 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::execution_count(arg0), v0, arg6, v6, 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orders::round_bid_price(v18 * (100000 - v69) / 100000, v33), 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orders::round_ask_price(v18 * (100000 + v70) / 100000, v33), v66, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), v67, v68, v66 > v67, v69, v70, 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::inv_sizing::apply_multiplier(*0x1::vector::borrow<u64>(&arg26, 0), v29, v34, v35), 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::inv_sizing::apply_multiplier(*0x1::vector::borrow<u64>(&arg27, 0), v30, v34, v35), arg13, true, true, v18);
            0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::multi_layer::process_layers<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, v18, arg9, arg10, arg13, arg12, &arg24, &arg25, &arg26, &arg27, &arg28, arg29, v29, v30, &v8, v3, v33, v35, v44, v46, arg37);
            return
        };
        let v71 = if (v46 > 0 && v31 >= v46) {
            v46 * (100000 - arg9) / 100000
        } else {
            v31
        };
        let v72 = if (v44 > 0 && v32 <= v44) {
            v44 * (100000 + arg10) / 100000
        } else {
            v32
        };
        let (v73, v74) = if (0x1::option::is_some<0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orderbook_analyzer::OrderbookSnapshot>(&v17) && arg17 > 0) {
            let v75 = 0x1::option::borrow<0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orderbook_analyzer::OrderbookSnapshot>(&v17);
            let (v76, v77) = 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orderbook_analyzer::find_queue_snipe_price(v75, v71, true, v33, arg17);
            let v78 = if (v77) {
                v76
            } else {
                0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orders::round_bid_price(v76, v33)
            };
            let (v79, v80) = 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orderbook_analyzer::find_queue_snipe_price(v75, v72, false, v33, arg17);
            let v81 = if (v80) {
                v79
            } else {
                0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orders::round_ask_price(v79, v33)
            };
            (v78, v81)
        } else {
            (0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orders::round_bid_price(v71, v33), 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orders::round_ask_price(v72, v33))
        };
        let (v82, v83) = if (0x1::option::is_some<0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orderbook_analyzer::OrderbookSnapshot>(&v17)) {
            let v84 = 0x1::option::borrow<0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orderbook_analyzer::OrderbookSnapshot>(&v17);
            let v85 = 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orderbook_analyzer::best_bid(v84);
            let v86 = 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orderbook_analyzer::best_ask(v84);
            let v87 = v73;
            let v88 = v74;
            if (v86 > 0 && v73 >= v86) {
                let v89 = if (v86 > v33) {
                    v86 - v33
                } else {
                    v33
                };
                v87 = v89;
            };
            if (v85 > 0 && v74 <= v85) {
                v88 = v85 + v33;
            };
            (v87, v88)
        } else {
            (v73, v74)
        };
        let v90 = 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::inv_sizing::apply_multiplier(arg14, v29, v34, v35);
        let v91 = 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::inv_sizing::apply_multiplier(arg15, v30, v34, v35);
        let v92 = if (v90 >= 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::config::min_order_size(v3)) {
            if (v90 >= v35) {
                v82 >= 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::config::min_price(v3)
            } else {
                false
            }
        } else {
            false
        };
        let v93 = if (v91 >= 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::config::min_order_size(v3)) {
            if (v91 >= v35) {
                v83 <= 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::config::max_price(v3)
            } else {
                false
            }
        } else {
            false
        };
        if (!v15) {
            if (0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::config::enable_deep_refill(v3)) {
                let (_, _) = 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::deep_manager::ensure_deep_balance<T0, T1, T2, T3>(arg3, arg4, arg2, &v8, v90 + v91, (v82 + v83) / 2, v3, arg5, arg37);
            };
            let v96 = false;
            let v97 = false;
            if (0x1::option::is_some<0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orderbook_analyzer::ExistingOrderInfo>(&v12)) {
                let v98 = 0x1::option::borrow<0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orderbook_analyzer::ExistingOrderInfo>(&v12);
                let v99 = 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orderbook_analyzer::price(v98);
                let v100 = v99 != v82;
                let v101 = !v100 && 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orderbook_analyzer::should_refresh_order(v98, v0, 30000);
                let v102 = v93 && v83 <= v99;
                let v103 = if (v100) {
                    true
                } else if (v101) {
                    true
                } else {
                    v102
                };
                if (v103) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v8, 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orderbook_analyzer::order_id(v98), arg5, arg37);
                    v96 = true;
                };
            };
            if (0x1::option::is_some<0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orderbook_analyzer::ExistingOrderInfo>(&v11)) {
                let v104 = 0x1::option::borrow<0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orderbook_analyzer::ExistingOrderInfo>(&v11);
                let v105 = 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orderbook_analyzer::price(v104);
                let v106 = v105 != v83;
                let v107 = !v106 && 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orderbook_analyzer::should_refresh_order(v104, v0, 30000);
                let v108 = v92 && v82 >= v105;
                let v109 = if (v106) {
                    true
                } else if (v107) {
                    true
                } else {
                    v108
                };
                if (v109) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, &v8, 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orderbook_analyzer::order_id(v104), arg5, arg37);
                    v97 = true;
                };
            };
            if (v92 && (!0x1::option::is_some<0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orderbook_analyzer::ExistingOrderInfo>(&v12) || v96)) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v8, arg13, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v82, v90, true, v36, arg12, arg5, arg37);
            };
            if (v93 && (!0x1::option::is_some<0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::orderbook_analyzer::ExistingOrderInfo>(&v11) || v97)) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v8, arg13, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v83, v91, false, v36, arg12, arg5, arg37);
            };
        };
        let v110 = 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::config::target_base_position(v3);
        let v111 = if (v110 > 0) {
            if (v13 >= v110) {
                (v13 - v110) * 10000 / v110
            } else {
                (v110 - v13) * 10000 / v110
            }
        } else {
            0
        };
        0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::events::emit_execution_detail(0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::state_id(arg0), v1, arg11, 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::execution_count(arg0), v0, arg6, v6, v82, v83, v13, v14, v110, v111, v13 > v110, arg7, arg8, v90, v91, arg13, v92, v93, v18);
        0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::record_order_time(arg0, v0);
    }

    public fun get_state_info(arg0: &0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::MMState) : (u64, u64, u64, bool) {
        (0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::current_price(arg0), 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::current_spread(arg0), 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::execution_count(arg0), 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::is_paused(arg0))
    }

    public fun pause_trading<T0, T1>(arg0: &mut 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::MMState, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::owner(arg0) == 0x2::tx_context::sender(arg6), 1);
        0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::advance_sequence(arg0, arg4);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, arg1, &v1, arg5, arg6);
        0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::events::emit_orders_cancelled(0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::state_id(arg0), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), v0);
        0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::pause(arg0, v0 + arg3, v0);
    }

    public fun resume_trading(arg0: &mut 0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::MMState, arg1: &0x2::tx_context::TxContext) {
        assert!(0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::owner(arg0) == 0x2::tx_context::sender(arg1), 1);
        0xf5e10f0290def4440767d1fa9faef4485b11a25df556fb1eca1162c81e6700bd::mm_state::unpause(arg0);
    }

    // decompiled from Move bytecode v6
}

