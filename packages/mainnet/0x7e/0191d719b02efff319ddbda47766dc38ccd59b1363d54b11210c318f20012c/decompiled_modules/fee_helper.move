module 0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::fee_helper {
    public fun get_composition_fee(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::safe_math::mul_div_u128_to_u64((arg0 as u128), 0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::safe_math::mul_u128((arg1 as u128), (0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::safe_math::add_u64(arg1, 0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::constants::precision()) as u128)), (0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::constants::squared_precision() as u128))
    }

    public fun get_fee_amount_exclusive(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 < 0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::constants::precision(), 502);
        0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::safe_math::u128_to_u64(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_ceil((arg0 as u128), (arg1 as u128), (0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::safe_math::sub_u64(0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::constants::precision(), arg1) as u128)))
    }

    public fun get_fee_amount_inclusive(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 < 0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::constants::precision(), 502);
        0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::safe_math::u128_to_u64(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_ceil((arg0 as u128), (arg1 as u128), (0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::constants::precision() as u128)))
    }

    public fun get_protocol_fee_amount(arg0: u64, arg1: u64) : u64 {
        0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::safe_math::mul_div_u64(arg0, arg1, 0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::constants::basis_point_max())
    }

    public fun validate_dynamic_fee_parameters(arg0: u16, arg1: u16, arg2: u16, arg3: u32, arg4: u32) {
        assert!(arg0 <= arg1, 509);
        assert!(arg1 <= 0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::constants::max_decay_period() && arg1 != 0, 505);
        assert!((arg2 as u64) <= 0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::constants::basis_point_max() && arg2 != 0, 506);
        assert!(arg3 <= 0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::constants::max_variable_fee_control(), 507);
        assert!(arg4 <= 0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::constants::max_volatility_accumulator() && arg4 != 0, 508);
    }

    public fun validate_fee_rate(arg0: u64) {
        assert!(arg0 <= 0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::constants::max_fee_rate(), 502);
    }

    public fun validate_fee_scheduler_exponential(arg0: u64, arg1: u16, arg2: u64, arg3: u64) {
        assert!(arg0 > 0, 510);
        assert!(arg0 <= 0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::constants::max_fee(), 510);
        assert!(arg1 > 0, 510);
        assert!(arg2 > 0, 510);
        assert!(arg3 > 0 && arg3 < 0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::constants::basis_point_max(), 510);
        let v0 = 0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::constants::scale();
        assert!(0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::safe_math::mul_div_u128_to_u64((arg0 as u128), 0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::q64x64::pow(0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::safe_math::sub_u128(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((arg3 as u128), v0, (0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::constants::basis_point_max() as u128))), (arg1 as u128)), v0) >= 0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::constants::min_fee_numerator(), 513);
    }

    public fun validate_fee_scheduler_linear(arg0: u64, arg1: u16, arg2: u64, arg3: u64) {
        assert!(arg0 > 0, 510);
        assert!(arg0 <= 0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::constants::max_fee(), 510);
        assert!(arg1 > 0, 510);
        assert!(arg2 > 0, 510);
        let v0 = 0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::safe_math::mul_u64(arg3, (arg1 as u64));
        assert!(v0 <= arg0, 511);
        assert!(0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::safe_math::sub_u64(arg0, v0) >= 0x7e0191d719b02efff319ddbda47766dc38ccd59b1363d54b11210c318f20012c::constants::min_fee_numerator(), 512);
    }

    public fun verify_protocol_share(arg0: u16) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

