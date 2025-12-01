module 0x29a1d5ac3119e5c8312dc6407811c1660f856c3a6fb2846f32d441447af623b8::dbke {
    struct EE has copy, drop {
        e: u64,
        l: u64,
    }

    public fun cao_s<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg3: &0x2::clock::Clock, arg4: &mut 0x7e5c9a5a5e505816e99df9ab6a076e8a3f23ddf0c3dab7c3666bbdc66a60e2d8::sq::SQR, arg5: u64, arg6: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x7e5c9a5a5e505816e99df9ab6a076e8a3f23ddf0c3dab7c3666bbdc66a60e2d8::sq::css(arg4, arg5, true, false, arg6);
        if (v0 != 0) {
            return v0
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg1, arg2, arg3, arg6);
        0
    }

    public fun caw<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg1, arg2, arg3, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T2>(arg1, arg4, arg5)
    }

    public fun elf<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0xeaf81a9984bb59db32beb3f15d19880c580eefa6ab9bc5688006acbe7f692591::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2::clock::Clock, arg4: &mut 0x7e5c9a5a5e505816e99df9ab6a076e8a3f23ddf0c3dab7c3666bbdc66a60e2d8::sq::SQR, arg5: u64, arg6: bool, arg7: u64, arg8: u64, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: vector<u64>, arg14: vector<u64>, arg15: vector<u64>, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7e5c9a5a5e505816e99df9ab6a076e8a3f23ddf0c3dab7c3666bbdc66a60e2d8::sq::css(arg4, arg5, true, false, arg16);
        if (v0 != 0x29a1d5ac3119e5c8312dc6407811c1660f856c3a6fb2846f32d441447af623b8::ct::e_no_error()) {
            let v1 = EE{
                e : v0,
                l : 704,
            };
            0x2::event::emit<EE>(v1);
            return
        };
        let v2 = 0xeaf81a9984bb59db32beb3f15d19880c580eefa6ab9bc5688006acbe7f692591::bm::gdtp(arg1, arg2, arg16);
        if (arg6) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg2, &v2, arg3, arg16);
        };
        let (v3, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v7 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2);
        let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg2);
        let v9 = if (v6 > arg7) {
            v6 - arg7
        } else {
            0
        };
        let v10 = if (v7 > arg8) {
            v7 - arg8
        } else {
            0
        };
        let (v11, v12, v13) = eto<T0, T1>(arg0, arg2, &v2, arg3, v9, v10, v8, arg9, arg10, arg13, arg14, arg15, v5, v3, v4, arg16);
        let (_, _, _) = emo<T0, T1>(arg0, arg2, &v2, arg3, v11, v12, v13, arg11, arg12, arg13, arg14, arg15, v5, v3, v4, arg16);
    }

    fun emo<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: u64, arg13: u64, arg14: u64, arg15: &0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only();
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker();
        let (v2, _, v4, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg3);
        let v6 = v2;
        let v7 = v4;
        let v8 = arg4;
        let v9 = arg5;
        let v10 = arg6;
        let v11 = 0;
        while (v11 < 0x1::vector::length<u64>(&arg7)) {
            let v12 = *0x1::vector::borrow<u64>(&arg7, v11);
            v11 = v11 + 1;
            let v13 = *0x1::vector::borrow<u64>(&arg11, v12);
            if (v13 < 0x2::clock::timestamp_ms(arg3)) {
                let v14 = EE{
                    e : 0x29a1d5ac3119e5c8312dc6407811c1660f856c3a6fb2846f32d441447af623b8::ct::e_order_expired(),
                    l : 486,
                };
                0x2::event::emit<EE>(v14);
                continue
            };
            if (v9 <= 0) {
                let v15 = EE{
                    e : 103,
                    l : 494,
                };
                0x2::event::emit<EE>(v15);
                break
            };
            let v16 = sp(&v6, &v7, arg13, *0x1::vector::borrow<u64>(&arg9, v12), true);
            if (v16 == 0) {
                let v17 = EE{
                    e : 101,
                    l : 507,
                };
                0x2::event::emit<EE>(v17);
                continue
            };
            let (v18, v19) = vbac<T0, T1>(arg0, v8, v9, v10, arg13, arg14, arg12, v16, *0x1::vector::borrow<u64>(&arg10, v12), true, false, true);
            let v20 = v19;
            let v21 = &v20;
            let v22 = 0;
            if (v21 == &v22) {
                let v23 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg1, arg2, 18446744073709551615, v0, v1, v16, v18, true, true, v13, arg3, arg15);
                v8 = v8 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v23);
                v9 = v9 - (((0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(&v23) as u128) * (v16 as u128) / 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling_u128() + 1) as u64);
                v10 = v10 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v23);
                continue
            };
            let v24 = 103;
            if (v21 == &v24) {
                break
            };
            let v25 = 104;
            if (v21 == &v25) {
                break
            };
            let v26 = EE{
                e : v19,
                l : 535,
            };
            0x2::event::emit<EE>(v26);
        };
        v11 = 0;
        while (v11 < 0x1::vector::length<u64>(&arg7)) {
            let v27 = *0x1::vector::borrow<u64>(&arg8, v11);
            v11 = v11 + 1;
            let v28 = *0x1::vector::borrow<u64>(&arg11, v27);
            if (v28 < 0x2::clock::timestamp_ms(arg3)) {
                let v29 = EE{
                    e : 0x29a1d5ac3119e5c8312dc6407811c1660f856c3a6fb2846f32d441447af623b8::ct::e_order_expired(),
                    l : 579,
                };
                0x2::event::emit<EE>(v29);
                continue
            };
            if (v8 < arg12) {
                let v30 = EE{
                    e : 102,
                    l : 587,
                };
                0x2::event::emit<EE>(v30);
                continue
            };
            let v31 = sp(&v6, &v7, arg13, *0x1::vector::borrow<u64>(&arg9, v27), false);
            if (v31 == 0) {
                let v32 = EE{
                    e : 101,
                    l : 600,
                };
                0x2::event::emit<EE>(v32);
                continue
            };
            let (v33, v34) = vbac<T0, T1>(arg0, v8, v9, v10, arg13, arg14, arg12, v31, *0x1::vector::borrow<u64>(&arg10, v27), false, false, true);
            let v35 = v34;
            let v36 = &v35;
            let v37 = 0;
            if (v36 == &v37) {
                if (v34 != 0x29a1d5ac3119e5c8312dc6407811c1660f856c3a6fb2846f32d441447af623b8::ct::e_no_error()) {
                    let v38 = EE{
                        e : v34,
                        l : 635,
                    };
                    0x2::event::emit<EE>(v38);
                    continue
                };
                let v39 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg1, arg2, 0, v0, v1, v31, v33, false, true, v28, arg3, arg15);
                v8 = v8 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(&v39);
                v9 = v9 + (((0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v39) as u128) * (v31 as u128) / 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling_u128()) as u64);
                v10 = v10 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v39);
                continue
            };
            let v40 = 102;
            if (v36 == &v40) {
                break
            };
            let v41 = 104;
            if (v36 == &v41) {
                break
            };
            let v42 = EE{
                e : v34,
                l : 629,
            };
            0x2::event::emit<EE>(v42);
        };
        (v8, v9, v10)
    }

    fun eto<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: u64, arg13: u64, arg14: u64, arg15: &0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel();
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker();
        let (v2, _, v4, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg3);
        let v6 = v2;
        let v7 = v4;
        let v8 = arg4;
        let v9 = arg5;
        let v10 = arg6;
        let v11 = 0;
        while (v11 < 0x1::vector::length<u64>(&arg7)) {
            let v12 = *0x1::vector::borrow<u64>(&arg7, v11);
            v11 = v11 + 1;
            let v13 = *0x1::vector::borrow<u64>(&arg11, v12);
            if (v13 < 0x2::clock::timestamp_ms(arg3)) {
                let v14 = EE{
                    e : 0x29a1d5ac3119e5c8312dc6407811c1660f856c3a6fb2846f32d441447af623b8::ct::e_order_expired(),
                    l : 287,
                };
                0x2::event::emit<EE>(v14);
                continue
            };
            let v15 = *0x1::vector::borrow<u64>(&arg9, v12);
            if (v9 <= 0) {
                let v16 = EE{
                    e : 103,
                    l : 296,
                };
                0x2::event::emit<EE>(v16);
                break
            };
            if (!vtop(v15, true, &v6, &v7)) {
                let v17 = EE{
                    e : 106,
                    l : 303,
                };
                0x2::event::emit<EE>(v17);
                break
            };
            let (v18, v19) = vbac<T0, T1>(arg0, v8, v9, v10, arg13, arg14, arg12, v15, *0x1::vector::borrow<u64>(&arg10, v12), true, false, true);
            let v20 = v19;
            let v21 = 0;
            if (&v20 == &v21) {
                let v22 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg1, arg2, 18446744073709551615, v0, v1, v15, v18, true, true, v13, arg3, arg15);
                v8 = v8 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v22);
                v9 = v9 - (((0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(&v22) as u128) * (v15 as u128) / 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling_u128() + 1) as u64);
                v10 = v10 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v22);
                continue
            };
            let v23 = EE{
                e : v19,
                l : 327,
            };
            0x2::event::emit<EE>(v23);
        };
        v11 = 0;
        while (v11 < 0x1::vector::length<u64>(&arg8)) {
            let v24 = *0x1::vector::borrow<u64>(&arg8, v11);
            v11 = v11 + 1;
            let v25 = *0x1::vector::borrow<u64>(&arg11, v24);
            if (v25 < 0x2::clock::timestamp_ms(arg3)) {
                let v26 = EE{
                    e : 0x29a1d5ac3119e5c8312dc6407811c1660f856c3a6fb2846f32d441447af623b8::ct::e_order_expired(),
                    l : 370,
                };
                0x2::event::emit<EE>(v26);
                continue
            };
            let v27 = *0x1::vector::borrow<u64>(&arg9, v24);
            if (v8 <= arg12) {
                let v28 = EE{
                    e : 102,
                    l : 379,
                };
                0x2::event::emit<EE>(v28);
                break
            };
            if (!vtop(v27, false, &v6, &v7)) {
                let v29 = EE{
                    e : 106,
                    l : 386,
                };
                0x2::event::emit<EE>(v29);
                break
            };
            let (v30, v31) = vbac<T0, T1>(arg0, v8, v9, v10, arg13, arg14, arg12, v27, *0x1::vector::borrow<u64>(&arg10, v24), false, false, true);
            let v32 = v31;
            let v33 = 0;
            if (&v32 == &v33) {
                let v34 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg1, arg2, 18446744073709551615, v0, v1, v27, v30, false, true, v25, arg3, arg15);
                v8 = v8 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v34);
                v9 = v9 - (((0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(&v34) as u128) * (v27 as u128) / 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling_u128() + 1) as u64);
                v10 = v10 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v34);
                continue
            };
            let v35 = EE{
                e : v31,
                l : 410,
            };
            0x2::event::emit<EE>(v35);
        };
        (v8, v9, v10)
    }

    fun sp(arg0: &vector<u64>, arg1: &vector<u64>, arg2: u64, arg3: u64, arg4: bool) : u64 {
        if (arg3 % arg2 != 0) {
            return 0
        };
        if (arg4) {
            if (0x1::vector::length<u64>(arg1) == 0) {
                return arg3
            };
            let v1 = *0x1::vector::borrow<u64>(arg1, 0);
            if (arg3 < v1) {
                return arg3
            };
            let v2 = v1 - arg2;
            if (v2 < arg2) {
                return 0
            };
            v2
        } else {
            if (0x1::vector::length<u64>(arg0) == 0) {
                return arg3
            };
            let v3 = *0x1::vector::borrow<u64>(arg0, 0);
            if (arg3 > v3) {
                return arg3
            };
            let v4 = v3 + arg2;
            if (v4 > 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_u64() - arg2) {
                return 0
            };
            v4
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
            let v1 = (((arg2 as u128) * 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling_u128() / (arg7 as u128)) as u64);
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

    fun vtop(arg0: u64, arg1: bool, arg2: &vector<u64>, arg3: &vector<u64>) : bool {
        if (arg0 == 0) {
            return false
        };
        if (arg1) {
            if (0x1::vector::length<u64>(arg3) == 0) {
                return false
            };
            if (arg0 < *0x1::vector::borrow<u64>(arg3, 0)) {
                return false
            };
        } else {
            if (0x1::vector::length<u64>(arg2) == 0) {
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

