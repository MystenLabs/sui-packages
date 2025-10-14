module 0xac410313d2004526d761152df73cf0baf61e280c54ee26ca9fdc751391c033a9::cte {
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
        let v11 = DBG128{
            l : 142,
            v : arg4,
        };
        0x2::event::emit<DBG128>(v11);
        let v12 = DBG128{
            l : 143,
            v : v4,
        };
        0x2::event::emit<DBG128>(v12);
        let v13 = DBG128{
            l : 144,
            v : v1,
        };
        0x2::event::emit<DBG128>(v13);
        let v14 = DBG128{
            l : 145,
            v : isp(v4),
        };
        0x2::event::emit<DBG128>(v14);
        (0, 0)
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

