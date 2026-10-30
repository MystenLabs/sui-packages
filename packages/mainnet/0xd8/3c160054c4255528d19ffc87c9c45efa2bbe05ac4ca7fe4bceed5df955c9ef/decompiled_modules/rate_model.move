module 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::rate_model {
    public(friend) fun calc_borrow_rate_v1(arg0: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::RateDataV1Params, arg1: u64, arg2: 0x1::type_name::TypeName) : u64 {
        cap_borrow_rate(calc_rate_v1(arg0, arg1), arg2)
    }

    public(friend) fun calc_borrow_rate_v2(arg0: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::RateDataV2Params, arg1: u64, arg2: 0x1::type_name::TypeName) : u64 {
        cap_borrow_rate(calc_rate_v2(arg0, arg1), arg2)
    }

    fun calc_rate_v1(arg0: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::RateDataV1Params, arg1: u64) : u256 {
        let v0 = 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v1_kink(arg0);
        let (v1, v2, v3, v4) = if (arg1 < v0) {
            (0, (v0 as u256), (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v1_rate_at_utilization_zero(arg0) as u256), (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v1_rate_at_utilization_kink(arg0) as u256))
        } else {
            ((v0 as u256), (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::four_decimals() as u256), (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v1_rate_at_utilization_kink(arg0) as u256), (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v1_rate_at_utilization_max(arg0) as u256))
        };
        get_rate(v3, v4, v1, v2, (arg1 as u256))
    }

    fun calc_rate_v2(arg0: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::RateDataV2Params, arg1: u64) : u256 {
        let v0 = 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v2_kink1(arg0);
        let v1 = 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v2_kink2(arg0);
        let (v2, v3, v4, v5) = if (arg1 < v0) {
            (0, (v0 as u256), (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v2_rate_at_utilization_zero(arg0) as u256), (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v2_rate_at_utilization_kink1(arg0) as u256))
        } else if (arg1 < v1) {
            ((v0 as u256), (v1 as u256), (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v2_rate_at_utilization_kink1(arg0) as u256), (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v2_rate_at_utilization_kink2(arg0) as u256))
        } else {
            ((v1 as u256), (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::four_decimals() as u256), (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v2_rate_at_utilization_kink2(arg0) as u256), (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v2_rate_at_utilization_max(arg0) as u256))
        };
        get_rate(v4, v5, v2, v3, (arg1 as u256))
    }

    fun cap_borrow_rate(arg0: u256, arg1: 0x1::type_name::TypeName) : u64 {
        if (arg0 > (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::max_rate() as u256)) {
            arg0 = (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::max_rate() as u256);
            0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::events::emit_log_borrow_rate_cap(arg1);
        };
        (arg0 as u64)
    }

    fun get_rate(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256) : u256 {
        if (arg4 > (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::max_rate() as u256)) {
            abort 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::liquidity_calcs_utilization_overflow()
        };
        let v0 = (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::twelve_decimals() as u256);
        let (v1, v2) = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::signed_from_diff(arg1, arg0);
        let (v3, v4) = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::signed_mul_pos(v1, v2, v0);
        let (v5, v6) = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::signed_div_pos(v3, v4, arg3 - arg2);
        let (v7, v8) = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::signed_mul_pos(v5, v6, arg2);
        let (v9, v10) = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::signed_neg(v7, v8);
        let (v11, v12) = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::signed_add(arg0 * v0, false, v9, v10);
        let (v13, v14) = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::signed_mul_pos(v5, v6, arg4);
        let (v15, v16) = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::signed_add(v13, v14, v11, v12);
        if (0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::signed_is_negative(v15, v16)) {
            abort 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::liquidity_calcs_borrow_rate_negative()
        };
        v15 / v0
    }

    public(friend) fun set_rate_data_v1(arg0: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::RateDataV1Params) : 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::RateDataV1Params {
        validate_v1(arg0);
        *arg0
    }

    public(friend) fun set_rate_data_v2(arg0: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::RateDataV2Params) : 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::RateDataV2Params {
        validate_v2(arg0);
        *arg0
    }

    fun validate_v1(arg0: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::RateDataV1Params) {
        if (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v1_rate_at_utilization_zero(arg0) > 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::max_rate()) {
            abort 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::admin_module_value_overflow_rate_at_util_zero()
        };
        if (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v1_rate_at_utilization_kink(arg0) > 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::max_rate()) {
            abort 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::admin_module_value_overflow_rate_at_util_kink()
        };
        if (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v1_rate_at_utilization_max(arg0) > 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::max_rate()) {
            abort 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::admin_module_value_overflow_rate_at_util_max()
        };
        let v0 = if (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v1_kink(arg0) == 0) {
            true
        } else if (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v1_kink(arg0) >= 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::four_decimals()) {
            true
        } else {
            0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v1_rate_at_utilization_kink(arg0) > 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v1_rate_at_utilization_max(arg0)
        };
        if (v0) {
            abort 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::admin_module_invalid_params()
        };
    }

    fun validate_v2(arg0: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::RateDataV2Params) {
        if (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v2_rate_at_utilization_zero(arg0) > 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::max_rate()) {
            abort 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::admin_module_value_overflow_rate_at_util_zero()
        };
        if (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v2_rate_at_utilization_kink1(arg0) > 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::max_rate()) {
            abort 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::admin_module_value_overflow_rate_at_util_kink1()
        };
        if (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v2_rate_at_utilization_kink2(arg0) > 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::max_rate()) {
            abort 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::admin_module_value_overflow_rate_at_util_kink2()
        };
        if (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v2_rate_at_utilization_max(arg0) > 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::max_rate()) {
            abort 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::admin_module_value_overflow_rate_at_util_max_v2()
        };
        let v0 = if (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v2_kink1(arg0) == 0) {
            true
        } else if (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v2_kink1(arg0) >= 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::four_decimals()) {
            true
        } else if (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v2_kink1(arg0) >= 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v2_kink2(arg0)) {
            true
        } else if (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v2_kink2(arg0) >= 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::four_decimals()) {
            true
        } else {
            0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v2_rate_at_utilization_kink2(arg0) > 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_v2_rate_at_utilization_max(arg0)
        };
        if (v0) {
            abort 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::admin_module_invalid_params()
        };
    }

    // decompiled from Move bytecode v7
}

