module 0xe74879da0860962c05aa385888f8b6ab3b46bed308a2208097d09b4a0294d26c::h0d1a7 {
    struct H291e0 has copy, drop {
        h32609: u64,
        h9c1a1: u64,
    }

    public fun h011fb<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: vector<u64>, arg14: vector<u64>, arg15: u64, arg16: u64, arg17: 0x1::option::Option<0x2::object::ID>, arg18: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg10);
        let v1 = if (0x1::vector::length<u64>(&arg11) == v0) {
            if (0x1::vector::length<u64>(&arg12) == v0) {
                if (0x1::vector::length<u64>(&arg13) == v0) {
                    0x1::vector::length<u64>(&arg14) == v0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 109);
        assert!(arg15 <= 100, 109);
        h0142f(&arg6, v0);
        h0142f(&arg7, v0);
        h0142f(&arg8, v0);
        h0142f(&arg9, v0);
        let v2 = 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::h50957(arg1, arg2, arg18);
        let (v3, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v6 = 0x2::clock::timestamp_ms(arg3);
        let v7 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2);
        let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg2);
        let v10 = if (v7 > arg4) {
            v7 - arg4
        } else {
            0
        };
        let v11 = if (v8 > arg5) {
            v8 - arg5
        } else {
            0
        };
        let (_, _, _) = h0ac4a<T0, T1>(arg0, arg2, &v2, arg3, v10, v11, v9, &arg6, &arg7, &arg10, &arg11, &arg12, v6, v5, v3, v4, arg18);
        let (v15, v16) = if ((0x1::vector::length<u64>(&arg8) > 0 || 0x1::vector::length<u64>(&arg9) > 0) && 0x1::option::is_some<0x2::object::ID>(&arg17)) {
            h3f97d<T0, T1>(arg0, arg3, 0x1::option::borrow<0x2::object::ID>(&arg17))
        } else {
            (0x1::vector::empty<u64>(), 0x1::vector::empty<u64>())
        };
        let v17 = v16;
        let v18 = v15;
        let (_, _, _) = ha78b6<T0, T1, T2>(arg0, arg2, &v2, arg3, arg4, arg5, &arg8, &arg9, arg10, &arg11, &arg12, &arg13, &arg14, arg15, arg16, v6, v5, v3, v4, &v18, &v17, arg18);
    }

    fun h0142f(arg0: &vector<u64>, arg1: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            assert!(*0x1::vector::borrow<u64>(arg0, v0) < arg1, 109);
            v0 = v0 + 1;
        };
    }

    public fun h03b75<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg1, arg2, arg3, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T2>(arg1, arg4, arg5)
    }

    fun h0ac4a<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u64, arg7: &vector<u64>, arg8: &vector<u64>, arg9: &vector<u64>, arg10: &vector<u64>, arg11: &vector<u64>, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: &0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = 0x1::vector::length<u64>(arg7);
        let v1 = 0x1::vector::length<u64>(arg8);
        if (v0 == 0 && v1 == 0) {
            return (arg4, arg5, arg6)
        };
        let v2 = 1;
        let v3 = 2;
        let (v4, _, v6, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg3);
        let v8 = v6;
        let v9 = v4;
        let v10 = 0x1::vector::length<u64>(&v9);
        let v11 = 0x1::vector::length<u64>(&v8);
        let v12 = arg4;
        let v13 = arg5;
        let v14 = arg6;
        let v15 = 0;
        while (v15 < v0) {
            let v16 = *0x1::vector::borrow<u64>(arg7, v15);
            v15 = v15 + 1;
            let v17 = *0x1::vector::borrow<u64>(arg11, v16);
            if (v17 < arg12) {
                let v18 = H291e0{
                    h32609 : 107,
                    h9c1a1 : 439,
                };
                0x2::event::emit<H291e0>(v18);
                continue
            };
            let v19 = *0x1::vector::borrow<u64>(arg9, v16);
            if (v13 == 0) {
                let v20 = H291e0{
                    h32609 : 103,
                    h9c1a1 : 448,
                };
                0x2::event::emit<H291e0>(v20);
                break
            };
            if (!h43ff2(v19, true, &v9, &v8, v10, v11)) {
                break
            };
            let (v21, v22) = hd56ec<T0, T1>(arg0, v12, v13, v14, arg14, arg15, arg13, v19, *0x1::vector::borrow<u64>(arg10, v16), true, false, true);
            if (v22 != 0) {
                let v23 = H291e0{
                    h32609 : v22,
                    h9c1a1 : 482,
                };
                0x2::event::emit<H291e0>(v23);
                continue
            };
            let v24 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg1, arg2, 18446744073709551615, v2, v3, v19, v21, true, true, v17, arg3, arg16);
            let v25 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v24);
            v12 = v12 + v25;
            v13 = v13 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::cumulative_quote_quantity(&v24);
            v14 = v14 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v24);
            if (v25 > 0) {
                let (v26, _, v28, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg3);
                v9 = v26;
                v8 = v28;
                v10 = 0x1::vector::length<u64>(&v9);
                v11 = 0x1::vector::length<u64>(&v8);
            };
        };
        v15 = 0;
        while (v15 < v1) {
            let v30 = *0x1::vector::borrow<u64>(arg8, v15);
            v15 = v15 + 1;
            let v31 = *0x1::vector::borrow<u64>(arg11, v30);
            if (v31 < arg12) {
                let v32 = H291e0{
                    h32609 : 107,
                    h9c1a1 : 530,
                };
                0x2::event::emit<H291e0>(v32);
                continue
            };
            let v33 = *0x1::vector::borrow<u64>(arg9, v30);
            if (v12 < arg13) {
                let v34 = H291e0{
                    h32609 : 102,
                    h9c1a1 : 539,
                };
                0x2::event::emit<H291e0>(v34);
                break
            };
            if (!h43ff2(v33, false, &v9, &v8, v10, v11)) {
                break
            };
            let (v35, v36) = hd56ec<T0, T1>(arg0, v12, v13, v14, arg14, arg15, arg13, v33, *0x1::vector::borrow<u64>(arg10, v30), false, false, true);
            if (v36 != 0) {
                let v37 = H291e0{
                    h32609 : v36,
                    h9c1a1 : 573,
                };
                0x2::event::emit<H291e0>(v37);
                continue
            };
            let v38 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg1, arg2, 18446744073709551615, v2, v3, v33, v35, false, true, v31, arg3, arg16);
            let v39 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v38);
            v12 = v12 - v39;
            v13 = v13 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::cumulative_quote_quantity(&v38);
            v14 = v14 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v38);
            if (v39 > 0) {
                let (v40, _, v42, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg3);
                v9 = v40;
                v8 = v42;
                v10 = 0x1::vector::length<u64>(&v9);
                v11 = 0x1::vector::length<u64>(&v8);
            };
        };
        (v12, v13, v14)
    }

    fun h1fdbf(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: u64) : u64 {
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

    public fun h20cdb<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u64 {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0
    }

    fun h22b6d<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u64, arg7: &vector<u64>, arg8: &vector<u64>, arg9: &vector<u64>, arg10: &vector<u64>, arg11: &vector<u64>, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: &0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = 3;
        let v1 = 2;
        let v2 = arg4;
        let v3 = arg5;
        let v4 = arg6;
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(arg7)) {
            let v6 = *0x1::vector::borrow<u64>(arg7, v5);
            v5 = v5 + 1;
            let v7 = *0x1::vector::borrow<u64>(arg11, v6);
            if (v7 < arg12) {
                let v8 = H291e0{
                    h32609 : 107,
                    h9c1a1 : 654,
                };
                0x2::event::emit<H291e0>(v8);
                continue
            };
            let v9 = *0x1::vector::borrow<u64>(arg9, v6);
            if (v9 == 0) {
                let v10 = H291e0{
                    h32609 : 101,
                    h9c1a1 : 662,
                };
                0x2::event::emit<H291e0>(v10);
                continue
            };
            if (v3 == 0) {
                let v11 = H291e0{
                    h32609 : 103,
                    h9c1a1 : 667,
                };
                0x2::event::emit<H291e0>(v11);
                break
            };
            let (v12, v13) = hd56ec<T0, T1>(arg0, v2, v3, v4, arg14, arg15, arg13, v9, *0x1::vector::borrow<u64>(arg10, v6), true, true, true);
            if (v13 != 0) {
                let v14 = H291e0{
                    h32609 : v13,
                    h9c1a1 : 687,
                };
                0x2::event::emit<H291e0>(v14);
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
        while (v5 < 0x1::vector::length<u64>(arg8)) {
            let v16 = *0x1::vector::borrow<u64>(arg8, v5);
            v5 = v5 + 1;
            let v17 = *0x1::vector::borrow<u64>(arg11, v16);
            if (v17 < arg12) {
                let v18 = H291e0{
                    h32609 : 107,
                    h9c1a1 : 735,
                };
                0x2::event::emit<H291e0>(v18);
                continue
            };
            let v19 = *0x1::vector::borrow<u64>(arg9, v16);
            if (v19 == 0) {
                let v20 = H291e0{
                    h32609 : 101,
                    h9c1a1 : 743,
                };
                0x2::event::emit<H291e0>(v20);
                continue
            };
            if (v2 < arg13) {
                let v21 = H291e0{
                    h32609 : 102,
                    h9c1a1 : 748,
                };
                0x2::event::emit<H291e0>(v21);
                break
            };
            let (v22, v23) = hd56ec<T0, T1>(arg0, v2, v3, v4, arg14, arg15, arg13, v19, *0x1::vector::borrow<u64>(arg10, v16), false, true, true);
            if (v23 != 0) {
                let v24 = H291e0{
                    h32609 : v23,
                    h9c1a1 : 768,
                };
                0x2::event::emit<H291e0>(v24);
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

    fun h3f97d<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::object::ID) : (vector<u64>, vector<u64>) {
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

    fun h43ff2(arg0: u64, arg1: bool, arg2: &vector<u64>, arg3: &vector<u64>, arg4: u64, arg5: u64) : bool {
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

    fun h9d383(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    fun ha78b6<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: &vector<u64>, arg7: &vector<u64>, arg8: vector<u64>, arg9: &vector<u64>, arg10: &vector<u64>, arg11: &vector<u64>, arg12: &vector<u64>, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: &vector<u64>, arg20: &vector<u64>, arg21: &0x2::tx_context::TxContext) : (u64, u64, u64) {
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
        while (v11 < 0x1::vector::length<u64>(arg6)) {
            let v16 = *0x1::vector::borrow<u64>(arg6, v11);
            v11 = v11 + 1;
            let v17 = *0x1::vector::borrow<u64>(arg9, v16);
            let v18 = h1fdbf(arg17, *0x1::vector::borrow<u64>(&arg8, v16), true, v8, v9);
            let v19 = if (v18 == 0) {
                0
            } else {
                hf29cd(arg17, v18, true, v8, v9, *0x1::vector::borrow<u64>(arg11, v16), haf5ec(arg19, v18, true))
            };
            if (v19 == 0) {
                let v20 = H291e0{
                    h32609 : 101,
                    h9c1a1 : 873,
                };
                0x2::event::emit<H291e0>(v20);
                continue
            };
            *0x1::vector::borrow_mut<u64>(&mut arg8, v16) = v19;
            let v21 = false;
            let v22 = 0;
            while (v22 < v1) {
                if (!*0x1::vector::borrow<bool>(&v10, v22)) {
                    let v23 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&v0, v22);
                    if (hc4910(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v23))) {
                        let v24 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(v23) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v23);
                        let v25 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(v23);
                        if (h9d383(v19, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v23)) <= *0x1::vector::borrow<u64>(arg12, v16) && v25 > arg15 + arg14) {
                            let v26 = (v17 as u128) * ((100 + arg13) as u128) / 100;
                            if ((v24 as u128) >= (v17 as u128) * ((100 - arg13) as u128) / 100 && (v24 as u128) <= v26) {
                                *0x1::vector::borrow_mut<bool>(&mut v10, v22) = true;
                                v21 = true;
                                v12 = v12 + 1;
                                break
                            };
                            if ((v24 as u128) > v26) {
                                let v27 = v17 / arg18 * arg18;
                                if (v27 >= arg16 && v25 > arg15 + arg14 * 2) {
                                    *0x1::vector::borrow_mut<bool>(&mut v10, v22) = true;
                                    v21 = true;
                                    0x1::vector::push_back<u128>(&mut v13, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v23));
                                    0x1::vector::push_back<u64>(&mut v14, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v23) + v27);
                                    break
                                };
                            };
                        };
                    };
                };
                v22 = v22 + 1;
            };
            if (!v21) {
                0x1::vector::push_back<u64>(&mut v15, v16);
            };
        };
        let v28 = 0x1::vector::empty<u64>();
        v11 = 0;
        while (v11 < 0x1::vector::length<u64>(arg7)) {
            let v29 = *0x1::vector::borrow<u64>(arg7, v11);
            v11 = v11 + 1;
            let v30 = *0x1::vector::borrow<u64>(arg9, v29);
            let v31 = h1fdbf(arg17, *0x1::vector::borrow<u64>(&arg8, v29), false, v8, v9);
            let v32 = if (v31 == 0) {
                0
            } else {
                hf29cd(arg17, v31, false, v8, v9, *0x1::vector::borrow<u64>(arg11, v29), haf5ec(arg20, v31, false))
            };
            if (v32 == 0) {
                let v33 = H291e0{
                    h32609 : 101,
                    h9c1a1 : 954,
                };
                0x2::event::emit<H291e0>(v33);
                continue
            };
            *0x1::vector::borrow_mut<u64>(&mut arg8, v29) = v32;
            let v34 = false;
            let v35 = 0;
            while (v35 < v1) {
                if (!*0x1::vector::borrow<bool>(&v10, v35)) {
                    let v36 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&v0, v35);
                    if (!hc4910(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v36))) {
                        let v37 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(v36) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v36);
                        let v38 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(v36);
                        if (h9d383(v32, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v36)) <= *0x1::vector::borrow<u64>(arg12, v29) && v38 > arg15 + arg14) {
                            let v39 = (v30 as u128) * ((100 + arg13) as u128) / 100;
                            if ((v37 as u128) >= (v30 as u128) * ((100 - arg13) as u128) / 100 && (v37 as u128) <= v39) {
                                *0x1::vector::borrow_mut<bool>(&mut v10, v35) = true;
                                v34 = true;
                                v12 = v12 + 1;
                                break
                            };
                            if ((v37 as u128) > v39) {
                                let v40 = v30 / arg18 * arg18;
                                if (v40 >= arg16 && v38 > arg15 + arg14 * 2) {
                                    *0x1::vector::borrow_mut<bool>(&mut v10, v35) = true;
                                    v34 = true;
                                    0x1::vector::push_back<u128>(&mut v13, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v36));
                                    0x1::vector::push_back<u64>(&mut v14, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v36) + v40);
                                    break
                                };
                            };
                        };
                    };
                };
                v35 = v35 + 1;
            };
            if (!v34) {
                0x1::vector::push_back<u64>(&mut v28, v29);
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
        let v41 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1);
        let v42 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1);
        let v43 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg1);
        let v44 = if (v41 > arg4) {
            v41 - arg4
        } else {
            0
        };
        let v45 = if (v42 > arg5) {
            v42 - arg5
        } else {
            0
        };
        h22b6d<T0, T1>(arg0, arg1, arg2, arg3, v44, v45, v43, &v15, &v28, &arg8, arg9, arg10, arg15, arg16, arg17, arg18, arg21)
    }

    fun haf5ec(arg0: &vector<u64>, arg1: u64, arg2: bool) : u64 {
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

    fun hc4910(arg0: u128) : bool {
        arg0 >> 127 == 0
    }

    fun hd56ec<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: bool, arg11: bool) : (u64, u64) {
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

    public fun hdd3c9(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg0);
        if (v0 < arg3) {
            let v1 = arg3 * 120 / 100 - v0;
            if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg2) < v1) {
                abort 108
            };
            let v2 = 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hc4901(arg1, arg4);
            0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hd47ee(arg1, v2, arg4);
            0x2::coin::join<0x2::sui::SUI>(arg0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<0x2::sui::SUI>(arg2, &v2, v1, arg4));
        };
    }

    public fun he605f<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2::clock::Clock, arg4: bool, arg5: u64, arg6: u64, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: vector<u64>, arg14: vector<u64>, arg15: 0x1::option::Option<0x2::object::ID>, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg11);
        let v1 = if (0x1::vector::length<u64>(&arg12) == v0) {
            if (0x1::vector::length<u64>(&arg13) == v0) {
                0x1::vector::length<u64>(&arg14) == v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 109);
        h0142f(&arg7, v0);
        h0142f(&arg8, v0);
        h0142f(&arg9, v0);
        h0142f(&arg10, v0);
        let v2 = 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::h50957(arg1, arg2, arg16);
        if (arg4) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg2, &v2, arg3, arg16);
        };
        let (v3, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v7 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2);
        let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg2);
        let v9 = if (v6 > arg5) {
            v6 - arg5
        } else {
            0
        };
        let v10 = if (v7 > arg6) {
            v7 - arg6
        } else {
            0
        };
        let v11 = 0x2::clock::timestamp_ms(arg3);
        let (v12, v13, v14) = h0ac4a<T0, T1>(arg0, arg2, &v2, arg3, v9, v10, v8, &arg7, &arg8, &arg11, &arg12, &arg13, v11, v5, v3, v4, arg16);
        let v15 = 0x1::vector::length<u64>(&arg9) > 0 || 0x1::vector::length<u64>(&arg10) > 0;
        let (v16, v17) = if (v15 && 0x1::option::is_some<0x2::object::ID>(&arg15)) {
            h3f97d<T0, T1>(arg0, arg3, 0x1::option::borrow<0x2::object::ID>(&arg15))
        } else {
            (0x1::vector::empty<u64>(), 0x1::vector::empty<u64>())
        };
        let v18 = v17;
        let v19 = v16;
        if (v15) {
            let (v20, _, v22, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg3);
            let v24 = v22;
            let v25 = v20;
            let v26 = if (0x1::vector::length<u64>(&v25) > 0) {
                *0x1::vector::borrow<u64>(&v25, 0)
            } else {
                0
            };
            let v27 = if (0x1::vector::length<u64>(&v24) > 0) {
                *0x1::vector::borrow<u64>(&v24, 0)
            } else {
                0
            };
            let v28 = 0;
            while (v28 < 0x1::vector::length<u64>(&arg9)) {
                let v29 = *0x1::vector::borrow<u64>(&arg9, v28);
                let v30 = h1fdbf(v3, *0x1::vector::borrow<u64>(&arg11, v29), true, v26, v27);
                let v31 = if (v30 == 0) {
                    0
                } else {
                    hf29cd(v3, v30, true, v26, v27, *0x1::vector::borrow<u64>(&arg14, v29), haf5ec(&v19, v30, true))
                };
                *0x1::vector::borrow_mut<u64>(&mut arg11, v29) = v31;
                v28 = v28 + 1;
            };
            v28 = 0;
            while (v28 < 0x1::vector::length<u64>(&arg10)) {
                let v32 = *0x1::vector::borrow<u64>(&arg10, v28);
                let v33 = h1fdbf(v3, *0x1::vector::borrow<u64>(&arg11, v32), false, v26, v27);
                let v34 = if (v33 == 0) {
                    0
                } else {
                    hf29cd(v3, v33, false, v26, v27, *0x1::vector::borrow<u64>(&arg14, v32), haf5ec(&v18, v33, false))
                };
                *0x1::vector::borrow_mut<u64>(&mut arg11, v32) = v34;
                v28 = v28 + 1;
            };
        };
        let (_, _, _) = h22b6d<T0, T1>(arg0, arg2, &v2, arg3, v12, v13, v14, &arg9, &arg10, &arg11, &arg12, &arg13, v11, v5, v3, v4, arg16);
    }

    fun hf29cd(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = arg1;
        if (arg2) {
            let v1 = if (arg6 > 0) {
                if (arg5 > 0) {
                    arg1 <= arg6
                } else {
                    false
                }
            } else {
                false
            };
            if (v1) {
                if (((arg6 - arg1) as u128) * (10000 as u128) <= (arg1 as u128) * (arg5 as u128)) {
                    let v2 = arg6 + arg0;
                    v0 = v2;
                    let v3 = if (arg4 > 0) {
                        if (v2 >= arg4) {
                            arg4 >= arg0
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    if (v3) {
                        v0 = arg4 - arg0;
                    };
                };
            };
        } else {
            let v4 = if (arg6 > 0) {
                if (arg5 > 0) {
                    if (arg6 > arg0) {
                        arg1 >= arg6
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v4) {
                if (((arg1 - arg6) as u128) * (10000 as u128) <= (arg1 as u128) * (arg5 as u128)) {
                    let v5 = arg6 - arg0;
                    v0 = v5;
                    let v6 = if (arg3 > 0) {
                        if (v5 <= arg3) {
                            arg3 <= 18446744073709551615 - arg0
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    if (v6) {
                        v0 = arg3 + arg0;
                    };
                };
            };
        };
        v0
    }

    // decompiled from Move bytecode v6
}

