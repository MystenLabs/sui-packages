module 0x753600f7cb9c88fe04ba97f23b82fd1912ff954a90607b898e0f54ceee45de59::lev_math {
    public(friend) fun assert_collateral_scaling(arg0: u256) {
        if (arg0 == 1000000000000 || arg0 == 1000000000) {
            return
        };
        assert!(arg0 > 0 && arg0 <= 1000000000000000000, 2);
        while (arg0 > 1) {
            assert!(arg0 % 10 == 0, 2);
            arg0 = arg0 / 10;
        };
    }

    public(friend) fun assert_notional_limit(arg0: u256, arg1: u256, arg2: u64) {
        assert!(arg1 > 0 && arg2 > 0, 2);
        assert!(arg0 <= (arg2 as u256) * 1000000000000000000000000000000 / arg1, 3);
    }

    public(friend) fun bps() : u64 {
        10000
    }

    public(friend) fun closing_size(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = if (arg1 > 0) {
            if (arg1 <= arg2) {
                arg3 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        let v1 = (arg2 as u256) * (arg3 as u256);
        ((0x1::u256::min(((arg0 as u256) * (arg1 as u256) + v1 - 1) / v1, ((arg0 / arg3) as u256)) * (arg3 as u256)) as u64)
    }

    public(friend) fun collateral_usd_e6(arg0: u64, arg1: u256, arg2: u256, arg3: bool) : u64 {
        assert_collateral_scaling(arg2);
        assert!(arg1 > 0 && arg1 < 57896044618658097711785492504343953926634992332820282019728792003956564819968, 2);
        let v0 = (arg0 as u256) * arg2 * arg1;
        let v1 = 1000000000000000000000000000000;
        let v2 = if (arg3 && v0 % v1 > 0) {
            1
        } else {
            0
        };
        ((v0 / v1 + v2) as u64)
    }

    public(friend) fun contribution(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > arg0, 1);
        0x1::u64::min(arg1 - arg0, arg2)
    }

    public(friend) fun distance(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public(friend) fun leverage_bps(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return if (arg0 == 0) {
                0
            } else {
                18446744073709551615
            }
        };
        let v1 = (arg0 as u128) * (10000 as u128) / (arg1 as u128);
        if (v1 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v1 as u64)
        }
    }

    public(friend) fun limit_price(arg0: u256, arg1: u64, arg2: bool, arg3: u64) : u64 {
        let v0 = if (arg0 > 0) {
            if (arg3 > 0) {
                arg1 < 10000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        let v1 = (arg3 as u256);
        let v2 = if (arg2) {
            arg0 / 1000000000 * ((10000 + arg1) as u256) / (10000 as u256)
        } else {
            (arg0 / 1000000000 * ((10000 - arg1) as u256) + (10000 as u256) - 1) / (10000 as u256)
        };
        let v3 = if (arg2) {
            v2 / v1 * v1
        } else {
            (v2 + v1 - 1) / v1 * v1
        };
        assert!(v3 > 0 && v3 <= 18446744073709551615, 2);
        (v3 as u64)
    }

    public(friend) fun mint_shares(arg0: u64, arg1: u64, arg2: u64, arg3: u256) : u64 {
        assert!(arg0 > 0, 1);
        let (v0, v1) = virtual_units(arg3);
        let v2 = (arg0 as u256) * ((arg2 as u256) + v0) / ((arg1 as u256) + v1);
        assert!(v2 > 0 && v2 <= 18446744073709551615, 1);
        (v2 as u64)
    }

    public(friend) fun notional_usd_e6(arg0: u256, arg1: u256) : u64 {
        ((arg0 * arg1 / 1000000000000000000000000000000) as u64)
    }

    public(friend) fun order_size(arg0: u64, arg1: u256, arg2: u64) : u64 {
        assert!(arg1 > 0 && arg2 > 0, 2);
        let v0 = (arg2 as u256);
        let v1 = 18446744073709551615 / v0 * v0;
        let v2 = (arg0 as u256) * 1000000000000000000000 / arg1 / v0 * v0;
        let v3 = if (v2 > v1) {
            v1
        } else {
            v2
        };
        (v3 as u64)
    }

    public(friend) fun portion(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public(friend) fun position_ratio_bps(arg0: u64) : u64 {
        assert!(arg0 >= 10000, 1);
        (((10000 as u128) * (10000 as u128) / (arg0 as u128)) as u64)
    }

    public(friend) fun redeem_assets(arg0: u64, arg1: u64, arg2: u64, arg3: u256) : u64 {
        assert!(arg0 > 0 && arg0 <= arg2, 1);
        let (v0, v1) = virtual_units(arg3);
        (((arg0 as u256) * ((arg1 as u256) + v1) / ((arg2 as u256) + v0)) as u64)
    }

    public(friend) fun redemption_payout(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0 && arg0 <= arg1, 1);
        if (arg2 >= arg1) {
            arg0 + arg2 - arg1
        } else {
            let v1 = arg1 - arg2;
            assert!(arg0 > v1, 1);
            arg0 - v1
        }
    }

    public(friend) fun share_payout(arg0: u64, arg1: u64, arg2: u64, arg3: u256, arg4: u256) : u64 {
        let v0 = if (arg2 <= arg1) {
            true
        } else if (arg4 == 0) {
            true
        } else {
            arg3 >= arg4
        };
        if (v0) {
            return redemption_payout(arg0, arg1, arg2)
        };
        redemption_payout(arg0, arg1, arg1 + ((((arg2 - arg1) as u256) * arg3 / arg4) as u64))
    }

    public(friend) fun streaming_fee_shares(arg0: u64, arg1: u128) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = (10000 as u256) * (31536000000 as u256);
        let v1 = 0x1::u256::min((arg1 as u256), v0 / 2);
        (((arg0 as u256) * v1 / (v0 - v1)) as u64)
    }

    public(friend) fun target_notional(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public(friend) fun token_price(arg0: u64, arg1: u64, arg2: u256) : u64 {
        let (v0, v1) = virtual_units(arg2);
        ((1000000000 * ((arg0 as u256) + v1) / ((arg1 as u256) + v0)) as u64)
    }

    fun virtual_units(arg0: u256) : (u256, u256) {
        assert_collateral_scaling(arg0);
        if (arg0 >= 1000000000) {
            (arg0 / 1000000000, 1)
        } else {
            (1, 1000000000 / arg0)
        }
    }

    // decompiled from Move bytecode v7
}

