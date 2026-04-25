module 0x4489b5ca0897e4c5d720a23ab6f6b5c6fd92b0b9595414952eef7dee3174a444::sui_math {
    public fun abs_diff(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public fun calculate_buy_price_capped(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x4489b5ca0897e4c5d720a23ab6f6b5c6fd92b0b9595414952eef7dee3174a444::sui_types::bps();
        min(arg0, mul_div(arg1, v0 + arg2, v0))
    }

    public fun calculate_days_held(arg0: u64, arg1: u64) : u64 {
        if (arg1 <= arg0) {
            return 0
        };
        (arg1 - arg0) / 86400
    }

    public fun calculate_effective_bc_virtual(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = 0x4489b5ca0897e4c5d720a23ab6f6b5c6fd92b0b9595414952eef7dee3174a444::sui_types::bps();
        if (arg2 == 0 || arg0 == 0) {
            return arg1
        };
        let v1 = if (arg0 >= arg2 * 2) {
            v0
        } else if (arg0 <= arg2) {
            0
        } else {
            mul_div(arg0 - arg2, v0, arg2)
        };
        let v2 = mul_div(arg3, v0 - v1, v0);
        if (v2 == 0) {
            return arg1
        };
        let v3 = mul_div(arg0, v0, arg2);
        mul_div(arg1, v0 + min(mul_div(mul_div(v3, v3, v0), v2, v0), v0 * 2), v0)
    }

    public fun calculate_exit_fee_bps(arg0: u64, arg1: &vector<0x4489b5ca0897e4c5d720a23ab6f6b5c6fd92b0b9595414952eef7dee3174a444::sui_types::ExitFeeTier>) : u64 {
        let v0 = 0x1::vector::length<0x4489b5ca0897e4c5d720a23ab6f6b5c6fd92b0b9595414952eef7dee3174a444::sui_types::ExitFeeTier>(arg1);
        if (v0 == 0) {
            return 0
        };
        let v1 = v0;
        while (v1 > 0) {
            v1 = v1 - 1;
            let v2 = 0x1::vector::borrow<0x4489b5ca0897e4c5d720a23ab6f6b5c6fd92b0b9595414952eef7dee3174a444::sui_types::ExitFeeTier>(arg1, v1);
            if (arg0 >= 0x4489b5ca0897e4c5d720a23ab6f6b5c6fd92b0b9595414952eef7dee3174a444::sui_types::exit_tier_days_held(v2)) {
                return 0x4489b5ca0897e4c5d720a23ab6f6b5c6fd92b0b9595414952eef7dee3174a444::sui_types::exit_tier_fee_bps(v2)
            };
        };
        0x4489b5ca0897e4c5d720a23ab6f6b5c6fd92b0b9595414952eef7dee3174a444::sui_types::exit_tier_fee_bps(0x1::vector::borrow<0x4489b5ca0897e4c5d720a23ab6f6b5c6fd92b0b9595414952eef7dee3174a444::sui_types::ExitFeeTier>(arg1, 0))
    }

    public fun calculate_nav(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0 && arg2 == 0) {
            return 0x4489b5ca0897e4c5d720a23ab6f6b5c6fd92b0b9595414952eef7dee3174a444::sui_types::precision()
        };
        let v0 = (arg1 as u128) + (arg2 as u128);
        if (v0 == 0) {
            return 0x4489b5ca0897e4c5d720a23ab6f6b5c6fd92b0b9595414952eef7dee3174a444::sui_types::precision()
        };
        ((((arg0 as u128) + (arg2 as u128)) * (0x4489b5ca0897e4c5d720a23ab6f6b5c6fd92b0b9595414952eef7dee3174a444::sui_types::precision() as u128) / v0) as u64)
    }

    public fun calculate_performance_fee(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg1 <= arg2) {
            return 0
        };
        let v0 = 0x4489b5ca0897e4c5d720a23ab6f6b5c6fd92b0b9595414952eef7dee3174a444::sui_types::precision();
        mul_div(mul_div(mul_div(arg0, arg1 - arg2, v0), arg3, 0x4489b5ca0897e4c5d720a23ab6f6b5c6fd92b0b9595414952eef7dee3174a444::sui_types::bps()), v0, arg1)
    }

    public fun calculate_rebalance(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64) {
        let v0 = 0x4489b5ca0897e4c5d720a23ab6f6b5c6fd92b0b9595414952eef7dee3174a444::sui_types::bps();
        let v1 = arg0 + arg1;
        if (v1 == 0) {
            return (0, 0)
        };
        let v2 = mul_div(arg0, v0, v1);
        if (v2 >= arg3 && v2 <= arg4) {
            return (0, 0)
        };
        let v3 = mul_div(v1, arg2, v0);
        if (arg0 > v3) {
            (arg0 - v3, 0)
        } else {
            (0, v3 - arg0)
        }
    }

    public fun calculate_sell_price_floored(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x4489b5ca0897e4c5d720a23ab6f6b5c6fd92b0b9595414952eef7dee3174a444::sui_types::bps();
        max(arg0, mul_div(arg1, v0 - arg2, v0))
    }

    public fun calculate_smoothed_nav(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg0 >= arg1) {
            return arg0
        };
        let v0 = min(arg2 / arg3, 10);
        let v1 = if (v0 >= 64) {
            0
        } else {
            arg1 - arg0 >> (v0 as u8)
        };
        arg0 + v1
    }

    public fun calculate_tiered_nav_virtual(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = 0x4489b5ca0897e4c5d720a23ab6f6b5c6fd92b0b9595414952eef7dee3174a444::sui_types::bps();
        if (arg4 == 0) {
            return 0
        };
        if (arg0 < arg1) {
            return mul_div(arg4, arg3, v0)
        };
        mul_div(arg4, arg3 - mul_div(arg3 - arg2, mul_div(min(arg0, arg1 * 2) - arg1, v0, arg1), v0), v0)
    }

    public fun calculate_tokens_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0 || arg1 == 0) {
            return 0
        };
        (((arg1 as u128) * (arg2 as u128) / ((arg0 as u128) + (arg2 as u128))) as u64)
    }

    public fun calculate_usdc_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0 || arg0 == 0) {
            return 0
        };
        (((arg0 as u128) * (arg2 as u128) / ((arg1 as u128) + (arg2 as u128))) as u64)
    }

    public fun calculate_virtual_base_usdc(arg0: u64, arg1: u64) : u64 {
        mul_div(arg0, arg1, 0x4489b5ca0897e4c5d720a23ab6f6b5c6fd92b0b9595414952eef7dee3174a444::sui_types::precision())
    }

    public fun from_high_precision(arg0: u64) : u64 {
        arg0 / 1000000
    }

    public fun internal_to_usdc(arg0: u64) : u64 {
        arg0
    }

    public fun is_price_within_bounds(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        let v0 = 0x4489b5ca0897e4c5d720a23ab6f6b5c6fd92b0b9595414952eef7dee3174a444::sui_types::bps();
        arg0 >= mul_div(arg1, v0 - arg3, v0) && arg0 <= mul_div(arg1, v0 + arg2, v0)
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

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 100);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= (18446744073709551615 as u128), 101);
        (v0 as u64)
    }

    public fun mul_div_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 100);
        let v0 = ((arg0 as u128) * (arg1 as u128) + (arg2 as u128) - 1) / (arg2 as u128);
        assert!(v0 <= (18446744073709551615 as u128), 101);
        (v0 as u64)
    }

    public fun percentage_bps(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        mul_div(arg0, 0x4489b5ca0897e4c5d720a23ab6f6b5c6fd92b0b9595414952eef7dee3174a444::sui_types::bps(), arg1)
    }

    public fun safe_add(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) + (arg1 as u128);
        assert!(v0 <= (18446744073709551615 as u128), 101);
        (v0 as u64)
    }

    public fun safe_mul(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    public fun safe_sub(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 >= arg1, 102);
        arg0 - arg1
    }

    public fun to_high_precision(arg0: u64) : u64 {
        arg0 * 1000000
    }

    public fun update_twap_ema(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x4489b5ca0897e4c5d720a23ab6f6b5c6fd92b0b9595414952eef7dee3174a444::sui_types::bps();
        mul_div(arg0, v0 - arg2, v0) + mul_div(arg1, arg2, v0)
    }

    public fun usdc_to_internal(arg0: u64) : u64 {
        arg0
    }

    // decompiled from Move bytecode v6
}

