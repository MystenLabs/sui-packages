module 0x3f052f09e057df15dc38916c6d9daab05fc9a00c6e36f2db6397655982c76622::mte {
    struct EE has copy, drop {
        e: u64,
        l: u64,
    }

    fun opt<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: bool, arg2: u128, arg3: u128, arg4: u64, arg5: u64, arg6: u64, arg7: u8) : u64 {
        assert!(arg6 < 100, 13906834616725471240);
        assert!(arg6 > 0, 13906834621020569610);
        assert!(arg4 > 0, 13906834625315143684);
        assert!(arg4 <= arg5, 13906834629610242054);
        let (v0, v1, v2) = sms<T0, T1>(arg0, arg5, arg1, arg2);
        let v3 = v0;
        if (v0 < arg4) {
            return 0
        };
        if (!v2) {
            if (pok(v1, arg3, arg1)) {
                return v0
            };
        };
        let v4 = 0;
        while (v4 < arg7) {
            let v5 = (((v3 as u128) * ((100 - arg6) as u128) / 100) as u64);
            if (v5 < arg4) {
                return 0
            };
            let (v6, v7, v8) = sms<T0, T1>(arg0, v5, arg1, arg2);
            if (!v8) {
                if (pok(v7, arg3, arg1)) {
                    return v6
                };
            };
            v3 = v6;
            v4 = v4 + 1;
        };
        0
    }

    fun pok(arg0: u128, arg1: u128, arg2: bool) : bool {
        arg2 && arg0 <= arg1 || arg0 >= arg1
    }

    fun sms<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: bool, arg3: u128) : (u64, u128, bool) {
        if (arg1 == 0) {
            return (0, 0, true)
        };
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg0, !arg2, true, arg3, arg1);
        let v1 = arg1 - 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_specified(&v0);
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v0);
        if (v2 == 0 || v1 == 0) {
            return (0, 0, true)
        };
        let v3 = if (arg2) {
            (v1 as u128) * 1000000000000 / (v2 as u128) + 1
        } else {
            (v2 as u128) * 1000000000000 / (v1 as u128)
        };
        (v1, v3, false)
    }

    fun spstrs(arg0: u128) : u128 {
        (((arg0 as u256) * (arg0 as u256) * (1000000000000 as u256) / 340282366920938463463374607431768211456) as u128)
    }

    fun tt<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &mut 0xeaf81a9984bb59db32beb3f15d19880c580eefa6ab9bc5688006acbe7f692591::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: u128, arg6: bool, arg7: u64, arg8: u64, arg9: u64, arg10: u8, arg11: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = arg6 && 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0) <= arg5 || 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0) >= arg5;
        if (!v0) {
            return 0
        };
        let v1 = if (arg6) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2)
        };
        if (v1 < arg7) {
            return 0
        };
        let v2 = if (arg8 > v1) {
            v1
        } else {
            arg8
        };
        let v3 = spstrs(arg5);
        let v4 = opt<T0, T1>(arg0, arg6, arg5, v3, arg7, v2, arg9, arg10);
        if (v4 < arg7) {
            return 0
        };
        let v5 = !arg6;
        let (v6, v7, v8) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, v5, true, v4, arg5, arg4, arg3, arg11);
        let v9 = v8;
        let v10 = v7;
        let v11 = v6;
        let (v12, v13) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v9);
        let v14 = if (v5) {
            v12
        } else {
            v13
        };
        let v15 = if (v5) {
            0x2::balance::value<T1>(&v10)
        } else {
            0x2::balance::value<T0>(&v11)
        };
        let v16 = if (arg6) {
            (((v14 as u128) * 1000000000000 / v3) as u64)
        } else {
            (((v14 as u128) * v3 / 1000000000000) as u64)
        };
        assert!(v15 >= v16, 13906835299624878082);
        let (v17, v18) = if (v5) {
            (0xeaf81a9984bb59db32beb3f15d19880c580eefa6ab9bc5688006acbe7f692591::bm::wd<T0>(arg1, arg2, v12, arg11), 0x2::coin::zero<T1>(arg11))
        } else {
            (0x2::coin::zero<T0>(arg11), 0xeaf81a9984bb59db32beb3f15d19880c580eefa6ab9bc5688006acbe7f692591::bm::wd<T1>(arg1, arg2, v13, arg11))
        };
        let v19 = v18;
        let v20 = v17;
        let (v21, v22) = if (v5) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v20, v12, arg11)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v19, v13, arg11)))
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v9, v21, v22, arg3, arg11);
        0x2::coin::join<T0>(&mut v20, 0x2::coin::from_balance<T0>(v11, arg11));
        0x2::coin::join<T1>(&mut v19, 0x2::coin::from_balance<T1>(v10, arg11));
        0xeaf81a9984bb59db32beb3f15d19880c580eefa6ab9bc5688006acbe7f692591::bm::dp<T0>(arg1, arg2, v20, arg11);
        0xeaf81a9984bb59db32beb3f15d19880c580eefa6ab9bc5688006acbe7f692591::bm::dp<T1>(arg1, arg2, v19, arg11);
        v14
    }

    public fun ttb<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &mut 0xeaf81a9984bb59db32beb3f15d19880c580eefa6ab9bc5688006acbe7f692591::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x7e5c9a5a5e505816e99df9ab6a076e8a3f23ddf0c3dab7c3666bbdc66a60e2d8::sq::SQR, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x2::clock::Clock, arg6: vector<u128>, arg7: vector<u64>, arg8: u64, arg9: vector<u128>, arg10: vector<u64>, arg11: u64, arg12: u64, arg13: u8, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7e5c9a5a5e505816e99df9ab6a076e8a3f23ddf0c3dab7c3666bbdc66a60e2d8::sq::csst(arg3, arg5, arg14, arg15, true, true, arg16);
        if (v0 != 0) {
            let v1 = EE{
                e : v0,
                l : 374,
            };
            0x2::event::emit<EE>(v1);
            return
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<u128>(&arg6)) {
            tt<T0, T1>(arg0, arg1, arg2, arg4, arg5, *0x1::vector::borrow<u128>(&arg6, v2), true, arg8, *0x1::vector::borrow<u64>(&arg7, v2), arg12, arg13, arg16);
            v2 = v2 + 1;
        };
        v2 = 0;
        while (v2 < 0x1::vector::length<u128>(&arg9)) {
            tt<T0, T1>(arg0, arg1, arg2, arg4, arg5, *0x1::vector::borrow<u128>(&arg9, v2), false, arg11, *0x1::vector::borrow<u64>(&arg10, v2), arg12, arg13, arg16);
            v2 = v2 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

