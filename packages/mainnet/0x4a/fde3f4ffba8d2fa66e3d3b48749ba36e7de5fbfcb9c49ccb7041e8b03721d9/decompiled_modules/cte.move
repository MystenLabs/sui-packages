module 0x4afde3f4ffba8d2fa66e3d3b48749ba36e7de5fbfcb9c49ccb7041e8b03721d9::cte {
    struct DBG has copy, drop {
        l: u64,
        v: u64,
    }

    struct DBG128 has copy, drop {
        l: u64,
        v: u128,
    }

    struct EE has copy, drop {
        e: u64,
        l: u64,
    }

    struct IP has copy, drop {
        c: u128,
        l: u128,
    }

    struct TS has copy, drop {
        dummy_field: bool,
    }

    fun isp(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        ((340282366920938463463374607431768211456 / (arg0 as u256)) as u128)
    }

    fun sfq32(arg0: u64, arg1: u64) : u64 {
        (0x1::u128::sqrt(((arg0 as u128) << 64) / (arg1 as u128)) as u64)
    }

    fun spstrs(arg0: u128) : u128 {
        (((arg0 as u256) * (arg0 as u256) * (1000000000000 as u256) / 340282366920938463463374607431768211456) as u128)
    }

    fun tt<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::CBM, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: u128, arg5: bool, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::fee_rate_denominator();
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0);
        let v2 = isp(v1);
        let v3 = sfq32(v0 - 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0), v0);
        let v4 = if (arg5) {
            let v5 = arg4 >> 32;
            v5 * (v3 as u128) + ((arg4 - (v5 << 32)) * (v3 as u128) >> 32)
        } else {
            (arg4 / (v3 as u128) << 32) + (((arg4 % (v3 as u128)) as u128) << 32) / (v3 as u128)
        };
        let v6 = arg5 && v2 <= arg4 || v2 >= arg4;
        if (!v6) {
            let v7 = IP{
                c : v2,
                l : arg4,
            };
            0x2::event::emit<IP>(v7);
            return (0, 0)
        };
        let v8 = if (arg5) {
            0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::balance<T0>(arg1)
        } else {
            0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::balance<T1>(arg1)
        };
        let v9 = if (arg7 > v8) {
            v8
        } else {
            arg7
        };
        if (v9 < arg6) {
            let v10 = DBG{
                l : 125,
                v : v9,
            };
            0x2::event::emit<DBG>(v10);
            return (0, 0)
        };
        let v11 = isp(v4);
        let v12 = DBG128{
            l : 142,
            v : arg4,
        };
        0x2::event::emit<DBG128>(v12);
        let v13 = DBG128{
            l : 143,
            v : v4,
        };
        0x2::event::emit<DBG128>(v13);
        let v14 = DBG128{
            l : 144,
            v : v1,
        };
        0x2::event::emit<DBG128>(v14);
        let v15 = DBG128{
            l : 145,
            v : v11,
        };
        0x2::event::emit<DBG128>(v15);
        let (v16, v17, v18) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg2, arg0, arg5, true, v9, v11, arg3);
        let v19 = v18;
        let v20 = v17;
        let v21 = v16;
        let v22 = if (arg5) {
            0x2::balance::value<T1>(&v20)
        } else {
            0x2::balance::value<T0>(&v21)
        };
        let v23 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v19);
        let v24 = if (arg5) {
            (((v23 as u128) * 1000000000000 / spstrs(arg4)) as u64)
        } else {
            (((v23 as u128) * spstrs(arg4) / 1000000000000) as u64)
        };
        assert!(v22 >= v24, 13906834925962723330);
        let (v25, v26) = if (arg5) {
            (v23, 0)
        } else {
            (0, v23)
        };
        let (v27, v28) = if (arg5) {
            (0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::wd<T0>(arg1, v23, arg8), 0x2::coin::zero<T1>(arg8))
        } else {
            (0x2::coin::zero<T0>(arg8), 0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::wd<T1>(arg1, v23, arg8))
        };
        let v29 = v28;
        let v30 = v27;
        let (v31, v32) = if (arg5) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v30, v25, arg8)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v29, v26, arg8)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg2, arg0, v31, v32, v19);
        0x2::coin::join<T0>(&mut v30, 0x2::coin::from_balance<T0>(v21, arg8));
        0x2::coin::join<T1>(&mut v29, 0x2::coin::from_balance<T1>(v20, arg8));
        0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::dp<T0>(arg1, v30, arg8);
        0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::dp<T1>(arg1, v29, arg8);
        (v23, v22)
    }

    public fun ttb<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::CBM, arg2: &mut 0xe691aeb328ba898b3374ed75fdffd3306619ad71bab29aa303b0227bf2bb0708::sq::SQR, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: vector<u128>, arg6: vector<u64>, arg7: u64, arg8: vector<u128>, arg9: vector<u64>, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe691aeb328ba898b3374ed75fdffd3306619ad71bab29aa303b0227bf2bb0708::sq::cii(arg2, arg11, true, arg12);
        if (v0 != 0) {
            let v1 = EE{
                e : v0,
                l : 235,
            };
            0x2::event::emit<EE>(v1);
            return
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<u128>(&arg5)) {
            let (v3, v4) = tt<T0, T1>(arg0, arg1, arg3, arg4, *0x1::vector::borrow<u128>(&arg5, v2), true, arg7, *0x1::vector::borrow<u64>(&arg6, v2), arg12);
            if (v3 == 0 && v4 == 0) {
                break
            };
            if (v3 < arg7) {
                let v5 = DBG{
                    l : 258,
                    v : v3,
                };
                0x2::event::emit<DBG>(v5);
                break
            };
            v2 = v2 + 1;
        };
        v2 = 0;
        while (v2 < 0x1::vector::length<u128>(&arg8)) {
            let (v6, v7) = tt<T0, T1>(arg0, arg1, arg3, arg4, *0x1::vector::borrow<u128>(&arg8, v2), false, arg10, *0x1::vector::borrow<u64>(&arg9, v2), arg12);
            if (v6 == 0 && v7 == 0) {
                break
            };
            if (v6 < arg10) {
                let v8 = DBG{
                    l : 284,
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

