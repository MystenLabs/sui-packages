module 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::pair_parameter_helper {
    struct PairParameters has copy, drop, store {
        base_factor: u32,
        protocol_share: u64,
        active_id: u32,
        activation_timestamp: u64,
        fee_scheduler_mode: u8,
        enabled_fee_scheduler: bool,
        cliff_fee_numerator: u64,
        number_of_period: u16,
        period_frequency: u64,
        fee_scheduler_reduction_factor: u64,
        enabled_dynamic_fee: bool,
        filter_period: u16,
        decay_period: u16,
        reduction_factor: u16,
        variable_fee_control: u32,
        max_volatility_accumulator: u32,
        volatility_accumulator: u32,
        volatility_reference: u32,
        id_reference: u32,
        time_of_last_update: u64,
    }

    public fun disable_dynamic_fee(arg0: &mut PairParameters) {
        arg0.enabled_dynamic_fee = false;
    }

    public(friend) fun disable_fee_scheduler(arg0: &mut PairParameters) {
        arg0.enabled_fee_scheduler = false;
    }

    public fun enable_dynamic_fee(arg0: &mut PairParameters) {
        arg0.enabled_dynamic_fee = true;
    }

    public(friend) fun enable_fee_scheduler(arg0: &mut PairParameters) {
        arg0.enabled_fee_scheduler = true;
    }

    public fun get_activation_timestamp(arg0: &PairParameters) : u64 {
        arg0.activation_timestamp
    }

    public fun get_active_id(arg0: &PairParameters) : u32 {
        arg0.active_id
    }

    public fun get_base_factor(arg0: &PairParameters) : u32 {
        arg0.base_factor
    }

    public fun get_base_fee(arg0: &PairParameters, arg1: u64) : u64 {
        if (!arg0.enabled_fee_scheduler || arg0.activation_timestamp == 0) {
            return (arg0.base_factor as u64)
        };
        let v0 = get_current_number_period(arg0, arg1);
        if (v0 == (arg0.number_of_period as u64)) {
            return (arg0.base_factor as u64)
        };
        if (arg0.fee_scheduler_mode == 1) {
            return get_base_fee_exponential(arg0, v0)
        };
        if (arg0.fee_scheduler_mode == 0) {
            return get_base_fee_linear(arg0, v0)
        };
        (arg0.base_factor as u64)
    }

    public fun get_base_fee_exponential(arg0: &PairParameters, arg1: u64) : u64 {
        let v0 = 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::q64x64::scale();
        0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::safe_math::mul_div_u128_to_u64((arg0.cliff_fee_numerator as u128), 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::q64x64::pow(0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::safe_math::sub_u128(v0, 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::q64x64::mul_div_round_down_u128((arg0.fee_scheduler_reduction_factor as u128), v0, (0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::constants::basis_point_max() as u128))), (arg1 as u128)), v0)
    }

    public fun get_base_fee_linear(arg0: &PairParameters, arg1: u64) : u64 {
        0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::safe_math::sub_u64(arg0.cliff_fee_numerator, 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::safe_math::mul_u64((arg0.fee_scheduler_reduction_factor as u64), arg1))
    }

    public fun get_cliff_fee_numerator(arg0: &PairParameters) : u64 {
        arg0.cliff_fee_numerator
    }

    public fun get_current_number_period(arg0: &PairParameters, arg1: u64) : u64 {
        if (arg0.period_frequency == 0) {
            return 0
        };
        if (arg1 < arg0.activation_timestamp) {
            return (arg0.number_of_period as u64)
        };
        0x1::u64::min(0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::safe_math::sub_u64(arg1, arg0.activation_timestamp) / arg0.period_frequency, (arg0.number_of_period as u64))
    }

    public fun get_delta_id(arg0: &PairParameters, arg1: u32) : u32 {
        let v0 = arg0.active_id;
        if (arg1 > v0) {
            arg1 - v0
        } else {
            v0 - arg1
        }
    }

    public fun get_dynamic_decay_period(arg0: &PairParameters) : u16 {
        arg0.decay_period
    }

    public fun get_dynamic_filter_period(arg0: &PairParameters) : u16 {
        arg0.filter_period
    }

    public fun get_dynamic_max_volatility_accumulator(arg0: &PairParameters) : u32 {
        arg0.max_volatility_accumulator
    }

    public fun get_dynamic_reduction_factor(arg0: &PairParameters) : u16 {
        arg0.reduction_factor
    }

    public fun get_dynamic_variable_fee_control(arg0: &PairParameters) : u32 {
        arg0.variable_fee_control
    }

    public fun get_fee_scheduler_mode(arg0: &PairParameters) : u8 {
        arg0.fee_scheduler_mode
    }

    public fun get_id_reference(arg0: &PairParameters) : u32 {
        arg0.id_reference
    }

    public fun get_protocol_share(arg0: &PairParameters) : u64 {
        arg0.protocol_share
    }

    public fun get_scheduler_number_of_period(arg0: &PairParameters) : u16 {
        arg0.number_of_period
    }

    public fun get_scheduler_period_frequency(arg0: &PairParameters) : u64 {
        arg0.period_frequency
    }

    public fun get_scheduler_reduction_factor(arg0: &PairParameters) : u64 {
        arg0.fee_scheduler_reduction_factor
    }

    public fun get_time_of_last_update(arg0: &PairParameters) : u64 {
        arg0.time_of_last_update
    }

    public fun get_total_fee_rate(arg0: &PairParameters, arg1: u16, arg2: u64) : (u64, u64, u64) {
        let v0 = get_base_fee(arg0, arg2);
        let v1 = get_variable_fee(arg0, arg1);
        (0x1::u64::min(0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::safe_math::add_u64(v0, v1), 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::constants::max_fee_rate()), v0, v1)
    }

    public fun get_total_fee_rate_legacy(arg0: &PairParameters, arg1: u16) : u64 {
        0x1::u64::min(0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::safe_math::add_u64(0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::safe_math::mul_u64((arg0.base_factor as u64), (arg1 as u64)), get_variable_fee(arg0, arg1)), 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::constants::max_fee_rate())
    }

    public fun get_variable_fee(arg0: &PairParameters, arg1: u16) : u64 {
        if (arg0.enabled_dynamic_fee == false) {
            return 0
        };
        let v0 = (arg0.variable_fee_control as u64);
        if (v0 != 0) {
            let v2 = 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::safe_math::mul_u64((arg0.volatility_accumulator as u64), (arg1 as u64));
            (0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::safe_math::mul_u64(0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::safe_math::mul_u64(v2, v2), v0) + 99) / 100
        } else {
            0
        }
    }

    public fun get_volatility_accumulator(arg0: &PairParameters) : u32 {
        arg0.volatility_accumulator
    }

    public fun get_volatility_reference(arg0: &PairParameters) : u32 {
        arg0.volatility_reference
    }

    public fun is_fee_scheduler_enabled(arg0: &PairParameters) : bool {
        arg0.enabled_fee_scheduler
    }

    public(friend) fun new(arg0: u32, arg1: u8, arg2: bool, arg3: bool) : PairParameters {
        PairParameters{
            base_factor                    : 0,
            protocol_share                 : 0,
            active_id                      : arg0,
            activation_timestamp           : 0,
            fee_scheduler_mode             : arg1,
            enabled_fee_scheduler          : arg2,
            cliff_fee_numerator            : 0,
            number_of_period               : 0,
            period_frequency               : 0,
            fee_scheduler_reduction_factor : 0,
            enabled_dynamic_fee            : arg3,
            filter_period                  : 0,
            decay_period                   : 0,
            reduction_factor               : 0,
            variable_fee_control           : 0,
            max_volatility_accumulator     : 0,
            volatility_accumulator         : 0,
            volatility_reference           : 0,
            id_reference                   : arg0,
            time_of_last_update            : 0,
        }
    }

    public(friend) fun set_activation_timestamp(arg0: &mut PairParameters, arg1: u64) {
        arg0.activation_timestamp = arg1;
    }

    public(friend) fun set_active_id(arg0: &mut PairParameters, arg1: u32) {
        arg0.active_id = arg1;
    }

    public(friend) fun set_base_factor(arg0: &mut PairParameters, arg1: u32) {
        arg0.base_factor = arg1;
    }

    public(friend) fun set_static_fee_parameters(arg0: &mut PairParameters, arg1: u32, arg2: u16, arg3: u64, arg4: u16, arg5: u16, arg6: u16, arg7: u32, arg8: u32, arg9: u64, arg10: u16, arg11: u64, arg12: u64) {
        arg0.base_factor = arg1;
        arg0.protocol_share = (arg2 as u64);
        arg0.activation_timestamp = arg3;
        arg0.filter_period = arg4;
        arg0.decay_period = arg5;
        arg0.reduction_factor = arg6;
        arg0.variable_fee_control = arg7;
        arg0.max_volatility_accumulator = arg8;
        arg0.cliff_fee_numerator = arg9;
        arg0.number_of_period = arg10;
        arg0.period_frequency = arg11;
        arg0.fee_scheduler_reduction_factor = arg12;
    }

    public(friend) fun set_volatility_accumulator(arg0: &mut PairParameters, arg1: u32) {
        assert!(arg1 <= 1048575, 900);
        arg0.volatility_accumulator = arg1;
    }

    public(friend) fun set_volatility_reference(arg0: &mut PairParameters, arg1: u32) {
        assert!(arg1 <= 1048575, 900);
        arg0.volatility_reference = arg1;
    }

    public(friend) fun update_id_reference(arg0: &mut PairParameters) {
        arg0.id_reference = arg0.active_id;
    }

    public(friend) fun update_references(arg0: &mut PairParameters, arg1: u64) {
        let v0 = arg1 - arg0.time_of_last_update;
        if (v0 >= (arg0.filter_period as u64)) {
            update_id_reference(arg0);
            if (v0 < (arg0.decay_period as u64)) {
                update_volatility_reference(arg0);
            } else {
                set_volatility_reference(arg0, 0);
            };
        };
        update_time_of_last_update(arg0, arg1);
    }

    public(friend) fun update_time_of_last_update(arg0: &mut PairParameters, arg1: u64) {
        arg0.time_of_last_update = arg1;
    }

    public(friend) fun update_volatility_accumulator(arg0: &mut PairParameters, arg1: u32) {
        arg0.volatility_accumulator = 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::safe_math::u64_to_u32(0x1::u64::min(0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::safe_math::add_u64((arg0.volatility_reference as u64), 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::safe_math::mul_u64((0x1::u32::diff(arg1, arg0.id_reference) as u64), 10)), (arg0.max_volatility_accumulator as u64)));
    }

    public(friend) fun update_volatility_parameters(arg0: &mut PairParameters, arg1: u32, arg2: u64) {
        update_references(arg0, arg2);
        update_volatility_accumulator(arg0, arg1);
    }

    public(friend) fun update_volatility_reference(arg0: &mut PairParameters) {
        arg0.volatility_reference = 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::safe_math::u64_to_u32(0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::safe_math::mul_div_u64((arg0.volatility_accumulator as u64), (arg0.reduction_factor as u64), 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::constants::basis_point_max()));
    }

    // decompiled from Move bytecode v6
}

