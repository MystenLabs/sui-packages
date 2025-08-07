module 0xebe03715ba65ce959d183f64f907ca831d2084789072a5a4e4a01dc3f1c8a5b0::fee_helper {
    public fun get_composition_fee(arg0: u64, arg1: u64) : u64 {
        verify_fee(arg1);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = 0xebe03715ba65ce959d183f64f907ca831d2084789072a5a4e4a01dc3f1c8a5b0::constants::precision();
        0xebe03715ba65ce959d183f64f907ca831d2084789072a5a4e4a01dc3f1c8a5b0::safe_math::mul_div_u128_to_u64((arg0 as u128), 0xebe03715ba65ce959d183f64f907ca831d2084789072a5a4e4a01dc3f1c8a5b0::safe_math::mul_u128((arg1 as u128), (0xebe03715ba65ce959d183f64f907ca831d2084789072a5a4e4a01dc3f1c8a5b0::safe_math::add_u64(arg1, v0) as u128)), 0xebe03715ba65ce959d183f64f907ca831d2084789072a5a4e4a01dc3f1c8a5b0::safe_math::mul_u128((v0 as u128), (v0 as u128)))
    }

    public fun get_fee_amount(arg0: u64, arg1: u64) : u64 {
        verify_fee(arg1);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = 0xebe03715ba65ce959d183f64f907ca831d2084789072a5a4e4a01dc3f1c8a5b0::constants::precision();
        assert!(arg1 < v0, 500);
        0xebe03715ba65ce959d183f64f907ca831d2084789072a5a4e4a01dc3f1c8a5b0::safe_math::u128_to_u64(0xebe03715ba65ce959d183f64f907ca831d2084789072a5a4e4a01dc3f1c8a5b0::safe_math::div_round_up_u128(0xebe03715ba65ce959d183f64f907ca831d2084789072a5a4e4a01dc3f1c8a5b0::safe_math::mul_u128((arg0 as u128), (arg1 as u128)), ((v0 - arg1) as u128)))
    }

    public fun get_fee_amount_from(arg0: u64, arg1: u64) : u64 {
        verify_fee(arg1);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = 0xebe03715ba65ce959d183f64f907ca831d2084789072a5a4e4a01dc3f1c8a5b0::safe_math::div_round_up_u64(0xebe03715ba65ce959d183f64f907ca831d2084789072a5a4e4a01dc3f1c8a5b0::safe_math::mul_u64(arg0, arg1), 0xebe03715ba65ce959d183f64f907ca831d2084789072a5a4e4a01dc3f1c8a5b0::constants::precision());
        if (v0 > arg0) {
            arg0
        } else {
            v0
        }
    }

    public fun get_protocol_fee_amount(arg0: u64, arg1: u64) : u64 {
        verify_protocol_share(arg1);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        0xebe03715ba65ce959d183f64f907ca831d2084789072a5a4e4a01dc3f1c8a5b0::safe_math::mul_div_u64(arg0, arg1, 0xebe03715ba65ce959d183f64f907ca831d2084789072a5a4e4a01dc3f1c8a5b0::constants::basis_point_max())
    }

    public fun verify_fee(arg0: u64) {
        assert!(arg0 <= 0xebe03715ba65ce959d183f64f907ca831d2084789072a5a4e4a01dc3f1c8a5b0::constants::max_fee(), 500);
    }

    public fun verify_protocol_share(arg0: u64) {
        assert!(arg0 <= 0xebe03715ba65ce959d183f64f907ca831d2084789072a5a4e4a01dc3f1c8a5b0::constants::max_protocol_share(), 501);
    }

    // decompiled from Move bytecode v6
}

