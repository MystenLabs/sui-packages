module 0xfc783d9610c4900a5bab9fe10716a7a8a1b2ec6c39f30c1a1a9adb6d9e9ed523::ffx {
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

    public fun bt(arg0: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg1: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<0x2::sui::SUI>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: vector<u128>, arg6: vector<u64>, arg7: vector<u64>, arg8: u64, arg9: vector<u128>, arg10: vector<u64>, arg11: vector<u64>, arg12: u64, arg13: u8, arg14: u8, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u128>(&arg5) == 0x1::vector::length<u64>(&arg6), 4);
        assert!(0x1::vector::length<u128>(&arg5) == 0x1::vector::length<u64>(&arg7), 4);
        assert!(0x1::vector::length<u128>(&arg9) == 0x1::vector::length<u64>(&arg10), 4);
        assert!(0x1::vector::length<u128>(&arg9) == 0x1::vector::length<u64>(&arg11), 4);
        let v0 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2);
        let v1 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<0x2::sui::SUI>(arg1);
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

    fun op(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg1: bool, arg2: u128, arg3: u64, arg4: u64, arg5: u8, arg6: u8, arg7: u64, arg8: &0x2::clock::Clock) : u64 {
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
            let (v4, v5, v6) = sm(arg0, v2, arg1, arg2, arg8);
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
            let (v8, v9, v10) = sm(arg0, v7, arg1, arg2, arg8);
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

    fun sm(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg1: u64, arg2: bool, arg3: u128, arg4: &0x2::clock::Clock) : (u64, u128, bool) {
        if (arg1 == 0) {
            return (0, 0, true)
        };
        let (v0, v1, _) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_swap_out<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg0, arg1, arg2, arg4);
        let v3 = arg1 - v0;
        let v4 = v0 > 0;
        if (v1 == 0 || v3 == 0) {
            return (0, 0, true)
        };
        let v5 = if (arg2) {
            (v3 as u128) * 1000000000000 / (v1 as u128) + 1
        } else {
            (v1 as u128) * 1000000000000 / (v3 as u128)
        };
        if (!pk(v5, arg3, arg2)) {
            v4 = true;
        };
        (v3, v5, v4)
    }

    fun sp(arg0: u128) : u128 {
        arg0
    }

    fun sw(arg0: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg1: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<0x2::sui::SUI>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: u128, arg6: bool, arg7: u64, arg8: u64, arg9: u8, arg10: u8, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = sp(arg5);
        let (v1, v2, v3) = sm(arg0, arg7, arg6, v0, arg4);
        let v4 = if (v1 == 0) {
            true
        } else if (v3) {
            true
        } else {
            !pk(v2, v0, arg6)
        };
        if (v4) {
            return (0, 0)
        };
        let v5 = op(arg0, arg6, v0, arg7, arg8, arg9, arg10, arg11, arg4);
        if (v5 < arg7) {
            return (0, 0)
        };
        let v6 = if (arg6) {
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, v5, arg12)
        } else {
            0x2::coin::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg12)
        };
        let v7 = if (arg6) {
            0x2::coin::zero<0x2::sui::SUI>(arg12)
        } else {
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<0x2::sui::SUI>(arg1, v5, arg12)
        };
        let (v8, v9) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg3, arg0, arg6, 0, v6, v7, arg4, arg12);
        let v10 = v9;
        let v11 = v8;
        let v12 = if (arg6) {
            v5 - 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v11)
        } else {
            v5 - 0x2::coin::value<0x2::sui::SUI>(&v10)
        };
        assert!(v12 <= arg8, 5);
        let v13 = if (arg6) {
            0x2::coin::value<0x2::sui::SUI>(&v10)
        } else {
            0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v11)
        };
        let v14 = if (arg6) {
            (((v12 as u128) * 1000000000000 / v0) as u64)
        } else {
            (((v12 as u128) * v0 / 1000000000000) as u64)
        };
        assert!(v13 >= v14, 6);
        if (0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v11) > 0) {
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, v11);
        } else {
            0x2::coin::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v11);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&v10) > 0) {
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<0x2::sui::SUI>(arg1, v10);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v10);
        };
        if (v12 == 0 || v13 == 0) {
            return (0, 0)
        };
        (v12, v13)
    }

    // decompiled from Move bytecode v6
}

