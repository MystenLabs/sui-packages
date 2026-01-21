module 0x4efb1dac508823469be7179b94db134d8e36fdce4fa2cd81e023f95b5baee784::dbs {
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

    public fun bt<T0, T1>(arg0: &mut 0x951a01360d85b06722edf896852bf8005b81cdb26375235c935138987f629502::sponsored::Fund, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg3: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg4: &0x2::clock::Clock, arg5: vector<u128>, arg6: vector<u64>, arg7: vector<u64>, arg8: u64, arg9: vector<u128>, arg10: vector<u64>, arg11: vector<u64>, arg12: u64, arg13: u8, arg14: u8, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u128>(&arg5) == 0x1::vector::length<u64>(&arg6), 4);
        assert!(0x1::vector::length<u128>(&arg5) == 0x1::vector::length<u64>(&arg7), 4);
        assert!(0x1::vector::length<u128>(&arg9) == 0x1::vector::length<u64>(&arg10), 4);
        assert!(0x1::vector::length<u128>(&arg9) == 0x1::vector::length<u64>(&arg11), 4);
        let v0 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T0>(arg2);
        let v1 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T1>(arg3);
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
            let v12 = if (v11 > v1) {
                v1
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
            v1 = v1 - v13;
            v0 = v0 + v14;
            v10 = v10 + 1;
        };
        v10 = 0;
        while (v10 < 0x1::vector::length<u128>(&arg9)) {
            let v16 = *0x1::vector::borrow<u64>(&arg10, v10);
            let v17 = if (v16 > v0) {
                v0
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
            v0 = v0 - v18;
            v1 = v1 + v19;
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

    fun op<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: u128, arg3: u64, arg4: u64, arg5: u8, arg6: u8, arg7: u64, arg8: &0x2::clock::Clock) : u64 {
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
            let (v4, _, v6) = sm<T0, T1>(arg0, v2, arg1, arg2, arg8);
            if (v6) {
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
            let (v8, _, v10) = sm<T0, T1>(arg0, v7, arg1, arg2, arg8);
            if (!v10) {
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

    fun sm<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: bool, arg3: u128, arg4: &0x2::clock::Clock) : (u64, u128, bool) {
        if (arg1 == 0) {
            return (0, 0, true)
        };
        let v0 = if (arg2) {
            0
        } else {
            arg1
        };
        let v1 = if (arg2) {
            arg1
        } else {
            0
        };
        let (v2, v3, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg0, v0, v1, arg4);
        let v5 = if (arg2) {
            v2
        } else {
            v3
        };
        if (v5 == 0) {
            return (0, 0, true)
        };
        let v6 = if (arg2) {
            (arg1 as u128) * 1000000000000 / (v5 as u128) + 1
        } else {
            (v5 as u128) * 1000000000000 / (arg1 as u128)
        };
        (arg1, v6, !pk(v6, arg3, arg2))
    }

    fun sp(arg0: u128) : u128 {
        arg0
    }

    fun sw<T0, T1>(arg0: &mut 0x951a01360d85b06722edf896852bf8005b81cdb26375235c935138987f629502::sponsored::Fund, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg3: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg4: &0x2::clock::Clock, arg5: u128, arg6: bool, arg7: u64, arg8: u64, arg9: u8, arg10: u8, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = sp(arg5);
        let v1 = op<T0, T1>(arg1, arg6, v0, arg7, arg8, arg9, arg10, arg11, arg4);
        if (v1 < arg7) {
            return (0, 0, 0)
        };
        if (arg6) {
            let (v5, v6) = 0x951a01360d85b06722edf896852bf8005b81cdb26375235c935138987f629502::sponsored::swap_exact_quote_for_base<T0, T1>(arg0, arg1, 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T1>(arg3, v1, arg12), 0, arg4, arg12);
            let v7 = v6;
            let v8 = v5;
            let v9 = v1 - 0x2::coin::value<T1>(&v7);
            let v10 = 0x2::coin::value<T0>(&v8);
            assert!(v9 <= arg8, 5);
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T1>(arg3, v7);
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T0>(arg2, v8);
            if (v9 == 0 || v10 == 0) {
                return (0, 0, 0)
            };
            let v11 = imo(v9, v0, true);
            assert!(v10 >= v11, 6);
            (v9, v10, v11)
        } else {
            let (v12, v13) = 0x951a01360d85b06722edf896852bf8005b81cdb26375235c935138987f629502::sponsored::swap_exact_base_for_quote<T0, T1>(arg0, arg1, 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T0>(arg2, v1, arg12), 0, arg4, arg12);
            let v14 = v13;
            let v15 = v12;
            let v16 = v1 - 0x2::coin::value<T0>(&v15);
            let v17 = 0x2::coin::value<T1>(&v14);
            assert!(v16 <= arg8, 5);
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T0>(arg2, v15);
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T1>(arg3, v14);
            if (v16 == 0 || v17 == 0) {
                return (0, 0, 0)
            };
            let v18 = imo(v16, v0, false);
            assert!(v17 >= v18, 6);
            (v16, v17, v18)
        }
    }

    // decompiled from Move bytecode v6
}

