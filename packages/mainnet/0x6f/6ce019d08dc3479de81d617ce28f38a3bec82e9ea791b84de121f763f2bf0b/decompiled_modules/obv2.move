module 0x6f6ce019d08dc3479de81d617ce28f38a3bec82e9ea791b84de121f763f2bf0b::obv2 {
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

    public fun bee<T0, T1>(arg0: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg1: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u64, arg8: vector<bool>, arg9: vector<u64>, arg10: vector<u64>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<bool>(&arg8);
        assert!(0x1::vector::length<u64>(&arg9) == v0, 0);
        assert!(0x1::vector::length<u64>(&arg10) == v0, 0);
        let v1 = 0x6f6ce019d08dc3479de81d617ce28f38a3bec82e9ea791b84de121f763f2bf0b::ut::check_deadline(arg3, arg7);
        if (v1 != 0) {
            let v2 = EE{
                ec : v1,
                ph : 1,
            };
            0x2::event::emit<EE>(v2);
            return
        };
        let v3 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T0>(arg1);
        let v4 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T1>(arg2);
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        while (v10 < v0) {
            let v11 = *0x1::vector::borrow<bool>(&arg8, v10);
            let v12 = *0x1::vector::borrow<u64>(&arg9, v10);
            let v13 = *0x1::vector::borrow<u64>(&arg10, v10);
            let (v14, _) = vs<T0, T1>(arg0, v3, v4, v11, v12, v13);
            if (v14 != 0x6f6ce019d08dc3479de81d617ce28f38a3bec82e9ea791b84de121f763f2bf0b::ct::good()) {
                let v16 = EE{
                    ec : v14,
                    ph : 2,
                };
                0x2::event::emit<EE>(v16);
                break
            };
            let (v17, v18, v19, v20, v21) = do<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v11, v12, v13, arg11);
            if (v17 != 0x6f6ce019d08dc3479de81d617ce28f38a3bec82e9ea791b84de121f763f2bf0b::ct::good()) {
                let v22 = EE{
                    ec : v17,
                    ph : 3,
                };
                0x2::event::emit<EE>(v22);
                break
            };
            let v23 = v3 + v20;
            v3 = v23 - v18;
            let v24 = v4 + v21;
            v4 = v24 - v19;
            v5 = v5 + v18;
            v6 = v6 + v19;
            v7 = v7 + v20;
            v8 = v8 + v21;
            v9 = v9 + v13;
            v10 = v10 + 1;
        };
        let v25 = if (v5 > 0) {
            true
        } else if (v6 > 0) {
            true
        } else if (v7 > 0) {
            true
        } else {
            v8 > 0
        };
        if (v25) {
            let v26 = if (v0 > 0 && *0x1::vector::borrow<bool>(&arg8, 0)) {
                1
            } else {
                0
            };
            let v27 = SSE<T0, T1>{
                d   : v26,
                tit : v5 + v6,
                tot : v7 + v8,
                l   : v9,
            };
            0x2::event::emit<SSE<T0, T1>>(v27);
        };
    }

    fun do<T0, T1>(arg0: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg1: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: bool, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64) {
        if (arg7) {
            let v5 = 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::swap_x_to_y<T0, T1>(arg0, arg3, arg4, arg5, arg6, 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T0>(arg1, arg8, arg10), arg10);
            let v6 = 0x2::coin::value<T1>(&v5);
            assert!(v6 >= arg9, 0x6f6ce019d08dc3479de81d617ce28f38a3bec82e9ea791b84de121f763f2bf0b::ct::e_slip());
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T1>(arg2, v5);
            (0x6f6ce019d08dc3479de81d617ce28f38a3bec82e9ea791b84de121f763f2bf0b::ct::good(), arg8, 0, 0, v6)
        } else {
            let v7 = 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::swap_y_to_x<T0, T1>(arg0, arg3, arg4, arg5, arg6, 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T1>(arg2, arg8, arg10), arg10);
            let v8 = 0x2::coin::value<T0>(&v7);
            assert!(v8 >= arg9, 0x6f6ce019d08dc3479de81d617ce28f38a3bec82e9ea791b84de121f763f2bf0b::ct::e_slip());
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T0>(arg1, v7);
            (0x6f6ce019d08dc3479de81d617ce28f38a3bec82e9ea791b84de121f763f2bf0b::ct::good(), 0, arg8, v8, 0)
        }
    }

    fun vs<T0, T1>(arg0: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg1: u64, arg2: u64, arg3: bool, arg4: u64, arg5: u64) : (u64, u64) {
        if (arg3) {
            if (arg4 > arg1) {
                return (0x6f6ce019d08dc3479de81d617ce28f38a3bec82e9ea791b84de121f763f2bf0b::ct::e_inp(), 0)
            };
        } else if (arg4 > arg2) {
            return (0x6f6ce019d08dc3479de81d617ce28f38a3bec82e9ea791b84de121f763f2bf0b::ct::e_inp(), 0)
        };
        let v0 = if (arg3) {
            let (v1, _) = 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::quote_x_to_y<T0, T1>(arg0, arg4);
            v1
        } else {
            let (v3, _) = 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::quote_y_to_x<T0, T1>(arg0, arg4);
            v3
        };
        if (v0 == 0) {
            return (0x6f6ce019d08dc3479de81d617ce28f38a3bec82e9ea791b84de121f763f2bf0b::ct::e_slip(), 0)
        };
        if (v0 < arg5) {
            return (0x6f6ce019d08dc3479de81d617ce28f38a3bec82e9ea791b84de121f763f2bf0b::ct::e_slip(), 0)
        };
        (0x6f6ce019d08dc3479de81d617ce28f38a3bec82e9ea791b84de121f763f2bf0b::ct::good(), v0)
    }

    // decompiled from Move bytecode v6
}

