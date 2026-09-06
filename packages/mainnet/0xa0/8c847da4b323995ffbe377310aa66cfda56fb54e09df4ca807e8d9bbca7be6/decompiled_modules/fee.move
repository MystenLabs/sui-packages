module 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee {
    struct VolatilityState has copy, drop, store {
        volatility_accumulator: u32,
        volatility_reference: u32,
        index_reference: u32,
        last_update_timestamp: u64,
        reference_anchored_at: u64,
    }

    public fun fee_precision() : u64 {
        0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::constants::fee_precision()
    }

    public fun apply_oracle_distance_fee(arg0: &0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::FeeParameters, arg1: u64, arg2: u32, arg3: u32, arg4: bool, arg5: bool) : u64 {
        if (arg2 == 0) {
            return arg1
        };
        if (arg2 == arg3) {
            return arg1
        };
        let v0 = if (arg2 > arg3) {
            ((arg2 - arg3) as u128)
        } else {
            ((arg3 - arg2) as u128)
        };
        let v1 = 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::checked_mul(v0, (0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::bin_step(arg0) as u128));
        let v2 = (0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::oracle_deadband_bps(arg0) as u128);
        if (v1 <= v2) {
            return arg1
        };
        let v3 = v1 - v2;
        if (is_swap_toward_oracle(arg2, arg3, arg4)) {
            let v5 = (0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::oracle_distance_surcharge_bps(arg0) as u128);
            if (v5 == 0) {
                return arg1
            };
            clamp_total_fee(0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::checked_add((arg1 as u128), oracle_adjustment_fee_rate(v3, v5)))
        } else {
            if (!arg5) {
                return arg1
            };
            let v6 = (0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::divergence_discount_bps(arg0) as u128);
            if (v6 == 0) {
                return arg1
            };
            let v7 = oracle_adjustment_fee_rate(v3, v6);
            let v8 = ((arg1 / 2) as u128);
            let v9 = if (v7 > v8) {
                v8
            } else {
                v7
            };
            let v10 = (clamp_total_fee(0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::checked_add((arg1 as u128), oracle_adjustment_fee_rate(v3, (0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::oracle_distance_surcharge_bps(arg0) as u128)))) as u128);
            let v11 = if (v10 > (arg1 as u128)) {
                v10 - (arg1 as u128)
            } else {
                0
            };
            let v12 = if (v9 > v11) {
                v11
            } else {
                v9
            };
            arg1 - (v12 as u64)
        }
    }

    fun clamp_total_fee(arg0: u128) : u64 {
        if (arg0 > 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::constants::max_total_fee()) {
            (0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::constants::max_total_fee() as u64)
        } else {
            (arg0 as u64)
        }
    }

    public fun discount_max_age_ms() : u64 {
        60000
    }

    public fun effective_volatility_accumulator(arg0: &VolatilityState, arg1: &0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::FeeParameters, arg2: u64) : u32 {
        let v0 = arg0.volatility_accumulator;
        if (v0 == 0) {
            return 0
        };
        let v1 = (0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::decay_period(arg1) as u64);
        let v2 = if (arg2 > arg0.last_update_timestamp) {
            arg2 - arg0.last_update_timestamp
        } else {
            0
        };
        let v3 = if (arg2 > arg0.reference_anchored_at) {
            arg2 - arg0.reference_anchored_at
        } else {
            0
        };
        if (v2 < (0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::filter_period(arg1) as u64) && v3 < v1) {
            return v0
        };
        if (v2 >= v1) {
            return 0
        };
        (0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::mul_div_floor((v0 as u128), ((0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::reduction_factor(arg1) as u64) as u128), 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::constants::bps_denominator_u128()) as u32)
    }

    public fun get_base_fee(arg0: &0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::FeeParameters) : u64 {
        (0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::checked_mul(0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::checked_mul((0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::base_factor(arg0) as u128), (0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::bin_step(arg0) as u128)), 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::constants::base_fee_scale()) as u64)
    }

    public fun get_total_fee(arg0: &0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::FeeParameters, arg1: &VolatilityState, arg2: u64) : u64 {
        clamp_total_fee(0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::checked_add((get_base_fee(arg0) as u128), (get_variable_fee(arg0, arg1, arg2) as u128)))
    }

    fun get_variable_fee(arg0: &0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::FeeParameters, arg1: &VolatilityState, arg2: u64) : u64 {
        let v0 = 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::variable_fee_control(arg0);
        if (v0 == 0) {
            return 0
        };
        let v1 = (effective_volatility_accumulator(arg1, arg0, arg2) as u128);
        if (v1 == 0) {
            return 0
        };
        let v2 = 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::checked_mul(v1, (0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::bin_step(arg0) as u128));
        (0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::mul_div_ceil((v0 as u128), 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::checked_mul(v2, v2), 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::constants::fee_calc_precision()) as u64)
    }

    public fun index_reference(arg0: &VolatilityState) : u32 {
        arg0.index_reference
    }

    public fun is_swap_toward_oracle(arg0: u32, arg1: u32, arg2: bool) : bool {
        if (arg0 == arg1) {
            return false
        };
        arg0 > arg1 && !arg2 || arg2
    }

    public fun last_update_timestamp(arg0: &VolatilityState) : u64 {
        arg0.last_update_timestamp
    }

    public fun new_volatility_state() : VolatilityState {
        VolatilityState{
            volatility_accumulator : 0,
            volatility_reference   : 0,
            index_reference        : 0,
            last_update_timestamp  : 0,
            reference_anchored_at  : 0,
        }
    }

    fun oracle_adjustment_fee_rate(arg0: u128, arg1: u128) : u128 {
        let v0 = 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::mul_div_floor(arg0, arg1, 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::constants::bps_denominator_u128());
        let v1 = if (v0 > 200) {
            200
        } else {
            v0
        };
        v1 * 100000
    }

    public fun reference_anchored_at(arg0: &VolatilityState) : u64 {
        arg0.reference_anchored_at
    }

    public fun update_references(arg0: &mut VolatilityState, arg1: &0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::FeeParameters, arg2: u32, arg3: u64) {
        assert!(arg3 >= arg0.last_update_timestamp, 300);
        let v0 = (0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::decay_period(arg1) as u64);
        let v1 = arg3 - arg0.last_update_timestamp;
        let v2 = if (arg3 > arg0.reference_anchored_at) {
            arg3 - arg0.reference_anchored_at
        } else {
            0
        };
        if (v1 < (0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::filter_period(arg1) as u64) && v2 < v0) {
            arg0.last_update_timestamp = arg3;
            return
        };
        if (v1 >= v0) {
            arg0.volatility_reference = 0;
        } else {
            arg0.volatility_reference = (0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::mul_div_floor(((arg0.volatility_accumulator as u64) as u128), ((0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::reduction_factor(arg1) as u64) as u128), 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::constants::bps_denominator_u128()) as u32);
        };
        arg0.volatility_accumulator = arg0.volatility_reference;
        arg0.index_reference = arg2;
        arg0.last_update_timestamp = arg3;
        arg0.reference_anchored_at = arg3;
    }

    public fun update_volatility_accumulator(arg0: &mut VolatilityState, arg1: &0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::FeeParameters, arg2: u32) {
        let v0 = if (arg2 > arg0.index_reference) {
            arg2 - arg0.index_reference
        } else {
            arg0.index_reference - arg2
        };
        let v1 = 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::checked_add_u64((arg0.volatility_reference as u64), (0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::checked_mul((v0 as u128), (0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::constants::bin_delta_scale() as u128)) as u64));
        let v2 = (0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::max_volatility_accumulator(arg1) as u64);
        let v3 = if (v1 > v2) {
            v2
        } else {
            v1
        };
        arg0.volatility_accumulator = (v3 as u32);
    }

    public fun volatility_accumulator(arg0: &VolatilityState) : u32 {
        arg0.volatility_accumulator
    }

    public fun volatility_reference(arg0: &VolatilityState) : u32 {
        arg0.volatility_reference
    }

    // decompiled from Move bytecode v7
}

