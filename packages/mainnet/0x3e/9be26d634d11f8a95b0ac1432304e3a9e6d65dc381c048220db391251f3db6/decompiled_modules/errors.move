module 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors {
    public fun arithmetic_overflow() : u64 {
        900
    }

    public fun arithmetic_underflow() : u64 {
        902
    }

    public fun buffer_would_fall_below_refill() : u64 {
        800
    }

    public fun delivered_exceeds_fair_value() : u64 {
        413
    }

    public fun deposit_cap_exceeded() : u64 {
        201
    }

    public fun deposits_paused() : u64 {
        203
    }

    public fun division_by_zero() : u64 {
        901
    }

    public fun emergency_mode_active() : u64 {
        601
    }

    public fun epoch_already_closed() : u64 {
        410
    }

    public fun epoch_already_finalized() : u64 {
        411
    }

    public fun epoch_already_open() : u64 {
        409
    }

    public fun epoch_duration_not_elapsed() : u64 {
        406
    }

    public fun epoch_not_closed() : u64 {
        401
    }

    public fun epoch_not_empty() : u64 {
        403
    }

    public fun epoch_not_finalized() : u64 {
        402
    }

    public fun epoch_not_open() : u64 {
        400
    }

    public fun epoch_wrong_id() : u64 {
        404
    }

    public fun force_withdraw_not_due() : u64 {
        803
    }

    public fun idle_usdc_mismatch() : u64 {
        503
    }

    public fun insufficient_shares() : u64 {
        301
    }

    public fun invalid_buffer_params() : u64 {
        208
    }

    public fun invalid_buffer_source() : u64 {
        806
    }

    public fun invalid_epoch_duration() : u64 {
        209
    }

    public fun invalid_fee_bps() : u64 {
        207
    }

    public fun invalid_fee_recipient() : u64 {
        703
    }

    public fun invalid_force_withdraw_amount() : u64 {
        804
    }

    public fun invalid_force_withdraw_recipient() : u64 {
        805
    }

    public fun invalid_vault_kind() : u64 {
        206
    }

    public fun lockup_active() : u64 {
        302
    }

    public fun nav_deviation_exceeded() : u64 {
        502
    }

    public fun nav_stale() : u64 {
        205
    }

    public fun nav_timestamp_not_monotonic() : u64 {
        501
    }

    public fun no_pending_force_withdraw() : u64 {
        802
    }

    public fun no_pending_oracle_rotation() : u64 {
        506
    }

    public fun not_emergency_mode() : u64 {
        600
    }

    public fun not_fee_recipient() : u64 {
        702
    }

    public fun not_fulfiller_authority() : u64 {
        504
    }

    public fun not_implemented() : u64 {
        9999
    }

    public fun not_oracle_authority() : u64 {
        500
    }

    public fun not_protocol_admin() : u64 {
        102
    }

    public fun not_request_owner() : u64 {
        407
    }

    public fun not_vault_admin() : u64 {
        700
    }

    public fun oracle_rotation_not_due() : u64 {
        505
    }

    public fun per_user_cap_exceeded() : u64 {
        202
    }

    public fun redemptions_paused() : u64 {
        405
    }

    public fun registry_already_initialized() : u64 {
        100
    }

    public fun registry_paused() : u64 {
        101
    }

    public fun requests_not_all_claimed() : u64 {
        408
    }

    public fun seed_deposit_below_min() : u64 {
        200
    }

    public fun share_receipt_not_empty() : u64 {
        300
    }

    public fun slippage_min_shares() : u64 {
        204
    }

    public fun vault_admin_cap_wrong_vault() : u64 {
        701
    }

    public fun vault_bricked() : u64 {
        212
    }

    public fun vault_ramping_deposit() : u64 {
        211
    }

    public fun vault_ramping_finalize() : u64 {
        414
    }

    public fun vault_ramping_redeem() : u64 {
        412
    }

    public fun withdraw_exceeds_idle() : u64 {
        801
    }

    public fun wrong_registry() : u64 {
        103
    }

    public fun wrong_vault_id() : u64 {
        210
    }

    // decompiled from Move bytecode v7
}

