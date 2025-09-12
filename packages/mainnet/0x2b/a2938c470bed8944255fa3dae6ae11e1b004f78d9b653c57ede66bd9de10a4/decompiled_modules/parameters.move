module 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::parameters {
    struct VariableParameters has copy, drop, store {
        volatility_accumulator: u32,
        volatility_reference: u32,
        index_reference: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        last_update_timestamp: u64,
        bin_step_config: 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::config::BinStepConfig,
    }

    public fun bin_step(arg0: &VariableParameters) : u16 {
        0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::config::bin_step(&arg0.bin_step_config)
    }

    public fun protocol_fee_rate(arg0: &VariableParameters) : u64 {
        0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::config::protocol_fee_rate(&arg0.bin_step_config)
    }

    public fun bin_step_config(arg0: &VariableParameters) : 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::config::BinStepConfig {
        arg0.bin_step_config
    }

    public fun get_variable_fee_rate(arg0: &VariableParameters) : u128 {
        if (0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::config::variable_fee_control(&arg0.bin_step_config) > 0) {
            return ((0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::config::variable_fee_control(&arg0.bin_step_config) as u128) * 0x1::u128::pow((volatility_accumulator(arg0) as u128) * (0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::config::bin_step(&arg0.bin_step_config) as u128), 2) + 99999999999) / 100000000000
        };
        0
    }

    public fun index_reference(arg0: &VariableParameters) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        arg0.index_reference
    }

    public fun last_update_timestamp(arg0: &VariableParameters) : u64 {
        arg0.last_update_timestamp
    }

    public(friend) fun new_variable_parameters(arg0: 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::config::BinStepConfig, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : VariableParameters {
        VariableParameters{
            volatility_accumulator : 0,
            volatility_reference   : 0,
            index_reference        : arg1,
            last_update_timestamp  : 0,
            bin_step_config        : arg0,
        }
    }

    public fun update_index_reference(arg0: &mut VariableParameters, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        arg0.index_reference = arg1;
    }

    public fun update_references(arg0: &mut VariableParameters, arg1: u64) {
        assert!(arg1 >= arg0.last_update_timestamp, 13906834659674816515);
        let v0 = arg1 - arg0.last_update_timestamp;
        if (v0 >= (0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::config::filter_period(&arg0.bin_step_config) as u64)) {
            if (v0 < (0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::config::decay_period(&arg0.bin_step_config) as u64)) {
                let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_floor((arg0.volatility_accumulator as u64), (0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::config::reduction_factor(&arg0.bin_step_config) as u64), 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::constants::basis_point());
                assert!(v1 < 4294967295, 13906834715509260289);
                arg0.volatility_reference = (v1 as u32);
            } else {
                arg0.volatility_reference = 0;
            };
        };
        arg0.last_update_timestamp = arg1;
    }

    public fun update_volatility_accumulator(arg0: &mut VariableParameters, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        let v0 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(arg0.index_reference, arg1)) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg0.index_reference, arg1))
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg1, arg0.index_reference))
        };
        let v1 = (arg0.volatility_reference as u64) + (v0 as u64) * 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::constants::basis_point();
        if (v1 > (0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::config::max_volatility_accumulator(&arg0.bin_step_config) as u64)) {
            arg0.volatility_accumulator = 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::config::max_volatility_accumulator(&arg0.bin_step_config);
        } else {
            arg0.volatility_accumulator = (v1 as u32);
        };
    }

    public fun update_volatility_parameter(arg0: &mut VariableParameters, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u64) {
        update_references(arg0, arg2);
        update_volatility_accumulator(arg0, arg1);
    }

    public fun volatility_accumulator(arg0: &VariableParameters) : u32 {
        arg0.volatility_accumulator
    }

    public fun volatility_reference(arg0: &VariableParameters) : u32 {
        arg0.volatility_reference
    }

    // decompiled from Move bytecode v6
}

