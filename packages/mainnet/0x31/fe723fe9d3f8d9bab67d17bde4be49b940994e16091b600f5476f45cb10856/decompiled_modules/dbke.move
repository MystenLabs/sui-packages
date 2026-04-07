module 0x31fe723fe9d3f8d9bab67d17bde4be49b940994e16091b600f5476f45cb10856::dbke {
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

    fun dmp(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : u64 {
        let v0 = sp(arg0, arg1, arg2, arg3, arg4);
        if (v0 == 0) {
            return 0
        };
        let v1 = v0;
        if (arg2) {
            let v2 = if (arg6 > 0) {
                if (arg5 > 0) {
                    v0 <= arg6
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                if (((arg6 - v0) as u128) * (10000 as u128) <= (v0 as u128) * (arg5 as u128)) {
                    let v3 = arg6 + arg0;
                    v1 = v3;
                    let v4 = if (arg4 > 0) {
                        if (v3 >= arg4) {
                            arg4 >= arg0
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    if (v4) {
                        v1 = arg4 - arg0;
                    };
                };
            };
        } else {
            let v5 = if (arg6 > 0) {
                if (arg5 > 0) {
                    if (arg6 > arg0) {
                        v0 >= arg6
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v5) {
                if (((v0 - arg6) as u128) * (10000 as u128) <= (v0 as u128) * (arg5 as u128)) {
                    let v6 = arg6 - arg0;
                    v1 = v6;
                    let v7 = if (arg3 > 0) {
                        if (v6 <= arg3) {
                            arg3 <= 18446744073709551615 - arg0
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    if (v7) {
                        v1 = arg3 + arg0;
                    };
                };
            };
        };
        v1
    }

    public fun ef(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg0);
        if (v0 < arg3) {
            let v1 = arg3 * 120 / 100 - v0;
            if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg2) < v1) {
                abort 108
            };
            let v2 = 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::twc(arg1, arg4);
            0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::dwc(arg1, v2, arg4);
            0x2::coin::join<0x2::sui::SUI>(arg0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<0x2::sui::SUI>(arg2, &v2, v1, arg4));
        };
    }

    public fun elf<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2::clock::Clock, arg4: bool, arg5: u64, arg6: u64, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: vector<u64>, arg14: vector<u64>, arg15: 0x1::option::Option<0x2::object::ID>, arg16: 0x1::option::Option<u64>, arg17: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<u64>(&arg16)) {
            let v0 = DFP{fp: *0x1::option::borrow<u64>(&arg16)};
            0x2::event::emit<DFP>(v0);
        };
        let v1 = 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::gdtp(arg1, arg2, arg17);
        if (arg4) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg2, &v1, arg3, arg17);
        };
        let (v2, v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v5 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2);
        let v7 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg2);
        let v8 = if (v5 > arg5) {
            v5 - arg5
        } else {
            0
        };
        let v9 = if (v6 > arg6) {
            v6 - arg6
        } else {
            0
        };
        let v10 = 0x2::clock::timestamp_ms(arg3);
        let (v11, v12, v13) = eto<T0, T1>(arg0, arg2, &v1, arg3, v8, v9, v7, arg7, arg8, arg11, arg12, arg13, v10, v4, v2, v3, arg17);
        let (v14, v15) = if (0x1::option::is_some<0x2::object::ID>(&arg15)) {
            gcbba<T0, T1>(arg0, arg3, 0x1::option::borrow<0x2::object::ID>(&arg15))
        } else {
            (0x1::vector::empty<u64>(), 0x1::vector::empty<u64>())
        };
        let v16 = v15;
        let v17 = v14;
        let (v18, _, v20, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg3);
        let v22 = v20;
        let v23 = v18;
        let v24 = if (0x1::vector::length<u64>(&v23) > 0) {
            *0x1::vector::borrow<u64>(&v23, 0)
        } else {
            0
        };
        let v25 = if (0x1::vector::length<u64>(&v22) > 0) {
            *0x1::vector::borrow<u64>(&v22, 0)
        } else {
            0
        };
        let v26 = 0;
        while (v26 < 0x1::vector::length<u64>(&arg9)) {
            let v27 = *0x1::vector::borrow<u64>(&arg9, v26);
            let v28 = dmp(v2, *0x1::vector::borrow<u64>(&arg11, v27), true, v24, v25, *0x1::vector::borrow<u64>(&arg14, v27), fct(&v17, sp(v2, *0x1::vector::borrow<u64>(&arg11, v27), true, v24, v25), true));
            if (v28 > 0) {
                *0x1::vector::borrow_mut<u64>(&mut arg11, v27) = v28;
            };
            v26 = v26 + 1;
        };
        v26 = 0;
        while (v26 < 0x1::vector::length<u64>(&arg10)) {
            let v29 = *0x1::vector::borrow<u64>(&arg10, v26);
            let v30 = dmp(v2, *0x1::vector::borrow<u64>(&arg11, v29), false, v24, v25, *0x1::vector::borrow<u64>(&arg14, v29), fct(&v16, sp(v2, *0x1::vector::borrow<u64>(&arg11, v29), false, v24, v25), false));
            if (v30 > 0) {
                *0x1::vector::borrow_mut<u64>(&mut arg11, v29) = v30;
            };
            v26 = v26 + 1;
        };
        let (_, _, _) = emo<T0, T1>(arg0, arg2, &v1, arg3, v11, v12, v13, arg9, arg10, arg11, arg12, arg13, v10, v4, v2, v3, arg17);
    }

    fun emo<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: &0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = 3;
        let v1 = 2;
        let v2 = arg4;
        let v3 = arg5;
        let v4 = arg6;
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&arg7)) {
            let v6 = *0x1::vector::borrow<u64>(&arg7, v5);
            v5 = v5 + 1;
            let v7 = *0x1::vector::borrow<u64>(&arg11, v6);
            if (v7 < arg12) {
                let v8 = EE{
                    e : 107,
                    l : 623,
                };
                0x2::event::emit<EE>(v8);
                continue
            };
            let v9 = *0x1::vector::borrow<u64>(&arg9, v6);
            if (v9 == 0) {
                let v10 = EE{
                    e : 101,
                    l : 631,
                };
                0x2::event::emit<EE>(v10);
                continue
            };
            if (v3 == 0) {
                let v11 = EE{
                    e : 103,
                    l : 636,
                };
                0x2::event::emit<EE>(v11);
                break
            };
            let (v12, v13) = vbac<T0, T1>(arg0, v2, v3, v4, arg14, arg15, arg13, v9, *0x1::vector::borrow<u64>(&arg10, v6), true, true, true);
            if (v13 != 0) {
                let v14 = EE{
                    e : v13,
                    l : 656,
                };
                0x2::event::emit<EE>(v14);
                if (v13 == 103 || v13 == 104) {
                    break
                } else {
                    continue
                };
            };
            let v15 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg1, arg2, 18446744073709551615, v0, v1, v9, v12, true, true, v7, arg3, arg16);
            v2 = v2 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v15);
            v3 = v3 - (((0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(&v15) as u128) * (v9 as u128) / 1000000000 + 1) as u64);
            v4 = v4 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v15);
        };
        v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&arg8)) {
            let v16 = *0x1::vector::borrow<u64>(&arg8, v5);
            v5 = v5 + 1;
            let v17 = *0x1::vector::borrow<u64>(&arg11, v16);
            if (v17 < arg12) {
                let v18 = EE{
                    e : 107,
                    l : 704,
                };
                0x2::event::emit<EE>(v18);
                continue
            };
            let v19 = *0x1::vector::borrow<u64>(&arg9, v16);
            if (v19 == 0) {
                let v20 = EE{
                    e : 101,
                    l : 712,
                };
                0x2::event::emit<EE>(v20);
                continue
            };
            if (v2 < arg13) {
                let v21 = EE{
                    e : 102,
                    l : 717,
                };
                0x2::event::emit<EE>(v21);
                break
            };
            let (v22, v23) = vbac<T0, T1>(arg0, v2, v3, v4, arg14, arg15, arg13, v19, *0x1::vector::borrow<u64>(&arg10, v16), false, true, true);
            if (v23 != 0) {
                let v24 = EE{
                    e : v23,
                    l : 737,
                };
                0x2::event::emit<EE>(v24);
                if (v23 == 102 || v23 == 104) {
                    break
                } else {
                    continue
                };
            };
            let v25 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg1, arg2, 0, v0, v1, v19, v22, false, true, v17, arg3, arg16);
            v2 = v2 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(&v25);
            v3 = v3 + (((0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v25) as u128) * (v19 as u128) / 1000000000) as u64);
            v4 = v4 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v25);
        };
        (v2, v3, v4)
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
                    l : 422,
                };
                0x2::event::emit<EE>(v16);
                continue
            };
            let v17 = *0x1::vector::borrow<u64>(&arg9, v14);
            if (v11 == 0) {
                let v18 = EE{
                    e : 103,
                    l : 431,
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
                    l : 465,
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
                    l : 506,
                };
                0x2::event::emit<EE>(v26);
                continue
            };
            let v27 = *0x1::vector::borrow<u64>(&arg9, v24);
            if (v10 < arg13) {
                let v28 = EE{
                    e : 102,
                    l : 515,
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
                    l : 549,
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

    fun fct(arg0: &vector<u64>, arg1: u64, arg2: bool) : u64 {
        let v0 = 0x1::vector::length<u64>(arg0);
        if (v0 == 0) {
            return 0
        };
        while (v0 > 0) {
            let v1 = v0 - 1;
            v0 = v1;
            let v2 = *0x1::vector::borrow<u64>(arg0, v1);
            if (arg2 && v2 >= arg1) {
                return v2
            };
            if (!arg2 && v2 <= arg1) {
                return v2
            };
        };
        0
    }

    fun gcbba<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::object::ID) : (vector<u64>, vector<u64>) {
        let v0 = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg1) + 300);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::iter_orders<T0, T1>(arg0, 0x1::option::none<u128>(), 0x1::option::none<u128>(), v0, 20, true);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::orders(&v1);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v3)) {
            let v5 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v3, v4);
            if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::balance_manager_id(v5) == *arg2) {
                0x1::vector::push_back<u64>(&mut v2, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v5));
            };
            v4 = v4 + 1;
        };
        let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::iter_orders<T0, T1>(arg0, 0x1::option::none<u128>(), 0x1::option::none<u128>(), v0, 20, false);
        let v7 = 0x1::vector::empty<u64>();
        let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::orders(&v6);
        v4 = 0;
        while (v4 < 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v8)) {
            let v9 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v8, v4);
            if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::balance_manager_id(v9) == *arg2) {
                0x1::vector::push_back<u64>(&mut v7, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v9));
            };
            v4 = v4 + 1;
        };
        (v2, v7)
    }

    fun smo<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: &vector<u64>, arg20: &vector<u64>, arg21: &0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_account_order_details<T0, T1>(arg0, arg1);
        let v1 = 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&v0);
        let (v2, _, v4, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg3);
        let v6 = v4;
        let v7 = v2;
        let v8 = if (0x1::vector::length<u64>(&v7) > 0) {
            *0x1::vector::borrow<u64>(&v7, 0)
        } else {
            0
        };
        let v9 = if (0x1::vector::length<u64>(&v6) > 0) {
            *0x1::vector::borrow<u64>(&v6, 0)
        } else {
            0
        };
        let v10 = 0x1::vector::empty<bool>();
        let v11 = 0;
        while (v11 < v1) {
            0x1::vector::push_back<bool>(&mut v10, false);
            v11 = v11 + 1;
        };
        let v12 = 0;
        let v13 = 0x1::vector::empty<u128>();
        let v14 = 0x1::vector::empty<u64>();
        let v15 = 0x1::vector::empty<u64>();
        v11 = 0;
        while (v11 < 0x1::vector::length<u64>(&arg6)) {
            let v16 = *0x1::vector::borrow<u64>(&arg6, v11);
            v11 = v11 + 1;
            let v17 = *0x1::vector::borrow<u64>(&arg9, v16);
            let v18 = dmp(arg17, *0x1::vector::borrow<u64>(&arg8, v16), true, v8, v9, *0x1::vector::borrow<u64>(&arg11, v16), fct(arg19, sp(arg17, *0x1::vector::borrow<u64>(&arg8, v16), true, v8, v9), true));
            if (v18 > 0) {
                *0x1::vector::borrow_mut<u64>(&mut arg8, v16) = v18;
            };
            let v19 = false;
            let v20 = 0;
            while (v20 < v1) {
                if (!*0x1::vector::borrow<bool>(&v10, v20)) {
                    let v21 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&v0, v20);
                    if (dio(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v21))) {
                        let v22 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(v21) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v21);
                        let v23 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(v21);
                        if (ad(v18, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v21)) <= *0x1::vector::borrow<u64>(&arg12, v16) && v23 > arg15 + arg14) {
                            let v24 = (v17 as u128) * ((100 + arg13) as u128) / 100;
                            if ((v22 as u128) >= (v17 as u128) * ((100 - arg13) as u128) / 100 && (v22 as u128) <= v24) {
                                *0x1::vector::borrow_mut<bool>(&mut v10, v20) = true;
                                v19 = true;
                                v12 = v12 + 1;
                                break
                            };
                            if ((v22 as u128) > v24) {
                                let v25 = v17 / arg18 * arg18;
                                let v26 = if (v25 > 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v21)) {
                                    if (v25 >= arg16) {
                                        v23 > arg15 + arg14 * 2
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                };
                                if (v26) {
                                    *0x1::vector::borrow_mut<bool>(&mut v10, v20) = true;
                                    v19 = true;
                                    0x1::vector::push_back<u128>(&mut v13, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v21));
                                    0x1::vector::push_back<u64>(&mut v14, v25);
                                    break
                                };
                            };
                        };
                    };
                };
                v20 = v20 + 1;
            };
            if (!v19) {
                0x1::vector::push_back<u64>(&mut v15, v16);
            };
        };
        let v27 = 0x1::vector::empty<u64>();
        v11 = 0;
        while (v11 < 0x1::vector::length<u64>(&arg7)) {
            let v28 = *0x1::vector::borrow<u64>(&arg7, v11);
            v11 = v11 + 1;
            let v29 = *0x1::vector::borrow<u64>(&arg9, v28);
            let v30 = dmp(arg17, *0x1::vector::borrow<u64>(&arg8, v28), false, v8, v9, *0x1::vector::borrow<u64>(&arg11, v28), fct(arg20, sp(arg17, *0x1::vector::borrow<u64>(&arg8, v28), false, v8, v9), false));
            if (v30 > 0) {
                *0x1::vector::borrow_mut<u64>(&mut arg8, v28) = v30;
            };
            let v31 = false;
            let v32 = 0;
            while (v32 < v1) {
                if (!*0x1::vector::borrow<bool>(&v10, v32)) {
                    let v33 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&v0, v32);
                    if (!dio(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v33))) {
                        let v34 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(v33) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v33);
                        let v35 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(v33);
                        if (ad(v30, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v33)) <= *0x1::vector::borrow<u64>(&arg12, v28) && v35 > arg15 + arg14) {
                            let v36 = (v29 as u128) * ((100 + arg13) as u128) / 100;
                            if ((v34 as u128) >= (v29 as u128) * ((100 - arg13) as u128) / 100 && (v34 as u128) <= v36) {
                                *0x1::vector::borrow_mut<bool>(&mut v10, v32) = true;
                                v31 = true;
                                v12 = v12 + 1;
                                break
                            };
                            if ((v34 as u128) > v36) {
                                let v37 = v29 / arg18 * arg18;
                                let v38 = if (v37 > 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v33)) {
                                    if (v37 >= arg16) {
                                        v35 > arg15 + arg14 * 2
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                };
                                if (v38) {
                                    *0x1::vector::borrow_mut<bool>(&mut v10, v32) = true;
                                    v31 = true;
                                    0x1::vector::push_back<u128>(&mut v13, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v33));
                                    0x1::vector::push_back<u64>(&mut v14, v37);
                                    break
                                };
                            };
                        };
                    };
                };
                v32 = v32 + 1;
            };
            if (!v31) {
                0x1::vector::push_back<u64>(&mut v27, v28);
            };
        };
        v11 = 0;
        while (v11 < 0x1::vector::length<u128>(&v13)) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::modify_order<T0, T1>(arg0, arg1, arg2, *0x1::vector::borrow<u128>(&v13, v11), *0x1::vector::borrow<u64>(&v14, v11), arg3, arg21);
            v11 = v11 + 1;
        };
        v11 = 0;
        while (v11 < v1) {
            if (!*0x1::vector::borrow<bool>(&v10, v11)) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg0, arg1, arg2, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&v0, v11)), arg3, arg21);
            };
            v11 = v11 + 1;
        };
        let v39 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1);
        let v40 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1);
        let v41 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg1);
        let v42 = if (v39 > arg4) {
            v39 - arg4
        } else {
            0
        };
        let v43 = if (v40 > arg5) {
            v40 - arg5
        } else {
            0
        };
        emo<T0, T1>(arg0, arg1, arg2, arg3, v42, v43, v41, v15, v27, arg8, arg9, arg10, arg15, arg16, arg17, arg18, arg21)
    }

    fun sp(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: u64) : u64 {
        if (arg1 % arg0 != 0) {
            return 0
        };
        if (arg2) {
            if (arg4 == 0) {
                return arg1
            };
            if (arg1 < arg4) {
                return arg1
            };
            if (arg4 < arg0) {
                return 0
            };
            arg4 - arg0
        } else {
            if (arg3 == 0) {
                return arg1
            };
            if (arg1 > arg3) {
                return arg1
            };
            if (arg3 > 18446744073709551615 - arg0) {
                return 0
            };
            arg3 + arg0
        }
    }

    public fun suf<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: vector<u64>, arg14: vector<u64>, arg15: u64, arg16: u64, arg17: 0x1::option::Option<0x2::object::ID>, arg18: 0x1::option::Option<u64>, arg19: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<u64>(&arg18)) {
            let v0 = DFP{fp: *0x1::option::borrow<u64>(&arg18)};
            0x2::event::emit<DFP>(v0);
        };
        let v1 = 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::gdtp(arg1, arg2, arg19);
        let (v2, v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v5 = 0x2::clock::timestamp_ms(arg3);
        let (v6, v7) = if (0x1::option::is_some<0x2::object::ID>(&arg17)) {
            gcbba<T0, T1>(arg0, arg3, 0x1::option::borrow<0x2::object::ID>(&arg17))
        } else {
            (0x1::vector::empty<u64>(), 0x1::vector::empty<u64>())
        };
        let v8 = v7;
        let v9 = v6;
        let (_, _, _) = smo<T0, T1, T2>(arg0, arg2, &v1, arg3, arg4, arg5, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, v5, v4, v2, v3, &v9, &v8, arg19);
        let v13 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v14 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2);
        let v15 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg2);
        let v16 = if (v13 > arg4) {
            v13 - arg4
        } else {
            0
        };
        let v17 = if (v14 > arg5) {
            v14 - arg5
        } else {
            0
        };
        let (_, _, _) = eto<T0, T1>(arg0, arg2, &v1, arg3, v16, v17, v15, arg6, arg7, arg10, arg11, arg12, v5, v4, v2, v3, arg19);
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

