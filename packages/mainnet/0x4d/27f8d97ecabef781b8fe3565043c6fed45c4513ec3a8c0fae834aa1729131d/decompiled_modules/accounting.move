module 0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::accounting {
    public fun assert_exit_minimum(arg0: u64, arg1: u64, arg2: u64, arg3: u256, arg4: u256) {
        let v0 = if (arg2 > 0) {
            if (arg0 <= arg1) {
                arg1 % arg2 == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        if (arg1 == 0) {
            assert!(arg0 == 0, 0);
            return
        };
        assert!(arg0 > 0 && arg0 % arg2 == 0, 0);
        if (arg0 == arg1) {
            return
        };
        assert_order_minimum(arg0, arg2, arg3, arg4);
        assert_order_minimum(arg1 - arg0, arg2, arg3, arg4);
    }

    public fun assert_order_minimum(arg0: u64, arg1: u64, arg2: u256, arg3: u256) {
        assert!(arg0 >= order_minimum(arg1, arg2, arg3) && arg0 % arg1 == 0, 0);
    }

    public fun assert_units(arg0: u64, arg1: u64) {
        assert!((arg0 as u128) == (arg1 as u128) * 1000, 3);
    }

    public fun close_size(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = if (arg1 > 0) {
            if (arg1 <= arg2) {
                arg3 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        assert!(arg0 > 0 && arg0 % arg3 == 0, 3);
        let v1 = (arg0 as u128) * (arg1 as u128);
        let v2 = (arg2 as u128) * (arg3 as u128);
        assert!(v1 % v2 == 0, 3);
        ((v1 / v2 * (arg3 as u128)) as u64)
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0);
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun order_minimum(arg0: u64, arg1: u256, arg2: u256) : u64 {
        let v0 = 340282366920938463463374607431768211455;
        let v1 = if (arg0 > 0) {
            if (arg1 > 0) {
                if (arg1 <= v0) {
                    arg2 <= v0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 0);
        let v2 = arg2 * 1000000000;
        let v3 = if (v2 % arg1 > 0) {
            1
        } else {
            0
        };
        let v4 = v2 / arg1 + v3;
        let v5 = if (v4 % (arg0 as u256) > 0) {
            1
        } else {
            0
        };
        let v6 = v4 / (arg0 as u256) + v5;
        let v7 = if (v6 == 0) {
            1
        } else {
            v6
        };
        ((v7 * (arg0 as u256)) as u64)
    }

    public fun redeem_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        assert!(arg1 > 0 && arg1 <= arg0, 0);
        let v0 = arg2 - mul_div(arg2, arg1, arg0);
        assert!(arg3 > v0, 1);
        let v1 = arg3 - v0;
        assert!(v1 >= arg4, 2);
        v1
    }

    public fun redemption_amounts(arg0: u64, arg1: u64) : (u64, u64) {
        assert!(arg0 > 0, 0);
        let v0 = arg0 / 400;
        let v1 = arg0 - v0;
        assert!(v1 >= arg1, 2);
        (v1, v0)
    }

    public fun unit_base(arg0: u64) : u64 {
        assert!(arg0 > 0, 0);
        (((arg0 as u128) * 1000) as u64)
    }

    public fun unit_entry_equity(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg0 > 0) {
            if (arg1 > 0) {
                arg2 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        ((((arg1 as u128) * (arg2 as u128) + (arg0 as u128) - 1) / (arg0 as u128)) as u64)
    }

    public fun unit_mint(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 > 0 && arg0 % 1000 == 0, 0);
        let v0 = arg0 / 1000;
        assert!(v0 >= arg1, 2);
        v0
    }

    public fun unit_step(arg0: u64) : u64 {
        assert!(arg0 > 0, 0);
        let v0 = 1000;
        while (v0 > 0) {
            v0 = arg0 % v0;
        };
        (((arg0 as u128) / (arg0 as u128) * 1000) as u64)
    }

    // decompiled from Move bytecode v7
}

