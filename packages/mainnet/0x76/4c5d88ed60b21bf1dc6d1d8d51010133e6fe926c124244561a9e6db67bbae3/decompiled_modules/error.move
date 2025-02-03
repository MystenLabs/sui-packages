module 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::error {
    public fun base_asset_not_active_error() : u64 {
        73729
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

    public fun flash_loan_not_paid_enough() : u64 {
        69633
    }

    public fun flash_loan_repay_not_enough_error() : u64 {
        1283
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

    public fun invalid_obligation_error() : u64 {
        769
    }

    public fun invalid_params_error() : u64 {
        2307
    }

    public fun max_collateral_reached_error() : u64 {
        1793
    }

    public fun mint_market_coin_too_small_error() : u64 {
        2049
    }

    public fun obligation_access_lock_key_not_in_store() : u64 {
        773
    }

    public fun obligation_access_reward_key_not_in_store() : u64 {
        774
    }

    public fun obligation_access_store_key_exists() : u64 {
        775
    }

    public fun obligation_access_store_key_not_found() : u64 {
        776
    }

    public fun obligation_already_locked() : u64 {
        772
    }

    public fun obligation_cant_forcely_unlocked() : u64 {
        777
    }

    public fun obligation_locked() : u64 {
        770
    }

    public fun obligation_unlock_with_wrong_key() : u64 {
        771
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

    public fun redeem_market_coin_too_small_error() : u64 {
        2050
    }

    public fun reserve_not_enough_error() : u64 {
        81924
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

    public fun unable_to_borrow_other_coin_with_isolated_asset() : u64 {
        1285
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

    public fun whitelist_error() : u64 {
        257
    }

    public fun withdraw_collateral_too_much_error() : u64 {
        1795
    }

    public fun zero_repay_amount_error() : u64 {
        86017
    }

    // decompiled from Move bytecode v6
}

