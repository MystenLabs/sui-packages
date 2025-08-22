module 0x7655af2a24bad050beeae7ae2d6a8a9d06a2c61c6b64ac97332d3210a5ec726c::errors {
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

    public fun err_invalid_deposit_type() : u64 {
        abort 308
    }

    public fun err_invalid_fee_rate() : u64 {
        abort 900
    }

    public fun err_invalid_leverage() : u64 {
        abort 300
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

    public fun err_position_balance_not_zero() : u64 {
        abort 307
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

