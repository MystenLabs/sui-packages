module 0xa3bd218544ffadc43649045661240cd4d3a29cb7e69a89e738cbb7e82767fb36::hp {
    struct EE has copy, drop {
        ec: u64,
        ph: u64,
    }

    struct SSE<phantom T0, phantom T1> has copy, drop {
        d: u64,
        tit: u64,
        tot: u64,
        l: u64,
    }

    public fun bee<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg4: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg5: &0x2::clock::Clock, arg6: u64, arg7: vector<bool>, arg8: vector<u64>, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa3bd218544ffadc43649045661240cd4d3a29cb7e69a89e738cbb7e82767fb36::ut::check_deadline(arg5, arg6);
        if (v0 != 0) {
            let v1 = EE{
                ec : v0,
                ph : 1,
            };
            0x2::event::emit<EE>(v1);
            return
        };
        let v2 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T0>(arg3);
        let v3 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T1>(arg4);
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0x1::vector::length<bool>(&arg7);
        while (v9 < v10) {
            let v11 = *0x1::vector::borrow<bool>(&arg7, v9);
            let v12 = *0x1::vector::borrow<u64>(&arg9, v9);
            if (v11) {
            };
            let (v13, v14) = vs<T0, T1>(arg0, v2, v3, v11, *0x1::vector::borrow<u64>(&arg8, v9), v12, arg5, arg1, arg2);
            if (v13 != 0xa3bd218544ffadc43649045661240cd4d3a29cb7e69a89e738cbb7e82767fb36::ct::good()) {
                let v15 = EE{
                    ec : v13,
                    ph : 2,
                };
                0x2::event::emit<EE>(v15);
                break
            };
            let (v16, v17, v18, v19, v20) = do<T0, T1>(arg3, arg4, arg0, arg1, arg2, v11, v14, v12, arg5, arg10);
            if (v16 != 0xa3bd218544ffadc43649045661240cd4d3a29cb7e69a89e738cbb7e82767fb36::ct::good()) {
                let v21 = EE{
                    ec : v16,
                    ph : 3,
                };
                0x2::event::emit<EE>(v21);
                v9 = v9 + 1;
                continue
            };
            let v22 = v2 + v19;
            v2 = v22 - v17;
            let v23 = v3 + v20;
            v3 = v23 - v18;
            v4 = v4 + v17;
            v5 = v5 + v18;
            v6 = v6 + v19;
            v7 = v7 + v20;
            v8 = v8 + v12;
            v9 = v9 + 1;
        };
        let v24 = if (v4 > 0) {
            true
        } else if (v5 > 0) {
            true
        } else if (v6 > 0) {
            true
        } else {
            v7 > 0
        };
        if (v24) {
            let v25 = if (v10 > 0 && *0x1::vector::borrow<bool>(&arg7, 0)) {
                1
            } else {
                0
            };
            let v26 = SSE<T0, T1>{
                d   : v25,
                tit : v4 + v5,
                tot : v6 + v7,
                l   : v8,
            };
            0x2::event::emit<SSE<T0, T1>>(v26);
        };
    }

    fun do<T0, T1>(arg0: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg1: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg2: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64) {
        if (arg5) {
            let v5 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T0>(arg0, arg6, arg9);
            let v6 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_base_coin<T0, T1>(arg2, arg8, arg3, arg4, &mut v5, arg6, arg7, arg9);
            let v7 = 0x2::coin::value<T0>(&v5);
            let v8 = 0x2::coin::value<T1>(&v6);
            if (v7 > 0) {
                0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T0>(arg0, v5);
            } else {
                0x2::coin::destroy_zero<T0>(v5);
            };
            if (v8 > 0) {
                0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T1>(arg1, v6);
            } else {
                0x2::coin::destroy_zero<T1>(v6);
            };
            (0xa3bd218544ffadc43649045661240cd4d3a29cb7e69a89e738cbb7e82767fb36::ct::good(), 0x2::coin::value<T0>(&v5) - v7, 0, 0, v8)
        } else {
            let v9 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T1>(arg1, arg6, arg9);
            let v10 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_quote_coin<T0, T1>(arg2, arg8, arg3, arg4, &mut v9, arg6, arg7, arg9);
            let v11 = 0x2::coin::value<T1>(&v9);
            let v12 = 0x2::coin::value<T0>(&v10);
            if (v11 > 0) {
                0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T1>(arg1, v9);
            } else {
                0x2::coin::destroy_zero<T1>(v9);
            };
            if (v12 > 0) {
                0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T0>(arg0, v10);
            } else {
                0x2::coin::destroy_zero<T0>(v10);
            };
            (0xa3bd218544ffadc43649045661240cd4d3a29cb7e69a89e738cbb7e82767fb36::ct::good(), 0, 0x2::coin::value<T1>(&v9) - v11, v12, 0)
        }
    }

    fun vs<T0, T1>(arg0: &0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: bool, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : (u64, u64) {
        let v0 = if (arg3) {
            0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::query_sell_base_coin<T0, T1>(arg0, arg6, arg7, arg8, arg4)
        } else {
            0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::query_sell_quote_coin<T0, T1>(arg0, arg6, arg7, arg8, arg4)
        };
        if (v0 < arg5) {
            return (0xa3bd218544ffadc43649045661240cd4d3a29cb7e69a89e738cbb7e82767fb36::ct::e_slip(), 0)
        };
        if (arg3) {
            if (arg4 > arg1) {
                return (0xa3bd218544ffadc43649045661240cd4d3a29cb7e69a89e738cbb7e82767fb36::ct::e_inp(), 0)
            };
        } else if (arg4 > arg2) {
            return (0xa3bd218544ffadc43649045661240cd4d3a29cb7e69a89e738cbb7e82767fb36::ct::e_inp(), 0)
        };
        (0xa3bd218544ffadc43649045661240cd4d3a29cb7e69a89e738cbb7e82767fb36::ct::good(), arg4)
    }

    // decompiled from Move bytecode v6
}

