module 0xb1003292213a2eefa93d13be617a0ce1f012c92bfff32e9c78bf77cdb38058de::bfx2 {
    struct BSE<phantom T0, phantom T1, phantom T2> has copy, drop {
        bs: u64,
        ss: u64,
        bi: u64,
        bo: u64,
        bm: u64,
        si: u64,
        so: u64,
        sm: u64,
    }

    struct EE has copy, drop {
        EE: u64,
    }

    public fun bt2_ab_bc<T0, T1, T2>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg3: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &0x2::clock::Clock, arg6: vector<u128>, arg7: vector<u64>, arg8: vector<u64>, arg9: u64, arg10: vector<u128>, arg11: vector<u64>, arg12: vector<u64>, arg13: u64, arg14: u8, arg15: u8, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u128>(&arg6) == 0x1::vector::length<u64>(&arg7), 4);
        assert!(0x1::vector::length<u128>(&arg6) == 0x1::vector::length<u64>(&arg8), 4);
        assert!(0x1::vector::length<u128>(&arg10) == 0x1::vector::length<u64>(&arg11), 4);
        assert!(0x1::vector::length<u128>(&arg10) == 0x1::vector::length<u64>(&arg12), 4);
        let v0 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T0>(arg2);
        let v1 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T2>(arg3);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        while (v10 < (0x1::vector::length<u128>(&arg6) as u64)) {
            let v11 = *0x1::vector::borrow<u64>(&arg7, v10);
            let v12 = if (v11 > v1) {
                v1
            } else {
                v11
            };
            if (v12 < arg9) {
                break
            };
            let (v13, v14, v15) = sw2_ab_bc<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, true, *0x1::vector::borrow<u128>(&arg6, v10), arg9, v12, arg14, arg15, *0x1::vector::borrow<u64>(&arg8, v10), arg16);
            if (v13 == 0 || v14 == 0) {
                break
            };
            v2 = v2 + 1;
            v4 = v4 + v13;
            v5 = v5 + v14;
            v6 = v6 + v15;
            v1 = v1 - v13;
            v0 = v0 + v14;
            v10 = v10 + 1;
        };
        v10 = 0;
        while (v10 < (0x1::vector::length<u128>(&arg10) as u64)) {
            let v16 = *0x1::vector::borrow<u64>(&arg11, v10);
            let v17 = if (v16 > v0) {
                v0
            } else {
                v16
            };
            if (v17 < arg13) {
                break
            };
            let (v18, v19, v20) = sw2_ab_bc<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, false, *0x1::vector::borrow<u128>(&arg10, v10), arg13, v17, arg14, arg15, *0x1::vector::borrow<u64>(&arg12, v10), arg16);
            if (v18 == 0 || v19 == 0) {
                break
            };
            v3 = v3 + 1;
            v7 = v7 + v18;
            v8 = v8 + v19;
            v9 = v9 + v20;
            v0 = v0 - v18;
            v1 = v1 + v19;
            v10 = v10 + 1;
        };
        if (v2 > 0 || v3 > 0) {
            let v21 = BSE<T0, T1, T2>{
                bs : v2,
                ss : v3,
                bi : v4,
                bo : v5,
                bm : v6,
                si : v7,
                so : v8,
                sm : v9,
            };
            0x2::event::emit<BSE<T0, T1, T2>>(v21);
        } else {
            let v22 = EE{EE: 999};
            0x2::event::emit<EE>(v22);
        };
    }

    public fun bt2_ab_cb<T0, T1, T2>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg3: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &0x2::clock::Clock, arg6: vector<u128>, arg7: vector<u64>, arg8: vector<u64>, arg9: u64, arg10: vector<u128>, arg11: vector<u64>, arg12: vector<u64>, arg13: u64, arg14: u8, arg15: u8, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u128>(&arg6) == 0x1::vector::length<u64>(&arg7), 4);
        assert!(0x1::vector::length<u128>(&arg6) == 0x1::vector::length<u64>(&arg8), 4);
        assert!(0x1::vector::length<u128>(&arg10) == 0x1::vector::length<u64>(&arg11), 4);
        assert!(0x1::vector::length<u128>(&arg10) == 0x1::vector::length<u64>(&arg12), 4);
        let v0 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T0>(arg2);
        let v1 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T2>(arg3);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        while (v10 < (0x1::vector::length<u128>(&arg6) as u64)) {
            let v11 = *0x1::vector::borrow<u64>(&arg7, v10);
            let v12 = if (v11 > v1) {
                v1
            } else {
                v11
            };
            if (v12 < arg9) {
                break
            };
            let (v13, v14, v15) = sw2_ab_cb<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, true, *0x1::vector::borrow<u128>(&arg6, v10), arg9, v12, arg14, arg15, *0x1::vector::borrow<u64>(&arg8, v10), arg16);
            if (v13 == 0 || v14 == 0) {
                break
            };
            v2 = v2 + 1;
            v4 = v4 + v13;
            v5 = v5 + v14;
            v6 = v6 + v15;
            v1 = v1 - v13;
            v0 = v0 + v14;
            v10 = v10 + 1;
        };
        v10 = 0;
        while (v10 < (0x1::vector::length<u128>(&arg10) as u64)) {
            let v16 = *0x1::vector::borrow<u64>(&arg11, v10);
            let v17 = if (v16 > v0) {
                v0
            } else {
                v16
            };
            if (v17 < arg13) {
                break
            };
            let (v18, v19, v20) = sw2_ab_cb<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, false, *0x1::vector::borrow<u128>(&arg10, v10), arg13, v17, arg14, arg15, *0x1::vector::borrow<u64>(&arg12, v10), arg16);
            if (v18 == 0 || v19 == 0) {
                break
            };
            v3 = v3 + 1;
            v7 = v7 + v18;
            v8 = v8 + v19;
            v9 = v9 + v20;
            v0 = v0 - v18;
            v1 = v1 + v19;
            v10 = v10 + 1;
        };
        if (v2 > 0 || v3 > 0) {
            let v21 = BSE<T0, T1, T2>{
                bs : v2,
                ss : v3,
                bi : v4,
                bo : v5,
                bm : v6,
                si : v7,
                so : v8,
                sm : v9,
            };
            0x2::event::emit<BSE<T0, T1, T2>>(v21);
        } else {
            let v22 = EE{EE: 999};
            0x2::event::emit<EE>(v22);
        };
    }

    public fun bt2_ba_bc<T0, T1, T2>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg3: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &0x2::clock::Clock, arg6: vector<u128>, arg7: vector<u64>, arg8: vector<u64>, arg9: u64, arg10: vector<u128>, arg11: vector<u64>, arg12: vector<u64>, arg13: u64, arg14: u8, arg15: u8, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u128>(&arg6) == 0x1::vector::length<u64>(&arg7), 4);
        assert!(0x1::vector::length<u128>(&arg6) == 0x1::vector::length<u64>(&arg8), 4);
        assert!(0x1::vector::length<u128>(&arg10) == 0x1::vector::length<u64>(&arg11), 4);
        assert!(0x1::vector::length<u128>(&arg10) == 0x1::vector::length<u64>(&arg12), 4);
        let v0 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T0>(arg2);
        let v1 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T2>(arg3);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        while (v10 < (0x1::vector::length<u128>(&arg6) as u64)) {
            let v11 = *0x1::vector::borrow<u64>(&arg7, v10);
            let v12 = if (v11 > v1) {
                v1
            } else {
                v11
            };
            if (v12 < arg9) {
                break
            };
            let (v13, v14, v15) = sw2_ba_bc<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, true, *0x1::vector::borrow<u128>(&arg6, v10), arg9, v12, arg14, arg15, *0x1::vector::borrow<u64>(&arg8, v10), arg16);
            if (v13 == 0 || v14 == 0) {
                break
            };
            v2 = v2 + 1;
            v4 = v4 + v13;
            v5 = v5 + v14;
            v6 = v6 + v15;
            v1 = v1 - v13;
            v0 = v0 + v14;
            v10 = v10 + 1;
        };
        v10 = 0;
        while (v10 < (0x1::vector::length<u128>(&arg10) as u64)) {
            let v16 = *0x1::vector::borrow<u64>(&arg11, v10);
            let v17 = if (v16 > v0) {
                v0
            } else {
                v16
            };
            if (v17 < arg13) {
                break
            };
            let (v18, v19, v20) = sw2_ba_bc<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, false, *0x1::vector::borrow<u128>(&arg10, v10), arg13, v17, arg14, arg15, *0x1::vector::borrow<u64>(&arg12, v10), arg16);
            if (v18 == 0 || v19 == 0) {
                break
            };
            v3 = v3 + 1;
            v7 = v7 + v18;
            v8 = v8 + v19;
            v9 = v9 + v20;
            v0 = v0 - v18;
            v1 = v1 + v19;
            v10 = v10 + 1;
        };
        if (v2 > 0 || v3 > 0) {
            let v21 = BSE<T0, T1, T2>{
                bs : v2,
                ss : v3,
                bi : v4,
                bo : v5,
                bm : v6,
                si : v7,
                so : v8,
                sm : v9,
            };
            0x2::event::emit<BSE<T0, T1, T2>>(v21);
        } else {
            let v22 = EE{EE: 999};
            0x2::event::emit<EE>(v22);
        };
    }

    public fun bt2_ba_cb<T0, T1, T2>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg3: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &0x2::clock::Clock, arg6: vector<u128>, arg7: vector<u64>, arg8: vector<u64>, arg9: u64, arg10: vector<u128>, arg11: vector<u64>, arg12: vector<u64>, arg13: u64, arg14: u8, arg15: u8, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u128>(&arg6) == 0x1::vector::length<u64>(&arg7), 4);
        assert!(0x1::vector::length<u128>(&arg6) == 0x1::vector::length<u64>(&arg8), 4);
        assert!(0x1::vector::length<u128>(&arg10) == 0x1::vector::length<u64>(&arg11), 4);
        assert!(0x1::vector::length<u128>(&arg10) == 0x1::vector::length<u64>(&arg12), 4);
        let v0 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T0>(arg2);
        let v1 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T2>(arg3);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        while (v10 < (0x1::vector::length<u128>(&arg6) as u64)) {
            let v11 = *0x1::vector::borrow<u64>(&arg7, v10);
            let v12 = if (v11 > v1) {
                v1
            } else {
                v11
            };
            if (v12 < arg9) {
                break
            };
            let (v13, v14, v15) = sw2_ba_cb<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, true, *0x1::vector::borrow<u128>(&arg6, v10), arg9, v12, arg14, arg15, *0x1::vector::borrow<u64>(&arg8, v10), arg16);
            if (v13 == 0 || v14 == 0) {
                break
            };
            v2 = v2 + 1;
            v4 = v4 + v13;
            v5 = v5 + v14;
            v6 = v6 + v15;
            v1 = v1 - v13;
            v0 = v0 + v14;
            v10 = v10 + 1;
        };
        v10 = 0;
        while (v10 < (0x1::vector::length<u128>(&arg10) as u64)) {
            let v16 = *0x1::vector::borrow<u64>(&arg11, v10);
            let v17 = if (v16 > v0) {
                v0
            } else {
                v16
            };
            if (v17 < arg13) {
                break
            };
            let (v18, v19, v20) = sw2_ba_cb<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, false, *0x1::vector::borrow<u128>(&arg10, v10), arg13, v17, arg14, arg15, *0x1::vector::borrow<u64>(&arg12, v10), arg16);
            if (v18 == 0 || v19 == 0) {
                break
            };
            v3 = v3 + 1;
            v7 = v7 + v18;
            v8 = v8 + v19;
            v9 = v9 + v20;
            v0 = v0 - v18;
            v1 = v1 + v19;
            v10 = v10 + 1;
        };
        if (v2 > 0 || v3 > 0) {
            let v21 = BSE<T0, T1, T2>{
                bs : v2,
                ss : v3,
                bi : v4,
                bo : v5,
                bm : v6,
                si : v7,
                so : v8,
                sm : v9,
            };
            0x2::event::emit<BSE<T0, T1, T2>>(v21);
        } else {
            let v22 = EE{EE: 999};
            0x2::event::emit<EE>(v22);
        };
    }

    fun dep_or_destroy<T0>(arg0: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
        } else {
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T0>(arg0, arg1);
        };
    }

    fun inf_limit(arg0: bool) : u128 {
        if (arg0) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::min_sqrt_price() + 1
        } else {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::max_sqrt_price() - 1
        }
    }

    fun inv_x12(arg0: u128) : u128 {
        assert!(arg0 > 0, 7);
        (((1000000000000 as u256) * (1000000000000 as u256) / (arg0 as u256)) as u128)
    }

    fun mul_x12(arg0: u128, arg1: u128) : u128 {
        (((arg0 as u256) * (arg1 as u256) / (1000000000000 as u256)) as u128)
    }

    fun op2_ab_bc<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg2: bool, arg3: u128, arg4: u64, arg5: u64, arg6: u8, arg7: u8, arg8: u64) : u64 {
        assert!(arg4 > 0, 1);
        assert!(arg4 <= arg5, 2);
        assert!(arg8 < arg4, 3);
        let v0 = 0;
        let v1 = 0;
        let v2 = arg4;
        let v3 = 0;
        while (v3 < arg6) {
            v3 = v3 + 1;
            if (v2 > arg5) {
                v2 = arg5;
            };
            let (v4, _, v6, v7) = sm2_ab_bc<T0, T1, T2>(arg0, arg1, v2, arg2);
            if (v7) {
                break
            };
            if (!pk(v6, arg3, arg2)) {
                break
            };
            v0 = v4;
            if (v2 == arg5) {
                return v4
            };
            v1 = v2;
            v2 = v2 * 2;
        };
        if (v0 == 0) {
            return 0
        };
        v3 = 0;
        while (v3 < arg7) {
            v3 = v3 + 1;
            if (v2 - v1 <= arg8) {
                break
            };
            let v8 = (v1 + v2) / 2;
            let (v9, _, v11, v12) = sm2_ab_bc<T0, T1, T2>(arg0, arg1, v8, arg2);
            if (pk(v11, arg3, arg2) && !v12) {
                v0 = v9;
                v1 = v8;
                continue
            };
            v2 = v8;
        };
        v0
    }

    fun op2_ab_cb<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg2: bool, arg3: u128, arg4: u64, arg5: u64, arg6: u8, arg7: u8, arg8: u64) : u64 {
        assert!(arg4 > 0, 1);
        assert!(arg4 <= arg5, 2);
        assert!(arg8 < arg4, 3);
        let v0 = 0;
        let v1 = 0;
        let v2 = arg4;
        let v3 = 0;
        while (v3 < arg6) {
            v3 = v3 + 1;
            if (v2 > arg5) {
                v2 = arg5;
            };
            let (v4, _, v6, v7) = sm2_ab_cb<T0, T1, T2>(arg0, arg1, v2, arg2);
            if (v7) {
                break
            };
            if (!pk(v6, arg3, arg2)) {
                break
            };
            v0 = v4;
            if (v2 == arg5) {
                return v4
            };
            v1 = v2;
            v2 = v2 * 2;
        };
        if (v0 == 0) {
            return 0
        };
        v3 = 0;
        while (v3 < arg7) {
            v3 = v3 + 1;
            if (v2 - v1 <= arg8) {
                break
            };
            let v8 = (v1 + v2) / 2;
            let (v9, _, v11, v12) = sm2_ab_cb<T0, T1, T2>(arg0, arg1, v8, arg2);
            if (pk(v11, arg3, arg2) && !v12) {
                v0 = v9;
                v1 = v8;
                continue
            };
            v2 = v8;
        };
        v0
    }

    fun op2_ba_bc<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg2: bool, arg3: u128, arg4: u64, arg5: u64, arg6: u8, arg7: u8, arg8: u64) : u64 {
        assert!(arg4 > 0, 1);
        assert!(arg4 <= arg5, 2);
        assert!(arg8 < arg4, 3);
        let v0 = 0;
        let v1 = 0;
        let v2 = arg4;
        let v3 = 0;
        while (v3 < arg6) {
            v3 = v3 + 1;
            if (v2 > arg5) {
                v2 = arg5;
            };
            let (v4, _, v6, v7) = sm2_ba_bc<T0, T1, T2>(arg0, arg1, v2, arg2);
            if (v7) {
                break
            };
            if (!pk(v6, arg3, arg2)) {
                break
            };
            v0 = v4;
            if (v2 == arg5) {
                return v4
            };
            v1 = v2;
            v2 = v2 * 2;
        };
        if (v0 == 0) {
            return 0
        };
        v3 = 0;
        while (v3 < arg7) {
            v3 = v3 + 1;
            if (v2 - v1 <= arg8) {
                break
            };
            let v8 = (v1 + v2) / 2;
            let (v9, _, v11, v12) = sm2_ba_bc<T0, T1, T2>(arg0, arg1, v8, arg2);
            if (pk(v11, arg3, arg2) && !v12) {
                v0 = v9;
                v1 = v8;
                continue
            };
            v2 = v8;
        };
        v0
    }

    fun op2_ba_cb<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg2: bool, arg3: u128, arg4: u64, arg5: u64, arg6: u8, arg7: u8, arg8: u64) : u64 {
        assert!(arg4 > 0, 1);
        assert!(arg4 <= arg5, 2);
        assert!(arg8 < arg4, 3);
        let v0 = 0;
        let v1 = 0;
        let v2 = arg4;
        let v3 = 0;
        while (v3 < arg6) {
            v3 = v3 + 1;
            if (v2 > arg5) {
                v2 = arg5;
            };
            let (v4, _, v6, v7) = sm2_ba_cb<T0, T1, T2>(arg0, arg1, v2, arg2);
            if (v7) {
                break
            };
            if (!pk(v6, arg3, arg2)) {
                break
            };
            v0 = v4;
            if (v2 == arg5) {
                return v4
            };
            v1 = v2;
            v2 = v2 * 2;
        };
        if (v0 == 0) {
            return 0
        };
        v3 = 0;
        while (v3 < arg7) {
            v3 = v3 + 1;
            if (v2 - v1 <= arg8) {
                break
            };
            let v8 = (v1 + v2) / 2;
            let (v9, _, v11, v12) = sm2_ba_cb<T0, T1, T2>(arg0, arg1, v8, arg2);
            if (pk(v11, arg3, arg2) && !v12) {
                v0 = v9;
                v1 = v8;
                continue
            };
            v2 = v8;
        };
        v0
    }

    fun op2_core(arg0: bool, arg1: u128, arg2: u64, arg3: u64, arg4: u8, arg5: u8, arg6: u64) : u64 {
        0
    }

    fun pk(arg0: u128, arg1: u128, arg2: bool) : bool {
        arg2 && arg0 <= arg1 || !arg2 && arg0 >= arg1
    }

    fun route_px_ab_bc<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>) : u128 {
        mul_x12(sp(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0)), sp(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, T2>(arg1)))
    }

    fun route_px_ab_cb<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>) : u128 {
        mul_x12(sp(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0)), inv_x12(sp(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T2, T1>(arg1))))
    }

    fun route_px_ba_bc<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>) : u128 {
        mul_x12(inv_x12(sp(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, T0>(arg0))), sp(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, T2>(arg1)))
    }

    fun route_px_ba_cb<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>) : u128 {
        mul_x12(inv_x12(sp(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, T0>(arg0))), inv_x12(sp(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T2, T1>(arg1))))
    }

    fun send_or_destroy<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    fun sim_hop<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: bool) : (u64, u64, bool) {
        if (arg2 == 0) {
            return (0, 0, true)
        };
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg0, arg1, true, arg2, inf_limit(arg1));
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v0);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified(&v0) - v1;
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v0);
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v0);
        if (arg3 && v1 > 0) {
            v4 = true;
        };
        if (v2 == 0 || v3 == 0) {
            v4 = true;
        };
        (v2, v3, v4)
    }

    fun sm2_ab_bc<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg2: u64, arg3: bool) : (u64, u64, u128, bool) {
        if (arg2 == 0) {
            return (0, 0, 0, true)
        };
        if (arg3) {
            let (v4, v5, v6) = sim_hop<T1, T2>(arg1, false, arg2, true);
            if (v4 == 0 || v5 == 0) {
                return (0, 0, 0, true)
            };
            let (_, v8, v9) = sim_hop<T0, T1>(arg0, false, v5, false);
            if (v8 == 0) {
                return (0, 0, 0, true)
            };
            let v10 = v6 || v9;
            (v4, v8, (v4 as u128) * 1000000000000 / (v8 as u128) + 1, v10)
        } else {
            let (v11, v12, v13) = sim_hop<T0, T1>(arg0, true, arg2, true);
            if (v11 == 0 || v12 == 0) {
                return (0, 0, 0, true)
            };
            let (_, v15, v16) = sim_hop<T1, T2>(arg1, true, v12, false);
            if (v15 == 0) {
                return (0, 0, 0, true)
            };
            let v17 = v13 || v16;
            (v11, v15, (v15 as u128) * 1000000000000 / (v11 as u128), v17)
        }
    }

    fun sm2_ab_cb<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg2: u64, arg3: bool) : (u64, u64, u128, bool) {
        if (arg2 == 0) {
            return (0, 0, 0, true)
        };
        if (arg3) {
            let (v4, v5, v6) = sim_hop<T2, T1>(arg1, true, arg2, true);
            if (v4 == 0 || v5 == 0) {
                return (0, 0, 0, true)
            };
            let (_, v8, v9) = sim_hop<T0, T1>(arg0, false, v5, false);
            if (v8 == 0) {
                return (0, 0, 0, true)
            };
            let v10 = v6 || v9;
            (v4, v8, (v4 as u128) * 1000000000000 / (v8 as u128) + 1, v10)
        } else {
            let (v11, v12, v13) = sim_hop<T0, T1>(arg0, true, arg2, true);
            if (v11 == 0 || v12 == 0) {
                return (0, 0, 0, true)
            };
            let (_, v15, v16) = sim_hop<T2, T1>(arg1, false, v12, false);
            if (v15 == 0) {
                return (0, 0, 0, true)
            };
            let v17 = v13 || v16;
            (v11, v15, (v15 as u128) * 1000000000000 / (v11 as u128), v17)
        }
    }

    fun sm2_ba_bc<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg2: u64, arg3: bool) : (u64, u64, u128, bool) {
        if (arg2 == 0) {
            return (0, 0, 0, true)
        };
        if (arg3) {
            let (v4, v5, v6) = sim_hop<T1, T2>(arg1, false, arg2, true);
            if (v4 == 0 || v5 == 0) {
                return (0, 0, 0, true)
            };
            let (_, v8, v9) = sim_hop<T1, T0>(arg0, true, v5, false);
            if (v8 == 0) {
                return (0, 0, 0, true)
            };
            let v10 = v6 || v9;
            (v4, v8, (v4 as u128) * 1000000000000 / (v8 as u128) + 1, v10)
        } else {
            let (v11, v12, v13) = sim_hop<T1, T0>(arg0, false, arg2, true);
            if (v11 == 0 || v12 == 0) {
                return (0, 0, 0, true)
            };
            let (_, v15, v16) = sim_hop<T1, T2>(arg1, true, v12, false);
            if (v15 == 0) {
                return (0, 0, 0, true)
            };
            let v17 = v13 || v16;
            (v11, v15, (v15 as u128) * 1000000000000 / (v11 as u128), v17)
        }
    }

    fun sm2_ba_cb<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg2: u64, arg3: bool) : (u64, u64, u128, bool) {
        if (arg2 == 0) {
            return (0, 0, 0, true)
        };
        if (arg3) {
            let (v4, v5, v6) = sim_hop<T2, T1>(arg1, true, arg2, true);
            if (v4 == 0 || v5 == 0) {
                return (0, 0, 0, true)
            };
            let (_, v8, v9) = sim_hop<T1, T0>(arg0, true, v5, false);
            if (v8 == 0) {
                return (0, 0, 0, true)
            };
            let v10 = v6 || v9;
            (v4, v8, (v4 as u128) * 1000000000000 / (v8 as u128) + 1, v10)
        } else {
            let (v11, v12, v13) = sim_hop<T1, T0>(arg0, false, arg2, true);
            if (v11 == 0 || v12 == 0) {
                return (0, 0, 0, true)
            };
            let (_, v15, v16) = sim_hop<T2, T1>(arg1, false, v12, false);
            if (v15 == 0) {
                return (0, 0, 0, true)
            };
            let v17 = v13 || v16;
            (v11, v15, (v15 as u128) * 1000000000000 / (v11 as u128), v17)
        }
    }

    fun sp(arg0: u128) : u128 {
        (((arg0 as u256) * (arg0 as u256) * (1000000000000 as u256) / 340282366920938463463374607431768211456) as u128)
    }

    fun sw2_ab_bc<T0, T1, T2>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg3: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &0x2::clock::Clock, arg6: bool, arg7: u128, arg8: u64, arg9: u64, arg10: u8, arg11: u8, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        assert!(arg7 > 0, 7);
        if (!pk(route_px_ab_bc<T0, T1, T2>(arg0, arg1), arg7, arg6)) {
            return (0, 0, 0)
        };
        let v0 = op2_ab_bc<T0, T1, T2>(arg0, arg1, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        if (v0 < arg8) {
            return (0, 0, 0)
        };
        if (arg6) {
            let (v4, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg5, arg4, arg1, false, true, v0, inf_limit(false));
            let v7 = v6;
            let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T2>(&v7);
            assert!(v8 <= arg9, 5);
            let v9 = 0x2::coin::from_balance<T1>(v4, arg13);
            let v10 = 0x2::coin::from_balance<T2>(v5, arg13);
            let v11 = 0x2::coin::value<T1>(&v9);
            if (v11 == 0) {
                0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg4, arg1, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T2>(0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T2>(arg3, v8, arg13)), v7);
                dep_or_destroy<T2>(arg3, v10);
                send_or_destroy<T1>(v9, arg13);
                return (0, 0, 0)
            };
            let (v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg5, arg4, arg0, false, true, v11, inf_limit(false));
            let v15 = v14;
            let v16 = 0x2::coin::from_balance<T0>(v12, arg13);
            let v17 = 0x2::coin::value<T0>(&v16);
            let v18 = (((v8 as u128) * 1000000000000 / arg7) as u64);
            assert!(v17 >= v18, 6);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg4, arg0, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v9, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v15), arg13)), v15);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg4, arg1, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T2>(0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T2>(arg3, v8, arg13)), v7);
            let v19 = 0x2::coin::from_balance<T1>(v13, arg13);
            0x2::coin::join<T1>(&mut v19, v9);
            dep_or_destroy<T0>(arg2, v16);
            dep_or_destroy<T2>(arg3, v10);
            send_or_destroy<T1>(v19, arg13);
            (v8, v17, v18)
        } else {
            let (v20, v21, v22) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg5, arg4, arg0, true, true, v0, inf_limit(true));
            let v23 = v22;
            let v24 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v23);
            assert!(v24 <= arg9, 5);
            let v25 = 0x2::coin::from_balance<T1>(v21, arg13);
            let v26 = 0x2::coin::from_balance<T0>(v20, arg13);
            let v27 = 0x2::coin::value<T1>(&v25);
            if (v27 == 0) {
                0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg4, arg0, 0x2::coin::into_balance<T0>(0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T0>(arg2, v24, arg13)), 0x2::balance::zero<T1>(), v23);
                dep_or_destroy<T0>(arg2, v26);
                send_or_destroy<T1>(v25, arg13);
                return (0, 0, 0)
            };
            let (v28, v29, v30) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg5, arg4, arg1, true, true, v27, inf_limit(true));
            let v31 = v30;
            let v32 = 0x2::coin::from_balance<T2>(v29, arg13);
            let v33 = 0x2::coin::value<T2>(&v32);
            let v34 = (((v24 as u128) * arg7 / 1000000000000) as u64);
            assert!(v33 >= v34, 6);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg4, arg1, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v25, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T2>(&v31), arg13)), 0x2::balance::zero<T2>(), v31);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg4, arg0, 0x2::coin::into_balance<T0>(0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T0>(arg2, v24, arg13)), 0x2::balance::zero<T1>(), v23);
            let v35 = 0x2::coin::from_balance<T1>(v28, arg13);
            0x2::coin::join<T1>(&mut v35, v25);
            dep_or_destroy<T0>(arg2, v26);
            dep_or_destroy<T2>(arg3, v32);
            send_or_destroy<T1>(v35, arg13);
            (v24, v33, v34)
        }
    }

    fun sw2_ab_cb<T0, T1, T2>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg3: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &0x2::clock::Clock, arg6: bool, arg7: u128, arg8: u64, arg9: u64, arg10: u8, arg11: u8, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        assert!(arg7 > 0, 7);
        if (!pk(route_px_ab_cb<T0, T1, T2>(arg0, arg1), arg7, arg6)) {
            return (0, 0, 0)
        };
        let v0 = op2_ab_cb<T0, T1, T2>(arg0, arg1, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        if (v0 < arg8) {
            return (0, 0, 0)
        };
        if (arg6) {
            let (v4, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg5, arg4, arg1, true, true, v0, inf_limit(true));
            let v7 = v6;
            let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T1>(&v7);
            assert!(v8 <= arg9, 5);
            let v9 = 0x2::coin::from_balance<T1>(v5, arg13);
            let (v10, v11, v12) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg5, arg4, arg0, false, true, 0x2::coin::value<T1>(&v9), inf_limit(false));
            let v13 = v12;
            let v14 = 0x2::coin::from_balance<T0>(v10, arg13);
            let v15 = 0x2::coin::value<T0>(&v14);
            let v16 = (((v8 as u128) * 1000000000000 / arg7) as u64);
            assert!(v15 >= v16, 6);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg4, arg0, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v9, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v13), arg13)), v13);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg4, arg1, 0x2::coin::into_balance<T2>(0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T2>(arg3, v8, arg13)), 0x2::balance::zero<T1>(), v7);
            let v17 = 0x2::coin::from_balance<T1>(v11, arg13);
            0x2::coin::join<T1>(&mut v17, v9);
            dep_or_destroy<T0>(arg2, v14);
            dep_or_destroy<T2>(arg3, 0x2::coin::from_balance<T2>(v4, arg13));
            send_or_destroy<T1>(v17, arg13);
            (v8, v15, v16)
        } else {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg5, arg4, arg0, true, true, v0, inf_limit(true));
            let v21 = v20;
            let v22 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v21);
            assert!(v22 <= arg9, 5);
            let v23 = 0x2::coin::from_balance<T1>(v19, arg13);
            let (v24, v25, v26) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg5, arg4, arg1, false, true, 0x2::coin::value<T1>(&v23), inf_limit(false));
            let v27 = v26;
            let v28 = 0x2::coin::from_balance<T2>(v24, arg13);
            let v29 = 0x2::coin::value<T2>(&v28);
            let v30 = (((v22 as u128) * arg7 / 1000000000000) as u64);
            assert!(v29 >= v30, 6);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg4, arg1, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v23, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T1>(&v27), arg13)), v27);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg4, arg0, 0x2::coin::into_balance<T0>(0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T0>(arg2, v22, arg13)), 0x2::balance::zero<T1>(), v21);
            let v31 = 0x2::coin::from_balance<T1>(v25, arg13);
            0x2::coin::join<T1>(&mut v31, v23);
            dep_or_destroy<T0>(arg2, 0x2::coin::from_balance<T0>(v18, arg13));
            dep_or_destroy<T2>(arg3, v28);
            send_or_destroy<T1>(v31, arg13);
            (v22, v29, v30)
        }
    }

    fun sw2_ba_bc<T0, T1, T2>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg3: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &0x2::clock::Clock, arg6: bool, arg7: u128, arg8: u64, arg9: u64, arg10: u8, arg11: u8, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        assert!(arg7 > 0, 7);
        if (!pk(route_px_ba_bc<T0, T1, T2>(arg0, arg1), arg7, arg6)) {
            return (0, 0, 0)
        };
        let v0 = op2_ba_bc<T0, T1, T2>(arg0, arg1, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        if (v0 < arg8) {
            return (0, 0, 0)
        };
        if (arg6) {
            let (v4, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg5, arg4, arg1, false, true, v0, inf_limit(false));
            let v7 = v6;
            let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T2>(&v7);
            assert!(v8 <= arg9, 5);
            let v9 = 0x2::coin::from_balance<T1>(v4, arg13);
            let (v10, v11, v12) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg5, arg4, arg0, true, true, 0x2::coin::value<T1>(&v9), inf_limit(true));
            let v13 = v12;
            let v14 = 0x2::coin::from_balance<T0>(v11, arg13);
            let v15 = 0x2::coin::value<T0>(&v14);
            let v16 = (((v8 as u128) * 1000000000000 / arg7) as u64);
            assert!(v15 >= v16, 6);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg4, arg0, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v9, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T0>(&v13), arg13)), 0x2::balance::zero<T0>(), v13);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg4, arg1, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T2>(0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T2>(arg3, v8, arg13)), v7);
            let v17 = 0x2::coin::from_balance<T1>(v10, arg13);
            0x2::coin::join<T1>(&mut v17, v9);
            dep_or_destroy<T0>(arg2, v14);
            dep_or_destroy<T2>(arg3, 0x2::coin::from_balance<T2>(v5, arg13));
            send_or_destroy<T1>(v17, arg13);
            (v8, v15, v16)
        } else {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg5, arg4, arg0, false, true, v0, inf_limit(false));
            let v21 = v20;
            let v22 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T0>(&v21);
            assert!(v22 <= arg9, 5);
            let v23 = 0x2::coin::from_balance<T1>(v18, arg13);
            let (v24, v25, v26) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg5, arg4, arg1, true, true, 0x2::coin::value<T1>(&v23), inf_limit(true));
            let v27 = v26;
            let v28 = 0x2::coin::from_balance<T2>(v25, arg13);
            let v29 = 0x2::coin::value<T2>(&v28);
            let v30 = (((v22 as u128) * arg7 / 1000000000000) as u64);
            assert!(v29 >= v30, 6);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg4, arg1, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v23, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T2>(&v27), arg13)), 0x2::balance::zero<T2>(), v27);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg4, arg0, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T0>(arg2, v22, arg13)), v21);
            let v31 = 0x2::coin::from_balance<T1>(v24, arg13);
            0x2::coin::join<T1>(&mut v31, v23);
            dep_or_destroy<T0>(arg2, 0x2::coin::from_balance<T0>(v19, arg13));
            dep_or_destroy<T2>(arg3, v28);
            send_or_destroy<T1>(v31, arg13);
            (v22, v29, v30)
        }
    }

    fun sw2_ba_cb<T0, T1, T2>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg3: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &0x2::clock::Clock, arg6: bool, arg7: u128, arg8: u64, arg9: u64, arg10: u8, arg11: u8, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        assert!(arg7 > 0, 7);
        if (!pk(route_px_ba_cb<T0, T1, T2>(arg0, arg1), arg7, arg6)) {
            return (0, 0, 0)
        };
        let v0 = op2_ba_cb<T0, T1, T2>(arg0, arg1, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        if (v0 < arg8) {
            return (0, 0, 0)
        };
        if (arg6) {
            let (v4, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg5, arg4, arg1, true, true, v0, inf_limit(true));
            let v7 = v6;
            let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T1>(&v7);
            assert!(v8 <= arg9, 5);
            let v9 = 0x2::coin::from_balance<T1>(v5, arg13);
            let (v10, v11, v12) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg5, arg4, arg0, true, true, 0x2::coin::value<T1>(&v9), inf_limit(true));
            let v13 = v12;
            let v14 = 0x2::coin::from_balance<T0>(v11, arg13);
            let v15 = 0x2::coin::value<T0>(&v14);
            let v16 = (((v8 as u128) * 1000000000000 / arg7) as u64);
            assert!(v15 >= v16, 6);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg4, arg0, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v9, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T0>(&v13), arg13)), 0x2::balance::zero<T0>(), v13);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg4, arg1, 0x2::coin::into_balance<T2>(0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T2>(arg3, v8, arg13)), 0x2::balance::zero<T1>(), v7);
            let v17 = 0x2::coin::from_balance<T1>(v10, arg13);
            0x2::coin::join<T1>(&mut v17, v9);
            dep_or_destroy<T0>(arg2, v14);
            dep_or_destroy<T2>(arg3, 0x2::coin::from_balance<T2>(v4, arg13));
            send_or_destroy<T1>(v17, arg13);
            (v8, v15, v16)
        } else {
            let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg5, arg4, arg0, false, true, v0, inf_limit(false));
            let v21 = v20;
            let v22 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T0>(&v21);
            assert!(v22 <= arg9, 5);
            let v23 = 0x2::coin::from_balance<T1>(v18, arg13);
            let (v24, v25, v26) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg5, arg4, arg1, false, true, 0x2::coin::value<T1>(&v23), inf_limit(false));
            let v27 = v26;
            let v28 = 0x2::coin::from_balance<T2>(v24, arg13);
            let v29 = 0x2::coin::value<T2>(&v28);
            let v30 = (((v22 as u128) * arg7 / 1000000000000) as u64);
            assert!(v29 >= v30, 6);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg4, arg1, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v23, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T1>(&v27), arg13)), v27);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg4, arg0, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T0>(arg2, v22, arg13)), v21);
            let v31 = 0x2::coin::from_balance<T1>(v25, arg13);
            0x2::coin::join<T1>(&mut v31, v23);
            dep_or_destroy<T0>(arg2, 0x2::coin::from_balance<T0>(v19, arg13));
            dep_or_destroy<T2>(arg3, v28);
            send_or_destroy<T1>(v31, arg13);
            (v22, v29, v30)
        }
    }

    // decompiled from Move bytecode v6
}

