module 0x7fb87a713258db392a7231e0f047491a20d918ac34eb38e992634b877eb44b6c::h34126 {
    struct H0b417 has copy, drop {
        hb1b72: bool,
        h3caf2: u64,
        h4a541: u64,
        h40510: u64,
    }

    struct H5566a has copy, drop {
        h1591f: u64,
        h571c8: u64,
        ha92e9: u64,
    }

    struct H71b14 has copy, drop {
        h1591f: u64,
        h571c8: u64,
        ha92e9: u64,
        h16a0d: u128,
        hbe2a7: bool,
    }

    fun h2a25a<T0, T1>(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: u64, arg6: u128, arg7: bool, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        if (arg5 == 0) {
            return (0, 0)
        };
        let v0 = if (arg8) {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0)
        } else {
            h59a11(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0))
        };
        let v1 = arg7 && v0 <= arg6 || v0 >= arg6;
        if (!v1) {
            return (0, 0)
        };
        let v2 = arg8 != arg7;
        let v3 = hf9836<T0, T1>(arg0, v2, true, arg5, arg6, arg8);
        let v4 = (v3.h1591f as u128) + (v3.ha92e9 as u128);
        let v5 = v3.h571c8;
        if (v5 == 0 || v4 == 0) {
            return (0, 0)
        };
        let v6 = ha5092(arg6);
        if (v6 == 0) {
            return (0, 0)
        };
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
            h59a11(arg6)
        };
        let (v9, v10, v11) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg3, arg0, v2, true, arg5, v8, arg4);
        let v12 = v11;
        let v13 = v10;
        let v14 = v9;
        let v15 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v12);
        let v16 = if (v2) {
            0x2::balance::value<T1>(&v13)
        } else {
            0x2::balance::value<T0>(&v14)
        };
        let v17 = if (arg7) {
            (((v15 as u128) * 1000000000000 / v6) as u64)
        } else {
            (((v15 as u128) * v6 / 1000000000000) as u64)
        };
        assert!(v16 >= v17, 13906835398409125890);
        let (v18, v19) = if (v2) {
            (0x2::coin::into_balance<T0>(0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hf6525<T0>(arg1, arg2, v15, arg9)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hf6525<T1>(arg1, arg2, v15, arg9)))
        };
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg3, arg0, v18, v19, v12);
        if (0x2::balance::value<T0>(&v14) > 0) {
            0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hec8a2<T0>(arg1, arg2, 0x2::coin::from_balance<T0>(v14, arg9), arg9);
        } else {
            0x2::balance::destroy_zero<T0>(v14);
        };
        if (0x2::balance::value<T1>(&v13) > 0) {
            0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hec8a2<T1>(arg1, arg2, 0x2::coin::from_balance<T1>(v13, arg9), arg9);
        } else {
            0x2::balance::destroy_zero<T1>(v13);
        };
        (v15, v16)
    }

    fun h4e127(arg0: &mut H5566a, arg1: u64, arg2: u64, arg3: u64) {
        arg0.h1591f = arg0.h1591f + arg1;
        arg0.h571c8 = arg0.h571c8 + arg2;
        arg0.ha92e9 = arg0.ha92e9 + arg3;
    }

    fun h59a11(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        ((340282366920938463463374607431768211456 / (arg0 as u256)) as u128)
    }

    fun ha5092(arg0: u128) : u128 {
        (((arg0 as u256) * (arg0 as u256) * (1000000000000 as u256) / 340282366920938463463374607431768211456) as u128)
    }

    public fun hb453b<T0, T1>(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: vector<u64>, arg6: vector<u128>, arg7: vector<u64>, arg8: vector<u128>, arg9: u64, arg10: u64, arg11: bool, arg12: &mut 0x2::tx_context::TxContext) {
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
                let v9 = H0b417{
                    hb1b72 : true,
                    h3caf2 : v6,
                    h4a541 : v7,
                    h40510 : v3,
                };
                0x2::event::emit<H0b417>(v9);
            };
            if (v8 == 0) {
                break
            };
            let (v10, v11) = h2a25a<T0, T1>(arg0, arg1, arg2, arg3, arg4, v8, *0x1::vector::borrow<u128>(&arg6, v6), true, arg11, arg12);
            if (v10 == 0 || v11 == 0) {
                break
            };
            v3 = v3 - v10;
            v5 = v5 + v11;
            v6 = v6 + 1;
        };
        v6 = 0;
        while (v6 < 0x1::vector::length<u64>(&arg7)) {
            let v12 = *0x1::vector::borrow<u64>(&arg7, v6);
            let v13 = v12;
            if (v12 > v5) {
                v13 = v5;
                let v14 = H0b417{
                    hb1b72 : false,
                    h3caf2 : v6,
                    h4a541 : v12,
                    h40510 : v5,
                };
                0x2::event::emit<H0b417>(v14);
            };
            if (v13 == 0) {
                break
            };
            let (v15, v16) = h2a25a<T0, T1>(arg0, arg1, arg2, arg3, arg4, v13, *0x1::vector::borrow<u128>(&arg8, v6), false, arg11, arg12);
            if (v15 == 0 || v16 == 0) {
                break
            };
            v5 = v5 - v15;
            v3 = v3 + v16;
            v6 = v6 + 1;
        };
    }

    fun hf9836<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: u128, arg5: bool) : H71b14 {
        let v0 = if (arg5) {
            arg4
        } else {
            h59a11(arg4)
        };
        let v1 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0);
        let v2 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::liquidity<T0, T1>(arg0);
        let v3 = H5566a{
            h1591f : 0,
            h571c8 : 0,
            ha92e9 : 0,
        };
        let v4 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::first_score_for_swap(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::tick_manager<T0, T1>(arg0), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg0), arg1);
        let v5 = H71b14{
            h1591f : 0,
            h571c8 : 0,
            ha92e9 : 0,
            h16a0d : 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0),
            hbe2a7 : false,
        };
        while (arg3 > 0 && v1 != v0) {
            if (0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::is_none(&v4)) {
                v5.hbe2a7 = true;
                break
            };
            let (v6, v7) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::borrow_tick_for_swap(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::tick_manager<T0, T1>(arg0), 0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::borrow(&v4), arg1);
            v4 = v7;
            let v8 = if (arg1) {
                0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::math_u128::max(v0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::sqrt_price(v6))
            } else {
                0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::math_u128::min(v0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::sqrt_price(v6))
            };
            let (v9, v10, v11, v12) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::compute_swap_step(v1, v8, v2, arg3, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg0), arg1, arg2);
            if (v9 != 0 || v12 != 0) {
                if (arg2) {
                    let v13 = arg3 - v9;
                    arg3 = v13 - v12;
                } else {
                    arg3 = arg3 - v10;
                };
                let v14 = &mut v3;
                h4e127(v14, v9, v10, v12);
            };
            if (v11 == v8) {
                v1 = v8;
                let v15 = if (arg1) {
                    0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::neg(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::liquidity_net(v6))
                } else {
                    0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::liquidity_net(v6)
                };
                if (!0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::is_neg(v15)) {
                    v2 = v2 + 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::abs_u128(v15);
                    continue
                };
                v2 = v2 - 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::abs_u128(v15);
                continue
            };
            v1 = v11;
        };
        v5.h1591f = v3.h1591f;
        v5.h571c8 = v3.h571c8;
        v5.ha92e9 = v3.ha92e9;
        v5.h16a0d = v1;
        v5
    }

    // decompiled from Move bytecode v6
}

