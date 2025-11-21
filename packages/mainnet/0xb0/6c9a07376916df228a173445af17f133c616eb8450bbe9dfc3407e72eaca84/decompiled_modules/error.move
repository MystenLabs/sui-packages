module 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error {
    public fun asset_already_collateral() : u64 {
        1797
    }

    public fun asset_already_onboarded() : u64 {
        257
    }

    public fun asset_not_collateral() : u64 {
        1798
    }

    public fun borrow_paused_for_asset() : u64 {
        1285
    }

    public fun constraint_double_support_ctoken() : u64 {
        262144
    }

    public fun constraint_split_ctoken_too_many() : u64 {
        262145
    }

    public fun deposit_paused_for_asset() : u64 {
        1808
    }

    public fun emode_group_not_exists() : u64 {
        1000001
    }

    public fun flash_loan_not_ongoing() : u64 {
        1283
    }

    public fun flash_loan_ongoing() : u64 {
        1283
    }

    public fun flash_loan_paused_for_asset() : u64 {
        1282
    }

    public fun flash_loan_repay_not_enough_error() : u64 {
        1286
    }

    public fun group_already_supports_asset() : u64 {
        1000002
    }

    public fun invalid_market() : u64 {
        262146
    }

    public fun invalid_params_error() : u64 {
        2307
    }

    public fun invariant_borrow_index_incremental() : u64 {
        131073
    }

    public fun invariant_seize_tokens_crazy_big() : u64 {
        131076
    }

    public fun liquidation_close_factor_exceeded() : u64 {
        196609
    }

    public fun liquidation_obligation_still_safe() : u64 {
        196608
    }

    public fun liquidation_zero_repay() : u64 {
        196610
    }

    public fun market_already_exists() : u64 {
        262147
    }

    public fun market_borrow_limit_exceeded() : u64 {
        4098
    }

    public fun market_cash_reserve_not_enough() : u64 {
        4097
    }

    public fun market_deposit_limit_exceeded() : u64 {
        1793
    }

    public fun market_not_found() : u64 {
        262145
    }

    public fun market_under_circuit_break() : u64 {
        1001
    }

    public fun max_emode_groups_reached() : u64 {
        1000000
    }

    public fun obligation_borrow_below_min() : u64 {
        771
    }

    public fun obligation_borrow_collateral_asset() : u64 {
        772
    }

    public fun obligation_deposit_borrowed_asset() : u64 {
        775
    }

    public fun obligation_from_different_market() : u64 {
        770
    }

    public fun obligation_not_safe_after_operation() : u64 {
        773
    }

    public fun obligation_withdraw_no_deposit() : u64 {
        774
    }

    public fun oracle_price_not_found_error() : u64 {
        1026
    }

    public fun oracle_stale_price_error() : u64 {
        1025
    }

    public fun oracle_zero_price_error() : u64 {
        1027
    }

    public fun outflow_reach_limit_error() : u64 {
        4097
    }

    public fun reserve_flash_loan_fee_too_small() : u64 {
        2052
    }

    public fun reserve_flash_loan_more_than_cash() : u64 {
        2053
    }

    public fun reserve_flash_loan_not_paid_enough() : u64 {
        2051
    }

    public fun reserve_not_enough_error() : u64 {
        81924
    }

    public fun reserve_zero_coin_not_allowed() : u64 {
        2050
    }

    public fun version_mismatch() : u64 {
        1000
    }

    public fun version_mismatch_error() : u64 {
        513
    }

    public fun withdraw_paused_for_asset() : u64 {
        1801
    }

    public fun zero_debt_to_repay_error() : u64 {
        86018
    }

    // decompiled from Move bytecode v6
}

