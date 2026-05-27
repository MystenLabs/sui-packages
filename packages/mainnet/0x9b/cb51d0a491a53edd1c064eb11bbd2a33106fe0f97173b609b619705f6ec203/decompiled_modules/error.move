module 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error {
    public(friend) fun err_cooldown_not_elapsed() {
        abort 206
    }

    public(friend) fun err_deprecated_function() {
        abort 1000
    }

    public(friend) fun err_exceed_capacity() {
        abort 404
    }

    public(friend) fun err_exceed_max_leverage() {
        abort 104
    }

    public(friend) fun err_exceed_max_open_interest() {
        abort 105
    }

    public(friend) fun err_exceed_oi_cap() {
        abort 411
    }

    public(friend) fun err_exceed_reserve_ratio() {
        abort 409
    }

    public(friend) fun err_insufficient_balance() {
        abort 601
    }

    public(friend) fun err_insufficient_collateral() {
        abort 202
    }

    public(friend) fun err_insufficient_deposit() {
        abort 406
    }

    public(friend) fun err_insufficient_free_liquidity() {
        abort 410
    }

    public(friend) fun err_insufficient_liquidity() {
        abort 403
    }

    public(friend) fun err_invalid_action() {
        abort 905
    }

    public(friend) fun err_invalid_collateral_type() {
        abort 208
    }

    public(friend) fun err_invalid_config() {
        abort 106
    }

    public(friend) fun err_invalid_linked_order() {
        abort 304
    }

    public(friend) fun err_invalid_order_type() {
        abort 301
    }

    public(friend) fun err_invalid_referral_code() {
        abort 702
    }

    public(friend) fun err_invalid_size() {
        abort 201
    }

    public(friend) fun err_invalid_trigger_price() {
        abort 302
    }

    public(friend) fun err_invalid_version() {
        abort 801
    }

    public(friend) fun err_market_not_active() {
        abort 100
    }

    public(friend) fun err_max_sub_accounts_reached() {
        abort 603
    }

    public(friend) fun err_missing_request_witness() {
        abort 900
    }

    public(friend) fun err_missing_response_witness() {
        abort 901
    }

    public(friend) fun err_no_redeem_request() {
        abort 408
    }

    public(friend) fun err_not_account_owner() {
        abort 600
    }

    public(friend) fun err_order_not_found() {
        abort 300
    }

    public(friend) fun err_pool_not_active() {
        abort 400
    }

    public(friend) fun err_position_flip_not_supported() {
        abort 207
    }

    public(friend) fun err_position_locked() {
        abort 902
    }

    public(friend) fun err_position_not_found() {
        abort 200
    }

    public(friend) fun err_position_not_liquidatable() {
        abort 203
    }

    public(friend) fun err_redeem_blocked_by_utilization() {
        abort 412
    }

    public(friend) fun err_redeem_not_ready() {
        abort 407
    }

    public(friend) fun err_reduce_only_requires_position() {
        abort 303
    }

    public(friend) fun err_referral_already_bound() {
        abort 700
    }

    public(friend) fun err_referral_code_being_set() {
        abort 703
    }

    public(friend) fun err_referral_code_not_exists() {
        abort 704
    }

    public(friend) fun err_self_referral() {
        abort 701
    }

    public(friend) fun err_slippage_exceeded() {
        abort 405
    }

    public(friend) fun err_stale_price() {
        abort 501
    }

    public(friend) fun err_sub_account_name_too_long() {
        abort 604
    }

    public(friend) fun err_sub_account_not_found() {
        abort 602
    }

    public(friend) fun err_symbol_already_exists() {
        abort 101
    }

    public(friend) fun err_symbol_not_active() {
        abort 103
    }

    public(friend) fun err_symbol_not_exists() {
        abort 102
    }

    public(friend) fun err_token_already_supported() {
        abort 402
    }

    public(friend) fun err_token_not_supported() {
        abort 401
    }

    public(friend) fun err_too_many_linked_orders() {
        abort 204
    }

    public(friend) fun err_trading_slippage_exceeded() {
        abort 903
    }

    public(friend) fun err_unauthorized() {
        abort 800
    }

    public(friend) fun err_user_mismatch() {
        abort 205
    }

    public(friend) fun err_witness_already_exists() {
        abort 904
    }

    public(friend) fun err_zero_price() {
        abort 500
    }

    // decompiled from Move bytecode v7
}

