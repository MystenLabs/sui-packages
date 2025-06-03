module 0x593b979f89a481f594ade406871884c058178c01aee1c9235afdd9581e82d68f::dbke {
    struct EE has copy, drop {
        e: u64,
        l: u64,
    }

    public fun cao_s<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg3: &0x2::clock::Clock, arg4: &mut 0x67a4708740dcc8cfd86aea52b11d1972fe1fd9e9f3070b49763d55fe609611a1::sq::SQR, arg5: u64, arg6: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x67a4708740dcc8cfd86aea52b11d1972fe1fd9e9f3070b49763d55fe609611a1::sq::cii(arg4, arg5, true, arg6);
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

    fun cim(arg0: u8) : bool {
        let v0 = &arg0;
        let v1 = custom_post_only_slide();
        if (v0 == &v1) {
            true
        } else {
            let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only();
            if (v0 == &v3) {
                true
            } else {
                let v4 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel();
                if (v0 == &v4) {
                    false
                } else {
                    let v5 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::fill_or_kill();
                    v0 == &v5 && false
                }
            }
        }
    }

    fun custom_post_only_slide() : u8 {
        111
    }

    public fun elb<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x61e43d6889970253a03978b179967d46a01ced914ff3b5581b76fb0d9f283c8a::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2::clock::Clock, arg4: bool, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<bool>, arg10: vector<u64>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x61e43d6889970253a03978b179967d46a01ced914ff3b5581b76fb0d9f283c8a::bm::gdtp(arg1, arg2, arg11);
        if (arg4) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg2, &v0, arg3, arg11);
        };
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2);
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg2);
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg7)) {
            let v5 = *0x1::vector::borrow<u64>(&arg10, v4);
            if (v5 < 0x2::clock::timestamp_ms(arg3)) {
                let v6 = EE{
                    e : 6,
                    l : 252,
                };
                0x2::event::emit<EE>(v6);
                v4 = v4 + 1;
                continue
            };
            let v7 = *0x1::vector::borrow<u8>(&arg5, v4);
            let v8 = *0x1::vector::borrow<u8>(&arg6, v4);
            let v9 = *0x1::vector::borrow<u64>(&arg7, v4);
            let v10 = *0x1::vector::borrow<u64>(&arg8, v4);
            let v11 = *0x1::vector::borrow<bool>(&arg9, v4);
            if (v7 == 111) {
                let v12 = EE{
                    e : 7,
                    l : 264,
                };
                0x2::event::emit<EE>(v12);
                v4 = v4 + 1;
                continue
            };
            let v13 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg2, &v0, v4, v7, v8, v9, v10, v11, true, v5, arg3, arg11);
            if (v11) {
                v1 = v1 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v13);
                v2 = v2 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(&v13) * v9 / 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() + 1;
            } else {
                v1 = v1 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(&v13);
                let v14 = v2 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v13) * v9 / 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling();
                v2 = v14 - 1;
            };
            v3 = v3 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v13);
            v4 = v4 + 1;
        };
    }

    public fun elf<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x61e43d6889970253a03978b179967d46a01ced914ff3b5581b76fb0d9f283c8a::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2::clock::Clock, arg4: &mut 0x67a4708740dcc8cfd86aea52b11d1972fe1fd9e9f3070b49763d55fe609611a1::sq::SQR, arg5: u64, arg6: bool, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<bool>, arg12: vector<u64>, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x67a4708740dcc8cfd86aea52b11d1972fe1fd9e9f3070b49763d55fe609611a1::sq::cii(arg4, arg5, true, arg13);
        if (v0 != 0) {
            let v1 = EE{
                e : v0,
                l : 324,
            };
            0x2::event::emit<EE>(v1);
            return
        };
        let v2 = 0x61e43d6889970253a03978b179967d46a01ced914ff3b5581b76fb0d9f283c8a::bm::gdtp(arg1, arg2, arg13);
        if (arg6) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg2, &v2, arg3, arg13);
        };
        let (v3, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v7 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2);
        let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg2);
        let v9 = false;
        let v10 = 0x1::vector::empty<u64>();
        let v11 = 0x1::vector::empty<u64>();
        let v12 = 0;
        while (v12 < 0x1::vector::length<u64>(&arg9)) {
            let v13 = *0x1::vector::borrow<u64>(&arg12, v12);
            if (v13 < 0x2::clock::timestamp_ms(arg3)) {
                let v14 = EE{
                    e : 6,
                    l : 348,
                };
                0x2::event::emit<EE>(v14);
                v12 = v12 + 1;
                continue
            };
            let v15 = *0x1::vector::borrow<u8>(&arg7, v12);
            let v16 = *0x1::vector::borrow<u8>(&arg8, v12);
            let v17 = *0x1::vector::borrow<u64>(&arg9, v12);
            let v18 = *0x1::vector::borrow<u64>(&arg10, v12);
            let v19 = *0x1::vector::borrow<bool>(&arg11, v12);
            let v20 = v17;
            let v21 = v15;
            if (v15 == 111) {
                if (!v9) {
                    let (v22, _, v24, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg3);
                    v10 = v22;
                    v11 = v24;
                    v9 = true;
                };
                let v26 = sp(&v10, &v11, v3, v17, v19);
                if (v26 == 0) {
                    let v27 = EE{
                        e : 1,
                        l : 379,
                    };
                    0x2::event::emit<EE>(v27);
                    v12 = v12 + 1;
                    continue
                };
                v20 = v26;
                v21 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only();
            };
            let (v28, v29) = vbac<T0, T1>(arg0, v6, v7, v8, v3, v4, v5, v20, v18, v19, cim(v15), true);
            if (v29 != 0) {
                let v30 = EE{
                    e : v29,
                    l : 404,
                };
                0x2::event::emit<EE>(v30);
                v12 = v12 + 1;
                continue
            };
            let v31 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg2, &v2, v12, v21, v16, v20, v28, v19, true, v13, arg3, arg13);
            if (v19) {
                v6 = v6 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v31);
                v7 = v7 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(&v31) * v20 / 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() + 1;
            } else {
                v6 = v6 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(&v31);
                let v32 = v7 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v31) * v20 / 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling();
                v7 = v32 - 1;
            };
            v8 = v8 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v31);
            v12 = v12 + 1;
        };
    }

    fun sp(arg0: &vector<u64>, arg1: &vector<u64>, arg2: u64, arg3: u64, arg4: bool) : u64 {
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
            return (0, 1)
        };
        if (arg7 % arg4 != 0) {
            return (0, 1)
        };
        if (!arg9 && arg1 < arg6) {
            return (0, 2)
        };
        if (arg8 < arg6) {
            return (0, 5)
        };
        let v0 = if (arg9) {
            let v1 = (((arg2 as u128) * 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling_u128() / (arg7 as u128)) as u64);
            let v2 = v1 - arg5 - v1 % arg5;
            if (v2 < arg6) {
                return (0, 3)
            };
            let v3 = 0x1::u64::max(arg6, 0x1::u64::min(arg8, (v2 as u64)));
            v3 - v3 % arg5
        } else {
            let v4 = 0x1::u64::max(arg6, 0x1::u64::min(arg8, arg1));
            v4 - v4 % arg5
        };
        let v5 = if (arg11) {
            let (v6, v7) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order_deep_required<T0, T1>(arg0, v0, arg7);
            if (arg10) {
                v7
            } else {
                v6
            }
        } else {
            0
        };
        if (v5 > arg3) {
            return (0, 4)
        };
        (v0, 0)
    }

    // decompiled from Move bytecode v6
}

