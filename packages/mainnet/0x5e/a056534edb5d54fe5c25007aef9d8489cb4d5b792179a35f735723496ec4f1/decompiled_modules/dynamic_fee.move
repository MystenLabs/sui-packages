module 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::dynamic_fee {
    struct DynamicFee has copy, drop, store {
        volatility_accumulator: u128,
        volatility_reference: u128,
        sqrt_price_reference: u128,
        last_update_timestamp: u64,
        bin_step_config: DynamicFeeConfig,
    }

    struct DynamicFeeConfig has copy, drop, store {
        bin_step: u16,
        bin_step_u128: u128,
        filter_period: u16,
        decay_period: u16,
        reduction_factor: u16,
        variable_fee_control: u32,
        max_volatility_accumulator: u32,
    }

    public fun bin_step(arg0: &DynamicFeeConfig) : u16 {
        arg0.bin_step
    }

    public fun bin_step_config(arg0: &DynamicFee) : &DynamicFeeConfig {
        &arg0.bin_step_config
    }

    public fun bin_step_u128(arg0: &DynamicFeeConfig) : u128 {
        arg0.bin_step_u128
    }

    public fun decay_period(arg0: &DynamicFeeConfig) : u16 {
        arg0.decay_period
    }

    public fun filter_period(arg0: &DynamicFeeConfig) : u16 {
        arg0.filter_period
    }

    public fun get_delta_bin_id(arg0: u128, arg1: u128, arg2: u128) : u128 {
        let (v0, v1) = if (arg1 > arg2) {
            (arg1, arg2)
        } else {
            (arg2, arg1)
        };
        (0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::full_math_u128::mul_div_floor(v0, 18446744073709551616, v1) - 18446744073709551616) / arg0 * 2
    }

    public fun get_variable_fee_rate(arg0: &DynamicFee) : u128 {
        if (variable_fee_control(&arg0.bin_step_config) > 0) {
            return ((variable_fee_control(&arg0.bin_step_config) as u128) * 0x1::u128::pow((arg0.volatility_accumulator as u128) * (bin_step(&arg0.bin_step_config) as u128), 2) + 99999999999) / 100000000000
        };
        0
    }

    public fun last_update_timestamp(arg0: &DynamicFee) : u64 {
        arg0.last_update_timestamp
    }

    public fun max_volatility_accumulator(arg0: &DynamicFeeConfig) : u32 {
        arg0.max_volatility_accumulator
    }

    public(friend) fun new_dynamic_fee(arg0: 0x1::option::Option<DynamicFeeConfig>, arg1: u128) : 0x1::option::Option<DynamicFee> {
        if (0x1::option::is_some<DynamicFeeConfig>(&arg0)) {
            let v0 = DynamicFee{
                volatility_accumulator : 0,
                volatility_reference   : 0,
                sqrt_price_reference   : arg1,
                last_update_timestamp  : 0,
                bin_step_config        : 0x1::option::extract<DynamicFeeConfig>(&mut arg0),
            };
            return 0x1::option::some<DynamicFee>(v0)
        };
        0x1::option::none<DynamicFee>()
    }

    public(friend) fun new_dynamic_fee_config(arg0: u16, arg1: u128, arg2: u16, arg3: u16, arg4: u16, arg5: u32, arg6: u32) : DynamicFeeConfig {
        let v0 = DynamicFeeConfig{
            bin_step                   : arg0,
            bin_step_u128              : arg1,
            filter_period              : arg2,
            decay_period               : arg3,
            reduction_factor           : arg4,
            variable_fee_control       : arg5,
            max_volatility_accumulator : arg6,
        };
        validate(&v0);
        v0
    }

    public fun reduction_factor(arg0: &DynamicFeeConfig) : u16 {
        arg0.reduction_factor
    }

    public fun sqrt_price_reference(arg0: &DynamicFee) : u128 {
        arg0.sqrt_price_reference
    }

    public fun update_references(arg0: &mut DynamicFee, arg1: u128, arg2: u64) {
        assert!(arg2 >= arg0.last_update_timestamp, 13835058832671244289);
        let v0 = arg2 - arg0.last_update_timestamp;
        if (v0 >= (filter_period(&arg0.bin_step_config) as u64)) {
            arg0.sqrt_price_reference = arg1;
            if (v0 < (decay_period(&arg0.bin_step_config) as u64)) {
                arg0.volatility_reference = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::full_math_u128::mul_div_floor(arg0.volatility_accumulator, (reduction_factor(&arg0.bin_step_config) as u128), 10000);
            } else {
                arg0.volatility_reference = 0;
            };
        };
    }

    public fun update_volatility_accumulator(arg0: &mut DynamicFee, arg1: u128, arg2: u64) {
        let v0 = get_delta_bin_id(bin_step_u128(&arg0.bin_step_config), arg1, arg0.sqrt_price_reference);
        let v1 = arg0.volatility_reference + v0 * 10000;
        if (v1 > (max_volatility_accumulator(&arg0.bin_step_config) as u128)) {
            arg0.volatility_accumulator = (max_volatility_accumulator(&arg0.bin_step_config) as u128);
        } else {
            arg0.volatility_accumulator = v1;
        };
        if (v0 > 0) {
            arg0.last_update_timestamp = arg2;
        };
    }

    fun validate(arg0: &DynamicFeeConfig) {
        assert!(arg0.bin_step == 1, 13835341282605662211);
        assert!(arg0.bin_step_u128 == 1844674407370955, 13835341286900629507);
        assert!(arg0.filter_period < arg0.decay_period, 13835622766172438533);
        assert!((arg0.reduction_factor as u64) <= 10000, 13835622770467405829);
        assert!(arg0.variable_fee_control <= 16777215, 13835622774762373125);
        assert!(arg0.max_volatility_accumulator <= 16777215, 13835622779057340421);
    }

    public fun variable_fee_control(arg0: &DynamicFeeConfig) : u32 {
        arg0.variable_fee_control
    }

    public fun volatility_accumulator(arg0: &DynamicFee) : u128 {
        arg0.volatility_accumulator
    }

    public fun volatility_reference(arg0: &DynamicFee) : u128 {
        arg0.volatility_reference
    }

    // decompiled from Move bytecode v6
}

