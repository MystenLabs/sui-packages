module 0xfc783d9610c4900a5bab9fe10716a7a8a1b2ec6c39f30c1a1a9adb6d9e9ed523::hd2 {
    struct BSE has copy, drop {
        bs: u64,
        ss: u64,
        bi: u64,
        bo: u64,
        si: u64,
        so: u64,
    }

    struct EE has copy, drop {
        EE: u64,
    }

    public fun bt(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<0x2::sui::SUI>, arg3: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x2::clock::Clock, arg5: vector<u128>, arg6: vector<u64>, arg7: vector<u64>, arg8: u64, arg9: vector<u128>, arg10: vector<u64>, arg11: vector<u64>, arg12: u64, arg13: u8, arg14: u8, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u128>(&arg5) == 0x1::vector::length<u64>(&arg6), 4);
        assert!(0x1::vector::length<u128>(&arg5) == 0x1::vector::length<u64>(&arg7), 4);
        assert!(0x1::vector::length<u128>(&arg9) == 0x1::vector::length<u64>(&arg10), 4);
        assert!(0x1::vector::length<u128>(&arg9) == 0x1::vector::length<u64>(&arg11), 4);
        let v0 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3);
        let v1 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<0x2::sui::SUI>(arg2);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        while (v8 < (0x1::vector::length<u128>(&arg5) as u64)) {
            let v9 = *0x1::vector::borrow<u64>(&arg6, v8);
            let v10 = if (v9 > v0) {
                v0
            } else {
                v9
            };
            if (v10 < arg8) {
                break
            };
            let (v11, v12) = sw(arg0, arg1, arg2, arg3, arg4, *0x1::vector::borrow<u128>(&arg5, v8), true, arg8, v10, arg13, arg14, *0x1::vector::borrow<u64>(&arg7, v8), arg15);
            if (v11 == 0 || v12 == 0) {
                break
            };
            v2 = v2 + 1;
            v4 = v4 + v11;
            v5 = v5 + v12;
            v0 = v0 - v11;
            v1 = v1 + v12;
            v8 = v8 + 1;
        };
        v8 = 0;
        while (v8 < (0x1::vector::length<u128>(&arg9) as u64)) {
            let v13 = *0x1::vector::borrow<u64>(&arg10, v8);
            let v14 = if (v13 > v1) {
                v1
            } else {
                v13
            };
            if (v14 < arg12) {
                break
            };
            let (v15, v16) = sw(arg0, arg1, arg2, arg3, arg4, *0x1::vector::borrow<u128>(&arg9, v8), false, arg12, v14, arg13, arg14, *0x1::vector::borrow<u64>(&arg11, v8), arg15);
            if (v15 == 0 || v16 == 0) {
                break
            };
            v3 = v3 + 1;
            v6 = v6 + v15;
            v7 = v7 + v16;
            v1 = v1 - v15;
            v0 = v0 + v16;
            v8 = v8 + 1;
        };
        if (v2 > 0 || v3 > 0) {
            let v17 = BSE{
                bs : v2,
                ss : v3,
                bi : v4,
                bo : v5,
                si : v6,
                so : v7,
            };
            0x2::event::emit<BSE>(v17);
        } else {
            let v18 = EE{EE: 999};
            0x2::event::emit<EE>(v18);
        };
    }

    fun op(arg0: &0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock, arg3: bool, arg4: u128, arg5: u128, arg6: u64, arg7: u64, arg8: u8, arg9: u8, arg10: u64) : u64 {
        assert!(arg6 > 0, 1);
        assert!(arg6 <= arg7, 2);
        assert!(arg10 < arg6, 3);
        let v0 = 0;
        let v1 = 0;
        let v2 = arg6;
        let v3 = 0;
        while (v3 < arg8) {
            v3 = v3 + 1;
            if (v2 > arg7) {
                v2 = arg7;
            };
            let (v4, v5, v6) = sm(arg0, arg1, arg2, v2, arg3, arg4);
            if (v6) {
                break
            };
            if (!pk(v5, arg5, arg3)) {
                break
            };
            v0 = v4;
            if (v2 == arg7) {
                return v4
            };
            v1 = v2;
            v2 = v2 * 2;
        };
        if (v0 == 0) {
            return 0
        };
        v3 = 0;
        while (v3 < arg9) {
            v3 = v3 + 1;
            if (v2 - v1 <= arg10) {
                break
            };
            let v7 = (v1 + v2) / 2;
            let (v8, v9, v10) = sm(arg0, arg1, arg2, v7, arg3, arg4);
            if (pk(v9, arg5, arg3) && !v10) {
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

    fun sm(arg0: &0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock, arg3: u64, arg4: bool, arg5: u128) : (u64, u128, bool) {
        if (arg3 == 0) {
            return (0, 0, true)
        };
        let v0 = if (arg4) {
            0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::trader::query_sell_quote_coin<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, arg2, arg1, arg3)
        } else {
            0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::trader::query_sell_base_coin<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, arg2, arg1, arg3)
        };
        if (v0 == 0) {
            return (0, 0, true)
        };
        let v1 = if (arg4) {
            (arg3 as u128) * 1000000000000 / (v0 as u128) + 1
        } else {
            (v0 as u128) * 1000000000000 / (arg3 as u128)
        };
        (arg3, v1, false)
    }

    fun sw(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<0x2::sui::SUI>, arg3: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x2::clock::Clock, arg5: u128, arg6: bool, arg7: u64, arg8: u64, arg9: u8, arg10: u8, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        if (arg5 == 0) {
            return (0, 0)
        };
        let (_, v1, v2) = sm(arg0, arg1, arg4, arg7, arg6, 0);
        if (v2) {
            return (0, 0)
        };
        if (!pk(v1, arg5, arg6)) {
            return (0, 0)
        };
        let v3 = op(arg0, arg1, arg4, arg6, 0, arg5, arg7, arg8, arg9, arg10, arg11);
        if (v3 < arg7) {
            return (0, 0)
        };
        let v4 = if (arg6) {
            (((v3 as u128) * 1000000000000 / arg5) as u64)
        } else {
            (((v3 as u128) * arg5 / 1000000000000) as u64)
        };
        if (arg6) {
            let v7 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, v3, arg12);
            let v8 = 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::trader::sell_quote_coin<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, arg4, arg1, &mut v7, v3, v4, arg12);
            let v9 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v7);
            let v10 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v7) - v9;
            assert!(v10 <= arg8, 5);
            let v11 = 0x2::coin::value<0x2::sui::SUI>(&v8);
            assert!(v11 >= (((v10 as u128) * 1000000000000 / arg5) as u64), 6);
            if (v9 > 0) {
                0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, v7);
            } else {
                0x2::coin::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v7);
            };
            if (v11 > 0) {
                0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<0x2::sui::SUI>(arg2, v8);
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(v8);
            };
            (v10, v11)
        } else {
            let v12 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<0x2::sui::SUI>(arg2, v3, arg12);
            let v13 = 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::trader::sell_base_coin<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, arg4, arg1, &mut v12, v3, v4, arg12);
            let v14 = 0x2::coin::value<0x2::sui::SUI>(&v12);
            let v15 = 0x2::coin::value<0x2::sui::SUI>(&v12) - v14;
            assert!(v15 <= arg8, 5);
            let v16 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v13);
            assert!(v16 >= (((v15 as u128) * arg5 / 1000000000000) as u64), 6);
            if (v14 > 0) {
                0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<0x2::sui::SUI>(arg2, v12);
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(v12);
            };
            if (v16 > 0) {
                0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, v13);
            } else {
                0x2::coin::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v13);
            };
            (v15, v16)
        }
    }

    // decompiled from Move bytecode v6
}

