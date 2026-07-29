module 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::inverse_cdf {
    fun eval_rational_wad(arg0: u256, arg1: vector<u128>, arg2: vector<bool>, arg3: vector<u128>, arg4: vector<bool>) : u128 {
        let v0 = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::horner::eval_rational_scaled(arg0, arg1, arg2, arg3, arg4, 1000000000000000000);
        let v1 = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::inverse_cdf_coefficients::max_z_raw();
        if (v0 > (v1 as u256)) {
            v1
        } else {
            (v0 as u128)
        }
    }

    public(friend) fun inverse_cdf_upper_raw(arg0: u128) : u128 {
        if (arg0 >= 1000000000) {
            return 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::inverse_cdf_coefficients::max_z_raw()
        };
        if (arg0 == 500000000) {
            return 0
        };
        if (arg0 < 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::inverse_cdf_coefficients::central_threshold_raw()) {
            eval_rational_wad(((arg0 - 500000000) as u256) * 1000000000, 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::inverse_cdf_coefficients::central_num_mags(), 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::inverse_cdf_coefficients::central_num_negs(), 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::inverse_cdf_coefficients::central_den_mags(), 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::inverse_cdf_coefficients::central_den_negs())
        } else {
            eval_rational_wad((tail_variable_wad(arg0) as u256), 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::inverse_cdf_coefficients::tail_num_mags(), 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::inverse_cdf_coefficients::tail_num_negs(), 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::inverse_cdf_coefficients::tail_den_mags(), 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::inverse_cdf_coefficients::tail_den_negs())
        }
    }

    fun tail_variable_wad(arg0: u128) : u128 {
        let (_, v1) = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::common::raw_log2(1000000000 - arg0);
        (0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u256::sqrt(((2 * 0x1::option::destroy_some<u128>(0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::mul_div(v1, 693147180559945309, 1000000000000000000, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::nearest()))) as u256) * 1000000000000000000, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::nearest()) as u128)
    }

    // decompiled from Move bytecode v7
}

