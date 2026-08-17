module 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors {
    public fun adapter_disabled() : u64 {
        190
    }

    public fun adapter_not_implemented() : u64 {
        191
    }

    public fun bad_clearance() : u64 {
        344
    }

    public fun bad_deposit() : u64 {
        64
    }

    public fun bad_fee_bps() : u64 {
        3
    }

    public fun bad_fee_config() : u64 {
        104
    }

    public fun bad_period_ms() : u64 {
        4
    }

    public fun bad_quote_type() : u64 {
        194
    }

    public fun bad_risk_param() : u64 {
        7
    }

    public fun bad_share_amount() : u64 {
        60
    }

    public fun bad_withdraw() : u64 {
        65
    }

    public fun batch_too_large() : u64 {
        136
    }

    public fun boost_deadline() : u64 {
        310
    }

    public fun boost_min_return() : u64 {
        311
    }

    public fun boost_nav_shortfall() : u64 {
        314
    }

    public fun boost_ticket_mismatch() : u64 {
        312
    }

    public fun boost_zero_amount() : u64 {
        313
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

    public fun cap_flag_missing() : u64 {
        35
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

    public fun cap_wrong_owner() : u64 {
        34
    }

    public fun clearance_too_low() : u64 {
        342
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

    public fun fee_recipient_not_set() : u64 {
        103
    }

    public fun flash_deadline() : u64 {
        404
    }

    public fun flash_not_permitted() : u64 {
        400
    }

    public fun flash_notional_cap() : u64 {
        401
    }

    public fun flash_profit_floor() : u64 {
        402
    }

    public fun flash_ticket_mismatch() : u64 {
        403
    }

    public fun flash_zero_notional() : u64 {
        405
    }

    public fun guardian_scope() : u64 {
        343
    }

    public fun hwm_regression() : u64 {
        102
    }

    public fun insufficient_balance() : u64 {
        62
    }

    public fun insufficient_shares() : u64 {
        61
    }

    public fun master_cap_mismatch() : u64 {
        345
    }

    public fun not_a_guardian() : u64 {
        346
    }

    public fun oracle_bad_param() : u64 {
        376
    }

    public fun oracle_duplicate_source() : u64 {
        374
    }

    public fun oracle_mismatch() : u64 {
        375
    }

    public fun oracle_no_samples() : u64 {
        378
    }

    public fun oracle_quorum() : u64 {
        372
    }

    public fun oracle_source_disabled() : u64 {
        371
    }

    public fun oracle_source_unknown() : u64 {
        370
    }

    public fun oracle_spread() : u64 {
        373
    }

    public fun oracle_stale() : u64 {
        377
    }

    public fun order_too_large() : u64 {
        131
    }

    public fun overflow() : u64 {
        137
    }

    public fun policy_already_granted() : u64 {
        286
    }

    public fun policy_bad_param() : u64 {
        288
    }

    public fun policy_book_mismatch() : u64 {
        287
    }

    public fun policy_cycle_cap() : u64 {
        283
    }

    public fun policy_executions() : u64 {
        285
    }

    public fun policy_expired() : u64 {
        282
    }

    public fun policy_not_found() : u64 {
        280
    }

    public fun policy_paused() : u64 {
        281
    }

    public fun policy_period_cap() : u64 {
        284
    }

    public fun pool_not_allowed() : u64 {
        192
    }

    public fun price_bad_guard() : u64 {
        259
    }

    public fun price_bad_scale() : u64 {
        260
    }

    public fun price_deviation() : u64 {
        256
    }

    public fun price_feed_mismatch() : u64 {
        250
    }

    public fun price_feed_paused() : u64 {
        251
    }

    public fun price_future_skew() : u64 {
        253
    }

    public fun price_out_of_bounds() : u64 {
        255
    }

    public fun price_receipt_mismatch() : u64 {
        258
    }

    public fun price_replay() : u64 {
        254
    }

    public fun price_stale() : u64 {
        252
    }

    public fun price_zero() : u64 {
        257
    }

    public fun product_halted() : u64 {
        341
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

    public fun setup_not_finalized() : u64 {
        8
    }

    public fun share_owner_mismatch() : u64 {
        66
    }

    public fun slippage_exceeded() : u64 {
        193
    }

    public fun strategy_bounds() : u64 {
        163
    }

    public fun strategy_cap_mismatch() : u64 {
        160
    }

    public fun strategy_deadline() : u64 {
        162
    }

    public fun strategy_nonce() : u64 {
        161
    }

    public fun unauthorized() : u64 {
        10
    }

    public fun unknown_dex() : u64 {
        5
    }

    public fun unknown_product() : u64 {
        340
    }

    public fun vault_mismatch() : u64 {
        63
    }

    public fun vault_not_empty() : u64 {
        69
    }

    public fun venue_bad_param() : u64 {
        230
    }

    public fun venue_book_frozen() : u64 {
        226
    }

    public fun venue_book_mismatch() : u64 {
        227
    }

    public fun venue_cap_exceeded() : u64 {
        225
    }

    public fun venue_disabled() : u64 {
        222
    }

    public fun venue_not_allowed() : u64 {
        224
    }

    public fun venue_unknown() : u64 {
        220
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

