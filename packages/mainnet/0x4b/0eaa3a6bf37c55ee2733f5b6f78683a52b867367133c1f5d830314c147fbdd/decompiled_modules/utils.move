module 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::utils {
    public fun assert_lp_amount_is_increased(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!((arg0 as u128) * (arg1 as u128) < (arg2 as u128) * (arg3 as u128), 3);
    }

    public fun calc_optimal_coin_values(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64) {
        if (arg4 == 0 && arg5 == 0) {
            return (arg0, arg1)
        };
        let v0 = 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::math::mul_div_u64(arg0, arg5, arg4);
        if (v0 <= arg1) {
            assert!(v0 >= arg3, 2);
            return (arg0, v0)
        };
        let v1 = 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::math::mul_div_u64(arg1, arg4, arg5);
        assert!(v1 <= arg0, 0);
        assert!(v1 >= arg2, 1);
        (v1, arg1)
    }

    public fun get_amount_in(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg0 > 0, 4);
        assert!(arg1 > 0 && arg2 > 0, 5);
        (((arg1 as u128) * (arg0 as u128) * (10000 as u128) / ((arg2 - arg0) as u128) * ((10000 - arg3) as u128) + 1) as u64)
    }

    public fun get_amount_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg0 > 0, 4);
        assert!(arg1 > 0 && arg2 > 0, 5);
        let v0 = (arg0 as u128) * ((10000 - arg3) as u128);
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::math::mul_div_u128(v0, (arg2 as u128), (arg1 as u128) * (10000 as u128) + v0)
    }

    public fun get_fee_to_fundation(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::math::mul_div_u64(arg0, arg1 * arg2 / 100, 10000)
    }

    // decompiled from Move bytecode v6
}

