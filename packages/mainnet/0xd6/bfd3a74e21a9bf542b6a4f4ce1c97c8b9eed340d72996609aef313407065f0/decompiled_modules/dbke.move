module 0xd6bfd3a74e21a9bf542b6a4f4ce1c97c8b9eed340d72996609aef313407065f0::dbke {
    struct EE has copy, drop {
        e: u64,
        l: u64,
    }

    struct DD has copy, drop {
        tp: u64,
        op: u64,
        np: u64,
    }

    struct DFP has copy, drop {
        fp: u64,
    }

    fun ad(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public fun cao_s<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u64 {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0
    }

    public fun caw<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg1, arg2, arg3, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T2>(arg1, arg4, arg5)
    }

    fun dio(arg0: u128) : bool {
        arg0 >> 127 == 0
    }

    public fun ef(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg0);
        if (v0 < arg3) {
            let v1 = arg3 * 2 - v0;
            if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg2) < v1) {
                abort 108
            };
            let v2 = 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::twc(arg1, arg4);
            0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::dwc(arg1, v2, arg4);
            0x2::coin::join<0x2::sui::SUI>(arg0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<0x2::sui::SUI>(arg2, &v2, v1, arg4));
        };
    }

    public fun elf<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2::clock::Clock, arg4: bool, arg5: u64, arg6: u64, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: vector<u64>, arg14: vector<u64>, arg15: 0x1::option::Option<0x2::object::ID>, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::gdtp(arg1, arg2, arg16);
        if (arg4) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg2, &v0, arg3, arg16);
        };
        let (v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v4 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v5 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2);
        let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg2);
        let v7 = if (v4 > arg5) {
            v4 - arg5
        } else {
            0
        };
        let v8 = if (v5 > arg6) {
            v5 - arg6
        } else {
            0
        };
        let v9 = 0x2::clock::timestamp_ms(arg3);
        let (v10, v11, v12) = eto<T0, T1>(arg0, arg2, &v0, arg3, v7, v8, v6, arg7, arg8, arg11, arg12, arg13, v9, v3, v1, v2, arg16);
        let (v13, v14) = if (0x1::option::is_some<0x2::object::ID>(&arg15)) {
            gcbba<T0, T1>(arg0, arg3, 0x1::option::borrow<0x2::object::ID>(&arg15))
        } else {
            (0, 0)
        };
        let (_, _, _) = emo<T0, T1>(arg0, arg2, &v0, arg3, v10, v11, v12, arg9, arg10, arg11, arg12, arg13, arg14, v9, v3, v1, v2, v13, v14, arg16);
    }

    fun emo<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: &0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = 3;
        let v1 = 2;
        let (v2, _, v4, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg3);
        let v6 = v4;
        let v7 = v2;
        let v8 = 0x1::vector::length<u64>(&v7);
        let v9 = 0x1::vector::length<u64>(&v6);
        let v10 = arg4;
        let v11 = arg5;
        let v12 = arg6;
        let v13 = 0;
        while (v13 < 0x1::vector::length<u64>(&arg7)) {
            let v14 = *0x1::vector::borrow<u64>(&arg7, v13);
            v13 = v13 + 1;
            let v15 = *0x1::vector::borrow<u64>(&arg11, v14);
            if (v15 < arg13) {
                let v16 = EE{
                    e : 107,
                    l : 569,
                };
                0x2::event::emit<EE>(v16);
                continue
            };
            let v17 = *0x1::vector::borrow<u64>(&arg12, v14);
            if (v11 == 0) {
                let v18 = EE{
                    e : 103,
                    l : 578,
                };
                0x2::event::emit<EE>(v18);
                break
            };
            let v19 = sp(&v7, &v6, arg15, *0x1::vector::borrow<u64>(&arg9, v14), true, v8, v9);
            if (v19 == 0) {
                let v20 = EE{
                    e : 101,
                    l : 593,
                };
                0x2::event::emit<EE>(v20);
                continue
            };
            let v21 = v19;
            let v22 = if (arg17 > 0) {
                if (v17 > 0) {
                    v19 <= arg17
                } else {
                    false
                }
            } else {
                false
            };
            if (v22) {
                if (((arg17 - v19) as u128) * (10000 as u128) <= (v19 as u128) * (v17 as u128)) {
                    let v23 = arg17 + arg15;
                    v21 = v23;
                    let v24 = DD{
                        tp : arg17,
                        op : v19,
                        np : v23,
                    };
                    0x2::event::emit<DD>(v24);
                    if (v9 > 0) {
                        let v25 = *0x1::vector::borrow<u64>(&v6, 0);
                        if (v23 >= v25 && v25 >= arg15) {
                            v21 = v25 - arg15;
                        };
                    };
                };
            };
            let (v26, v27) = vbac<T0, T1>(arg0, v10, v11, v12, arg15, arg16, arg14, v21, *0x1::vector::borrow<u64>(&arg10, v14), true, true, true);
            if (v27 != 0) {
                let v28 = EE{
                    e : v27,
                    l : 633,
                };
                0x2::event::emit<EE>(v28);
                if (v27 == 103 || v27 == 104) {
                    break
                } else {
                    continue
                };
            };
            let v29 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg1, arg2, 18446744073709551615, v0, v1, v21, v26, true, true, v15, arg3, arg19);
            v10 = v10 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v29);
            v11 = v11 - (((0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(&v29) as u128) * (v21 as u128) / 1000000000 + 1) as u64);
            v12 = v12 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v29);
        };
        v13 = 0;
        while (v13 < 0x1::vector::length<u64>(&arg8)) {
            let v30 = *0x1::vector::borrow<u64>(&arg8, v13);
            v13 = v13 + 1;
            let v31 = *0x1::vector::borrow<u64>(&arg11, v30);
            if (v31 < arg13) {
                let v32 = EE{
                    e : 107,
                    l : 681,
                };
                0x2::event::emit<EE>(v32);
                continue
            };
            let v33 = *0x1::vector::borrow<u64>(&arg12, v30);
            if (v10 < arg14) {
                let v34 = EE{
                    e : 102,
                    l : 690,
                };
                0x2::event::emit<EE>(v34);
                break
            };
            let v35 = sp(&v7, &v6, arg15, *0x1::vector::borrow<u64>(&arg9, v30), false, v8, v9);
            if (v35 == 0) {
                let v36 = EE{
                    e : 101,
                    l : 705,
                };
                0x2::event::emit<EE>(v36);
                continue
            };
            let v37 = v35;
            let v38 = if (arg18 > 0) {
                if (v33 > 0) {
                    if (arg18 > arg15) {
                        v35 >= arg18
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v38) {
                if (((v35 - arg18) as u128) * (10000 as u128) <= (v35 as u128) * (v33 as u128)) {
                    let v39 = arg18 - arg15;
                    v37 = v39;
                    if (v8 > 0) {
                        let v40 = *0x1::vector::borrow<u64>(&v7, 0);
                        let v41 = DD{
                            tp : arg18,
                            op : v35,
                            np : v39,
                        };
                        0x2::event::emit<DD>(v41);
                        if (v39 <= v40 && v40 <= 18446744073709551615 - arg15) {
                            v37 = v40 + arg15;
                        };
                    };
                };
            };
            let (v42, v43) = vbac<T0, T1>(arg0, v10, v11, v12, arg15, arg16, arg14, v37, *0x1::vector::borrow<u64>(&arg10, v30), false, true, true);
            if (v43 != 0) {
                let v44 = EE{
                    e : v43,
                    l : 746,
                };
                0x2::event::emit<EE>(v44);
                if (v43 == 102 || v43 == 104) {
                    break
                } else {
                    continue
                };
            };
            let v45 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg1, arg2, 0, v0, v1, v37, v42, false, true, v31, arg3, arg19);
            v10 = v10 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(&v45);
            v11 = v11 + (((0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v45) as u128) * (v37 as u128) / 1000000000) as u64);
            v12 = v12 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v45);
        };
        (v10, v11, v12)
    }

    fun eto<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: &0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = 1;
        let v1 = 2;
        let (v2, _, v4, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg3);
        let v6 = v4;
        let v7 = v2;
        let v8 = 0x1::vector::length<u64>(&v7);
        let v9 = 0x1::vector::length<u64>(&v6);
        let v10 = arg4;
        let v11 = arg5;
        let v12 = arg6;
        let v13 = 0;
        while (v13 < 0x1::vector::length<u64>(&arg7)) {
            let v14 = *0x1::vector::borrow<u64>(&arg7, v13);
            v13 = v13 + 1;
            let v15 = *0x1::vector::borrow<u64>(&arg11, v14);
            if (v15 < arg12) {
                let v16 = EE{
                    e : 107,
                    l : 362,
                };
                0x2::event::emit<EE>(v16);
                continue
            };
            let v17 = *0x1::vector::borrow<u64>(&arg9, v14);
            if (v11 == 0) {
                let v18 = EE{
                    e : 103,
                    l : 371,
                };
                0x2::event::emit<EE>(v18);
                break
            };
            if (!vtop(v17, true, &v7, &v6, v8, v9)) {
                break
            };
            let (v19, v20) = vbac<T0, T1>(arg0, v10, v11, v12, arg14, arg15, arg13, v17, *0x1::vector::borrow<u64>(&arg10, v14), true, false, true);
            if (v20 != 0) {
                let v21 = EE{
                    e : v20,
                    l : 405,
                };
                0x2::event::emit<EE>(v21);
                continue
            };
            let v22 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg1, arg2, 18446744073709551615, v0, v1, v17, v19, true, true, v15, arg3, arg16);
            let v23 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v22);
            v10 = v10 + v23;
            v11 = v11 - (((v23 as u128) * (v17 as u128) / 1000000000 + 1) as u64);
            v12 = v12 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v22);
        };
        v13 = 0;
        while (v13 < 0x1::vector::length<u64>(&arg8)) {
            let v24 = *0x1::vector::borrow<u64>(&arg8, v13);
            v13 = v13 + 1;
            let v25 = *0x1::vector::borrow<u64>(&arg11, v24);
            if (v25 < arg12) {
                let v26 = EE{
                    e : 107,
                    l : 446,
                };
                0x2::event::emit<EE>(v26);
                continue
            };
            let v27 = *0x1::vector::borrow<u64>(&arg9, v24);
            if (v10 < arg13) {
                let v28 = EE{
                    e : 102,
                    l : 455,
                };
                0x2::event::emit<EE>(v28);
                break
            };
            if (!vtop(v27, false, &v7, &v6, v8, v9)) {
                break
            };
            let (v29, v30) = vbac<T0, T1>(arg0, v10, v11, v12, arg14, arg15, arg13, v27, *0x1::vector::borrow<u64>(&arg10, v24), false, false, true);
            if (v30 != 0) {
                let v31 = EE{
                    e : v30,
                    l : 489,
                };
                0x2::event::emit<EE>(v31);
                continue
            };
            let v32 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg1, arg2, 18446744073709551615, v0, v1, v27, v29, false, true, v25, arg3, arg16);
            let v33 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v32);
            v10 = v10 - v33;
            v11 = v11 + (((v33 as u128) * (v27 as u128) / 1000000000) as u64);
            v12 = v12 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v32);
        };
        (v10, v11, v12)
    }

    fun gcbba<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::object::ID) : (u64, u64) {
        let v0 = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg1) + 300);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::iter_orders<T0, T1>(arg0, 0x1::option::none<u128>(), 0x1::option::none<u128>(), v0, 10, true);
        let v2 = 0;
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::orders(&v1);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v3)) {
            let v5 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v3, v4);
            if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::balance_manager_id(v5) == *arg2) {
                v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v5);
                break
            };
            v4 = v4 + 1;
        };
        let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::iter_orders<T0, T1>(arg0, 0x1::option::none<u128>(), 0x1::option::none<u128>(), v0, 10, false);
        let v7 = 0;
        let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::orders(&v6);
        v4 = 0;
        while (v4 < 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v8)) {
            let v9 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v8, v4);
            if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::balance_manager_id(v9) == *arg2) {
                v7 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v9);
                break
            };
            v4 = v4 + 1;
        };
        (v2, v7)
    }

    fun smo<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: &0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_account_order_details<T0, T1>(arg0, arg1);
        let v1 = 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&v0);
        let v2 = 0x1::vector::empty<bool>();
        let v3 = 0;
        while (v3 < v1) {
            0x1::vector::push_back<bool>(&mut v2, false);
            v3 = v3 + 1;
        };
        let v4 = 0;
        let v5 = 0x1::vector::empty<u128>();
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0x1::vector::empty<u64>();
        v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg6)) {
            let v8 = *0x1::vector::borrow<u64>(&arg6, v3);
            v3 = v3 + 1;
            let v9 = *0x1::vector::borrow<u64>(&arg9, v8);
            let v10 = false;
            let v11 = 0;
            while (v11 < v1) {
                if (!*0x1::vector::borrow<bool>(&v2, v11)) {
                    let v12 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&v0, v11);
                    if (dio(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v12))) {
                        let v13 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(v12) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v12);
                        let v14 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(v12);
                        if (ad(*0x1::vector::borrow<u64>(&arg8, v8), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v12)) <= *0x1::vector::borrow<u64>(&arg12, v8) && v14 > arg15 + arg14) {
                            let v15 = (v9 as u128) * ((100 + arg13) as u128) / 100;
                            if ((v13 as u128) >= (v9 as u128) * ((100 - arg13) as u128) / 100 && (v13 as u128) <= v15) {
                                *0x1::vector::borrow_mut<bool>(&mut v2, v11) = true;
                                v10 = true;
                                v4 = v4 + 1;
                                break
                            };
                            if ((v13 as u128) > v15) {
                                let v16 = v9 / arg18 * arg18;
                                let v17 = if (v16 > 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v12)) {
                                    if (v16 >= arg16) {
                                        v14 > arg15 + arg14 * 2
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                };
                                if (v17) {
                                    *0x1::vector::borrow_mut<bool>(&mut v2, v11) = true;
                                    v10 = true;
                                    0x1::vector::push_back<u128>(&mut v5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v12));
                                    0x1::vector::push_back<u64>(&mut v6, v16);
                                    break
                                };
                            };
                        };
                    };
                };
                v11 = v11 + 1;
            };
            if (!v10) {
                0x1::vector::push_back<u64>(&mut v7, v8);
            };
        };
        let v18 = 0x1::vector::empty<u64>();
        v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg7)) {
            let v19 = *0x1::vector::borrow<u64>(&arg7, v3);
            v3 = v3 + 1;
            let v20 = *0x1::vector::borrow<u64>(&arg9, v19);
            let v21 = false;
            let v22 = 0;
            while (v22 < v1) {
                if (!*0x1::vector::borrow<bool>(&v2, v22)) {
                    let v23 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&v0, v22);
                    if (!dio(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v23))) {
                        let v24 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(v23) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v23);
                        let v25 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(v23);
                        if (ad(*0x1::vector::borrow<u64>(&arg8, v19), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v23)) <= *0x1::vector::borrow<u64>(&arg12, v19) && v25 > arg15 + arg14) {
                            let v26 = (v20 as u128) * ((100 + arg13) as u128) / 100;
                            if ((v24 as u128) >= (v20 as u128) * ((100 - arg13) as u128) / 100 && (v24 as u128) <= v26) {
                                *0x1::vector::borrow_mut<bool>(&mut v2, v22) = true;
                                v21 = true;
                                v4 = v4 + 1;
                                break
                            };
                            if ((v24 as u128) > v26) {
                                let v27 = v20 / arg18 * arg18;
                                let v28 = if (v27 > 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v23)) {
                                    if (v27 >= arg16) {
                                        v25 > arg15 + arg14 * 2
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                };
                                if (v28) {
                                    *0x1::vector::borrow_mut<bool>(&mut v2, v22) = true;
                                    v21 = true;
                                    0x1::vector::push_back<u128>(&mut v5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v23));
                                    0x1::vector::push_back<u64>(&mut v6, v27);
                                    break
                                };
                            };
                        };
                    };
                };
                v22 = v22 + 1;
            };
            if (!v21) {
                0x1::vector::push_back<u64>(&mut v18, v19);
            };
        };
        v3 = 0;
        while (v3 < 0x1::vector::length<u128>(&v5)) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::modify_order<T0, T1>(arg0, arg1, arg2, *0x1::vector::borrow<u128>(&v5, v3), *0x1::vector::borrow<u64>(&v6, v3), arg3, arg21);
            v3 = v3 + 1;
        };
        v3 = 0;
        while (v3 < v1) {
            if (!*0x1::vector::borrow<bool>(&v2, v3)) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg0, arg1, arg2, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&v0, v3)), arg3, arg21);
            };
            v3 = v3 + 1;
        };
        let v29 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1);
        let v30 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1);
        let v31 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg1);
        let v32 = if (v29 > arg4) {
            v29 - arg4
        } else {
            0
        };
        let v33 = if (v30 > arg5) {
            v30 - arg5
        } else {
            0
        };
        emo<T0, T1>(arg0, arg1, arg2, arg3, v32, v33, v31, v7, v18, arg8, arg9, arg10, arg11, arg15, arg16, arg17, arg18, arg19, arg20, arg21)
    }

    fun sp(arg0: &vector<u64>, arg1: &vector<u64>, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: u64) : u64 {
        if (arg3 % arg2 != 0) {
            return 0
        };
        if (arg4) {
            if (arg6 == 0) {
                return arg3
            };
            let v1 = *0x1::vector::borrow<u64>(arg1, 0);
            if (arg3 < v1) {
                return arg3
            };
            if (v1 < arg2) {
                return 0
            };
            v1 - arg2
        } else {
            if (arg5 == 0) {
                return arg3
            };
            let v2 = *0x1::vector::borrow<u64>(arg0, 0);
            if (arg3 > v2) {
                return arg3
            };
            if (v2 > 18446744073709551615 - arg2) {
                return 0
            };
            v2 + arg2
        }
    }

    public fun suf<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: vector<u64>, arg14: vector<u64>, arg15: u64, arg16: u64, arg17: 0x1::option::Option<0x2::object::ID>, arg18: 0x1::option::Option<u64>, arg19: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::gdtp(arg1, arg2, arg19);
        let (v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v4 = 0x2::clock::timestamp_ms(arg3);
        let (v5, v6) = if (0x1::option::is_some<0x2::object::ID>(&arg17)) {
            gcbba<T0, T1>(arg0, arg3, 0x1::option::borrow<0x2::object::ID>(&arg17))
        } else {
            (0, 0)
        };
        let (_, _, _) = smo<T0, T1, T2>(arg0, arg2, &v0, arg3, arg4, arg5, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, v4, v3, v1, v2, v5, v6, arg19);
        let v10 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v11 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2);
        let v12 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg2);
        let v13 = if (v10 > arg4) {
            v10 - arg4
        } else {
            0
        };
        let v14 = if (v11 > arg5) {
            v11 - arg5
        } else {
            0
        };
        let (_, _, _) = eto<T0, T1>(arg0, arg2, &v0, arg3, v13, v14, v12, arg6, arg7, arg10, arg11, arg12, v4, v3, v1, v2, arg19);
        if (0x1::option::is_some<u64>(&arg18)) {
            let v18 = DFP{fp: *0x1::option::borrow<u64>(&arg18)};
            0x2::event::emit<DFP>(v18);
        };
    }

    fun vbac<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: bool, arg11: bool) : (u64, u64) {
        if (arg7 == 0) {
            return (0, 101)
        };
        if (arg7 % arg4 != 0) {
            return (0, 101)
        };
        if (!arg9 && arg1 < arg6) {
            return (0, 102)
        };
        if (arg8 < arg6) {
            return (0, 105)
        };
        let v0 = if (arg9) {
            let v1 = (((arg2 as u128) * 1000000000 / (arg7 as u128)) as u64);
            let v2 = v1 % arg5 + arg5;
            if (v1 < v2) {
                return (0, 103)
            };
            let v3 = v1 - v2;
            if (v3 < arg6) {
                return (0, 103)
            };
            let v4 = 0x1::u64::max(arg6, 0x1::u64::min(arg8, (v3 as u64)));
            v4 - v4 % arg5
        } else {
            let v5 = 0x1::u64::max(arg6, 0x1::u64::min(arg8, arg1));
            v5 - v5 % arg5
        };
        let v6 = if (arg11) {
            let (v7, v8) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order_deep_required<T0, T1>(arg0, v0, arg7);
            if (arg10) {
                v8
            } else {
                v7
            }
        } else {
            0
        };
        if (v6 > arg3) {
            return (0, 104)
        };
        (v0, 0)
    }

    fun vtop(arg0: u64, arg1: bool, arg2: &vector<u64>, arg3: &vector<u64>, arg4: u64, arg5: u64) : bool {
        if (arg0 == 0) {
            return false
        };
        if (arg1) {
            if (arg5 == 0) {
                return false
            };
            if (arg0 < *0x1::vector::borrow<u64>(arg3, 0)) {
                return false
            };
        } else {
            if (arg4 == 0) {
                return false
            };
            if (arg0 > *0x1::vector::borrow<u64>(arg2, 0)) {
                return false
            };
        };
        true
    }

    // decompiled from Move bytecode v6
}

