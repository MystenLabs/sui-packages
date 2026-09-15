module 0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::share_math {
    public fun assert_collateral_scaling(arg0: u256) {
        if (arg0 == 1000000000000 || arg0 == 1000000000) {
            return
        };
        assert!(arg0 > 0 && arg0 <= 1000000000000000000, 2);
        while (arg0 > 1) {
            assert!(arg0 % 10 == 0, 2);
            arg0 = arg0 / 10;
        };
    }

    public fun assert_notional_limit(arg0: u256, arg1: u256, arg2: u64) {
        assert!(arg1 > 0 && arg2 > 0, 2);
        assert!(arg0 <= (arg2 as u256) * 1000000000000000000000000000000 / arg1, 3);
    }

    public fun closing_size(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
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

    public fun collateral_to_lend(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg1 <= 4500, 1);
        let v0 = if (arg2 > arg3) {
            arg2 - arg3
        } else {
            0
        };
        0x1::u64::min((((arg0 as u256) * (arg1 as u256) / 10000) as u64), v0)
    }

    public fun collateral_usd_e6(arg0: u64, arg1: u256, arg2: u256, arg3: bool) : u64 {
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

    public fun contribution(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > arg0, 1);
        0x1::u64::min(arg1 - arg0, arg2)
    }

    public fun mint_shares(arg0: u64, arg1: u64, arg2: u64) : u64 {
        mint_shares_scaled(arg0, arg1, arg2, 1000000000000)
    }

    public fun mint_shares_scaled(arg0: u64, arg1: u64, arg2: u64, arg3: u256) : u64 {
        assert!(arg0 > 0, 1);
        let (v0, v1) = virtual_units(arg3);
        let v2 = (arg0 as u256) * ((arg2 as u256) + v0) / ((arg1 as u256) + v1);
        assert!(v2 > 0, 1);
        (v2 as u64)
    }

    public fun order_size(arg0: u64, arg1: u256, arg2: u64) : u64 {
        assert!(arg1 > 0 && arg2 > 0, 2);
        let v0 = (arg2 as u256);
        (((arg0 as u256) * 1000000000000000000000 / arg1 / v0 * v0) as u64)
    }

    public fun redeem_assets(arg0: u64, arg1: u64, arg2: u64) : u64 {
        redeem_assets_scaled(arg0, arg1, arg2, 1000000000000)
    }

    public fun redeem_assets_scaled(arg0: u64, arg1: u64, arg2: u64, arg3: u256) : u64 {
        assert!(arg0 > 0 && arg0 <= arg2, 1);
        let (v0, v1) = virtual_units(arg3);
        (((arg0 as u256) * ((arg1 as u256) + v1) / ((arg2 as u256) + v0)) as u64)
    }

    public fun redemption_payout(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0 && arg0 <= arg1, 1);
        if (arg2 >= arg1) {
            arg0 + arg2 - arg1
        } else {
            let v1 = arg1 - arg2;
            assert!(arg0 > v1, 1);
            arg0 - v1
        }
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

