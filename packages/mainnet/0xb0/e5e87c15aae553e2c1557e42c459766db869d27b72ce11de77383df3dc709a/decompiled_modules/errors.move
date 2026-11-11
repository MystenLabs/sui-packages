module 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::errors {
    public fun err_amount_in_is_zero() : u64 {
        abort 3
    }

    public fun err_amount_out_is_zero() : u64 {
        abort 8
    }

    public fun err_amount_out_limit_is_zero() : u64 {
        abort 11
    }

    public fun err_amount_out_slippage_check_failed() : u64 {
        abort 1
    }

    public fun err_bad_plan_signature() : u64 {
        abort 15
    }

    public fun err_exceed_max_amount_in() : u64 {
        abort 7
    }

    public fun err_expect_amount_out_overflow() : u64 {
        abort 13
    }

    public fun err_invalid_fee_recipient() : u64 {
        abort 4
    }

    public fun err_invalid_plan() : u64 {
        abort 14
    }

    public fun err_invalid_slippage() : u64 {
        abort 9
    }

    public fun err_not_support_b2a() : u64 {
        abort 6
    }

    public fun err_overlay_fee_unsupported() : u64 {
        abort 22
    }

    public fun err_plan_amount_in_mismatch() : u64 {
        abort 20
    }

    public fun err_plan_coin_mismatch() : u64 {
        abort 19
    }

    public fun err_plan_expired() : u64 {
        abort 21
    }

    public fun err_plan_sender_mismatch() : u64 {
        abort 18
    }

    public fun err_plan_vault_mismatch() : u64 {
        abort 17
    }

    public fun err_remains_balance() : u64 {
        abort 2
    }

    public fun err_too_large_fee_rate() : u64 {
        abort 5
    }

    public fun err_unknown_plan_signer() : u64 {
        abort 16
    }

    // decompiled from Move bytecode v7
}

