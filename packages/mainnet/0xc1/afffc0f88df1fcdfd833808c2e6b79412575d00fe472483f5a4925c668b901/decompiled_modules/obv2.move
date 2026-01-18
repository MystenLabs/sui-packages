module 0xc1afffc0f88df1fcdfd833808c2e6b79412575d00fe472483f5a4925c668b901::obv2 {
    struct BSE has copy, drop {
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

    public fun bt<T0: store, T1: store>(arg0: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg1: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: vector<u128>, arg8: vector<u64>, arg9: vector<u64>, arg10: u64, arg11: vector<u128>, arg12: vector<u64>, arg13: vector<u64>, arg14: u64, arg15: u8, arg16: u8, arg17: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u128>(&arg7) == 0x1::vector::length<u64>(&arg8), 4);
        assert!(0x1::vector::length<u128>(&arg7) == 0x1::vector::length<u64>(&arg9), 4);
        assert!(0x1::vector::length<u128>(&arg11) == 0x1::vector::length<u64>(&arg12), 4);
        assert!(0x1::vector::length<u128>(&arg11) == 0x1::vector::length<u64>(&arg13), 4);
        let v0 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T1>(arg2);
        let v1 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T0>(arg1);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        while (v10 < 0x1::vector::length<u128>(&arg7)) {
            let v11 = *0x1::vector::borrow<u64>(&arg8, v10);
            let v12 = if (v11 > v0) {
                v0
            } else {
                v11
            };
            if (v12 < arg10) {
                break
            };
            let (v13, v14, v15) = sw<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, *0x1::vector::borrow<u128>(&arg7, v10), true, arg10, v12, arg15, arg16, *0x1::vector::borrow<u64>(&arg9, v10), arg17);
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
        while (v10 < 0x1::vector::length<u128>(&arg11)) {
            let v16 = *0x1::vector::borrow<u64>(&arg12, v10);
            let v17 = if (v16 > v1) {
                v1
            } else {
                v16
            };
            if (v17 < arg14) {
                break
            };
            let (v18, v19, v20) = sw<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, *0x1::vector::borrow<u128>(&arg11, v10), false, arg14, v17, arg15, arg16, *0x1::vector::borrow<u64>(&arg13, v10), arg17);
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
            let v21 = BSE{
                bs : v2,
                ss : v3,
                bi : v4,
                bo : v5,
                si : v6,
                so : v7,
                bm : v8,
                sm : v9,
            };
            0x2::event::emit<BSE>(v21);
        } else {
            let v22 = EE{EE: 999};
            0x2::event::emit<EE>(v22);
        };
    }

    fun op<T0: store, T1: store>(arg0: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg1: bool, arg2: u128, arg3: u64, arg4: u64, arg5: u8, arg6: u8, arg7: u64) : u64 {
        assert!(arg3 > 0, 1);
        assert!(arg3 <= arg4, 2);
        assert!(arg7 < arg3, 3);
        let v0 = 0;
        let v1 = 0;
        let v2 = arg3;
        let v3 = 0;
        while (v3 < arg5) {
            v3 = v3 + 1;
            if (v2 > arg4) {
                v2 = arg4;
            };
            let (v4, v5, v6) = sm<T0, T1>(arg0, v2, arg1);
            if (v6) {
                break
            };
            if (!pk(v5, arg2, arg1)) {
                break
            };
            v0 = v4;
            if (v2 == arg4) {
                return v4
            };
            v1 = v2;
            v2 = v2 * 2;
        };
        if (v0 == 0) {
            return 0
        };
        v3 = 0;
        while (v3 < arg6) {
            v3 = v3 + 1;
            if (v2 - v1 <= arg7) {
                break
            };
            let v7 = (v1 + v2) / 2;
            let (v8, v9, v10) = sm<T0, T1>(arg0, v7, arg1);
            if (pk(v9, arg2, arg1) && !v10) {
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

    fun sm<T0: store, T1: store>(arg0: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg1: u64, arg2: bool) : (u64, u128, bool) {
        if (arg1 == 0) {
            return (0, 0, true)
        };
        let v0 = if (arg2) {
            let (v1, _) = 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::quote_y_to_x<T0, T1>(arg0, arg1);
            v1
        } else {
            let (v3, _) = 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::quote_x_to_y<T0, T1>(arg0, arg1);
            v3
        };
        if (v0 == 0) {
            return (0, 0, true)
        };
        let v5 = if (arg2) {
            (arg1 as u128) * 1000000000000 / (v0 as u128) + 1
        } else {
            (v0 as u128) * 1000000000000 / (arg1 as u128)
        };
        (arg1, v5, false)
    }

    fun sp(arg0: u128) : u128 {
        arg0
    }

    fun sw<T0: store, T1: store>(arg0: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg1: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u128, arg8: bool, arg9: u64, arg10: u64, arg11: u8, arg12: u8, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = sp(arg7);
        let (v1, v2, v3) = sm<T0, T1>(arg0, arg9, arg8);
        if (v3 || v1 == 0) {
            return (0, 0, 0)
        };
        if (!pk(v2, v0, arg8)) {
            return (0, 0, 0)
        };
        let v4 = op<T0, T1>(arg0, arg8, v0, arg9, arg10, arg11, arg12, arg13);
        if (v4 < arg9) {
            return (0, 0, 0)
        };
        assert!(v4 <= arg10, 5);
        let (v5, v6) = if (arg8) {
            let v7 = 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::swap_y_to_x<T0, T1>(arg0, arg3, arg4, arg5, arg6, 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T1>(arg2, v4, arg14), arg14);
            let v8 = 0x2::coin::value<T0>(&v7);
            let v9 = (((v4 as u128) * 1000000000000 / v0) as u64);
            assert!(v8 >= v9, 6);
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T0>(arg1, v7);
            (v8, v9)
        } else {
            let v10 = 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::swap_x_to_y<T0, T1>(arg0, arg3, arg4, arg5, arg6, 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T0>(arg1, v4, arg14), arg14);
            let v11 = 0x2::coin::value<T1>(&v10);
            let v12 = (((v4 as u128) * v0 / 1000000000000) as u64);
            assert!(v11 >= v12, 6);
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T1>(arg2, v10);
            (v11, v12)
        };
        (v4, v5, v6)
    }

    // decompiled from Move bytecode v6
}

