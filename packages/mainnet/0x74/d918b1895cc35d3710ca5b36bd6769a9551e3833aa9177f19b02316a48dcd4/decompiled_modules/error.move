module 0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::error {
    public(friend) fun adl_already_has_coin() : u64 {
        601
    }

    public(friend) fun adl_emode_group_not_found() : u64 {
        604
    }

    public(friend) fun adl_no_coin() : u64 {
        600
    }

    public(friend) fun adl_not_activated_by_time() : u64 {
        602
    }

    public(friend) fun adl_within_limit() : u64 {
        603
    }

    public(friend) fun already_under_circuit_break() : u64 {
        116
    }

    public(friend) fun asset_already_collateral() : u64 {
        100
    }

    public(friend) fun asset_already_onboarded() : u64 {
        110
    }

    public(friend) fun asset_not_collateral() : u64 {
        101
    }

    public(friend) fun borrow_paused_for_asset() : u64 {
        208
    }

    public(friend) fun caller_has_no_permission() : u64 {
        115
    }

    public(friend) fun caller_not_whitelisted() : u64 {
        114
    }

    public(friend) fun coin_decimals_registry_already_registered() : u64 {
        111
    }

    public(friend) fun constraint_double_support_ctoken() : u64 {
        102
    }

    public(friend) fun constraint_split_ctoken_too_many() : u64 {
        203
    }

    public(friend) fun deposit_paused_for_asset() : u64 {
        200
    }

    public(friend) fun emode_borrow_limit_exceeded() : u64 {
        206
    }

    public(friend) fun emode_group_already_supports_asset() : u64 {
        502
    }

    public(friend) fun emode_group_does_not_support_asset() : u64 {
        503
    }

    public(friend) fun emode_group_not_exists() : u64 {
        501
    }

    public(friend) fun flash_loan_not_ongoing() : u64 {
        406
    }

    public(friend) fun flash_loan_ongoing() : u64 {
        405
    }

    public(friend) fun flash_loan_paused_for_asset() : u64 {
        404
    }

    public(friend) fun flash_loan_repay_not_enough_error() : u64 {
        407
    }

    public(friend) fun invalid_market() : u64 {
        108
    }

    public(friend) fun invalid_operation_status() : u64 {
        119
    }

    public(friend) fun invalid_params_error() : u64 {
        104
    }

    public(friend) fun invariant_borrow_index_incremental() : u64 {
        112
    }

    public(friend) fun invariant_seize_tokens_crazy_big() : u64 {
        113
    }

    public(friend) fun liquidation_close_factor_exceeded() : u64 {
        606
    }

    public(friend) fun liquidation_obligation_still_safe() : u64 {
        605
    }

    public(friend) fun liquidation_paused_for_asset() : u64 {
        214
    }

    public(friend) fun liquidation_zero_repay() : u64 {
        607
    }

    public(friend) fun liquidity_mining_invalid_start_time() : u64 {
        707
    }

    public(friend) fun liquidity_mining_invalid_time() : u64 {
        700
    }

    public(friend) fun liquidity_mining_invalid_type() : u64 {
        701
    }

    public(friend) fun liquidity_mining_max_concurrent_pool_rewards_violated() : u64 {
        702
    }

    public(friend) fun liquidity_mining_no_reward_to_claim() : u64 {
        708
    }

    public(friend) fun liquidity_mining_not_all_rewards_claimed() : u64 {
        703
    }

    public(friend) fun liquidity_mining_pool_initialized() : u64 {
        706
    }

    public(friend) fun liquidity_mining_pool_not_initialized() : u64 {
        705
    }

    public(friend) fun liquidity_mining_pool_reward_period_not_over() : u64 {
        704
    }

    public(friend) fun market_already_exists() : u64 {
        107
    }

    public(friend) fun market_borrow_limit_exceeded() : u64 {
        218
    }

    public(friend) fun market_cash_reserve_not_enough() : u64 {
        205
    }

    public(friend) fun market_deposit_limit_exceeded() : u64 {
        207
    }

    public(friend) fun market_not_found() : u64 {
        106
    }

    public(friend) fun market_under_circuit_break() : u64 {
        103
    }

    public(friend) fun max_emode_groups_reached() : u64 {
        500
    }

    public(friend) fun no_zero_amount() : u64 {
        213
    }

    public(friend) fun not_found_in_coin_decimals_registry() : u64 {
        999
    }

    public(friend) fun not_under_circuit_break() : u64 {
        117
    }

    public(friend) fun obligation_borrow_below_min() : u64 {
        209
    }

    public(friend) fun obligation_borrow_collateral_asset() : u64 {
        210
    }

    public(friend) fun obligation_deposit_borrowed_asset() : u64 {
        212
    }

    public(friend) fun obligation_from_different_market() : u64 {
        204
    }

    public(friend) fun obligation_not_safe_after_operation() : u64 {
        201
    }

    public(friend) fun obligation_withdraw_no_deposit() : u64 {
        211
    }

    public(friend) fun outflow_reach_limit_error() : u64 {
        105
    }

    public(friend) fun referral_already_has_referral_code() : u64 {
        801
    }

    public(friend) fun referral_claim_paused() : u64 {
        806
    }

    public(friend) fun referral_claim_zero_value_rebate() : u64 {
        807
    }

    public(friend) fun referral_invalid_referral_code() : u64 {
        803
    }

    public(friend) fun referral_no_rebates() : u64 {
        800
    }

    public(friend) fun referral_no_referral_code() : u64 {
        804
    }

    public(friend) fun referral_no_self_reference() : u64 {
        808
    }

    public(friend) fun referral_not_qualified_to_gen_code() : u64 {
        802
    }

    public(friend) fun referral_rebate_no_token() : u64 {
        805
    }

    public(friend) fun reserve_flash_loan_fee_too_small() : u64 {
        402
    }

    public(friend) fun reserve_flash_loan_more_than_cash() : u64 {
        403
    }

    public(friend) fun reserve_flash_loan_not_paid_enough() : u64 {
        401
    }

    public(friend) fun reserve_join_zero_value() : u64 {
        215
    }

    public(friend) fun reserve_not_enough_error() : u64 {
        109
    }

    public(friend) fun reserve_split_zero_value() : u64 {
        216
    }

    public(friend) fun reserve_zero_coin_not_allowed() : u64 {
        400
    }

    public(friend) fun take_too_much_revenue() : u64 {
        217
    }

    public(friend) fun updating_with_same_value() : u64 {
        118
    }

    public(friend) fun version_mismatch() : u64 {
        1
    }

    public(friend) fun withdraw_paused_for_asset() : u64 {
        202
    }

    // decompiled from Move bytecode v6
}

