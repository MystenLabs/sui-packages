module 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::fee_helper {
    public fun get_composition_fee(arg0: u64, arg1: u64) : u64 {
        verify_fee(arg1);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::constants::precision();
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::mul_div_u64(arg0, 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::mul_div_u64(arg1, 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::add_u64(arg1, v0), v0), v0)
    }

    public fun get_fee_amount(arg0: u64, arg1: u64) : u64 {
        verify_fee(arg1);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::constants::precision();
        assert!(arg1 < v0, 500);
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::div_round_up_u64(0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::mul_u64(arg0, arg1), v0 - arg1)
    }

    public fun get_fee_amount_from(arg0: u64, arg1: u64) : u64 {
        verify_fee(arg1);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::div_round_up_u64(0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::mul_u64(arg0, arg1), 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::constants::precision());
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
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::mul_div_u64(arg0, arg1, 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::constants::basis_point_max())
    }

    public fun verify_fee(arg0: u64) {
        assert!(arg0 <= 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::constants::max_fee(), 500);
    }

    public fun verify_protocol_share(arg0: u64) {
        assert!(arg0 <= 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::constants::max_protocol_share(), 501);
    }

    // decompiled from Move bytecode v6
}

