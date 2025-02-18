module 0x8f19f70c0ce1f69c5533e1e981b5b0342b309cb1d324ee6b0d5e9b969d1cc639::pool_math {
    public(friend) fun assert_lp_supply_reserve_ratio(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!((arg2 as u128) * (arg1 as u128) >= (arg0 as u128) * (arg3 as u128), 3);
    }

    fun lp_tokens_to_mint(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        if (arg2 == 0) {
            if (arg4 == 0) {
                return arg3
            };
            (0x1::u128::sqrt((arg3 as u128) * (arg4 as u128)) as u64)
        } else if (arg1 == 0) {
            0x8f19f70c0ce1f69c5533e1e981b5b0342b309cb1d324ee6b0d5e9b969d1cc639::math::safe_mul_div(arg3, arg2, arg0)
        } else {
            0x1::u64::min(0x8f19f70c0ce1f69c5533e1e981b5b0342b309cb1d324ee6b0d5e9b969d1cc639::math::safe_mul_div(arg3, arg2, arg0), 0x8f19f70c0ce1f69c5533e1e981b5b0342b309cb1d324ee6b0d5e9b969d1cc639::math::safe_mul_div(arg4, arg2, arg1))
        }
    }

    public(friend) fun quote_deposit(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64, u64) {
        let (v0, v1) = tokens_to_deposit(arg0, arg1, arg3, arg4);
        (v0, v1, lp_tokens_to_mint(arg0, arg1, arg2, v0, v1))
    }

    public(friend) fun quote_redeem(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64) {
        let v0 = 0x8f19f70c0ce1f69c5533e1e981b5b0342b309cb1d324ee6b0d5e9b969d1cc639::math::safe_mul_div(arg0, arg3, arg2);
        let v1 = 0x8f19f70c0ce1f69c5533e1e981b5b0342b309cb1d324ee6b0d5e9b969d1cc639::math::safe_mul_div(arg1, arg3, arg2);
        assert!(v0 >= arg4, 1);
        assert!(v1 >= arg5, 2);
        (v0, v1)
    }

    fun tokens_to_deposit(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        assert!(arg2 > 0, 4);
        if (arg0 == 0 && arg1 == 0) {
            (arg2, arg3)
        } else {
            let v2 = 0x8f19f70c0ce1f69c5533e1e981b5b0342b309cb1d324ee6b0d5e9b969d1cc639::math::safe_mul_div_up(arg2, arg1, arg0);
            if (v2 <= arg3) {
                (arg2, v2)
            } else {
                let v3 = 0x8f19f70c0ce1f69c5533e1e981b5b0342b309cb1d324ee6b0d5e9b969d1cc639::math::safe_mul_div_up(arg3, arg0, arg1);
                assert!(v3 > 0, 5);
                assert!(v3 <= arg2, 0);
                (v3, arg3)
            }
        }
    }

    // decompiled from Move bytecode v6
}

