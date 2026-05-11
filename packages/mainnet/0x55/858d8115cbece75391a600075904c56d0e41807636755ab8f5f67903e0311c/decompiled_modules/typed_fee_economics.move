module 0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::typed_fee_economics {
    fun clamp_fee(arg0: u64) : u64 {
        if (arg0 < 0) {
            return 0
        };
        if (arg0 > 0) {
            return 0
        };
        arg0
    }

    public fun dust_fail_closed() : u8 {
        1
    }

    public fun dust_unsupported() : u8 {
        0
    }

    public fun economics_configured() : u8 {
        2
    }

    public fun economics_not_configured() : u8 {
        1
    }

    public fun economics_unsupported() : u8 {
        0
    }

    public fun explicit_minimum_launch_fee_policy<T0>() : bool {
        if (typed_fee_economics_required<T0>()) {
            let v1 = typed_fee_bps<T0>();
            if (0x1::option::is_some<u64>(&v1)) {
                let v2 = typed_fee_min_amount<T0>();
                if (0x1::option::is_some<u64>(&v2)) {
                    let v3 = typed_fee_max_amount<T0>();
                    if (0x1::option::is_some<u64>(&v3)) {
                        if (0 == 0) {
                            if (0 == 0) {
                                if (0 == 0) {
                                    1 == 1
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
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun generic_zero_fee_economics_rejected<T0>() : bool {
        typed_fee_economics_required<T0>()
    }

    public fun ready_for_runtime_economics<T0>() : bool {
        if (typed_fee_economics_complete<T0>()) {
            if (generic_zero_fee_economics_rejected<T0>()) {
                if (explicit_minimum_launch_fee_policy<T0>()) {
                    0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::typed_fee_governance::future_admin_update_rules_pinned<T0>()
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

    public fun ready_for_runtime_enablement<T0>() : bool {
        ready_for_runtime_economics<T0>() && 0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::typed_fee_governance::product_runtime_enablement_allowed<T0>()
    }

    fun round_up_bps(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        ((((arg0 as u128) * (arg1 as u128) + (10000 as u128) - 1) / (10000 as u128)) as u64)
    }

    public fun rounding_unsupported() : u8 {
        0
    }

    public fun rounding_up() : u8 {
        1
    }

    public fun typed_fee_amount<T0>(arg0: u64) : 0x1::option::Option<u64> {
        if (!ready_for_runtime_economics<T0>()) {
            return 0x1::option::none<u64>()
        };
        if (arg0 < 1) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>(clamp_fee(round_up_bps(arg0, 0)))
    }

    public fun typed_fee_bps<T0>() : 0x1::option::Option<u64> {
        if (typed_fee_economics_required<T0>()) {
            return 0x1::option::some<u64>(0)
        };
        0x1::option::none<u64>()
    }

    public fun typed_fee_decimals<T0>() : 0x1::option::Option<u8> {
        if (typed_fee_economics_required<T0>()) {
            return 0x1::option::some<u8>(6)
        };
        0x1::option::none<u8>()
    }

    public fun typed_fee_dust_policy<T0>() : u8 {
        if (typed_fee_economics_required<T0>()) {
            return 1
        };
        0
    }

    public fun typed_fee_economics_complete<T0>() : bool {
        if (typed_fee_economics_required<T0>()) {
            if (typed_fee_economics_configured<T0>()) {
                let v1 = typed_fee_bps<T0>();
                if (0x1::option::is_some<u64>(&v1)) {
                    let v2 = typed_fee_min_amount<T0>();
                    if (0x1::option::is_some<u64>(&v2)) {
                        let v3 = typed_fee_max_amount<T0>();
                        if (0x1::option::is_some<u64>(&v3)) {
                            let v4 = typed_fee_min_viable_order_amount<T0>();
                            0x1::option::is_some<u64>(&v4)
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

    public fun typed_fee_economics_configured<T0>() : bool {
        typed_fee_economics_status<T0>() == 2
    }

    public fun typed_fee_economics_fail_closed<T0>() : bool {
        typed_fee_economics_required<T0>() && !typed_fee_economics_configured<T0>()
    }

    public fun typed_fee_economics_required<T0>() : bool {
        0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::typed_fee_policy::exact_typed_fee_policy_required<T0>()
    }

    public fun typed_fee_economics_status<T0>() : u8 {
        if (typed_fee_economics_required<T0>()) {
            return 2
        };
        0
    }

    public fun typed_fee_max_amount<T0>() : 0x1::option::Option<u64> {
        if (typed_fee_economics_required<T0>()) {
            return 0x1::option::some<u64>(0)
        };
        0x1::option::none<u64>()
    }

    public fun typed_fee_min_amount<T0>() : 0x1::option::Option<u64> {
        if (typed_fee_economics_required<T0>()) {
            return 0x1::option::some<u64>(0)
        };
        0x1::option::none<u64>()
    }

    public fun typed_fee_min_viable_order_amount<T0>() : 0x1::option::Option<u64> {
        if (typed_fee_economics_required<T0>()) {
            return 0x1::option::some<u64>(1)
        };
        0x1::option::none<u64>()
    }

    public fun typed_fee_rounding_mode<T0>() : u8 {
        if (typed_fee_economics_required<T0>()) {
            return 1
        };
        0
    }

    // decompiled from Move bytecode v7
}

