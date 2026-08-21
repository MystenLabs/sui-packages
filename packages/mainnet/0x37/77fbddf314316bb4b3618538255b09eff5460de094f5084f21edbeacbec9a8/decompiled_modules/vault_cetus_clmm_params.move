module 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_cetus_clmm_params {
    struct RiskParams has copy, drop {
        swap_deviation_bps: u64,
        clmm_price_deviation_bps: u64,
        max_swap_wal_amount: u64,
        nav_haircut_bps: u64,
        user_output_buffer_bps: u64,
        max_accounted_value_gap_bps: u64,
    }

    public fun clmm_price_deviation_bps(arg0: &RiskParams) : u64 {
        arg0.clmm_price_deviation_bps
    }

    public fun configured_execution_loss_bps(arg0: &RiskParams) : u64 {
        configured_user_output_buffer_bps(arg0)
    }

    public fun configured_max_accounted_value_gap_bps(arg0: &RiskParams) : u64 {
        arg0.max_accounted_value_gap_bps
    }

    public fun configured_nav_haircut_bps(arg0: &RiskParams) : u64 {
        arg0.nav_haircut_bps
    }

    public fun configured_user_output_buffer_bps(arg0: &RiskParams) : u64 {
        arg0.user_output_buffer_bps
    }

    fun derived_max_loss_bps_unchecked(arg0: u64, arg1: u64) : u64 {
        10000 - ((((10000 - arg0) as u128) * ((10000 - arg1) as u128) / (10000 as u128)) as u64)
    }

    public fun execution_loss_bps(arg0: u64, arg1: u64, arg2: u64) : u64 {
        user_output_buffer_bps(arg0, arg1, arg2)
    }

    public(friend) fun from_values(arg0: u64, arg1: u64, arg2: u64) : RiskParams {
        assert!(is_valid(arg0, arg1, arg2), 1);
        RiskParams{
            swap_deviation_bps          : arg0,
            clmm_price_deviation_bps    : arg1,
            max_swap_wal_amount         : arg2,
            nav_haircut_bps             : nav_haircut_bps(arg0, arg1, arg2),
            user_output_buffer_bps      : user_output_buffer_bps(arg0, arg1, arg2),
            max_accounted_value_gap_bps : max_accounted_value_gap_bps(arg0, arg1, arg2),
        }
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
        if (derived_max_loss_bps_unchecked(arg0, v2) > 1000) {
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
        1000
    }

    public fun max_clmm_price_deviation_bps() : u64 {
        2000
    }

    public fun max_swap_wal_amount(arg0: &RiskParams) : u64 {
        arg0.max_swap_wal_amount
    }

    public fun nav_haircut_bps(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(is_valid(arg0, arg1, arg2), 1);
        arg0 + arg1
    }

    public fun normalization_rounding_buffer_bps() : u64 {
        5
    }

    public fun swap_deviation_bps(arg0: &RiskParams) : u64 {
        arg0.swap_deviation_bps
    }

    public fun user_output_buffer_bps(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(is_valid(arg0, arg1, arg2), 1);
        arg0 + 5
    }

    // decompiled from Move bytecode v7
}

