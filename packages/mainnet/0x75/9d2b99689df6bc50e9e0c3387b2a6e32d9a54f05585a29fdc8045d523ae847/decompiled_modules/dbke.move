module 0x759d2b99689df6bc50e9e0c3387b2a6e32d9a54f05585a29fdc8045d523ae847::dbke {
    struct EE has copy, drop {
        e: u64,
        l: u64,
    }

    public fun cao_s<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u64 {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0
    }

    public fun caw<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg1, arg2, arg3, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T2>(arg1, arg4, arg5)
    }

    public fun ef(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg0);
        if (v0 < arg3) {
            if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg2) < arg3) {
                abort 108
            };
            let v1 = 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::twc(arg1, arg4);
            0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::dwc(arg1, v1, arg4);
            0x2::coin::join<0x2::sui::SUI>(arg0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<0x2::sui::SUI>(arg2, &v1, arg3 * 2 - v0, arg4));
        };
    }

    public fun elf<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2::clock::Clock, arg4: bool, arg5: u64, arg6: u64, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: vector<u64>, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::gdtp(arg1, arg2, arg14);
        if (arg4) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg2, &v0, arg3, arg14);
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
        let (v10, v11, v12) = eto<T0, T1>(arg0, arg2, &v0, arg3, v7, v8, v6, arg7, arg8, arg11, arg12, arg13, v9, v3, v1, v2, arg14);
        let (_, _, _) = emo<T0, T1>(arg0, arg2, &v0, arg3, v10, v11, v12, arg9, arg10, arg11, arg12, arg13, v9, v3, v1, v2, arg14);
    }

    fun emo<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: &0x2::tx_context::TxContext) : (u64, u64, u64) {
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
            if (v15 < arg12) {
                continue
            };
            if (v11 == 0) {
                let v16 = EE{
                    e : 103,
                    l : 494,
                };
                0x2::event::emit<EE>(v16);
                break
            };
            let v17 = sp(&v7, &v6, arg14, *0x1::vector::borrow<u64>(&arg9, v14), true, v8, v9);
            if (v17 == 0) {
                let v18 = EE{
                    e : 101,
                    l : 507,
                };
                0x2::event::emit<EE>(v18);
                continue
            };
            let (v19, v20) = vbac<T0, T1>(arg0, v10, v11, v12, arg14, arg15, arg13, v17, *0x1::vector::borrow<u64>(&arg10, v14), true, true, true);
            if (v20 != 0) {
                if (v20 == 103 || v20 == 104) {
                    break
                };
                let v21 = EE{
                    e : v20,
                    l : 535,
                };
                0x2::event::emit<EE>(v21);
                continue
            };
            let v22 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg1, arg2, 18446744073709551615, v0, v1, v17, v19, true, true, v15, arg3, arg16);
            v10 = v10 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v22);
            v11 = v11 - (((0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(&v22) as u128) * (v17 as u128) / 1000000000 + 1) as u64);
            v12 = v12 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v22);
        };
        v13 = 0;
        while (v13 < 0x1::vector::length<u64>(&arg8)) {
            let v23 = *0x1::vector::borrow<u64>(&arg8, v13);
            v13 = v13 + 1;
            let v24 = *0x1::vector::borrow<u64>(&arg11, v23);
            if (v24 < arg12) {
                continue
            };
            if (v10 < arg13) {
                let v25 = EE{
                    e : 102,
                    l : 587,
                };
                0x2::event::emit<EE>(v25);
                break
            };
            let v26 = sp(&v7, &v6, arg14, *0x1::vector::borrow<u64>(&arg9, v23), false, v8, v9);
            if (v26 == 0) {
                let v27 = EE{
                    e : 101,
                    l : 600,
                };
                0x2::event::emit<EE>(v27);
                continue
            };
            let (v28, v29) = vbac<T0, T1>(arg0, v10, v11, v12, arg14, arg15, arg13, v26, *0x1::vector::borrow<u64>(&arg10, v23), false, true, true);
            if (v29 != 0) {
                if (v29 == 102 || v29 == 104) {
                    break
                };
                let v30 = EE{
                    e : v29,
                    l : 629,
                };
                0x2::event::emit<EE>(v30);
                continue
            };
            let v31 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg1, arg2, 0, v0, v1, v26, v28, false, true, v24, arg3, arg16);
            v10 = v10 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(&v31);
            v11 = v11 + (((0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v31) as u128) * (v26 as u128) / 1000000000) as u64);
            v12 = v12 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v31);
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
                    l : 287,
                };
                0x2::event::emit<EE>(v16);
                continue
            };
            let v17 = *0x1::vector::borrow<u64>(&arg9, v14);
            if (v11 == 0) {
                let v18 = EE{
                    e : 103,
                    l : 296,
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
                    l : 327,
                };
                0x2::event::emit<EE>(v21);
                continue
            };
            let v22 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg1, arg2, 18446744073709551615, v0, v1, v17, v19, true, true, v15, arg3, arg16);
            v10 = v10 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v22);
            v11 = v11 - (((0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(&v22) as u128) * (v17 as u128) / 1000000000 + 1) as u64);
            v12 = v12 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v22);
        };
        v13 = 0;
        while (v13 < 0x1::vector::length<u64>(&arg8)) {
            let v23 = *0x1::vector::borrow<u64>(&arg8, v13);
            v13 = v13 + 1;
            let v24 = *0x1::vector::borrow<u64>(&arg11, v23);
            if (v24 < arg12) {
                let v25 = EE{
                    e : 107,
                    l : 370,
                };
                0x2::event::emit<EE>(v25);
                continue
            };
            let v26 = *0x1::vector::borrow<u64>(&arg9, v23);
            if (v10 < arg13) {
                let v27 = EE{
                    e : 102,
                    l : 379,
                };
                0x2::event::emit<EE>(v27);
                break
            };
            if (!vtop(v26, false, &v7, &v6, v8, v9)) {
                break
            };
            let (v28, v29) = vbac<T0, T1>(arg0, v10, v11, v12, arg14, arg15, arg13, v26, *0x1::vector::borrow<u64>(&arg10, v23), false, false, true);
            if (v29 != 0) {
                let v30 = EE{
                    e : v29,
                    l : 410,
                };
                0x2::event::emit<EE>(v30);
                continue
            };
            let v31 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg1, arg2, 18446744073709551615, v0, v1, v26, v28, false, true, v24, arg3, arg16);
            v10 = v10 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v31);
            v11 = v11 + (((0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(&v31) as u128) * (v26 as u128) / 1000000000 + 1) as u64);
            v12 = v12 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v31);
        };
        (v10, v11, v12)
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

