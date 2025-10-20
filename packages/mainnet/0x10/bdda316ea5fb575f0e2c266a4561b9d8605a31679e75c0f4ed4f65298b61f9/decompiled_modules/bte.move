module 0x10bdda316ea5fb575f0e2c266a4561b9d8605a31679e75c0f4ed4f65298b61f9::bte {
    struct DBG has copy, drop {
        l: u64,
        v: u64,
    }

    struct DBG8 has copy, drop {
        l: u64,
        v: u8,
    }

    struct EE has copy, drop {
        e: u64,
        l: u64,
    }

    struct IP has copy, drop {
        c: u128,
        l: u128,
    }

    fun opt<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: u128, arg3: u64, arg4: u64, arg5: u8, arg6: u8, arg7: u64) : u64 {
        assert!(arg3 > 0, 13906834702624686086);
        assert!(arg3 <= arg4, 13906834706919784456);
        assert!(arg7 < arg3, 13906834711214882826);
        let (v0, v1) = sbs<T0, T1>(arg0, arg3, arg1);
        let v2 = v0;
        if (!pok(v1, arg2, arg1)) {
            return 0
        };
        let v3 = 0;
        let v4 = v3;
        let v5 = arg3;
        let v6 = 0;
        while (v6 < arg5) {
            if (v5 >= arg4 || v5 - v3 <= arg7) {
                break
            };
            let v7 = v5 << 1;
            if (v7 <= v5) {
                break
            };
            let v8 = if (v7 > arg4) {
                arg4
            } else {
                v7
            };
            v4 = arg3;
            v5 = v8;
            let (v9, v10) = sbs<T0, T1>(arg0, v8, arg1);
            if (!pok(v10, arg2, arg1)) {
                break
            };
            v2 = v9;
            v6 = v6 + 1;
        };
        let v11 = DBG8{
            l : 176,
            v : v6,
        };
        0x2::event::emit<DBG8>(v11);
        let v12 = DBG{
            l : 177,
            v : v3,
        };
        0x2::event::emit<DBG>(v12);
        let v13 = DBG{
            l : 178,
            v : v5,
        };
        0x2::event::emit<DBG>(v13);
        if (v3 == v5 || v5 - v3 <= arg7) {
            return v2
        };
        v6 = 0;
        while (v6 < arg6) {
            if (v4 + 1 >= v5 || v5 - v4 <= arg7) {
                break
            };
            let v14 = v4 + (v5 - v4 >> 1);
            let (v15, v16) = sbs<T0, T1>(arg0, v14, arg1);
            if (pok(v16, arg2, arg1)) {
                v2 = v15;
                v4 = v14;
            } else {
                v5 = v14;
            };
            v6 = v6 + 1;
        };
        let v17 = DBG8{
            l : 206,
            v : v6,
        };
        0x2::event::emit<DBG8>(v17);
        let v18 = DBG{
            l : 207,
            v : v4,
        };
        0x2::event::emit<DBG>(v18);
        let v19 = DBG{
            l : 208,
            v : v5,
        };
        0x2::event::emit<DBG>(v19);
        v2
    }

    fun pok(arg0: u128, arg1: u128, arg2: bool) : bool {
        arg2 && arg0 <= arg1 || arg0 >= arg1
    }

    fun sbs<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u64, arg2: bool) : (u64, u128) {
        let v0 = !arg2;
        let v1 = if (v0) {
            4295048016 + 1
        } else {
            79226673515401279992447579055 - 1
        };
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg0, v0, true, arg1, v1);
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified(&v2);
        let v4 = if (arg2) {
            (v3 as u128) * 1000000000000 / (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v2) as u128) + 1
        } else {
            (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v2) as u128) * 1000000000000 / (v3 as u128)
        };
        (v3, v4)
    }

    fun spstrs(arg0: u128) : u128 {
        (((arg0 as u256) * (arg0 as u256) * (1000000000000 as u256) / 340282366920938463463374607431768211456) as u128)
    }

    fun tt<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::CBM, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: u128, arg5: bool, arg6: u64, arg7: u64, arg8: u8, arg9: u8, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0);
        let v1 = arg5 && v0 <= arg4 || v0 >= arg4;
        if (!v1) {
            let v2 = IP{
                c : v0,
                l : arg4,
            };
            0x2::event::emit<IP>(v2);
            return (0, 0)
        };
        let v3 = if (arg5) {
            0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::balance<T1>(arg1)
        } else {
            0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::balance<T0>(arg1)
        };
        if (v3 < arg6) {
            let v4 = DBG{
                l : 260,
                v : v3,
            };
            0x2::event::emit<DBG>(v4);
            return (0, 0)
        };
        let v5 = if (arg7 > v3) {
            v3
        } else {
            arg7
        };
        let v6 = spstrs(arg4);
        let v7 = opt<T0, T1>(arg0, arg5, v6, arg6, v5, arg8, arg9, arg10);
        if (v7 == 0) {
            return (0, 0)
        };
        if (v7 < arg6) {
            let v8 = DBG{
                l : 292,
                v : v7,
            };
            0x2::event::emit<DBG>(v8);
            return (0, 0)
        };
        let v9 = !arg5;
        let v10 = if (v9) {
            4295048016 + 1
        } else {
            79226673515401279992447579055 - 1
        };
        let (v11, v12, v13) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg2, arg0, v9, true, v7, v10);
        let v14 = v13;
        let v15 = v12;
        let v16 = v11;
        let v17 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v14);
        let v18 = if (v9) {
            0x2::balance::value<T1>(&v15)
        } else {
            0x2::balance::value<T0>(&v16)
        };
        let v19 = if (arg5) {
            (((v17 as u128) * 1000000000000 / v6) as u64)
        } else {
            (((v17 as u128) * v6 / 1000000000000) as u64)
        };
        assert!(v18 >= v19, 13906835548733112324);
        let (v20, v21) = if (v9) {
            (v17, 0)
        } else {
            (0, v17)
        };
        let (v22, v23) = if (v9) {
            (0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::wd<T0>(arg1, v20, arg11), 0x2::coin::zero<T1>(arg11))
        } else {
            (0x2::coin::zero<T0>(arg11), 0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::wd<T1>(arg1, v21, arg11))
        };
        let v24 = v23;
        let v25 = v22;
        let (v26, v27) = if (v9) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v25, v20, arg11)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v24, v21, arg11)))
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg2, arg0, v26, v27, v14);
        0x2::coin::join<T0>(&mut v25, 0x2::coin::from_balance<T0>(v16, arg11));
        0x2::coin::join<T1>(&mut v24, 0x2::coin::from_balance<T1>(v15, arg11));
        0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::dp<T0>(arg1, v25, arg11);
        0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::dp<T1>(arg1, v24, arg11);
        (v17, v18)
    }

    public fun ttb<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::CBM, arg2: &mut 0xe691aeb328ba898b3374ed75fdffd3306619ad71bab29aa303b0227bf2bb0708::sq::SQR, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: vector<u128>, arg6: vector<u64>, arg7: vector<u64>, arg8: u64, arg9: vector<u128>, arg10: vector<u64>, arg11: vector<u64>, arg12: u64, arg13: u8, arg14: u8, arg15: u64, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe691aeb328ba898b3374ed75fdffd3306619ad71bab29aa303b0227bf2bb0708::sq::ciit(arg2, arg4, arg15, arg16, true, arg17);
        if (v0 != 0) {
            let v1 = EE{
                e : v0,
                l : 409,
            };
            0x2::event::emit<EE>(v1);
            return
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<u128>(&arg5)) {
            let (v3, v4) = tt<T0, T1>(arg0, arg1, arg3, arg4, *0x1::vector::borrow<u128>(&arg5, v2), true, arg8, *0x1::vector::borrow<u64>(&arg6, v2), arg13, arg14, *0x1::vector::borrow<u64>(&arg7, v2), arg17);
            if (v3 == 0 && v4 == 0) {
                break
            };
            if (v3 < arg8) {
                let v5 = DBG{
                    l : 435,
                    v : v3,
                };
                0x2::event::emit<DBG>(v5);
                break
            };
            v2 = v2 + 1;
        };
        v2 = 0;
        while (v2 < 0x1::vector::length<u128>(&arg9)) {
            let (v6, v7) = tt<T0, T1>(arg0, arg1, arg3, arg4, *0x1::vector::borrow<u128>(&arg9, v2), false, arg12, *0x1::vector::borrow<u64>(&arg10, v2), arg13, arg14, *0x1::vector::borrow<u64>(&arg11, v2), arg17);
            if (v6 == 0 && v7 == 0) {
                break
            };
            if (v6 < arg12) {
                let v8 = DBG{
                    l : 464,
                    v : v6,
                };
                0x2::event::emit<DBG>(v8);
                break
            };
            v2 = v2 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

