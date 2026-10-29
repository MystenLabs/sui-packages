module 0xaf6a713d4881d3f8061740dcd18b7cc0c1cb52d9776a3619db3b937719838174::vault_math {
    public fun split_withdrawal_gas_fee(arg0: u128, arg1: u128) : (u128, u128) {
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::split_withdrawal_gas_fee(arg0, arg1)
    }

    public fun assert_creator_share_ratio(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: bool) {
        if (arg4 || arg1 == 0) {
            return
        };
        let v0 = arg1 - arg2;
        if (v0 == 0) {
            return
        };
        assert!(0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::base_div(arg0, v0) >= arg3, 2008);
    }

    public fun assert_follower_position_within_cap(arg0: u128, arg1: u128) {
        assert!(arg0 <= arg1, 2046);
    }

    public fun assert_total_value_within_cap(arg0: u128, arg1: u128) {
        assert!(arg0 <= arg1, 2011);
    }

    public fun compute_deposit_shares(arg0: u128, arg1: u128) : u128 {
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::base_div(arg0, arg1);
        assert!(v0 > 0, 2015);
        v0
    }

    public fun compute_position_value(arg0: u128, arg1: u128) : u128 {
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::base_mul(arg0, arg1)
    }

    public fun compute_share_price(arg0: u128, arg1: u128) : u128 {
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::base_div(arg0, arg1)
    }

    public fun position_nav_value(arg0: u128, arg1: u128, arg2: bool, arg3: u128, arg4: u128, arg5: bool) : u128 {
        let (v0, v1) = signed_add(0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::base_mul(arg1, arg3), arg2, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::base_mul(arg4, arg3), arg5);
        let (v2, v3) = signed_add_u128(v0, v1, arg0);
        if (v3) {
            v2
        } else {
            0
        }
    }

    public fun profit_sharing_to_creator(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : u128 {
        if (arg3 <= arg2) {
            0
        } else {
            0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::base_mul(0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::base_mul(arg3 - arg2, arg1), arg0)
        }
    }

    public fun profit_sharing_to_creator_shares(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128) : (u128, u128) {
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::base_div(profit_sharing_to_creator(arg0, arg1, arg2, arg3), arg4);
        (arg1 - v0, v0)
    }

    fun signed_add(arg0: u128, arg1: bool, arg2: u128, arg3: bool) : (u128, bool) {
        if (arg1 == arg3) {
            (arg0 + arg2, arg1)
        } else if (arg0 >= arg2) {
            (arg0 - arg2, arg1)
        } else {
            (arg2 - arg0, arg3)
        }
    }

    fun signed_add_u128(arg0: u128, arg1: bool, arg2: u128) : (u128, bool) {
        if (arg1) {
            (arg0 + arg2, true)
        } else if (arg0 > arg2) {
            (arg0 - arg2, false)
        } else {
            (arg2 - arg0, true)
        }
    }

    public fun validate_deposit_amount(arg0: u128, arg1: u128) {
        assert!(arg0 > 0 && arg0 >= arg1, 2037);
    }

    public fun validate_follower_max_cap(arg0: u128, arg1: u128, arg2: u128) {
        assert!(arg0 > 0, 2015);
        assert!(arg0 > arg1, 2047);
        assert!(arg0 <= arg2, 2011);
    }

    public fun validate_min_deposit_amount(arg0: u128, arg1: u128) {
        assert!(arg0 >= arg1, 2036);
    }

    public fun validate_user_vault_create(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128) : (u128, u128, u128, u128, u128) {
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::decimal_1e18_to_base(arg0);
        assert!(v0 <= arg5, 2011);
        let v1 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::decimal_1e18_to_base(arg1);
        assert!(v1 >= arg6, 2036);
        assert!(v1 <= v0, 2037);
        let v2 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::decimal_1e18_to_base(arg2);
        assert!(v2 >= arg7, 2028);
        let v3 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::decimal_1e18_to_base(arg4);
        assert!(v3 >= v1, 2037);
        assert!(v3 <= v0, 2011);
        (v0, v1, v2, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::decimal_1e18_to_base(arg3), v3)
    }

    public fun validate_vault_ratios(arg0: u128, arg1: u128, arg2: u128) {
        assert!(arg0 < 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::base_uint(), 2028);
        assert!(arg1 <= arg2, 2028);
    }

    public fun weighted_average_price(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : u128 {
        if (arg3 == 0) {
            return arg0
        };
        (arg0 * arg1 + arg2 * arg3) / (arg1 + arg3)
    }

    // decompiled from Move bytecode v7
}

