module 0xe0905cfef8329eddf62ba7d7ffe4ac1efd008307137b9d07e5f378c00aae729e::errors {
    public fun err_flash_loan_amount_mismatch() : u64 {
        abort 502
    }

    public fun err_flash_loan_failed() : u64 {
        abort 500
    }

    public fun err_flash_loan_repay_failed() : u64 {
        abort 501
    }

    public fun err_global_close_paused() : u64 {
        abort 205
    }

    public fun err_global_open_paused() : u64 {
        abort 204
    }

    public fun err_insufficient_collateral() : u64 {
        abort 303
    }

    public fun err_insufficient_fee() : u64 {
        abort 901
    }

    public fun err_insufficient_liquidation_reward() : u64 {
        abort 402
    }

    public fun err_insufficient_output() : u64 {
        abort 703
    }

    public fun err_invalid_action() : u64 {
        abort 1101
    }

    public fun err_invalid_config_permission() : u64 {
        abort 1001
    }

    public fun err_invalid_deposit_type() : u64 {
        abort 308
    }

    public fun err_invalid_fee_rate() : u64 {
        abort 900
    }

    public fun err_invalid_leverage_equal_to_zero() : u64 {
        abort 300
    }

    public fun err_invalid_leverage_too_high() : u64 {
        abort 301
    }

    public fun err_invalid_market_permission() : u64 {
        abort 1000
    }

    public fun err_invalid_position_type() : u64 {
        abort 306
    }

    public fun err_leverage_too_high() : u64 {
        abort 301
    }

    public fun err_leverage_too_low() : u64 {
        abort 302
    }

    public fun err_liquidation_failed() : u64 {
        abort 401
    }

    public fun err_market_already_exists() : u64 {
        abort 201
    }

    public fun err_market_close_paused() : u64 {
        abort 203
    }

    public fun err_market_not_found() : u64 {
        abort 200
    }

    public fun err_market_open_paused() : u64 {
        abort 202
    }

    public fun err_not_admin() : u64 {
        abort 100
    }

    public fun err_not_owner() : u64 {
        abort 101
    }

    public fun err_obligation_unhealthy() : u64 {
        abort 604
    }

    public fun err_position_already_exists() : u64 {
        abort 309
    }

    public fun err_position_balance_not_zero() : u64 {
        abort 307
    }

    public fun err_position_cap_not_match() : u64 {
        abort 310
    }

    public fun err_position_healthy() : u64 {
        abort 400
    }

    public fun err_position_not_found() : u64 {
        abort 304
    }

    public fun err_position_unhealthy() : u64 {
        abort 305
    }

    public fun err_price_feed_error() : u64 {
        abort 700
    }

    public fun err_slippage_too_high() : u64 {
        abort 701
    }

    public fun err_suilend_borrow_failed() : u64 {
        abort 601
    }

    public fun err_suilend_deposit_failed() : u64 {
        abort 600
    }

    public fun err_suilend_repay_failed() : u64 {
        abort 603
    }

    public fun err_suilend_withdraw_failed() : u64 {
        abort 602
    }

    public fun err_swap_failed() : u64 {
        abort 702
    }

    public fun err_system_error() : u64 {
        abort 801
    }

    public fun err_unauthorized() : u64 {
        abort 102
    }

    public fun err_wrong_version() : u64 {
        abort 800
    }

    // decompiled from Move bytecode v6
}

