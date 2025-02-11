module 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error {
    public fun acl_invalid_permission() : u64 {
        1025
    }

    public fun acl_role_already_exists() : u64 {
        1026
    }

    public fun acl_role_not_exists() : u64 {
        1027
    }

    public fun create_market_invalid_sender() : u64 {
        833
    }

    public fun emission_exceeds_total_reward() : u64 {
        1282
    }

    public fun factory_invalid_expiry() : u64 {
        516
    }

    public fun factory_invalid_py() : u64 {
        818
    }

    public fun factory_invalid_yt_amount() : u64 {
        517
    }

    public fun factory_yc_expired() : u64 {
        520
    }

    public fun factory_yc_not_expired() : u64 {
        521
    }

    public fun factory_zero_expiry_divisor() : u64 {
        515
    }

    public fun insufficient_lp_output() : u64 {
        836
    }

    public fun interest_fee_rate_too_high() : u64 {
        513
    }

    public fun invalid_argument(arg0: u64) : u64 {
        arg0
    }

    public fun invalid_epoch() : u64 {
        834
    }

    public fun invalid_flash_loan_position() : u64 {
        832
    }

    public fun invalid_py_amount() : u64 {
        819
    }

    public fun invalid_py_state() : u64 {
        528
    }

    public fun invalid_repay() : u64 {
        806
    }

    public fun invalid_reward_amount() : u64 {
        1280
    }

    public fun invalid_reward_end_time() : u64 {
        1281
    }

    public fun invalid_sy_approx_out() : u64 {
        1032
    }

    public fun invalid_yt_approx_out() : u64 {
        1031
    }

    public fun market_burn_pt_amount_is_zero() : u64 {
        792
    }

    public fun market_burn_sy_amount_is_zero() : u64 {
        791
    }

    public fun market_cap_exceeded() : u64 {
        805
    }

    public fun market_exchange_rate_below_one() : u64 {
        790
    }

    public fun market_exchange_rate_can_not_be_one() : u64 {
        789
    }

    public fun market_exchange_rate_negative() : u64 {
        786
    }

    public fun market_exists() : u64 {
        774
    }

    public fun market_expired() : u64 {
        784
    }

    public fun market_factory_reserve_fee_too_high() : u64 {
        773
    }

    public fun market_initial_anchor_too_low() : u64 {
        772
    }

    public fun market_insufficient_lp_for_burn() : u64 {
        824
    }

    public fun market_insufficient_pt_for_swap() : u64 {
        793
    }

    public fun market_insufficient_pt_in_for_mint_lp() : u64 {
        820
    }

    public fun market_insufficient_sy_for_swap() : u64 {
        801
    }

    public fun market_insufficient_sy_in_for_swap_yt() : u64 {
        803
    }

    public fun market_insufficient_yt_balance_swap() : u64 {
        825
    }

    public fun market_invalid_market_position() : u64 {
        822
    }

    public fun market_invalid_py_state() : u64 {
        821
    }

    public fun market_liquidity_too_low() : u64 {
        785
    }

    public fun market_ln_fee_rate_too_high() : u64 {
        771
    }

    public fun market_ln_implied_rate_is_zero() : u64 {
        790
    }

    public fun market_lp_amount_is_zero() : u64 {
        823
    }

    public fun market_proportion_can_not_be_one() : u64 {
        788
    }

    public fun market_proportion_too_high() : u64 {
        787
    }

    public fun market_pt_amount_is_zero() : u64 {
        776
    }

    public fun market_pt_expired() : u64 {
        770
    }

    public fun market_rate_scalar_negative() : u64 {
        800
    }

    public fun market_scalar_root_below_zero() : u64 {
        769
    }

    public fun market_scalar_root_is_zero() : u64 {
        775
    }

    public fun market_sy_amount_is_zero() : u64 {
        777
    }

    public fun mismatch_yt_pt_tokens() : u64 {
        519
    }

    public fun pool_rewarder_already_active() : u64 {
        1283
    }

    public fun pool_rewarder_not_active() : u64 {
        1285
    }

    public fun price_fluctuation_too_large() : u64 {
        837
    }

    public fun py_contract_exists() : u64 {
        518
    }

    public fun register_sy_invalid_sender() : u64 {
        807
    }

    public fun register_sy_type_already_registered() : u64 {
        809
    }

    public fun register_sy_type_not_registered() : u64 {
        816
    }

    public fun repay_sy_in_exceeds_expected_sy_in() : u64 {
        802
    }

    public fun reward_fee_rate_too_high() : u64 {
        514
    }

    public fun reward_not_harvested() : u64 {
        1286
    }

    public fun reward_token_type_mismatch() : u64 {
        1284
    }

    public fun swap_exact_yt_amount_mismatch() : u64 {
        835
    }

    public fun swapped_sy_borrowed_amount_not_equal() : u64 {
        804
    }

    public fun sy_insufficient_amountOut() : u64 {
        260
    }

    public fun sy_insufficient_repay() : u64 {
        817
    }

    public fun sy_insufficient_sharesOut() : u64 {
        258
    }

    public fun sy_not_supported() : u64 {
        808
    }

    public fun sy_zero_deposit() : u64 {
        257
    }

    public fun sy_zero_redeem() : u64 {
        259
    }

    public fun update_config_invalid_sender() : u64 {
        1029
    }

    public fun version_mismatch_error() : u64 {
        1028
    }

    public fun withdraw_from_treasury_invalid_sender() : u64 {
        1030
    }

    public fun wrong_slippage_tolerance() : u64 {
        1033
    }

    // decompiled from Move bytecode v6
}

