module 0x23cf5fb94614b2aaa208b504e0cf1e4d4803d7f75d264f4da66380a664f39302::hd8b35 {
    struct Hc9810 has copy, drop {
        hc6e2c: u64,
        h53fbc: u64,
    }

    struct H5dc59 has copy, drop {
        hc0cd2: u64,
        hfdfac: u64,
        hcec87: u64,
    }

    struct H7e707 has copy, drop {
        hc0cd2: u64,
        hfdfac: u64,
        hcec87: u64,
        h2da35: u128,
        h42cc6: bool,
    }

    fun h70101<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: bool, arg2: bool, arg3: u64, arg4: u128, arg5: bool) : H7e707 {
        let v0 = if (arg5) {
            arg4
        } else {
            hc1af0(arg4)
        };
        let v1 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0);
        let v2 = v1;
        let v3 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_liquidity<T0, T1, T2>(arg0);
        let v4 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_current_index<T0, T1, T2>(arg0);
        let v5 = H5dc59{
            hc0cd2 : 0,
            hfdfac : 0,
            hcec87 : 0,
        };
        let v6 = H7e707{
            hc0cd2 : 0,
            hfdfac : 0,
            hcec87 : 0,
            h2da35 : v1,
            h42cc6 : false,
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
                hd249b(v19, v15, v16, v17);
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
                v6.h42cc6 = true;
                break
            };
        };
        v6.hc0cd2 = v5.hc0cd2;
        v6.hfdfac = v5.hfdfac;
        v6.hcec87 = v5.hcec87;
        v6.h2da35 = v2;
        v6
    }

    fun h73a59<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: bool, arg2: u128, arg3: u128, arg4: u64, arg5: u64, arg6: u8, arg7: u8, arg8: u64, arg9: bool) : u64 {
        assert!(arg4 > 0, 13906835351164616708);
        assert!(arg4 <= arg5, 13906835355459715078);
        assert!(arg8 < arg4, 13906835359754813448);
        let v0 = 0;
        let v1 = 0;
        let v2 = arg4;
        let v3 = 0;
        while (v3 < arg6) {
            v3 = v3 + 1;
            if (v2 > arg5) {
                v2 = arg5;
            };
            let (v4, v5, v6) = ha21a6<T0, T1, T2>(arg0, v2, arg1, arg2, arg9);
            if (v6) {
                break
            };
            if (!h8dcae(v5, arg3, arg1)) {
                break
            };
            v0 = v4;
            if (v2 == arg5) {
                return v4
            };
            v1 = v2;
            let v7 = if (v2 > arg5 / 2) {
                arg5
            } else {
                v2 * 2
            };
            v2 = v7;
        };
        if (v0 == 0) {
            return v0
        };
        if (v2 > arg5) {
            v2 = arg5;
        };
        v3 = 0;
        while (v3 < arg7) {
            v3 = v3 + 1;
            if (v2 - v1 <= arg8) {
                break
            };
            let v8 = (v1 + v2) / 2;
            let (v9, v10, v11) = ha21a6<T0, T1, T2>(arg0, v8, arg1, arg2, arg9);
            if (h8dcae(v10, arg3, arg1) && !v11) {
                v0 = v9;
                v1 = v8;
                continue
            };
            v2 = v8;
        };
        v0
    }

    public fun h80423<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &0x2::clock::Clock, arg4: vector<u64>, arg5: vector<u128>, arg6: vector<u64>, arg7: vector<u128>, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg8) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1)
        };
        let v1 = v0;
        let v2 = if (arg8) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1)
        };
        let v3 = v2;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg4)) {
            let v5 = *0x1::vector::borrow<u64>(&arg4, v4);
            let v6 = v5;
            if (v5 > v1) {
                v6 = v1;
            };
            if (v6 == 0) {
                break
            };
            let (v7, v8) = haebb4<T0, T1, T2>(arg0, arg1, arg2, arg3, v6, *0x1::vector::borrow<u128>(&arg5, v4), true, arg8, arg9);
            if (v7 == 0 || v8 == 0) {
                break
            };
            v1 = v1 - v7;
            v3 = v3 + v8;
            v4 = v4 + 1;
        };
        v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg6)) {
            let v9 = *0x1::vector::borrow<u64>(&arg6, v4);
            let v10 = v9;
            if (v9 > v3) {
                v10 = v3;
            };
            if (v10 == 0) {
                break
            };
            let (v11, v12) = haebb4<T0, T1, T2>(arg0, arg1, arg2, arg3, v10, *0x1::vector::borrow<u128>(&arg7, v4), false, arg8, arg9);
            if (v11 == 0 || v12 == 0) {
                break
            };
            v3 = v3 - v11;
            v1 = v1 + v12;
            v4 = v4 + 1;
        };
    }

    fun h80634(arg0: u128) : u128 {
        (((arg0 as u256) * (arg0 as u256) * (1000000000000 as u256) / 340282366920938463463374607431768211456) as u128)
    }

    fun h8dcae(arg0: u128, arg1: u128, arg2: bool) : bool {
        arg2 && arg0 <= arg1 || arg0 >= arg1
    }

    fun ha21a6<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: u64, arg2: bool, arg3: u128, arg4: bool) : (u64, u128, bool) {
        if (arg1 == 0) {
            return (0, 0, true)
        };
        let v0 = h70101<T0, T1, T2>(arg0, arg4 != arg2, true, arg1, arg3, arg4);
        let v1 = v0.h42cc6 || v0.hc0cd2 + v0.hcec87 < arg1;
        let v2 = v0.hfdfac;
        let v3 = v0.hc0cd2 + v0.hcec87;
        if (v2 == 0 || v3 == 0) {
            return (0, 0, true)
        };
        let v4 = if (arg2) {
            (v3 as u128) * 1000000000000 / (v2 as u128) + 1
        } else {
            (v2 as u128) * 1000000000000 / (v3 as u128)
        };
        (v3, v4, v1)
    }

    fun ha9776<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &0x2::clock::Clock, arg4: u128, arg5: bool, arg6: u64, arg7: u64, arg8: u8, arg9: u8, arg10: u64, arg11: bool, arg12: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = if (arg11) {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0)
        } else {
            hc1af0(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0))
        };
        let v1 = arg5 && v0 <= arg4 || v0 >= arg4;
        if (!v1) {
            return (0, 0)
        };
        let v2 = h80634(arg4);
        let v3 = h73a59<T0, T1, T2>(arg0, arg5, arg4, v2, arg6, arg7, arg8, arg9, arg10, arg11);
        if (v3 < arg6) {
            let v4 = Hc9810{
                hc6e2c : 116,
                h53fbc : 419,
            };
            0x2::event::emit<Hc9810>(v4);
            return (0, 0)
        };
        let v5 = arg11 != arg5;
        let v6 = if (arg11) {
            arg4
        } else {
            hc1af0(arg4)
        };
        let (v7, v8, v9) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg12), v5, (v3 as u128), true, v6, arg3, arg2, arg12);
        let v10 = v9;
        let v11 = v8;
        let v12 = v7;
        let (_, _, v15) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v10);
        let (v16, v17) = if (v5) {
            (v15, 0)
        } else {
            (0, v15)
        };
        let v18 = if (v5) {
            v16
        } else {
            v17
        };
        let v19 = if (v5) {
            0x2::coin::value<T1>(&v11)
        } else {
            0x2::coin::value<T0>(&v12)
        };
        let v20 = if (arg5) {
            (((v18 as u128) * 1000000000000 / v2) as u64)
        } else {
            (((v18 as u128) * v2 / 1000000000000) as u64)
        };
        assert!(v19 >= v20, 13906836192978075650);
        let (v21, v22) = if (v5) {
            (0x2::coin::zero<T1>(arg12), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg1, v16, arg12))
        } else {
            (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(arg1, v17, arg12), 0x2::coin::zero<T0>(arg12))
        };
        let v23 = v21;
        let v24 = v22;
        let (v25, v26) = if (v5) {
            (0x2::coin::split<T0>(&mut v24, v16, arg12), 0x2::coin::zero<T1>(arg12))
        } else {
            (0x2::coin::zero<T0>(arg12), 0x2::coin::split<T1>(&mut v23, v17, arg12))
        };
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, v25, v26, v10, arg2);
        0x2::coin::join<T0>(&mut v24, v12);
        0x2::coin::join<T1>(&mut v23, v11);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg1, v24, arg12);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg1, v23, arg12);
        (v18, v19)
    }

    fun haebb4<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &0x2::clock::Clock, arg4: u64, arg5: u128, arg6: bool, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        if (arg4 == 0) {
            return (0, 0)
        };
        let v0 = if (arg7) {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0)
        } else {
            hc1af0(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0))
        };
        let v1 = arg6 && v0 <= arg5 || v0 >= arg5;
        if (!v1) {
            return (0, 0)
        };
        let v2 = arg7 != arg6;
        let v3 = h70101<T0, T1, T2>(arg0, v2, true, arg4, arg5, arg7);
        let v4 = (v3.hc0cd2 as u128) + (v3.hcec87 as u128);
        let v5 = v3.hfdfac;
        if (v5 == 0 || v4 == 0) {
            return (0, 0)
        };
        let v6 = h80634(arg5);
        let v7 = if (arg6) {
            ((v4 * 1000000000000 / v6) as u64)
        } else {
            ((v4 * v6 / 1000000000000) as u64)
        };
        if (v5 < v7) {
            return (0, 0)
        };
        let v8 = if (arg7) {
            arg5
        } else {
            hc1af0(arg5)
        };
        let (v9, v10, v11) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg8), v2, (arg4 as u128), true, v8, arg3, arg2, arg8);
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
        let v22 = if (arg6) {
            (((v20 as u128) * 1000000000000 / v6) as u64)
        } else {
            (((v20 as u128) * v6 / 1000000000000) as u64)
        };
        assert!(v21 >= v22, 13906837296784670722);
        let (v23, v24) = if (v2) {
            (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg1, v18, arg8), 0x2::coin::zero<T1>(arg8))
        } else {
            (0x2::coin::zero<T0>(arg8), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(arg1, v19, arg8))
        };
        let v25 = v24;
        let v26 = v23;
        let (v27, v28) = if (v2) {
            (0x2::coin::split<T0>(&mut v26, v18, arg8), 0x2::coin::zero<T1>(arg8))
        } else {
            (0x2::coin::zero<T0>(arg8), 0x2::coin::split<T1>(&mut v25, v19, arg8))
        };
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, v27, v28, v12, arg2);
        0x2::coin::join<T0>(&mut v26, v14);
        0x2::coin::join<T1>(&mut v25, v13);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg1, v26, arg8);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg1, v25, arg8);
        (v20, v21)
    }

    fun hc1af0(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        ((340282366920938463463374607431768211456 / (arg0 as u256)) as u128)
    }

    fun hd249b(arg0: &mut H5dc59, arg1: u64, arg2: u64, arg3: u64) {
        arg0.hc0cd2 = arg0.hc0cd2 + arg1;
        arg0.hfdfac = arg0.hfdfac + arg2;
        arg0.hcec87 = arg0.hcec87 + arg3;
    }

    public fun hdd0af<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &0x2::clock::Clock, arg4: vector<u128>, arg5: vector<u64>, arg6: vector<u64>, arg7: u64, arg8: vector<u128>, arg9: vector<u64>, arg10: vector<u64>, arg11: u64, arg12: u8, arg13: u8, arg14: bool, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg14) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1)
        };
        let v1 = v0;
        let v2 = if (arg14) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1)
        };
        let v3 = v2;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u128>(&arg4)) {
            let v5 = *0x1::vector::borrow<u64>(&arg5, v4);
            if (v5 > v1) {
                let v6 = Hc9810{
                    hc6e2c : 114,
                    h53fbc : 541,
                };
                0x2::event::emit<Hc9810>(v6);
            };
            let v7 = if (v5 > v1) {
                v1
            } else {
                v5
            };
            if (v7 < arg7) {
                let v8 = Hc9810{
                    hc6e2c : 115,
                    h53fbc : 544,
                };
                0x2::event::emit<Hc9810>(v8);
                break
            };
            let (v9, v10) = ha9776<T0, T1, T2>(arg0, arg1, arg2, arg3, *0x1::vector::borrow<u128>(&arg4, v4), true, arg7, v7, arg12, arg13, *0x1::vector::borrow<u64>(&arg6, v4), arg14, arg15);
            if (v9 == 0 || v10 == 0) {
                break
            };
            v1 = v1 - v9;
            v3 = v3 + v10;
            v4 = v4 + 1;
        };
        v4 = 0;
        while (v4 < 0x1::vector::length<u128>(&arg8)) {
            let v11 = *0x1::vector::borrow<u64>(&arg9, v4);
            if (v11 > v3) {
                let v12 = Hc9810{
                    hc6e2c : 114,
                    h53fbc : 580,
                };
                0x2::event::emit<Hc9810>(v12);
            };
            let v13 = if (v11 > v3) {
                v3
            } else {
                v11
            };
            if (v13 < arg11) {
                let v14 = Hc9810{
                    hc6e2c : 115,
                    h53fbc : 583,
                };
                0x2::event::emit<Hc9810>(v14);
                break
            };
            let (v15, v16) = ha9776<T0, T1, T2>(arg0, arg1, arg2, arg3, *0x1::vector::borrow<u128>(&arg8, v4), false, arg11, v13, arg12, arg13, *0x1::vector::borrow<u64>(&arg10, v4), arg14, arg15);
            if (v15 == 0 || v16 == 0) {
                break
            };
            v3 = v3 - v15;
            v1 = v1 + v16;
            v4 = v4 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

