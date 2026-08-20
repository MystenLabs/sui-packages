module 0x81ad750b468d9ed4d07c896200fc74f90dcc75ccb61956967f780fb6e62c4952::config {
    struct AMMConfig has drop, store {
        order_expiration_time_ms: u64,
        max_price_age_secs: u64,
        base_spread_bps: u64,
        max_conf_ratio_bps: u64,
        volatility_multiplier_bps: u64,
        outer_balance_bps: u64,
        max_commit_bps: u64,
        inventory_skew_bps: u64,
        stale_price_tolerance_bps: u64,
        post_only: bool,
    }

    public(friend) fun base_spread(arg0: &AMMConfig, arg1: u64) : u64 {
        0x1::u64::mul_div(arg1, arg0.base_spread_bps, 10000)
    }

    public fun base_spread_bps(arg0: &AMMConfig) : u64 {
        arg0.base_spread_bps
    }

    public fun inventory_skew_bps(arg0: &AMMConfig) : u64 {
        arg0.inventory_skew_bps
    }

    public(friend) fun is_stale_tolerant(arg0: &AMMConfig, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : bool {
        0x1::u64::mul_div(0x1::u64::diff(arg1, arg3), 10000, arg3) + 0x1::u64::mul_div(0x1::u64::mul_div(arg0.volatility_multiplier_bps, 0x1::u64::diff(arg2, arg4), 10000), arg0.outer_balance_bps * 2, 10000) < 0x1::u64::mul_div(arg0.base_spread_bps, arg0.stale_price_tolerance_bps, 10000)
    }

    public(friend) fun max_commit_balance(arg0: &AMMConfig, arg1: u64) : u64 {
        0x1::u64::mul_div(arg1, arg0.max_commit_bps, 10000)
    }

    public fun max_commit_bps(arg0: &AMMConfig) : u64 {
        arg0.max_commit_bps
    }

    public fun max_conf_ratio_bps(arg0: &AMMConfig) : u64 {
        arg0.max_conf_ratio_bps
    }

    public fun max_price_age_secs(arg0: &AMMConfig) : u64 {
        arg0.max_price_age_secs
    }

    public fun new(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool) : AMMConfig {
        assert!(arg0 > 0 && arg0 < 10000, 13835058630807781377);
        assert!(arg4 > 0 && arg4 < 10000, 13835340118669524995);
        assert!(arg5 < 10000, 13836184552189984777);
        assert!(arg6 > 0 && arg6 <= 10000, 13837873406346002453);
        assert!(arg7 < 10000, 13836466035756761099);
        assert!(arg8 < 10000, 13837591939959095315);
        assert!(arg2 > 0, 13835621619416170501);
        assert!(arg3 > 0, 13835903098687979527);
        assert!((arg2 as u128) <= (arg3 as u128) * 1000, 13837310486457090065);
        AMMConfig{
            order_expiration_time_ms  : arg2,
            max_price_age_secs        : arg3,
            base_spread_bps           : arg0,
            max_conf_ratio_bps        : arg4,
            volatility_multiplier_bps : arg1,
            outer_balance_bps         : arg5,
            max_commit_bps            : arg6,
            inventory_skew_bps        : arg7,
            stale_price_tolerance_bps : arg8,
            post_only                 : arg9,
        }
    }

    public fun order_expiration_time_ms(arg0: &AMMConfig) : u64 {
        arg0.order_expiration_time_ms
    }

    public(friend) fun outer_balance(arg0: &AMMConfig, arg1: u64) : u64 {
        0x1::u64::mul_div(arg1, arg0.outer_balance_bps, 10000)
    }

    public fun outer_balance_bps(arg0: &AMMConfig) : u64 {
        arg0.outer_balance_bps
    }

    public(friend) fun outer_spread(arg0: &AMMConfig, arg1: u64, arg2: u64) : u64 {
        0x1::u64::mul_div(arg1, arg0.base_spread_bps + 0x1::u64::mul_div(arg0.volatility_multiplier_bps, arg2, 10000), 10000)
    }

    public fun post_only(arg0: &AMMConfig) : bool {
        arg0.post_only
    }

    public(friend) fun reservation_mid(arg0: &AMMConfig, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg0.inventory_skew_bps == 0) {
            return arg1
        };
        let v0 = (arg2 as u128) * (arg1 as u128) / 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling_u128();
        let v1 = (arg3 as u128);
        let v2 = v0 + v1;
        if (v2 == 0) {
            return arg1
        };
        let v3 = if (v0 >= v1) {
            arg1 - ((0x1::u128::mul_div((base_spread(arg0, arg1) as u128), 0x1::u128::diff(v0, v1), v2) * (arg0.inventory_skew_bps as u128) / 10000) as u64)
        } else {
            let v4 = 0x1::u64::checked_add(arg1, ((0x1::u128::mul_div((base_spread(arg0, arg1) as u128), 0x1::u128::diff(v0, v1), v2) * (arg0.inventory_skew_bps as u128) / 10000) as u64));
            if (0x1::option::is_some<u64>(&v4)) {
                0x1::option::destroy_some<u64>(v4)
            } else {
                0x1::option::destroy_none<u64>(v4);
                abort 13837029969257955343
            }
        };
        assert!(v3 >= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::min_price(), 13836748502871048205);
        assert!(v3 <= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_price(), 13837029982142857231);
        v3
    }

    public fun stale_price_tolerance_bps(arg0: &AMMConfig) : u64 {
        arg0.stale_price_tolerance_bps
    }

    public fun volatility_multiplier_bps(arg0: &AMMConfig) : u64 {
        arg0.volatility_multiplier_bps
    }

    // decompiled from Move bytecode v7
}

