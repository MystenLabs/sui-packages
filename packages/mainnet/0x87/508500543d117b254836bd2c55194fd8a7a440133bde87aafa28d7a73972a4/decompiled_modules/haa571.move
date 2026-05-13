module 0x87508500543d117b254836bd2c55194fd8a7a440133bde87aafa28d7a73972a4::haa571 {
    struct H9c317 has copy, drop {
        hd909d: u64,
        h88d66: u64,
        h76211: u64,
    }

    struct H6cbe6 has copy, drop {
        hd909d: u64,
        h88d66: u64,
        h76211: u64,
        h471c9: u128,
        hf9fb2: bool,
    }

    fun h09bea<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: u64, arg6: u128, arg7: bool, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        if (arg5 == 0) {
            return (0, 0)
        };
        let v0 = if (arg8) {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0)
        } else {
            h41ce6(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0))
        };
        let v1 = arg7 && v0 <= arg6 || v0 >= arg6;
        if (!v1) {
            return (0, 0)
        };
        let v2 = arg8 != arg7;
        let v3 = h2c6c8<T0, T1, T2>(arg0, v2, true, arg5, arg6, arg8);
        let v4 = (v3.hd909d as u128) + (v3.h76211 as u128);
        let v5 = v3.h88d66;
        if (v5 == 0 || v4 == 0) {
            return (0, 0)
        };
        let v6 = h72b06(arg6);
        let v7 = if (arg7) {
            ((v4 * 1000000000000 / v6) as u64)
        } else {
            ((v4 * v6 / 1000000000000) as u64)
        };
        if (v5 < v7) {
            return (0, 0)
        };
        let v8 = if (arg8) {
            arg6
        } else {
            h41ce6(arg6)
        };
        let (v9, v10, v11) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg9), v2, (arg5 as u128), true, v8, arg4, arg3, arg9);
        let v12 = v11;
        let v13 = v10;
        let v14 = v9;
        let (_, _, v17) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v12);
        let (v18, v19) = if (v2) {
            (v17, 0)
        } else {
            (0, v17)
        };
        let v20 = if (v2) {
            v18
        } else {
            v19
        };
        let v21 = if (v2) {
            0x2::coin::value<T1>(&v13)
        } else {
            0x2::coin::value<T0>(&v14)
        };
        let v22 = if (arg7) {
            (((v20 as u128) * 1000000000000 / v6) as u64)
        } else {
            (((v20 as u128) * v6 / 1000000000000) as u64)
        };
        assert!(v21 >= v22, 13906835424178929666);
        let (v23, v24) = if (v2) {
            (0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hf6525<T0>(arg1, arg2, v18, arg9), 0x2::coin::zero<T1>(arg9))
        } else {
            (0x2::coin::zero<T0>(arg9), 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hf6525<T1>(arg1, arg2, v19, arg9))
        };
        let v25 = v24;
        let v26 = v23;
        let (v27, v28) = if (v2) {
            (0x2::coin::split<T0>(&mut v26, v18, arg9), 0x2::coin::zero<T1>(arg9))
        } else {
            (0x2::coin::zero<T0>(arg9), 0x2::coin::split<T1>(&mut v25, v19, arg9))
        };
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, v27, v28, v12, arg3);
        0x2::coin::join<T0>(&mut v26, v14);
        0x2::coin::join<T1>(&mut v25, v13);
        0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hec8a2<T0>(arg1, arg2, v26, arg9);
        0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hec8a2<T1>(arg1, arg2, v25, arg9);
        (v20, v21)
    }

    fun h2c6c8<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: bool, arg2: bool, arg3: u64, arg4: u128, arg5: bool) : H6cbe6 {
        let v0 = if (arg5) {
            arg4
        } else {
            h41ce6(arg4)
        };
        let v1 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0);
        let v2 = v1;
        let v3 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_liquidity<T0, T1, T2>(arg0);
        let v4 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_current_index<T0, T1, T2>(arg0);
        let v5 = H9c317{
            hd909d : 0,
            h88d66 : 0,
            h76211 : 0,
        };
        let v6 = H6cbe6{
            hd909d : 0,
            h88d66 : 0,
            h76211 : 0,
            h471c9 : v1,
            hf9fb2 : false,
        };
        while (arg3 > 0 && v2 != v0) {
            let (v7, v8) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::next_initialized_tick_within_one_word<T0, T1, T2>(arg0, v4, arg1);
            let v9 = v7;
            if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lt(v7, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::neg_from(443636))) {
                v9 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::neg_from(443636);
            } else if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::gt(v7, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(443636))) {
                v9 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(443636);
            };
            let v10 = if (arg1) {
                0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::max(v0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v9))
            } else {
                0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::min(v0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v9))
            };
            let (v11, v12, v13, v14) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_swap::compute_swap(v2, v10, v3, (arg3 as u128), arg2, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg0));
            let v15 = (v12 as u64);
            let v16 = (v13 as u64);
            let v17 = (v14 as u64);
            if (v15 != 0 || v17 != 0) {
                if (arg2) {
                    let v18 = arg3 - v15;
                    arg3 = v18 - v17;
                } else {
                    arg3 = arg3 - v16;
                };
                let v19 = &mut v5;
                h8430f(v19, v15, v16, v17);
            };
            if (v11 == v10) {
                v2 = v10;
                if (v8) {
                    let v20 = if (arg1) {
                        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::neg(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick_liquidity_net(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick<T0, T1, T2>(arg0, v9)))
                    } else {
                        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick_liquidity_net(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick<T0, T1, T2>(arg0, v9))
                    };
                    v3 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity::add_delta(v3, v20);
                };
                let v21 = if (arg1) {
                    0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::sub(v9, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(1))
                } else {
                    v9
                };
                v4 = v21;
            } else {
                v2 = v11;
            };
            if (v3 == 0) {
                v6.hf9fb2 = true;
                break
            };
        };
        v6.hd909d = v5.hd909d;
        v6.h88d66 = v5.h88d66;
        v6.h76211 = v5.h76211;
        v6.h471c9 = v2;
        v6
    }

    fun h41ce6(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        ((340282366920938463463374607431768211456 / (arg0 as u256)) as u128)
    }

    fun h72b06(arg0: u128) : u128 {
        (((arg0 as u256) * (arg0 as u256) * (1000000000000 as u256) / 340282366920938463463374607431768211456) as u128)
    }

    fun h8430f(arg0: &mut H9c317, arg1: u64, arg2: u64, arg3: u64) {
        arg0.hd909d = arg0.hd909d + arg1;
        arg0.h88d66 = arg0.h88d66 + arg2;
        arg0.h76211 = arg0.h76211 + arg3;
    }

    public fun h9d2f1<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: vector<u64>, arg6: vector<u128>, arg7: vector<u64>, arg8: vector<u128>, arg9: u64, arg10: u64, arg11: bool, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg11) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2)
        };
        let v1 = if (arg11) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2)
        };
        let v2 = if (v0 > arg10) {
            v0 - arg10
        } else {
            0
        };
        let v3 = v2;
        let v4 = if (v1 > arg9) {
            v1 - arg9
        } else {
            0
        };
        let v5 = v4;
        let v6 = 0;
        while (v6 < 0x1::vector::length<u64>(&arg5)) {
            let v7 = *0x1::vector::borrow<u64>(&arg5, v6);
            let v8 = v7;
            if (v7 > v3) {
                v8 = v3;
            };
            if (v8 == 0) {
                break
            };
            let (v9, v10) = h09bea<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v8, *0x1::vector::borrow<u128>(&arg6, v6), true, arg11, arg12);
            if (v9 == 0 || v10 == 0) {
                break
            };
            v3 = v3 - v9;
            v5 = v5 + v10;
            v6 = v6 + 1;
        };
        v6 = 0;
        while (v6 < 0x1::vector::length<u64>(&arg7)) {
            let v11 = *0x1::vector::borrow<u64>(&arg7, v6);
            let v12 = v11;
            if (v11 > v5) {
                v12 = v5;
            };
            if (v12 == 0) {
                break
            };
            let (v13, v14) = h09bea<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v12, *0x1::vector::borrow<u128>(&arg8, v6), false, arg11, arg12);
            if (v13 == 0 || v14 == 0) {
                break
            };
            v5 = v5 - v13;
            v3 = v3 + v14;
            v6 = v6 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

