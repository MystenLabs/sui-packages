module 0xb340d747c2cbe030e6f15340d00e4fc9d2cdb3de53a822dbb373b5cfe9ac6616::sizer {
    public fun assert_min_profit_after_gas(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg0 > arg1, 1003);
        let v0 = arg0 - arg1;
        assert!(v0 >= arg2 + arg3, 1003);
        v0 - arg2
    }

    public fun compute_clmm_clmm_q_star(arg0: u128, arg1: u128, arg2: bool, arg3: u128, arg4: u128, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: u64) : u64 {
        assert!(arg6 > arg7, 1003);
        let v0 = (compute_virtual_quote_reserve(arg0, arg1, arg2) as u256);
        let v1 = (compute_virtual_quote_reserve(arg3, arg4, arg5) as u256);
        let v2 = v0 + v1;
        assert!(v2 > 0, 1001);
        let v3 = v0 * v1 / v2 * ((arg6 - arg7) as u256) / 20000;
        let v4 = if (v3 > 18446744073709551615) {
            (18446744073709551615 as u64)
        } else {
            (v3 as u64)
        };
        let v5 = v4;
        if (arg8 > 0 && v4 > arg8) {
            v5 = arg8;
        };
        assert!(v5 >= arg9 && v5 > 0, 1004);
        v5
    }

    public fun compute_clmm_clob_q_star(arg0: u128, arg1: u128, arg2: bool, arg3: u64, arg4: u64, arg5: &vector<u64>, arg6: &vector<u64>, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64) : u64 {
        assert!(arg3 > arg4, 1003);
        let v0 = (compute_virtual_quote_reserve(arg0, arg1, arg2) as u256) * ((arg3 - arg4) as u256) / 20000;
        let v1 = if (v0 > 18446744073709551615) {
            (18446744073709551615 as u64)
        } else {
            (v0 as u64)
        };
        let v2 = compute_l2_quote_depth(arg5, arg6, arg7, arg8, arg9);
        let v3 = if (v1 < v2) {
            v1
        } else {
            v2
        };
        let v4 = v3;
        if (arg10 > 0 && v3 > arg10) {
            v4 = arg10;
        };
        assert!(v4 >= arg11 && v4 > 0, 1004);
        v4
    }

    public fun compute_l2_quote_depth(arg0: &vector<u64>, arg1: &vector<u64>, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = 0x1::vector::length<u64>(arg0);
        assert!(v0 == 0x1::vector::length<u64>(arg1), 1002);
        assert!(arg2 > 0 && arg4 > 0, 1002);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = (*0x1::vector::borrow<u64>(arg0, v2) as u256);
            let v4 = (*0x1::vector::borrow<u64>(arg1, v2) as u256);
            if (v3 > 0 && v4 > 0) {
                v1 = v1 + v4 * v3 * (arg3 as u256) / (arg2 as u256) * (arg4 as u256);
            };
            v2 = v2 + 1;
        };
        let v5 = v1 * 85 / 100;
        if (v5 > 18446744073709551615) {
            (18446744073709551615 as u64)
        } else {
            (v5 as u64)
        }
    }

    public fun compute_spot_price_e18(arg0: u128, arg1: bool) : u256 {
        assert!(arg0 > 0, 1001);
        let v0 = (arg0 as u256);
        let v1 = v0 * v0;
        assert!(v1 > 0, 1001);
        let v2 = if (arg1) {
            (1000000000000000000 << 128) / v1
        } else if (v1 <= 115792089237316195423570985008687907853269984665640564039457) {
            v1 * 1000000000000000000 >> 128
        } else {
            (v1 >> 64) * 1000000000000000000 >> 64
        };
        assert!(v2 > 0, 1001);
        v2
    }

    public fun compute_virtual_quote_reserve(arg0: u128, arg1: u128, arg2: bool) : u128 {
        assert!(arg0 > 0 && arg1 > 0, 1001);
        let v0 = if (arg2) {
            ((arg1 as u256) << 64) / (arg0 as u256)
        } else {
            (arg1 as u256) * (arg0 as u256) >> 64
        };
        assert!(v0 > 0, 1001);
        if (v0 > 340282366920938463463374607431768211455) {
            (340282366920938463463374607431768211455 as u128)
        } else {
            (v0 as u128)
        }
    }

    public fun isqrt_u256(arg0: u256) : u256 {
        if (arg0 <= 1) {
            return arg0
        };
        let v0 = arg0 >> 1;
        while (v0 < arg0) {
            let v1 = arg0 / v0 + v0;
            v0 = v1 >> 1;
        };
        arg0
    }

    public fun solve_clmm_clmm_q_star_v2(arg0: u128, arg1: u128, arg2: bool, arg3: u64, arg4: u128, arg5: u128, arg6: bool, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64) : u64 {
        assert!((arg3 as u256) < 1000000 && (arg7 as u256) < 1000000, 1006);
        let v0 = 1000000 - (arg3 as u256);
        let v1 = 1000000 - (arg7 as u256);
        let v2 = compute_spot_price_e18(arg0, arg2);
        let v3 = compute_spot_price_e18(arg4, arg6);
        let v4 = v3 * v0 * v1;
        assert!(v4 > v2 * 1000000 * 1000000, 1003);
        let v5 = isqrt_u256(v4 * 1000000 / v2);
        assert!(v5 > 1000000000, 1003);
        let v6 = (compute_virtual_quote_reserve(arg0, arg1, arg2) as u256);
        let v7 = (compute_virtual_quote_reserve(arg4, arg5, arg6) as u256);
        assert!(v6 > 0 && v7 > 0, 1001);
        let v8 = v6 * v7 / (v6 + v7) * (v5 - 1000000000) * 1000000 / v0 * 1000000000;
        let v9 = v8;
        let v10 = (arg8 as u256);
        if (v10 > 0 && v8 > v10) {
            v9 = v10;
        };
        assert!(v9 > 0, 1004);
        let v11 = if (v9 > 18446744073709551615) {
            (18446744073709551615 as u64)
        } else {
            (v9 as u64)
        };
        assert!(v11 >= arg9 && v11 > 0, 1004);
        let v12 = v0 * v9 / 1000000;
        let v13 = v12 * v6 / (v6 + v12) * 1000000000000000000 / v2;
        assert!(v13 > 0, 1003);
        let v14 = (compute_virtual_quote_reserve(arg4, arg5, !arg6) as u256);
        let v15 = v1 * v13 / 1000000;
        let v16 = v15 * v14 / (v14 + v15) * v3 / 1000000000000000000;
        assert!(v16 > v9, 1003);
        assert!(v16 - v9 >= (arg10 as u256) + (arg11 as u256), 1005);
        v11
    }

    public fun solve_clmm_clob_q_star_v2(arg0: u128, arg1: u128, arg2: bool, arg3: u64, arg4: u64, arg5: bool, arg6: &vector<u64>, arg7: &vector<u64>, arg8: u64, arg9: u64, arg10: u64, arg11: u64) : u64 {
        let v0 = 0x1::vector::length<u64>(arg6);
        assert!(v0 == 0x1::vector::length<u64>(arg7), 1002);
        assert!(v0 > 0, 1002);
        assert!((arg3 as u256) < 1000000 && (arg4 as u256) < 1000000, 1006);
        let v1 = 1000000 - (arg3 as u256);
        let v2 = 1000000 - (arg4 as u256);
        let v3 = compute_spot_price_e18(arg0, arg2);
        let v4 = (arg8 as u256);
        let v5 = 0;
        let v6 = 0;
        let v7 = v6;
        let v8 = 0;
        if (!arg5) {
            let v9 = (compute_virtual_quote_reserve(arg0, arg1, arg2) as u256);
            let v10 = 0;
            while (v10 < v0) {
                let v11 = (*0x1::vector::borrow<u64>(arg6, v10) as u256);
                let v12 = (*0x1::vector::borrow<u64>(arg7, v10) as u256) * 95 / 100;
                v10 = v10 + 1;
                if (v11 == 0 || v12 == 0) {
                    continue
                };
                let v13 = v11 * v1 * v2;
                if (v13 <= v3 * 1000) {
                    break
                };
                let v14 = isqrt_u256(v13 * 1000000000000000 / v3);
                if (v14 <= 1000000000) {
                    break
                };
                let v15 = v9 * (v14 - 1000000000) * 1000000 / v1 * 1000000000;
                let v16 = if (v4 > 0 && v15 > v4) {
                    v4
                } else {
                    v15
                };
                if (v16 <= v5) {
                    break
                };
                let v17 = v1 * v16 / 1000000;
                let v18 = v17 * v9 / (v9 + v17) * 1000000000000000000 / v3;
                if (v18 <= v7) {
                    break
                };
                let v19 = v18 - v7;
                if (v19 <= v12) {
                    v5 = v16;
                    v8 = v8 + v19 * v11 * v2 / 1000000000 * 1000000;
                    break
                };
                let v20 = v7 + v12;
                let v21 = v20 * v3 / 1000000000000000000;
                if (v21 >= v9) {
                    break
                };
                let v22 = v21 * v9 * 1000000 / v1 * (v9 - v21);
                if (v4 > 0 && v22 > v4) {
                    let v23 = v1 * v4 / 1000000;
                    let v24 = v23 * v9 / (v9 + v23) * 1000000000000000000 / v3;
                    if (v24 > v6) {
                        v5 = v4;
                        v8 = v8 + (v24 - v6) * v11 * v2 / 1000000000 * 1000000;
                        break
                    } else {
                        break
                    };
                };
                v5 = v22;
                v7 = v20;
                v8 = v8 + v12 * v11 * v2 / 1000000000 * 1000000;
            };
        } else {
            let v25 = (compute_virtual_quote_reserve(arg0, arg1, !arg2) as u256);
            let v26 = 0;
            while (v26 < v0) {
                let v27 = (*0x1::vector::borrow<u64>(arg6, v26) as u256);
                let v28 = (*0x1::vector::borrow<u64>(arg7, v26) as u256) * 95 / 100;
                v26 = v26 + 1;
                if (v27 == 0 || v28 == 0) {
                    continue
                };
                let v29 = v3 * v1 * v2;
                if (v29 <= v27 * 1000000000000000000000) {
                    break
                };
                let v30 = isqrt_u256(v29 / v27 * 1000);
                if (v30 <= 1000000000) {
                    break
                };
                let v31 = v25 * (v30 - 1000000000) * 1000000 / v1 * 1000000000;
                if (v31 <= v7) {
                    break
                };
                let v32 = v31 - v7;
                let v33 = if (v32 < v28) {
                    v32
                } else {
                    v28
                };
                let v34 = v33;
                let v35 = v33 * v27 * 1000000 / v2 * 1000000000;
                let v36 = v35;
                if (v4 > 0 && v5 + v35 > v4) {
                    let v37 = v4 - v5;
                    v34 = v37 * v2 * 1000000000 / v27 * 1000000;
                    v36 = v37;
                };
                if (v34 == 0 || v36 == 0) {
                    break
                };
                let v38 = v5 + v36;
                v5 = v38;
                v7 = v7 + v34;
                if (v34 < v28 || v4 > 0 && v38 >= v4) {
                    break
                };
            };
            if (v7 > 0) {
                let v39 = v1 * v7 / 1000000;
                v8 = v39 * v25 / (v25 + v39) * v3 / 1000000000000000000;
            };
        };
        assert!(v5 > 0, 1003);
        let v40 = if (v5 > 18446744073709551615) {
            (18446744073709551615 as u64)
        } else {
            (v5 as u64)
        };
        assert!(v40 >= arg9 && v40 > 0, 1004);
        assert!(v8 > v5, 1003);
        assert!(v8 - v5 >= (arg10 as u256) + (arg11 as u256), 1005);
        v40
    }

    // decompiled from Move bytecode v7
}

