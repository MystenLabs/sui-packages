module 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::fee_helper {
    public fun get_composition_fee(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::safe_math::mul_div_u128_to_u64((arg0 as u128), 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::safe_math::mul_u128((arg1 as u128), (0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::safe_math::add_u64(arg1, 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::constants::precision()) as u128)), (0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::constants::squared_precision() as u128))
    }

    public fun get_fee_amount_exclusive(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 < 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::constants::precision(), 502);
        0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::safe_math::u128_to_u64(0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::full_math_u128::mul_div_ceil((arg0 as u128), (arg1 as u128), (0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::safe_math::sub_u64(0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::constants::precision(), arg1) as u128)))
    }

    public fun get_fee_amount_inclusive(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 < 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::constants::precision(), 502);
        0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::safe_math::u128_to_u64(0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::full_math_u128::mul_div_ceil((arg0 as u128), (arg1 as u128), (0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::constants::precision() as u128)))
    }

    public fun get_protocol_fee_amount(arg0: u64, arg1: u64) : u64 {
        0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::safe_math::mul_div_u64(arg0, arg1, 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::constants::basis_point_max())
    }

    public fun validate_base_fee(arg0: u64, arg1: u8, arg2: u64, arg3: u16, arg4: u64, arg5: u64) {
        assert!(arg0 <= 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::constants::max_fee_rate(), 502);
        assert!(arg2 > 0, 510);
        assert!(arg2 <= 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::constants::max_fee(), 510);
        assert!(arg3 > 0, 510);
        assert!(arg4 > 0, 510);
        let v0 = if (arg1 == 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::constants::fee_scheduler_mode_linear()) {
            let v1 = 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::safe_math::mul_u64(arg5, (arg3 as u64));
            assert!(v1 <= arg2, 511);
            0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::safe_math::sub_u64(arg2, v1)
        } else {
            assert!(arg1 == 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::constants::fee_scheduler_mode_exponential(), 510);
            assert!(arg5 > 0 && arg5 < 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::constants::basis_point_max(), 510);
            let v2 = 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::constants::scale();
            0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::safe_math::mul_div_u128_to_u64((arg2 as u128), 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::q64x64::pow(0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::safe_math::sub_u128(v2, 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::full_math_u128::mul_div_floor((arg5 as u128), v2, (0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::constants::basis_point_max() as u128))), (arg3 as u128)), v2)
        };
        assert!(v0 >= 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::constants::min_fee_numerator(), 512);
    }

    public fun validate_dynamic_fee_parameters(arg0: u16, arg1: u16, arg2: u16, arg3: u32, arg4: u32) {
        assert!(arg0 <= arg1, 509);
        assert!(arg1 <= 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::constants::max_decay_period() && arg1 != 0, 505);
        assert!((arg2 as u64) <= 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::constants::basis_point_max() && arg2 != 0, 506);
        assert!(arg3 <= 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::constants::max_variable_fee_control(), 507);
        assert!(arg4 <= 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::constants::max_volatility_accumulator() && arg4 != 0, 508);
    }

    // decompiled from Move bytecode v6
}

