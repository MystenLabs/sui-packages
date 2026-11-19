module 0x7079054a36a798711f2f4f1531fec9c0309c2f7e9bac7e618f219cc4a3d4ecb6::sizer {
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
            18446744073709551615
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
            18446744073709551615
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
            18446744073709551615
        } else {
            (v5 as u64)
        }
    }

    public fun compute_virtual_quote_reserve(arg0: u128, arg1: u128, arg2: bool) : u128 {
        assert!(arg0 > 0 && arg1 > 0, 1001);
        let v0 = if (arg2) {
            ((arg1 as u256) << 64) / (arg0 as u256)
        } else {
            (arg1 as u256) * (arg0 as u256) >> 64
        };
        assert!(v0 > 0, 1001);
        let v1 = 340282366920938463463374607431768211455;
        if (v0 > v1) {
            (v1 as u128)
        } else {
            (v0 as u128)
        }
    }

    // decompiled from Move bytecode v7
}

