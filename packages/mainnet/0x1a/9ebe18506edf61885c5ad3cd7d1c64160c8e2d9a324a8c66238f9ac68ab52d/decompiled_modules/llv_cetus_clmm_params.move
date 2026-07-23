module 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_cetus_clmm_params {
    fun derived_max_loss_bps_unchecked(arg0: u64, arg1: u64) : u64 {
        10000 - ((((10000 - arg0) as u128) * ((10000 - arg1) as u128) / (10000 as u128)) as u64)
    }

    public fun is_valid(arg0: u64, arg1: u64, arg2: u64) : bool {
        if (arg2 == 0 || arg0 >= 10000) {
            return false
        };
        if (arg1 == 0 || arg1 > 2000) {
            return false
        };
        let v0 = (arg0 as u128) + (arg1 as u128);
        let v1 = (arg0 as u128) + (5 as u128);
        if (v0 >= (10000 as u128) || v1 > (10000 as u128)) {
            return false
        };
        let v2 = (v0 as u64);
        let v3 = (v1 as u64);
        if (derived_max_loss_bps_unchecked(arg0, v2) > 100) {
            return false
        };
        if (((10000 - v2) as u128) * ((10000 - v3) as u128) * ((10000 - v2) as u128) * ((10000 - v3) as u128) > ((10000 - arg0) as u128) * ((10000 - arg0) as u128) * ((10000 - arg1) as u128) * (10000 as u128)) {
            return false
        };
        true
    }

    public fun max_accounted_value_gap_bps(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(is_valid(arg0, arg1, arg2), 1);
        derived_max_loss_bps_unchecked(arg0, arg0 + arg1)
    }

    public fun max_accounted_value_gap_bps_hard_cap() : u64 {
        100
    }

    public fun max_clmm_price_deviation_bps() : u64 {
        2000
    }

    public fun nav_haircut_bps(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(is_valid(arg0, arg1, arg2), 1);
        arg0 + arg1
    }

    public fun normalization_rounding_buffer_bps() : u64 {
        5
    }

    public fun user_output_buffer_bps(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(is_valid(arg0, arg1, arg2), 1);
        arg0 + 5
    }

    // decompiled from Move bytecode v7
}

