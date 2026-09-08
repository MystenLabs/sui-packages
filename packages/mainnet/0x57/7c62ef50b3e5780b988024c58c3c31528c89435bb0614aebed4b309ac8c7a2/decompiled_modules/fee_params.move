module 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee_params {
    struct FeeParameters has copy, drop, store {
        bin_step: u16,
        base_factor: u32,
        filter_period: u32,
        decay_period: u32,
        reduction_factor: u16,
        variable_fee_control: u32,
        protocol_share: u16,
        max_volatility_accumulator: u32,
        oracle_distance_surcharge_bps: u16,
        oracle_deadband_bps: u16,
        divergence_discount_bps: u16,
        oracle_max_age_ms: u32,
        oracle_max_conf_bps: u16,
        oracle_max_pair_skew_ms: u32,
    }

    public fun base_factor(arg0: &FeeParameters) : u32 {
        arg0.base_factor
    }

    public fun bin_step(arg0: &FeeParameters) : u16 {
        arg0.bin_step
    }

    public fun decay_period(arg0: &FeeParameters) : u32 {
        arg0.decay_period
    }

    public fun divergence_discount_bps(arg0: &FeeParameters) : u16 {
        arg0.divergence_discount_bps
    }

    public fun filter_period(arg0: &FeeParameters) : u32 {
        arg0.filter_period
    }

    public fun is_valid_bin_step(arg0: u16) : bool {
        arg0 > 0 && arg0 <= 500
    }

    public fun max_oracle_conf_bps() : u16 {
        500
    }

    public fun max_oracle_pair_skew_ms() : u32 {
        30000
    }

    public fun max_volatility_accumulator(arg0: &FeeParameters) : u32 {
        arg0.max_volatility_accumulator
    }

    public fun new_fee_parameters(arg0: u16, arg1: u32, arg2: u32, arg3: u32, arg4: u16, arg5: u32, arg6: u16, arg7: u32, arg8: u16, arg9: u16, arg10: u16, arg11: u32, arg12: u16, arg13: u32) : FeeParameters {
        assert!(is_valid_bin_step(arg0), 101);
        assert!(arg1 <= 100000, 102);
        assert!(arg8 == 0 || arg12 > 0, 102);
        assert!(arg6 >= 500 && arg6 <= 2500, 102);
        assert!(arg2 >= 1000, 102);
        assert!(arg3 >= 10000, 102);
        assert!(arg2 <= arg3, 102);
        assert!(arg4 <= 9500, 102);
        assert!(arg7 <= 5000000, 102);
        assert!(arg5 <= 50000000, 102);
        assert!(arg8 <= 5000, 102);
        assert!(arg10 <= 5000, 102);
        assert!(arg9 <= 10000, 102);
        assert!(arg10 <= arg8, 102);
        assert!(arg11 >= 30000 && arg11 <= 900000, 102);
        assert!(arg12 <= 500, 102);
        let v0 = if (arg13 > 0) {
            if (arg13 <= 30000) {
                (arg13 as u64) <= (arg11 as u64) / 2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 102);
        let v1 = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::checked_mul((arg7 as u128), (arg0 as u128));
        assert!(0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::checked_add(0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::checked_mul(0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::checked_mul((arg1 as u128), (arg0 as u128)), 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::constants::base_fee_scale()), 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::mul_div_ceil((arg5 as u128), 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::checked_mul(v1, v1), 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::constants::fee_calc_precision())) <= 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::constants::max_total_fee(), 102);
        FeeParameters{
            bin_step                      : arg0,
            base_factor                   : arg1,
            filter_period                 : arg2,
            decay_period                  : arg3,
            reduction_factor              : arg4,
            variable_fee_control          : arg5,
            protocol_share                : arg6,
            max_volatility_accumulator    : arg7,
            oracle_distance_surcharge_bps : arg8,
            oracle_deadband_bps           : arg9,
            divergence_discount_bps       : arg10,
            oracle_max_age_ms             : arg11,
            oracle_max_conf_bps           : arg12,
            oracle_max_pair_skew_ms       : arg13,
        }
    }

    public fun oracle_deadband_bps(arg0: &FeeParameters) : u16 {
        arg0.oracle_deadband_bps
    }

    public fun oracle_distance_surcharge_bps(arg0: &FeeParameters) : u16 {
        arg0.oracle_distance_surcharge_bps
    }

    public fun oracle_max_age_ms(arg0: &FeeParameters) : u32 {
        arg0.oracle_max_age_ms
    }

    public fun oracle_max_conf_bps(arg0: &FeeParameters) : u16 {
        arg0.oracle_max_conf_bps
    }

    public fun oracle_max_pair_skew_ms(arg0: &FeeParameters) : u32 {
        arg0.oracle_max_pair_skew_ms
    }

    public fun protocol_share(arg0: &FeeParameters) : u16 {
        arg0.protocol_share
    }

    public fun reduction_factor(arg0: &FeeParameters) : u16 {
        arg0.reduction_factor
    }

    public fun variable_fee_control(arg0: &FeeParameters) : u32 {
        arg0.variable_fee_control
    }

    // decompiled from Move bytecode v7
}

