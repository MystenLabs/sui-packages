module 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::errors {
    public(friend) fun admin_invalid_source() : u64 {
        26003
    }

    public(friend) fun admin_oracle_nonce_taken() : u64 {
        26006
    }

    public(friend) fun auth_last_admin() : u64 {
        28002
    }

    public(friend) fun auth_no_auth() : u64 {
        28001
    }

    public(friend) fun auth_role_already_assigned() : u64 {
        28003
    }

    public(friend) fun auth_role_not_assigned() : u64 {
        28004
    }

    public(friend) fun oracle_already_migrated() : u64 {
        27002
    }

    public(friend) fun oracle_wrong_version() : u64 {
        27001
    }

    public(friend) fun pyth_core_confidence_not_sufficient() : u64 {
        32004
    }

    public(friend) fun pyth_core_price_arrived_too_late() : u64 {
        32005
    }

    public(friend) fun pyth_core_price_not_valid() : u64 {
        32002
    }

    public(friend) fun pyth_core_price_too_old() : u64 {
        32003
    }

    public(friend) fun pyth_core_wrong_feed() : u64 {
        32001
    }

    public(friend) fun rate_scaled_to_zero() : u64 {
        33001
    }

    public(friend) fun redstone_core_price_not_valid() : u64 {
        30002
    }

    public(friend) fun redstone_core_price_overflow() : u64 {
        30004
    }

    public(friend) fun redstone_core_price_too_old() : u64 {
        30003
    }

    public(friend) fun redstone_core_wrong_adapter() : u64 {
        30001
    }

    public(friend) fun view_rate_not_in_quote() : u64 {
        31001
    }

    // decompiled from Move bytecode v7
}

