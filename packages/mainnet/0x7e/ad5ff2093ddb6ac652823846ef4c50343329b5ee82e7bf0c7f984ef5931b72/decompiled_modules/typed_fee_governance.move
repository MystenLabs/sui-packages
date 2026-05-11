module 0x7ead5ff2093ddb6ac652823846ef4c50343329b5ee82e7bf0c7f984ef5931b72::typed_fee_governance {
    public(friend) fun admin_mutability_required_before_runtime<T0>() : bool {
        0x7ead5ff2093ddb6ac652823846ef4c50343329b5ee82e7bf0c7f984ef5931b72::typed_fee_policy::exact_typed_fee_policy_required<T0>()
    }

    public(friend) fun admin_update_can_enable_collateral_lane<T0>() : bool {
        false
    }

    public(friend) fun admin_update_may_set_decimals<T0>(arg0: u8) : bool {
        admin_update_may_target_asset<T0>() && arg0 == 6
    }

    public(friend) fun admin_update_may_set_fee_bps<T0>(arg0: u64) : bool {
        admin_update_may_target_asset<T0>() && arg0 <= 10000
    }

    public(friend) fun admin_update_may_set_min_viable_order_amount<T0>(arg0: u64) : bool {
        admin_update_may_target_asset<T0>() && arg0 >= 1
    }

    public(friend) fun admin_update_may_target_asset<T0>() : bool {
        0x7ead5ff2093ddb6ac652823846ef4c50343329b5ee82e7bf0c7f984ef5931b72::typed_fee_policy::exact_typed_fee_policy_required<T0>() && 0x7ead5ff2093ddb6ac652823846ef4c50343329b5ee82e7bf0c7f984ef5931b72::typed_fee_policy::typed_collateral_fee_policy_closed<T0>()
    }

    public(friend) fun admin_update_params_valid<T0>(arg0: u8, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : bool {
        if (!admin_update_may_target_asset<T0>()) {
            return false
        };
        if (arg0 != 6) {
            return false
        };
        if (arg1 > 10000) {
            return false
        };
        if (arg4 < 1) {
            return false
        };
        if (arg2 > arg3) {
            return false
        };
        if (arg3 == 0 && (arg1 > 0 || arg2 > 0)) {
            return false
        };
        true
    }

    public(friend) fun future_admin_update_rules_pinned<T0>() : bool {
        if (0x7ead5ff2093ddb6ac652823846ef4c50343329b5ee82e7bf0c7f984ef5931b72::typed_fee_policy::exact_typed_fee_policy_required<T0>()) {
            if (0x7ead5ff2093ddb6ac652823846ef4c50343329b5ee82e7bf0c7f984ef5931b72::typed_fee_policy::typed_collateral_fee_policy_closed<T0>()) {
                0x7ead5ff2093ddb6ac652823846ef4c50343329b5ee82e7bf0c7f984ef5931b72::typed_fee_policy::generic_zero_fee_path_rejected<T0>()
            } else {
                false
            }
        } else {
            false
        }
    }

    public(friend) fun generic_zero_fee_fallback_rejected<T0>() : bool {
        0x7ead5ff2093ddb6ac652823846ef4c50343329b5ee82e7bf0c7f984ef5931b72::typed_fee_policy::generic_zero_fee_path_rejected<T0>() && 0x7ead5ff2093ddb6ac652823846ef4c50343329b5ee82e7bf0c7f984ef5931b72::typed_fee_policy::exact_typed_fee_policy_required<T0>()
    }

    public(friend) fun governance_policy_version<T0>() : 0x1::option::Option<u64> {
        if (0x7ead5ff2093ddb6ac652823846ef4c50343329b5ee82e7bf0c7f984ef5931b72::typed_fee_policy::exact_typed_fee_policy_required<T0>()) {
            return 0x1::option::some<u64>(1)
        };
        0x1::option::none<u64>()
    }

    public(friend) fun governance_source_rules_pinned() : u8 {
        1
    }

    public(friend) fun governance_status<T0>() : u8 {
        if (0x7ead5ff2093ddb6ac652823846ef4c50343329b5ee82e7bf0c7f984ef5931b72::typed_fee_policy::exact_typed_fee_policy_required<T0>()) {
            return 1
        };
        0
    }

    public(friend) fun governance_unsupported() : u8 {
        0
    }

    public(friend) fun max_fee_bps() : u64 {
        10000
    }

    public(friend) fun min_viable_order_amount_floor() : u64 {
        1
    }

    public(friend) fun minimum_start_policy_version() : u64 {
        1
    }

    public(friend) fun native_sui_usdc_decimals() : u8 {
        6
    }

    public(friend) fun product_runtime_enablement_allowed<T0>() : bool {
        future_admin_update_rules_pinned<T0>() && runtime_config_object_published<T0>()
    }

    public(friend) fun runtime_config_object_published<T0>() : bool {
        0x7ead5ff2093ddb6ac652823846ef4c50343329b5ee82e7bf0c7f984ef5931b72::typed_fee_policy::exact_typed_fee_policy_required<T0>() && false
    }

    public(friend) fun runtime_enablement_stays_closed_until_object_publish<T0>() : bool {
        admin_mutability_required_before_runtime<T0>() && !runtime_config_object_published<T0>()
    }

    public(friend) fun unauthenticated_update_path_available<T0>() : bool {
        false
    }

    public(friend) fun zero_fee_launch_params_explicitly_versioned<T0>(arg0: u64, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : bool {
        if (admin_update_params_valid<T0>(arg1, arg2, arg3, arg4, arg5)) {
            if (arg0 == 1) {
                if (arg2 == 0) {
                    if (arg3 == 0) {
                        if (arg4 == 0) {
                            arg5 == 1
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public(friend) fun zero_fee_promotional_window_rejected<T0>() : bool {
        0x7ead5ff2093ddb6ac652823846ef4c50343329b5ee82e7bf0c7f984ef5931b72::typed_fee_policy::exact_typed_fee_policy_required<T0>()
    }

    // decompiled from Move bytecode v7
}

