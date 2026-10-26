module 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::rebalance_math {
    public(friend) fun base_for_execution_notional_down(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : u64 {
        assert!(arg1 > 0 && arg2 > 0, 29);
        assert!(arg3 > 0, 10);
        assert!(arg4 < 10000, 32);
        let v0 = 10000;
        (0x1::u256::min((arg0 as u256) * (arg2 as u256) * (arg5 as u256) / ((arg1 as u256) * (v0 + (arg4 as u256)) / v0 + 1) * (arg6 as u256) * (arg3 as u256), ((18446744073709551615 / arg3) as u256)) as u64) * arg3
    }

    public(friend) fun base_for_oracle_notional_down(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        assert!(arg1 > 0 && arg2 > 0, 29);
        assert!(arg3 > 0, 10);
        let v0 = (arg0 as u256) * (arg2 as u256) * (arg4 as u256) / (arg1 as u256) * (arg5 as u256);
        assert!(v0 <= 18446744073709551615, 15);
        (v0 as u64) / arg3 * arg3
    }

    public(friend) fun execution_cost_up(arg0: u64, arg1: u64, arg2: u64) : u128 {
        assert!(arg1 <= 10000 && arg2 < 10000, 56);
        let v0 = 10000;
        let v1 = 0x1::u128::div_ceil((arg0 as u128) * (arg2 as u128), v0);
        v1 + 0x1::u128::div_ceil(((arg0 as u128) + v1) * (arg1 as u128), v0)
    }

    public(friend) fun increase_base_down(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) : u64 {
        assert!(arg0 > 0, 2);
        assert!(arg2 > 0, 9);
        if ((arg0 as u128) * (arg2 as u128) / 10000 <= (arg1 as u128)) {
            return 0
        };
        let v0 = base_for_execution_notional_down(arg6, arg3, arg4, arg5, arg8, arg9, arg10);
        assert!(v0 > 0, 63);
        let v1 = 0;
        let v2 = v0 / arg5;
        while (v1 < v2) {
            let v3 = v1 + 0x1::u64::div_ceil(v2 - v1, 2);
            let v4 = oracle_notional_up(v3 * arg5, arg3, arg4, arg9, arg10);
            let v5 = execution_cost_up(v4, arg7, arg8);
            let v6 = (arg1 as u128) + (v4 as u128);
            let v7 = if (v6 <= 18446744073709551615) {
                if ((arg0 as u128) > v5) {
                    v6 * 10000 <= (arg2 as u128) * ((arg0 as u128) - v5)
                } else {
                    false
                }
            } else {
                false
            };
            if (v7) {
                v1 = v3;
                continue
            };
            v2 = v3 - 1;
        };
        v1 * arg5
    }

    public(friend) fun leverage_rose(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        (arg2 as u128) * (arg1 as u128) > (arg0 as u128) * (arg3 as u128)
    }

    public(friend) fun oracle_notional_up(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        assert!(arg1 > 0 && arg2 > 0, 29);
        let v0 = 0x1::u256::div_ceil((arg0 as u256) * (arg1 as u256) * (arg4 as u256), (arg2 as u256) * (arg3 as u256));
        assert!(v0 <= 18446744073709551615, 15);
        (v0 as u64)
    }

    public(friend) fun reduction_is_sufficient(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : bool {
        assert!(arg1 > 0 && arg3 > 0, 2);
        let v0 = 10000;
        let v1 = (arg1 as u256);
        let v2 = (arg3 as u256);
        let v3 = (arg4 as u256);
        let v4 = 0x1::u256::diff((arg2 as u256) * v0, v3 * v2);
        let v5 = 0x1::u256::diff((arg0 as u256) * v0, v3 * v1) * v2;
        let v6 = v4 * v1;
        v4 <= (arg6 as u256) * v0 && v6 <= v5 || v5 >= v6 + (arg5 as u256) * v1 * v2
    }

    public(friend) fun reduction_matches_capacity(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : bool {
        let v0 = if (arg1 > 0) {
            if (arg3 > 0) {
                arg5 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        let v1 = 10000;
        let v2 = (arg6 as u256);
        let v3 = 0x1::u256::diff((arg0 as u256) * v1, v2 * (arg1 as u256));
        let v4 = 0x1::u256::diff((arg2 as u256) * v1, v2 * (arg3 as u256));
        let v5 = 0x1::u256::diff((arg4 as u256) * v1, v2 * (arg5 as u256));
        if (v5 * (arg1 as u256) < v3 * (arg5 as u256)) {
            if (v4 * (arg1 as u256) < v3 * (arg3 as u256)) {
                v4 * (arg5 as u256) <= v5 * (arg3 as u256)
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v7
}

