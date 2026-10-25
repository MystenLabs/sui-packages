module 0x978161016d24c3d6a819d88f674fe093c15ee5c870ba5cade9648b09a7f8ff33::h0d1a7 {
    struct H291e0 has copy, drop {
        h32609: u64,
        h9c1a1: u64,
    }

    struct Hc4b41 has drop {
        h6f52c: 0x1::option::Option<u64>,
        h812ae: bool,
        h98e75: vector<u64>,
    }

    struct Hca161 has copy, drop {
        h2fbb3: u64,
        h9fe66: u64,
        h0615e: u64,
        hd7679: bool,
    }

    public fun h03b75<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg1, arg2, arg3, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T2>(arg1, arg4, arg5)
    }

    fun h0ac4a<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg3: &0x2::clock::Clock, arg4: &Hca161, arg5: u64, arg6: u64, arg7: &vector<u64>, arg8: &vector<u64>, arg9: &vector<u64>, arg10: &vector<u64>, arg11: &vector<u64>, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: &0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(arg7);
        let v1 = 0x1::vector::length<u64>(arg8);
        if (v0 == 0 && v1 == 0) {
            return
        };
        let (v2, _, v4, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg3);
        let v6 = v4;
        let v7 = v2;
        let v8 = 0;
        while (v8 < v0) {
            let v9 = *0x1::vector::borrow<u64>(arg7, v8);
            v8 = v8 + 1;
            if (*0x1::vector::borrow<u64>(arg11, v9) < arg12) {
                hdd85a(107, 704);
                continue
            };
            let v10 = *0x1::vector::borrow<u64>(arg9, v9);
            if (!h43ff2(v10, true, &v7, &v6)) {
                break
            };
            let (v11, v12, v13) = h885a4<T0, T1, T2>(arg1, arg5, arg6);
            if (v12 == 0) {
                hdd85a(103, 724);
                break
            };
            let (v14, v15) = h53798(arg4, arg4.h2fbb3, v11, v12, v13, arg14, arg15, arg13, v10, v10, *0x1::vector::borrow<u64>(arg10, v9), true);
            if (v15 != 0) {
                hdd85a(v15, 743);
                continue
            };
            let v16 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg1, arg2, 18446744073709551615, 1, 2, v10, v14, true, true, *0x1::vector::borrow<u64>(arg11, v9), arg3, arg16);
            if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v16) > 0) {
                let (v17, _, v19, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg3);
                v7 = v17;
                v6 = v19;
            };
        };
        v8 = 0;
        while (v8 < v1) {
            let v21 = *0x1::vector::borrow<u64>(arg8, v8);
            v8 = v8 + 1;
            if (*0x1::vector::borrow<u64>(arg11, v21) < arg12) {
                hdd85a(107, 776);
                continue
            };
            let v22 = *0x1::vector::borrow<u64>(arg9, v21);
            if (!h43ff2(v22, false, &v7, &v6)) {
                break
            };
            let (v23, v24, v25) = h885a4<T0, T1, T2>(arg1, arg5, arg6);
            if (v23 < arg13) {
                hdd85a(102, 796);
                break
            };
            let (v26, v27) = h53798(arg4, arg4.h2fbb3, v23, v24, v25, arg14, arg15, arg13, v22, 0x1::u64::max(v22, *0x1::vector::borrow<u64>(&v7, 0)), *0x1::vector::borrow<u64>(arg10, v21), false);
            if (v27 != 0) {
                hdd85a(v27, 818);
                continue
            };
            let v28 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg1, arg2, 18446744073709551615, 1, 2, v22, v26, false, true, *0x1::vector::borrow<u64>(arg11, v21), arg3, arg16);
            if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v28) > 0) {
                let (v29, _, v31, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg3);
                v7 = v29;
                v6 = v31;
            };
        };
    }

    fun h0cd12<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64) : Hc4b41 {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::iter_orders<T0, T1>(arg0, 0x1::option::none<u128>(), 0x1::option::none<u128>(), 0x1::option::none<u64>(), 20, arg1);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::orders(&v0);
        let v2 = vector[];
        let v3 = vector[];
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v1)) {
            let v5 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v1, v4);
            v4 = v4 + 1;
            if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(v5) < arg2) {
                continue
            };
            0x1::vector::push_back<u64>(&mut v2, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v5));
            0x1::vector::push_back<u64>(&mut v3, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(v5) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v5));
        };
        let v6 = if (0x1::vector::length<u64>(&v2) > 0) {
            0x1::option::some<u64>(*0x1::vector::borrow<u64>(&v2, 0))
        } else {
            0x1::option::none<u64>()
        };
        let v7 = 0x1::vector::length<u64>(&v2) == 0 && 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::has_next_page(&v0);
        Hc4b41{
            h6f52c : v6,
            h812ae : v7,
            h98e75 : hdd141(&v2, &v3, arg3),
        }
    }

    fun h13074(arg0: u64, arg1: u64) : bool {
        if (arg0 > 0) {
            if (arg0 <= 9223372036854775807) {
                arg0 % arg1 == 0
            } else {
                false
            }
        } else {
            false
        }
    }

    fun h132b5(arg0: bool, arg1: u64, arg2: u64) : u64 {
        if (arg0) {
            arg1 - arg2
        } else {
            arg1 + arg2
        }
    }

    fun h1c470(arg0: bool, arg1: u64, arg2: u64) : bool {
        arg0 && arg1 > arg2 || arg1 < arg2
    }

    fun h1e218<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) : Hca161 {
        let (v0, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        let (v3, v4, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params_next<T0, T1>(arg0);
        let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order_deep_price<T0, T1>(arg0);
        Hca161{
            h2fbb3 : 0x1::u64::max(v0, v3),
            h9fe66 : 0x1::u64::max(v1, v4),
            h0615e : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::deep_per_asset(&v6),
            hd7679 : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::asset_is_base(&v6),
        }
    }

    fun h1fdbf(arg0: u64, arg1: u64, arg2: bool, arg3: &0x1::option::Option<u64>, arg4: &0x1::option::Option<u64>) : u64 {
        if (!h13074(arg1, arg0)) {
            return 0
        };
        if (arg2) {
            if (0x1::option::is_some<u64>(arg4) && arg1 >= *0x1::option::borrow<u64>(arg4)) {
                let v0 = *0x1::option::borrow<u64>(arg4);
                if (v0 <= arg0) {
                    return 0
                };
                return v0 - arg0
            };
        } else if (0x1::option::is_some<u64>(arg3) && arg1 <= *0x1::option::borrow<u64>(arg3)) {
            let v1 = *0x1::option::borrow<u64>(arg3);
            if (v1 > h84f17(arg0) - arg0) {
                return 0
            };
            return v1 + arg0
        };
        arg1
    }

    fun h1feae(arg0: bool, arg1: u64, arg2: u64) : u64 {
        let v0 = h47671(arg1, arg2);
        if (arg0) {
            if (arg1 + v0 < 9223372036854775807) {
                arg1 + v0
            } else {
                9223372036854775807
            }
        } else {
            arg1 - v0
        }
    }

    public fun h20cdb<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0
    }

    fun h31444<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg3: &0x2::clock::Clock, arg4: &Hca161, arg5: u64, arg6: u64, arg7: &vector<u64>, arg8: &vector<u64>, arg9: &vector<u64>, arg10: &vector<u64>, arg11: &vector<u64>, arg12: bool, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: &0x1::option::Option<u64>, arg18: &0x1::option::Option<u64>, arg19: &vector<u64>, arg20: &0x1::option::Option<u64>, arg21: &0x2::tx_context::TxContext) : 0x1::option::Option<u64> {
        let v0 = if (arg12) {
            arg18
        } else {
            arg17
        };
        let v1 = 0x1::option::none<u64>();
        let v2 = 0x1::option::none<u64>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(arg7)) {
            let v4 = *0x1::vector::borrow<u64>(arg7, v3);
            v3 = v3 + 1;
            if (*0x1::vector::borrow<u64>(arg10, v4) < arg13) {
                hdd85a(107, 899);
                continue
            };
            let v5 = h1fdbf(arg15, *0x1::vector::borrow<u64>(arg8, v4), arg12, arg17, arg18);
            if (v5 == 0) {
                hdd85a(101, 905);
                continue
            };
            let v6 = ha32af(arg12, v5, *0x1::vector::borrow<u64>(arg11, v4), arg15, arg19, v0, &v1);
            if (0x1::option::is_some<u64>(arg20) && h4a576(arg12, v6, *0x1::option::borrow<u64>(arg20))) {
                hdd85a(111, 920);
                continue
            };
            let (v7, v8, v9) = h885a4<T0, T1, T2>(arg1, arg5, arg6);
            let (v10, v11) = h53798(arg4, arg4.h9fe66, v7, v8, v9, arg15, arg16, arg14, v6, v6, *0x1::vector::borrow<u64>(arg9, v4), arg12);
            if (v11 != 0) {
                hdd85a(v11, 944);
                if (!arg12 && v11 == 102) {
                    break
                } else {
                    continue
                };
            };
            let v12 = if (arg12) {
                18446744073709551615
            } else {
                0
            };
            let v13 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg1, arg2, v12, 3, 2, v6, v10, arg12, true, *0x1::vector::borrow<u64>(arg10, v4), arg3, arg21);
            if (!0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_inserted(&v13)) {
                hdd85a(112, 970);
                continue
            };
            if (0x1::option::is_none<u64>(&v2) || h1c470(arg12, v6, *0x1::option::borrow<u64>(&v2))) {
                v2 = 0x1::option::some<u64>(v6);
            };
            v1 = 0x1::option::some<u64>(h41d33(arg12, v6, arg15));
        };
        v2
    }

    fun h3bed9(arg0: bool, arg1: u64, arg2: u64) : u64 {
        if (h1c470(arg0, arg1, arg2)) {
            arg2
        } else {
            arg1
        }
    }

    fun h41d33(arg0: bool, arg1: u64, arg2: u64) : u64 {
        if (arg0) {
            if (arg1 > 2 * arg2) {
                arg1 - 2 * arg2
            } else {
                0
            }
        } else if (arg1 < 18446744073709551615 - 2 * arg2) {
            arg1 + 2 * arg2
        } else {
            18446744073709551615
        }
    }

    fun h43ff2(arg0: u64, arg1: bool, arg2: &vector<u64>, arg3: &vector<u64>) : bool {
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

    fun h47671(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    fun h4a576(arg0: bool, arg1: u64, arg2: u64) : bool {
        arg0 && arg1 >= arg2 || arg1 <= arg2
    }

    fun h53798(arg0: &Hca161, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: bool) : (u64, u64) {
        if (!h13074(arg8, arg5)) {
            return (0, 101)
        };
        if (arg10 < arg7) {
            return (0, 105)
        };
        let v0 = if (arg11) {
            103
        } else {
            102
        };
        let v1 = if (arg11) {
            hb70af(h8664a(arg0, arg1, arg3), arg8, arg6)
        } else {
            let v2 = h8664a(arg0, arg1, arg2);
            v2 - v2 % arg6
        };
        let v3 = 0x1::u64::min(arg10, v1);
        let v4 = v3 - v3 % arg6;
        if (v4 < arg7) {
            return (0, v0)
        };
        if (he1a5a((v4 as u128), arg8) > (18446744073709551615 as u128) || he1a5a((v4 as u128), arg9) > (18446744073709551615 as u128)) {
            return (0, 101)
        };
        let (v5, v6, v7) = h6cf1d(arg0, arg1, v4, arg8, arg9, arg11);
        if (v5 > (arg2 as u128) || v6 > (arg3 as u128)) {
            return (0, v0)
        };
        if (v7 > (arg4 as u128)) {
            return (0, 104)
        };
        (v4, 0)
    }

    fun h56af9(arg0: &mut vector<u64>, arg1: u64, arg2: u256, arg3: u64) {
        if (arg1 == 0 || arg2 == 0) {
            return
        };
        if (arg2 * (arg1 as u256) / (1000000000 as u256) >= (arg3 as u256)) {
            0x1::vector::push_back<u64>(arg0, arg1);
        };
    }

    fun h5943a(arg0: &vector<u64>) : 0x1::option::Option<u64> {
        if (0x1::vector::length<u64>(arg0) > 0) {
            0x1::option::some<u64>(*0x1::vector::borrow<u64>(arg0, 0))
        } else {
            0x1::option::none<u64>()
        }
    }

    fun h6cf1d(arg0: &Hca161, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: bool) : (u128, u128, u128) {
        let v0 = if (arg5) {
            0
        } else {
            (arg2 as u128)
        };
        let v1 = v0;
        let v2 = if (arg5) {
            he1a5a((arg2 as u128), arg3)
        } else {
            0
        };
        let v3 = v2;
        let v4 = 0;
        if (arg0.h0615e > 0) {
            let v5 = if (arg0.hd7679) {
                (arg2 as u128)
            } else {
                he1a5a((arg2 as u128), arg4)
            };
            v4 = he1a5a(he1a5a(v5, arg0.h0615e), arg1);
        } else if (arg5) {
            v3 = h9d2d2(v2, he1a5a(he1a5a(he1a5a((arg2 as u128), arg4), 1250000000), arg1));
        } else {
            v1 = h9d2d2(v0, he1a5a(he1a5a((arg2 as u128), 1250000000), arg1));
        };
        (v1, v3, v4)
    }

    fun h84f17(arg0: u64) : u64 {
        9223372036854775807 / arg0 * arg0
    }

    fun h8664a(arg0: &Hca161, arg1: u64, arg2: u64) : u64 {
        if (arg0.h0615e > 0) {
            return arg2
        };
        (((arg2 as u128) * 1000000000 / (1000000000 + he1a5a((1250000000 as u128), arg1))) as u64)
    }

    fun h885a4<T0, T1, T2>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: u64, arg2: u64) : (u64, u64, u64) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg0);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg0);
        let v2 = if (v0 > arg1) {
            v0 - arg1
        } else {
            0
        };
        let v3 = if (v1 > arg2) {
            v1 - arg2
        } else {
            0
        };
        (v2, v3, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg0))
    }

    public fun h984cc<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2::clock::Clock, arg4: bool, arg5: u64, arg6: u64, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: vector<u64>, arg14: vector<u64>, arg15: u64, arg16: bool, arg17: &mut 0x2::tx_context::TxContext) {
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
        let v2 = 0x1::vector::length<u64>(&arg9) > 0 || 0x1::vector::length<u64>(&arg10) > 0;
        assert!(!v2 || arg4, 110);
        let v3 = 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::h50957(arg1, arg2, arg17);
        if (arg4) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg2, &v3, arg3, arg17);
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg0, arg2, &v3);
        if (v0 == 0) {
            return
        };
        let (v4, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v7 = h1e218<T0, T1>(arg0);
        let v8 = 0x2::clock::timestamp_ms(arg3);
        h0ac4a<T0, T1, T2>(arg0, arg2, &v3, arg3, &v7, arg5, arg6, &arg7, &arg8, &arg11, &arg12, &arg13, v8, v6, v4, v5, arg17);
        if (!v2) {
            return
        };
        let (v9, v10, v11, v12) = hdaeb4<T0, T1>(arg0, arg3, v8, arg16, arg15);
        let v13 = v12;
        let v14 = v11;
        let v15 = v10;
        let v16 = v9;
        let v17 = 0x1::option::none<u64>();
        let v18 = h31444<T0, T1, T2>(arg0, arg2, &v3, arg3, &v7, arg5, arg6, &arg9, &arg11, &arg12, &arg13, &arg14, true, v8, v6, v4, v5, &v16, &v15, &v14, &v17, arg17);
        let v19 = v16;
        if (0x1::option::is_some<u64>(&v18)) {
            let v20 = *0x1::option::borrow<u64>(&v18);
            if (0x1::option::is_none<u64>(&v19) || v20 > *0x1::option::borrow<u64>(&v19)) {
                v19 = 0x1::option::some<u64>(v20);
            };
        };
        h31444<T0, T1, T2>(arg0, arg2, &v3, arg3, &v7, arg5, arg6, &arg10, &arg11, &arg12, &arg13, &arg14, false, v8, v6, v4, v5, &v19, &v15, &v13, &v18, arg17);
    }

    fun h9d2d2(arg0: u128, arg1: u128) : u128 {
        if (arg0 > 340282366920938463463374607431768211455 - arg1) {
            340282366920938463463374607431768211455
        } else {
            arg0 + arg1
        }
    }

    fun ha32af(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: &vector<u64>, arg5: &0x1::option::Option<u64>, arg6: &0x1::option::Option<u64>) : u64 {
        if (arg2 == 0) {
            return arg1
        };
        let v0 = h1feae(arg0, arg1, arg2);
        let v1 = v0;
        if (0x1::option::is_some<u64>(arg6)) {
            v1 = h3bed9(arg0, v0, *0x1::option::borrow<u64>(arg6));
        };
        let v2 = ha6da9(arg0, arg4, arg1, v1);
        if (0x1::option::is_some<u64>(&v2)) {
            let v3 = *0x1::option::borrow<u64>(&v2);
            if (!arg0 && v3 <= arg3 || arg0 && v3 >= h84f17(arg3)) {
                v2 = 0x1::option::none<u64>();
            };
        };
        if (0x1::option::is_none<u64>(&v2)) {
            return arg1
        };
        let v4 = hc8a5a(arg0, 0x1::option::extract<u64>(&mut v2), arg3);
        let v5 = v4;
        if (0x1::option::is_some<u64>(arg5)) {
            let v6 = *0x1::option::borrow<u64>(arg5);
            if (h4a576(arg0, v4, v6)) {
                v5 = h132b5(arg0, v6, arg3);
            };
        };
        v5
    }

    fun ha6da9(arg0: bool, arg1: &vector<u64>, arg2: u64, arg3: u64) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg1)) {
            let v1 = *0x1::vector::borrow<u64>(arg1, v0);
            v0 = v0 + 1;
            if (h1c470(arg0, v1, arg3)) {
                continue
            };
            if (h4a576(arg0, v1, arg2)) {
                return 0x1::option::some<u64>(v1)
            };
            return 0x1::option::none<u64>()
        };
        0x1::option::none<u64>()
    }

    fun hb70af(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (((arg0 as u128) + 1) * 1000000000 - 1) / (arg1 as u128);
        let v1 = if (v0 > (18446744073709551615 as u128)) {
            18446744073709551615
        } else {
            (v0 as u64)
        };
        v1 - v1 % arg2
    }

    fun hc8a5a(arg0: bool, arg1: u64, arg2: u64) : u64 {
        if (arg0) {
            arg1 + arg2
        } else {
            arg1 - arg2
        }
    }

    fun hdaeb4<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64, arg3: bool, arg4: u64) : (0x1::option::Option<u64>, 0x1::option::Option<u64>, vector<u64>, vector<u64>) {
        if (!arg3) {
            let (v0, _, v2, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg1);
            let v4 = v2;
            let v5 = v0;
            return (h5943a(&v5), h5943a(&v4), vector[], vector[])
        };
        let v6 = h0cd12<T0, T1>(arg0, true, arg2, arg4);
        let v7 = h0cd12<T0, T1>(arg0, false, arg2, arg4);
        let v8 = v6.h6f52c;
        let v9 = v7.h6f52c;
        if (v6.h812ae || v7.h812ae) {
            let (v10, _, v12, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg1);
            let v14 = v12;
            let v15 = v10;
            if (v6.h812ae) {
                v8 = h5943a(&v15);
            };
            if (v7.h812ae) {
                v9 = h5943a(&v14);
            };
        };
        (v8, v9, v6.h98e75, v7.h98e75)
    }

    fun hdd141(arg0: &vector<u64>, arg1: &vector<u64>, arg2: u64) : vector<u64> {
        let v0 = vector[];
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(arg0)) {
            let v5 = *0x1::vector::borrow<u64>(arg0, v4);
            if (v5 != v1) {
                let v6 = &mut v0;
                h56af9(v6, v1, v3, arg2);
                v2 = v5;
                v3 = 0;
            };
            v3 = v3 + (*0x1::vector::borrow<u64>(arg1, v4) as u256);
            v4 = v4 + 1;
        };
        let v7 = &mut v0;
        h56af9(v7, v2, v3, arg2);
        v0
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

    fun hdd85a(arg0: u64, arg1: u64) {
        let v0 = H291e0{
            h32609 : arg0,
            h9c1a1 : arg1,
        };
        0x2::event::emit<H291e0>(v0);
    }

    fun he1a5a(arg0: u128, arg1: u64) : u128 {
        if (arg0 > (18446744073709551615 as u128)) {
            return 340282366920938463463374607431768211455
        };
        arg0 * (arg1 as u128) / 1000000000
    }

    // decompiled from Move bytecode v7
}

