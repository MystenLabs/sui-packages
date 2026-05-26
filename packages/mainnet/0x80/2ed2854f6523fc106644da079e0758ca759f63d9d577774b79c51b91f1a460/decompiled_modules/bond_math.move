module 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::bond_math {
    public fun calculate_bond_price(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::math::mul_div_u128((arg0 as u128) * (arg1 as u128), (arg2 as u128), (100000000 as u128)) as u64)
    }

    public fun calculate_debt_ratio(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > 0, 1);
        0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::math::mul_div_u64(arg0, arg2, arg1)
    }

    public fun calculate_decay(arg0: u128, arg1: u64, arg2: u64) : u128 {
        if (arg2 == 0) {
            return arg0
        };
        if (arg1 >= arg2) {
            return arg0
        };
        let v0 = 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::math::mul_div_u128(arg0, (arg1 as u128), (arg2 as u128));
        let v1 = 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::math::mul_div_u128(arg0, 90, 100);
        if (v0 > v1) {
            v1
        } else {
            v0
        }
    }

    public fun calculate_fee(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 1000000, 3);
        let v0 = 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::math::mul_div_rounding_up_u64(arg0, arg1, 1000000);
        if (v0 > 0 && v0 < 1) {
            1
        } else {
            v0
        }
    }

    public fun calculate_fee_u128(arg0: u128, arg1: u64) : u128 {
        assert!(arg1 <= 1000000, 3);
        0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::math::mul_div_rounding_up_u128(arg0, (arg1 as u128), (1000000 as u128))
    }

    public fun calculate_linear_vesting(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg3 <= arg1) {
            return 0
        };
        let v0 = arg3 - arg1;
        if (v0 >= arg2) {
            return arg0
        };
        0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::math::mul_div_u64(arg0, v0, arg2)
    }

    public fun calculate_max_bcv_decrease(arg0: u64) : u64 {
        let v0 = percentage_of(arg0, 100000);
        if (v0 == 0) {
            1
        } else {
            v0
        }
    }

    public fun calculate_max_bcv_increase(arg0: u64) : u64 {
        let v0 = percentage_of(arg0, 300000);
        if (v0 == 0) {
            1
        } else {
            v0
        }
    }

    public fun calculate_payout(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > 0, 1);
        let v0 = if (arg2 == 1) {
            arg0 / arg1
        } else {
            0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::math::mul_div_u64(arg0, arg2, arg1)
        };
        assert!(v0 > 0 || arg0 == 0, 4);
        v0
    }

    public fun calculate_true_price(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 < 1000000, 3);
        let v0 = 1000000 - arg1;
        assert!(v0 > 0, 1);
        0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::math::mul_div_rounding_up_u64(arg0, 1000000, v0)
    }

    public fun is_within_bounds(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg0 >= arg1 && arg0 <= arg2
    }

    public fun max(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun percentage_base() : u64 {
        1000000
    }

    public fun percentage_of(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 1000000, 3);
        0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::math::mul_div_u64(arg0, arg1, 1000000)
    }

    public fun percentage_of_up(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 1000000, 3);
        0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::math::mul_div_rounding_up_u64(arg0, arg1, 1000000)
    }

    public fun price_decimals() : u64 {
        100000000
    }

    // decompiled from Move bytecode v7
}

