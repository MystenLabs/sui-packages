module 0xb1003292213a2eefa93d13be617a0ce1f012c92bfff32e9c78bf77cdb38058de::ffx {
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

    public fun bt<T0, T1>(arg0: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg3: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: vector<u128>, arg6: vector<u64>, arg7: vector<u64>, arg8: u64, arg9: vector<u128>, arg10: vector<u64>, arg11: vector<u64>, arg12: u64, arg13: u8, arg14: u8, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u128>(&arg5) == 0x1::vector::length<u64>(&arg6), 4);
        assert!(0x1::vector::length<u128>(&arg5) == 0x1::vector::length<u64>(&arg7), 4);
        assert!(0x1::vector::length<u128>(&arg9) == 0x1::vector::length<u64>(&arg10), 4);
        assert!(0x1::vector::length<u128>(&arg9) == 0x1::vector::length<u64>(&arg11), 4);
        let v0 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T0>(arg2);
        let v1 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T1>(arg1);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        while (v10 < 0x1::vector::length<u128>(&arg5)) {
            let v11 = *0x1::vector::borrow<u64>(&arg6, v10);
            let v12 = if (v11 > v0) {
                v0
            } else {
                v11
            };
            if (v12 < arg8) {
                break
            };
            let (v13, v14, v15) = sw<T0, T1>(arg0, arg1, arg2, arg3, arg4, *0x1::vector::borrow<u128>(&arg5, v10), true, arg8, v12, arg13, arg14, *0x1::vector::borrow<u64>(&arg7, v10), arg15);
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
        while (v10 < 0x1::vector::length<u128>(&arg9)) {
            let v16 = *0x1::vector::borrow<u64>(&arg10, v10);
            let v17 = if (v16 > v1) {
                v1
            } else {
                v16
            };
            if (v17 < arg12) {
                break
            };
            let (v18, v19, v20) = sw<T0, T1>(arg0, arg1, arg2, arg3, arg4, *0x1::vector::borrow<u128>(&arg9, v10), false, arg12, v17, arg13, arg14, *0x1::vector::borrow<u64>(&arg11, v10), arg15);
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

    fun op<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: bool, arg2: u128, arg3: u64, arg4: u64, arg5: u8, arg6: u8, arg7: u64, arg8: &0x2::clock::Clock) : u64 {
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
            let (v4, v5, v6) = sm<T0, T1>(arg0, v2, arg1, arg2, arg8);
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
            let (v8, v9, v10) = sm<T0, T1>(arg0, v7, arg1, arg2, arg8);
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

    fun sm<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: u64, arg2: bool, arg3: u128, arg4: &0x2::clock::Clock) : (u64, u128, bool) {
        if (arg1 == 0) {
            return (0, 0, true)
        };
        let (v0, v1, _) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_swap_out<T0, T1>(arg0, arg1, arg2, arg4);
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

    fun sw<T0, T1>(arg0: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg3: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: u128, arg6: bool, arg7: u64, arg8: u64, arg9: u8, arg10: u8, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = sp(arg5);
        let (v1, v2, v3) = sm<T0, T1>(arg0, arg7, arg6, v0, arg4);
        let v4 = if (v1 == 0) {
            true
        } else if (v3) {
            true
        } else {
            !pk(v2, v0, arg6)
        };
        if (v4) {
            return (0, 0, 0)
        };
        let v5 = op<T0, T1>(arg0, arg6, v0, arg7, arg8, arg9, arg10, arg11, arg4);
        if (v5 < arg7) {
            return (0, 0, 0)
        };
        let v6 = if (arg6) {
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T0>(arg2, v5, arg12)
        } else {
            0x2::coin::zero<T0>(arg12)
        };
        let v7 = if (arg6) {
            0x2::coin::zero<T1>(arg12)
        } else {
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T1>(arg1, v5, arg12)
        };
        let (v8, v9) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg3, arg0, arg6, 0, v6, v7, arg4, arg12);
        let v10 = v9;
        let v11 = v8;
        let v12 = if (arg6) {
            v5 - 0x2::coin::value<T0>(&v11)
        } else {
            v5 - 0x2::coin::value<T1>(&v10)
        };
        assert!(v12 <= arg8, 5);
        let v13 = if (arg6) {
            0x2::coin::value<T1>(&v10)
        } else {
            0x2::coin::value<T0>(&v11)
        };
        if (v12 == 0 || v13 == 0) {
            if (0x2::coin::value<T0>(&v11) > 0) {
                0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T0>(arg2, v11);
            } else {
                0x2::coin::destroy_zero<T0>(v11);
            };
            if (0x2::coin::value<T1>(&v10) > 0) {
                0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T1>(arg1, v10);
            } else {
                0x2::coin::destroy_zero<T1>(v10);
            };
            return (0, 0, 0)
        };
        let v14 = imo(v12, v0, arg6);
        assert!(v13 >= v14, 6);
        if (0x2::coin::value<T0>(&v11) > 0) {
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T0>(arg2, v11);
        } else {
            0x2::coin::destroy_zero<T0>(v11);
        };
        if (0x2::coin::value<T1>(&v10) > 0) {
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T1>(arg1, v10);
        } else {
            0x2::coin::destroy_zero<T1>(v10);
        };
        (v12, v13, v14)
    }

    // decompiled from Move bytecode v6
}

