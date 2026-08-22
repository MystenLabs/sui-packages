module 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::errors {
    public fun bad_fee_bps() : u64 {
        3
    }

    public fun bad_oracle_param() : u64 {
        220
    }

    public fun bad_period_ms() : u64 {
        4
    }

    public fun bad_risk_param() : u64 {
        7
    }

    public fun bad_share_amount() : u64 {
        60
    }

    public fun batch_too_large() : u64 {
        136
    }

    public fun boost_nav_shortfall() : u64 {
        314
    }

    public fun bootstrap_too_small() : u64 {
        70
    }

    public fun buy_fee_period_exceeded() : u64 {
        100
    }

    public fun buy_fee_trade_exceeded() : u64 {
        101
    }

    public fun cap_already_in_list() : u64 {
        33
    }

    public fun cap_not_in_allowlist() : u64 {
        32
    }

    public fun cap_revoked() : u64 {
        30
    }

    public fun cap_vault_mismatch() : u64 {
        31
    }

    public fun deposit_too_large() : u64 {
        138
    }

    public fun dex_not_allowed() : u64 {
        6
    }

    public fun direct_deposit_disabled() : u64 {
        67
    }

    public fun executor_not_allowed() : u64 {
        230
    }

    public fun executor_policy_missing() : u64 {
        231
    }

    public fun force_mark_bound() : u64 {
        231
    }

    public fun insufficient_balance() : u64 {
        62
    }

    public fun insufficient_shares() : u64 {
        61
    }

    public fun marks_stale() : u64 {
        225
    }

    public fun not_solvent() : u64 {
        230
    }

    public fun oracle_bad_source() : u64 {
        224
    }

    public fun oracle_confidence() : u64 {
        229
    }

    public fun oracle_mismatch() : u64 {
        226
    }

    public fun oracle_move_rejected() : u64 {
        228
    }

    public fun oracle_not_designated() : u64 {
        253
    }

    public fun oracle_primary_live() : u64 {
        227
    }

    public fun oracle_quorum() : u64 {
        221
    }

    public fun oracle_spread() : u64 {
        222
    }

    public fun oracle_stale() : u64 {
        223
    }

    public fun order_too_large() : u64 {
        131
    }

    public fun overflow() : u64 {
        137
    }

    public fun perp_binding() : u64 {
        250
    }

    public fun perp_mark_divergence() : u64 {
        251
    }

    public fun perp_negative_equity() : u64 {
        252
    }

    public fun pool_not_allowed() : u64 {
        192
    }

    public fun protocol_frozen() : u64 {
        2
    }

    public fun protocol_paused() : u64 {
        1
    }

    public fun ptb_too_many_ops() : u64 {
        130
    }

    public fun setup_already_finalized() : u64 {
        9
    }

    public fun share_owner_mismatch() : u64 {
        66
    }

    public fun swap_debt_mismatch() : u64 {
        201
    }

    public fun swap_min_output() : u64 {
        200
    }

    public fun swap_shortfall() : u64 {
        232
    }

    public fun unknown_dex() : u64 {
        5
    }

    public fun vault_mismatch() : u64 {
        63
    }

    public fun withdraw_too_large() : u64 {
        139
    }

    public fun wrong_version() : u64 {
        0
    }

    public fun zero_value() : u64 {
        68
    }

    // decompiled from Move bytecode v7
}

