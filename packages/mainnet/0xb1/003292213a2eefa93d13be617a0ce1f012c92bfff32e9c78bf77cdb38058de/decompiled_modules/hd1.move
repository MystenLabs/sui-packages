module 0xb1003292213a2eefa93d13be617a0ce1f012c92bfff32e9c78bf77cdb38058de::hd1 {
    struct BSE<phantom T0, phantom T1> has copy, drop {
        bs: u64,
        ss: u64,
        bi: u64,
        bo: u64,
        si: u64,
        so: u64,
        bm: u64,
        sm: u64,
    }

    struct EE has copy, drop {
        EE: u64,
    }

    public fun bt<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg4: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg5: &0x2::clock::Clock, arg6: vector<u128>, arg7: vector<u64>, arg8: vector<u64>, arg9: u64, arg10: vector<u128>, arg11: vector<u64>, arg12: vector<u64>, arg13: u64, arg14: u8, arg15: u8, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u128>(&arg6) == 0x1::vector::length<u64>(&arg7), 4);
        assert!(0x1::vector::length<u128>(&arg10) == 0x1::vector::length<u64>(&arg11), 4);
        let v0 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T1>(arg4);
        let v1 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T0>(arg3);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        while (v10 < 0x1::vector::length<u128>(&arg6)) {
            let v11 = *0x1::vector::borrow<u64>(&arg7, v10);
            let v12 = if (v11 > v0) {
                v0
            } else {
                v11
            };
            if (v12 < arg9) {
                break
            };
            let (v13, v14, v15) = sw<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, *0x1::vector::borrow<u128>(&arg6, v10), true, arg9, v12, arg14, arg15, 0, arg16);
            if (v13 == 0 || v14 == 0) {
                break
            };
            v2 = v2 + 1;
            v4 = v4 + v13;
            v5 = v5 + v14;
            v8 = v8 + v15;
            v0 = v0 - v13;
            v1 = v1 + v14;
            v10 = v10 + 1;
        };
        v10 = 0;
        while (v10 < 0x1::vector::length<u128>(&arg10)) {
            let v16 = *0x1::vector::borrow<u64>(&arg11, v10);
            let v17 = if (v16 > v1) {
                v1
            } else {
                v16
            };
            if (v17 < arg13) {
                break
            };
            let (v18, v19, v20) = sw<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, *0x1::vector::borrow<u128>(&arg10, v10), false, arg13, v17, arg14, arg15, 0, arg16);
            if (v18 == 0 || v19 == 0) {
                break
            };
            v3 = v3 + 1;
            v6 = v6 + v18;
            v7 = v7 + v19;
            v9 = v9 + v20;
            v1 = v1 - v18;
            v0 = v0 + v19;
            v10 = v10 + 1;
        };
        if (v2 > 0 || v3 > 0) {
            let v21 = BSE<T0, T1>{
                bs : v2,
                ss : v3,
                bi : v4,
                bo : v5,
                si : v6,
                so : v7,
                bm : v8,
                sm : v9,
            };
            0x2::event::emit<BSE<T0, T1>>(v21);
        } else {
            let v22 = EE{EE: 999};
            0x2::event::emit<EE>(v22);
        };
    }

    fun imo(arg0: u64, arg1: u128, arg2: bool) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = if (arg2) {
            (arg0 as u128) * 1000000000000 / arg1
        } else {
            (arg0 as u128) * arg1 / 1000000000000
        };
        assert!(v0 <= 18446744073709551615, 6);
        (v0 as u64)
    }

    fun op<T0, T1>(arg0: &0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: bool, arg5: u128, arg6: u128, arg7: u64, arg8: u64, arg9: u8, arg10: u8, arg11: u64) : u64 {
        assert!(arg7 > 0, 1);
        assert!(arg7 <= arg8, 2);
        assert!(arg11 < arg7, 3);
        let v0 = 0;
        let v1 = 0;
        let v2 = arg7;
        let v3 = 0;
        while (v3 < arg9) {
            v3 = v3 + 1;
            if (v2 > arg8) {
                v2 = arg8;
            };
            let (v4, v5, v6) = sm<T0, T1>(arg0, arg1, arg2, arg3, v2, arg4, arg5);
            if (v6) {
                break
            };
            if (!pk(v5, arg6, arg4)) {
                break
            };
            v0 = v4;
            if (v2 == arg8) {
                return v4
            };
            v1 = v2;
            v2 = v2 * 2;
        };
        if (v0 == 0) {
            return 0
        };
        v3 = 0;
        while (v3 < arg10) {
            v3 = v3 + 1;
            if (v2 - v1 <= arg11) {
                break
            };
            let v7 = (v1 + v2) / 2;
            let (v8, v9, v10) = sm<T0, T1>(arg0, arg1, arg2, arg3, v7, arg4, arg5);
            if (pk(v9, arg6, arg4) && !v10) {
                v0 = v8;
                v1 = v7;
                continue
            };
            v2 = v7;
        };
        v0
    }

    fun pk(arg0: u128, arg1: u128, arg2: bool) : bool {
        arg2 && arg0 <= arg1 || !arg2 && arg0 >= arg1
    }

    fun sm<T0, T1>(arg0: &0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: u64, arg5: bool, arg6: u128) : (u64, u128, bool) {
        if (arg4 == 0) {
            return (0, 0, true)
        };
        let v0 = if (arg5) {
            0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::query_sell_quote_coin<T0, T1>(arg0, arg3, arg1, arg2, arg4)
        } else {
            0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::query_sell_base_coin<T0, T1>(arg0, arg3, arg1, arg2, arg4)
        };
        if (v0 == 0) {
            return (0, 0, true)
        };
        let v1 = if (arg5) {
            (arg4 as u128) * 1000000000000 / (v0 as u128) + 1
        } else {
            (v0 as u128) * 1000000000000 / (arg4 as u128)
        };
        (arg4, v1, false)
    }

    fun sw<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg4: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg5: &0x2::clock::Clock, arg6: u128, arg7: bool, arg8: u64, arg9: u64, arg10: u8, arg11: u8, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        if (arg6 == 0) {
            return (0, 0, 0)
        };
        let (_, v1, v2) = sm<T0, T1>(arg0, arg1, arg2, arg5, arg8, arg7, 0);
        if (v2) {
            return (0, 0, 0)
        };
        if (!pk(v1, arg6, arg7)) {
            return (0, 0, 0)
        };
        let v3 = op<T0, T1>(arg0, arg1, arg2, arg5, arg7, 0, arg6, arg8, arg9, arg10, arg11, 1);
        if (v3 < arg8) {
            return (0, 0, 0)
        };
        if (arg7) {
            let v7 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T1>(arg4, v3, arg13);
            let v8 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_quote_coin<T0, T1>(arg0, arg5, arg1, arg2, &mut v7, v3, imo(v3, arg6, arg7), arg13);
            let v9 = 0x2::coin::value<T1>(&v7);
            let v10 = 0x2::coin::value<T1>(&v7) - v9;
            assert!(v10 <= arg9, 5);
            let v11 = 0x2::coin::value<T0>(&v8);
            if (v10 == 0 || v11 == 0) {
                if (v9 > 0) {
                    0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T1>(arg4, v7);
                } else {
                    0x2::coin::destroy_zero<T1>(v7);
                };
                if (v11 > 0) {
                    0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T0>(arg3, v8);
                } else {
                    0x2::coin::destroy_zero<T0>(v8);
                };
                return (0, 0, 0)
            };
            let v12 = imo(v10, arg6, true);
            assert!(v11 >= v12, 6);
            if (v9 > 0) {
                0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T1>(arg4, v7);
            } else {
                0x2::coin::destroy_zero<T1>(v7);
            };
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T0>(arg3, v8);
            (v10, v11, v12)
        } else {
            let v13 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T0>(arg3, v3, arg13);
            let v14 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_base_coin<T0, T1>(arg0, arg5, arg1, arg2, &mut v13, v3, imo(v3, arg6, arg7), arg13);
            let v15 = 0x2::coin::value<T0>(&v13);
            let v16 = 0x2::coin::value<T0>(&v13) - v15;
            assert!(v16 <= arg9, 5);
            let v17 = 0x2::coin::value<T1>(&v14);
            if (v16 == 0 || v17 == 0) {
                if (v15 > 0) {
                    0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T0>(arg3, v13);
                } else {
                    0x2::coin::destroy_zero<T0>(v13);
                };
                if (v17 > 0) {
                    0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T1>(arg4, v14);
                } else {
                    0x2::coin::destroy_zero<T1>(v14);
                };
                return (0, 0, 0)
            };
            let v18 = imo(v16, arg6, false);
            assert!(v17 >= v18, 6);
            if (v15 > 0) {
                0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T0>(arg3, v13);
            } else {
                0x2::coin::destroy_zero<T0>(v13);
            };
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T1>(arg4, v14);
            (v16, v17, v18)
        }
    }

    // decompiled from Move bytecode v6
}

