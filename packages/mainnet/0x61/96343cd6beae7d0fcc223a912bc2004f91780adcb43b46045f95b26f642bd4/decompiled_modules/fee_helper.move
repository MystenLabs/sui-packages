module 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::fee_helper {
    public fun get_composition_fee(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::safe_math::mul_div_u128_to_u64((arg0 as u128), 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::safe_math::mul_u128((arg1 as u128), (0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::safe_math::add_u64(arg1, 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::constants::precision()) as u128)), (0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::constants::squared_precision() as u128))
    }

    public fun get_fee_amount_exclusive(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 < 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::constants::precision(), 502);
        0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::safe_math::u128_to_u64(0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::q64x64::mul_div_round_up_u128((arg0 as u128), (arg1 as u128), (0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::safe_math::sub_u64(0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::constants::precision(), arg1) as u128)))
    }

    public fun get_fee_amount_inclusive(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 < 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::constants::precision(), 502);
        0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::safe_math::u128_to_u64(0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::q64x64::mul_div_round_up_u128((arg0 as u128), (arg1 as u128), (0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::constants::precision() as u128)))
    }

    public fun get_protocol_fee_amount(arg0: u64, arg1: u64) : u64 {
        0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::safe_math::mul_div_u64(arg0, arg1, 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::constants::basis_point_max())
    }

    public fun validate_fee_parameters(arg0: u32, arg1: u16, arg2: u16, arg3: u16, arg4: u32, arg5: u16, arg6: u32) {
        assert!(arg0 <= 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::constants::max_base_factor(), 503);
        assert!(arg1 <= arg2, 509);
        assert!(arg2 <= 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::constants::max_decay_period() && arg2 != 0, 505);
        assert!((arg3 as u64) <= 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::constants::basis_point_max() && arg3 != 0, 506);
        assert!(arg4 <= 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::constants::max_variable_fee_control(), 507);
        assert!(arg5 <= 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::constants::max_protocol_share(), 501);
        assert!(arg6 <= 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::constants::max_volatility_accumulator() && arg6 != 0, 508);
    }

    public fun verify_protocol_share(arg0: u16) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

