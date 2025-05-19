module 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::math {
    public fun assert_lp_value_is_increased(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!((arg0 as u128) * (arg1 as u128) <= (arg2 as u128) * (arg3 as u128), 16);
    }

    public fun calc_optimal_coin_values(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64) {
        if (arg4 == 0 && arg5 == 0) {
            (arg0, arg1)
        } else {
            let v2 = mul_div(arg0, arg5, arg4);
            if (v2 <= arg1) {
                assert!(v2 >= arg3, 18);
                (arg0, v2)
            } else {
                let v3 = mul_div(arg1, arg4, arg5);
                assert!(v3 <= arg0, 19);
                assert!(v3 >= arg2, 17);
                (v3, arg1)
            }
        }
    }

    public fun get_amount_in(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg0 <= 2000, 22);
        assert!(arg1 > 0, 20);
        assert!(arg2 > 0 && arg3 > 0, 21);
        let v0 = (arg2 as u256) * (arg1 as u256) * (10000 as u256) / ((arg3 - arg1) as u256) * ((10000 - arg0) as u256) + 1;
        assert!(v0 <= (18446744073709551615 as u256), 15);
        (v0 as u64)
    }

    public fun get_amount_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg0 <= 2000, 22);
        assert!(arg1 > 0, 20);
        assert!(arg2 > 0 && arg3 > 0, 21);
        let v0 = (arg1 as u256) * ((10000 - arg0) as u256);
        let v1 = v0 * (arg3 as u256) / ((arg2 as u256) * (10000 as u256) + v0);
        assert!(v1 <= (18446744073709551615 as u256), 15);
        (v1 as u64)
    }

    public fun get_fee_to_team(arg0: u64, arg1: u64) : u64 {
        mul_div(arg1, arg0, 10000) / 5
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 14);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(!(v0 > (18446744073709551615 as u128)), 15);
        (v0 as u64)
    }

    public fun mul_to_u128(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    public fun sqrt(arg0: u128) : u64 {
        if (arg0 < 4) {
            if (arg0 == 0) {
                0
            } else {
                1
            }
        } else {
            let v1 = arg0 / 2 + 1;
            while (v1 < arg0) {
                let v2 = arg0 / v1 + v1;
                v1 = v2 / 2;
            };
            (arg0 as u64)
        }
    }

    // decompiled from Move bytecode v6
}

