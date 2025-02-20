module 0xc926cbdf24f97c2c791a3f502a7de123099020e60c59e2305a771a383de0d84b::error {
    public fun amount_in_above_max_limit() : u64 {
        abort 1
    }

    public fun assets_and_prices_size_not_match() : u64 {
        abort 39
    }

    public fun aum_done_err() : u64 {
        abort 22
    }

    public fun clmm_pool_not_match() : u64 {
        abort 25
    }

    public fun fee_claim_err() : u64 {
        abort 20
    }

    public fun hard_cap_reached() : u64 {
        abort 5
    }

    public fun incorrect_repay() : u64 {
        abort 6
    }

    public fun incorrect_repay_type() : u64 {
        abort 7
    }

    public fun invalid_liquidity_range() : u64 {
        abort 18
    }

    public fun invalid_oracle_price() : u64 {
        abort 31
    }

    public fun invalid_price_feed_id() : u64 {
        abort 30
    }

    public fun invalid_protocol_fee_rate() : u64 {
        abort 13
    }

    public fun mining_claim_err() : u64 {
        abort 21
    }

    public fun no_operation_manager_permission() : u64 {
        abort 9
    }

    public fun no_oracle_manager_permission() : u64 {
        abort 11
    }

    public fun no_pool_manager_permission() : u64 {
        abort 10
    }

    public fun no_protocol_fee_claim_permission() : u64 {
        abort 8
    }

    public fun operation_not_allowed() : u64 {
        abort 27
    }

    public fun oracle_info_exists() : u64 {
        abort 28
    }

    public fun oracle_info_not_exists() : u64 {
        abort 29
    }

    public fun package_version_deprecate() : u64 {
        abort 12
    }

    public fun pool_is_pause() : u64 {
        abort 19
    }

    public fun pool_not_need_rebalance() : u64 {
        abort 23
    }

    public fun price_err() : u64 {
        abort 34
    }

    public fun price_not_exists() : u64 {
        abort 37
    }

    public fun price_not_stale() : u64 {
        abort 36
    }

    public fun price_object_not_match_with_coin_type() : u64 {
        abort 32
    }

    public fun quote_type_error() : u64 {
        abort 33
    }

    public fun remove_assets_not_empty() : u64 {
        abort 24
    }

    public fun slippage_config_exists() : u64 {
        abort 16
    }

    public fun slippage_config_not_exists() : u64 {
        abort 17
    }

    public fun token_amount_is_zero() : u64 {
        abort 3
    }

    public fun token_amount_not_enough() : u64 {
        abort 4
    }

    public fun token_amount_overflow() : u64 {
        abort 2
    }

    public fun treasury_cap_illegal() : u64 {
        abort 14
    }

    public fun update_price_fee_not_enough() : u64 {
        abort 35
    }

    public fun withdraw_cert_not_match() : u64 {
        abort 38
    }

    public fun withdraw_cert_pool_id_not_match() : u64 {
        abort 26
    }

    public fun wrong_package_version() : u64 {
        abort 15
    }

    // decompiled from Move bytecode v6
}

