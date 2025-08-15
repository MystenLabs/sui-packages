module 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::error {
    public fun asset_already_borrowable() : u64 {
        1799
    }

    public fun asset_already_collateral() : u64 {
        1797
    }

    public fun asset_already_onboarded() : u64 {
        257
    }

    public fun asset_deposit_paused() : u64 {
        1808
    }

    public fun asset_not_borrowable() : u64 {
        1800
    }

    public fun asset_not_collateral() : u64 {
        1798
    }

    public fun asset_withdraw_paused() : u64 {
        1801
    }

    public fun base_asset_not_active_error() : u64 {
        73729
    }

    public fun borrow_disabled() : u64 {
        1285
    }

    public fun borrow_limit_reached_error() : u64 {
        81925
    }

    public fun borrow_too_much_error() : u64 {
        1281
    }

    public fun borrow_too_small_error() : u64 {
        1282
    }

    public fun collateral_not_active_error() : u64 {
        73730
    }

    public fun collateral_not_enough() : u64 {
        81923
    }

    public fun constraint_double_support_ctoken() : u64 {
        262144
    }

    public fun constraint_repay_more_than_debt() : u64 {
        262146
    }

    public fun constraint_split_ctoken_too_many() : u64 {
        262145
    }

    public fun flash_loan_not_active() : u64 {
        1283
    }

    public fun flash_loan_ongoing() : u64 {
        1283
    }

    public fun flash_loan_repay_not_enough_error() : u64 {
        1286
    }

    public fun interest_model_param_error() : u64 {
        77826
    }

    public fun interest_model_type_not_match_error() : u64 {
        2305
    }

    public fun invalid_collateral_type_error() : u64 {
        1794
    }

    public fun invalid_market() : u64 {
        262146
    }

    public fun invalid_obligation_error() : u64 {
        769
    }

    public fun invalid_params_error() : u64 {
        2307
    }

    public fun invariant_borrow_index_incremental() : u64 {
        131073
    }

    public fun invariant_cash_and_balance_not_equal() : u64 {
        131074
    }

    public fun invariant_liquidation_repay_non_zero_residule() : u64 {
        131075
    }

    public fun invariant_repay_result_sum_not_consistent() : u64 {
        131077
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

    public fun market_not_found() : u64 {
        262145
    }

    public fun max_deposit_reached_error() : u64 {
        1793
    }

    public fun mint_market_coin_too_small_error() : u64 {
        2049
    }

    public fun obligation_borrow_below_min() : u64 {
        771
    }

    public fun obligation_borrow_collateral_asset() : u64 {
        772
    }

    public fun obligation_cant_forcely_unlocked() : u64 {
        777
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

    public fun obligation_withdraw_non_collateral() : u64 {
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

    public fun pool_liquidity_not_enough_error() : u64 {
        81921
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

    public fun risk_model_param_error() : u64 {
        77825
    }

    public fun risk_model_type_not_match_error() : u64 {
        2306
    }

    public fun supply_limit_reached() : u64 {
        81922
    }

    public fun unable_to_borrow_a_collateral_coin() : u64 {
        1284
    }

    public fun unable_to_deposit_a_borrowed_coin() : u64 {
        1796
    }

    public fun unable_to_liquidate_error() : u64 {
        1537
    }

    public fun version_mismatch_error() : u64 {
        513
    }

    public fun withdraw_collateral_too_much_error() : u64 {
        1795
    }

    public fun zero_debt_to_repay_error() : u64 {
        86018
    }

    public fun zero_repay_amount_error() : u64 {
        86017
    }

    // decompiled from Move bytecode v6
}

