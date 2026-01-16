module 0xfc783d9610c4900a5bab9fe10716a7a8a1b2ec6c39f30c1a1a9adb6d9e9ed523::db {
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

    public fun bt<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg3: &0x2::clock::Clock, arg4: vector<u128>, arg5: vector<u64>, arg6: vector<u64>, arg7: u64, arg8: vector<u128>, arg9: vector<u64>, arg10: vector<u64>, arg11: u64, arg12: u8, arg13: u8, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u128>(&arg4) == 0x1::vector::length<u64>(&arg5), 4);
        assert!(0x1::vector::length<u128>(&arg4) == 0x1::vector::length<u64>(&arg6), 4);
        assert!(0x1::vector::length<u128>(&arg8) == 0x1::vector::length<u64>(&arg9), 4);
        assert!(0x1::vector::length<u128>(&arg8) == 0x1::vector::length<u64>(&arg10), 4);
        let v0 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T0>(arg1);
        let v1 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T1>(arg2);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        while (v8 < (0x1::vector::length<u128>(&arg4) as u64)) {
            let v9 = *0x1::vector::borrow<u64>(&arg5, v8);
            let v10 = if (v9 > v1) {
                v1
            } else {
                v9
            };
            if (v10 < arg7) {
                break
            };
            let (v11, v12) = sw<T0, T1>(arg0, arg1, arg2, arg3, *0x1::vector::borrow<u128>(&arg4, v8), true, arg7, v10, arg12, arg13, *0x1::vector::borrow<u64>(&arg6, v8), arg14);
            if (v11 == 0 || v12 == 0) {
                break
            };
            v2 = v2 + 1;
            v4 = v4 + v11;
            v5 = v5 + v12;
            v1 = v1 - v11;
            v0 = v0 + v12;
            v8 = v8 + 1;
        };
        v8 = 0;
        while (v8 < (0x1::vector::length<u128>(&arg8) as u64)) {
            let v13 = *0x1::vector::borrow<u64>(&arg9, v8);
            let v14 = if (v13 > v0) {
                v0
            } else {
                v13
            };
            if (v14 < arg11) {
                break
            };
            let (v15, v16) = sw<T0, T1>(arg0, arg1, arg2, arg3, *0x1::vector::borrow<u128>(&arg8, v8), false, arg11, v14, arg12, arg13, *0x1::vector::borrow<u64>(&arg10, v8), arg14);
            if (v15 == 0 || v16 == 0) {
                break
            };
            v3 = v3 + 1;
            v6 = v6 + v15;
            v7 = v7 + v16;
            v0 = v0 - v15;
            v1 = v1 + v16;
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
        let (v0, v1) = if (arg2) {
            let (v2, v3, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg0, arg1, arg4);
            (v2, v3)
        } else {
            let (v5, v6, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg0, arg1, arg4);
            (v5, v6)
        };
        let v8 = if (arg2) {
            v0
        } else {
            v1
        };
        if (v8 == 0) {
            return (0, 0, true)
        };
        let v9 = if (arg2) {
            (arg1 as u128) * 1000000000000 / (v8 as u128) + 1
        } else {
            (v8 as u128) * 1000000000000 / (arg1 as u128)
        };
        (arg1, v9, !pk(v9, arg3, arg2))
    }

    fun sp(arg0: u128) : u128 {
        arg0
    }

    fun sw<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg3: &0x2::clock::Clock, arg4: u128, arg5: bool, arg6: u64, arg7: u64, arg8: u8, arg9: u8, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = sp(arg4);
        let v1 = op<T0, T1>(arg0, arg5, v0, arg6, arg7, arg8, arg9, arg10, arg3);
        if (v1 < arg6) {
            return (0, 0)
        };
        if (arg5) {
            let (v4, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T1>(arg2, v1, arg11), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg11), 0, arg3, arg11);
            let v7 = v5;
            let v8 = v4;
            let v9 = v1 - 0x2::coin::value<T1>(&v7);
            let v10 = 0x2::coin::value<T0>(&v8);
            assert!(v9 <= arg7, 5);
            assert!(v10 >= (((v9 as u128) * 1000000000000 / v0) as u64), 6);
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T1>(arg2, v7);
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T0>(arg1, v8);
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v6);
            if (v9 == 0 || v10 == 0) {
                return (0, 0)
            };
            (v9, v10)
        } else {
            let (v11, v12, v13) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T0>(arg1, v1, arg11), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg11), 0, arg3, arg11);
            let v14 = v12;
            let v15 = v11;
            let v16 = v1 - 0x2::coin::value<T0>(&v15);
            let v17 = 0x2::coin::value<T1>(&v14);
            assert!(v16 <= arg7, 5);
            assert!(v17 >= (((v16 as u128) * v0 / 1000000000000) as u64), 6);
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T0>(arg1, v15);
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T1>(arg2, v14);
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v13);
            if (v16 == 0 || v17 == 0) {
                return (0, 0)
            };
            (v16, v17)
        }
    }

    // decompiled from Move bytecode v6
}

