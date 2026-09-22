module 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::rebalance_math {
    public(friend) fun base_for_notional_down(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        assert!(arg1 > 0 && arg2 > 0, 29);
        assert!(arg3 > 0, 10);
        let v0 = (arg0 as u256) * (arg2 as u256) * (arg4 as u256) / (arg1 as u256) * (arg5 as u256);
        assert!(v0 <= 18446744073709551615, 15);
        (v0 as u64) / arg3 * arg3
    }

    fun execution_cost_up(arg0: u64, arg1: u64, arg2: u64) : u128 {
        assert!(arg1 <= 10000 && arg2 < 10000, 56);
        let v0 = 10000;
        let v1 = 0x1::u128::div_ceil((arg0 as u128) * (arg2 as u128), v0);
        v1 + 0x1::u128::div_ceil(((arg0 as u128) + v1) * (arg1 as u128), v0)
    }

    public(friend) fun increase_base_down(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) : u64 {
        let v0 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math::target_notional_down(arg0, arg2);
        if (v0 <= arg1) {
            return 0
        };
        let v1 = 0;
        let v2 = base_for_notional_down(0x1::u64::min(v0 - arg1, arg6), arg3, arg4, arg5, arg9, arg10) / arg5;
        while (v1 < v2) {
            let v3 = v1 + 0x1::u64::div_ceil(v2 - v1, 2);
            let v4 = oracle_notional_up(v3 * arg5, arg3, arg4, arg9, arg10);
            let v5 = execution_cost_up(v4, arg7, arg8);
            if ((arg0 as u128) > v5 && ((arg1 as u128) + (v4 as u128)) * 10000 <= (arg2 as u128) * ((arg0 as u128) - v5)) {
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

    // decompiled from Move bytecode v7
}

