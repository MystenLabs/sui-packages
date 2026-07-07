module 0x5c9659d97327c6bafcf0e8eddbf1fb25ca1b18fcb8ad9f38bc17bdd580852bad::h12369 {
    struct H38418 has copy, drop {
        h8f847: bool,
        h2d1b8: u64,
        h28290: u64,
        h072c1: u64,
    }

    public fun h3f05b<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: vector<u64>, arg6: vector<u128>, arg7: vector<u64>, arg8: vector<u128>, arg9: u64, arg10: u64, arg11: bool, arg12: &mut 0x2::tx_context::TxContext) {
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
                let v9 = H38418{
                    h8f847 : true,
                    h2d1b8 : v6,
                    h28290 : v7,
                    h072c1 : v3,
                };
                0x2::event::emit<H38418>(v9);
            };
            if (v8 == 0) {
                break
            };
            let (v10, v11) = hfdc13<T0, T1>(arg0, arg1, arg2, arg3, arg4, v8, *0x1::vector::borrow<u128>(&arg6, v6), true, arg11, arg12);
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
                let v14 = H38418{
                    h8f847 : false,
                    h2d1b8 : v6,
                    h28290 : v12,
                    h072c1 : v5,
                };
                0x2::event::emit<H38418>(v14);
            };
            if (v13 == 0) {
                break
            };
            let (v15, v16) = hfdc13<T0, T1>(arg0, arg1, arg2, arg3, arg4, v13, *0x1::vector::borrow<u128>(&arg8, v6), false, arg11, arg12);
            if (v15 == 0 || v16 == 0) {
                break
            };
            v5 = v5 - v15;
            v3 = v3 + v16;
            v6 = v6 + 1;
        };
    }

    fun hc2dcd(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        ((340282366920938463463374607431768211456 / (arg0 as u256)) as u128)
    }

    fun hcd464(arg0: u128) : u128 {
        (((arg0 as u256) * (arg0 as u256) * (1000000000000 as u256) / 340282366920938463463374607431768211456) as u128)
    }

    fun hfdc13<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: u64, arg6: u128, arg7: bool, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        if (arg5 == 0) {
            return (0, 0)
        };
        let v0 = if (arg8) {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0)
        } else {
            hc2dcd(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0))
        };
        let v1 = arg7 && v0 < arg6 || v0 > arg6;
        if (!v1) {
            return (0, 0)
        };
        let v2 = arg8 != arg7;
        let v3 = if (arg8) {
            arg6
        } else {
            hc2dcd(arg6)
        };
        let v4 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg0, v2, true, v3, arg5);
        let v5 = arg5 - 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_specified(&v4);
        let v6 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v4);
        if (v6 == 0 || v5 == 0) {
            return (0, 0)
        };
        let v7 = hcd464(arg6);
        if (v7 == 0) {
            return (0, 0)
        };
        let v8 = if (arg7) {
            (((v5 as u128) * 1000000000000 / v7) as u64)
        } else {
            (((v5 as u128) * v7 / 1000000000000) as u64)
        };
        if (v6 < v8) {
            return (0, 0)
        };
        let (v9, v10, v11) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, v2, true, arg5, v3, arg4, arg3, arg9);
        let v12 = v11;
        let v13 = v10;
        let v14 = v9;
        let (v15, v16) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v12);
        let v17 = if (v2) {
            v15
        } else {
            v16
        };
        let v18 = if (v2) {
            0x2::balance::value<T1>(&v13)
        } else {
            0x2::balance::value<T0>(&v14)
        };
        let v19 = if (arg7) {
            (((v17 as u128) * 1000000000000 / v7) as u64)
        } else {
            (((v17 as u128) * v7 / 1000000000000) as u64)
        };
        assert!(v18 >= v19, 13906834827178475522);
        let (v20, v21) = if (v2) {
            (0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hf6525<T0>(arg1, arg2, v15, arg9)))
        } else {
            (0x2::coin::into_balance<T1>(0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hf6525<T1>(arg1, arg2, v16, arg9)), 0x2::balance::zero<T0>())
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v12, v21, v20, arg3, arg9);
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
        (v17, v18)
    }

    // decompiled from Move bytecode v6
}

