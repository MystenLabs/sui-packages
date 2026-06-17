module 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors {
    public fun adapter_caller_not_escrow() : u64 {
        950
    }

    public fun adapter_no_position() : u64 {
        956
    }

    public fun adapter_paused() : u64 {
        955
    }

    public fun adapter_slippage_too_high() : u64 {
        952
    }

    public fun adapter_unknown_action() : u64 {
        953
    }

    public fun adapter_vault_not_allowed() : u64 {
        951
    }

    public fun adapter_zero_shares() : u64 {
        954
    }

    public fun asset_manager_mismatch() : u64 {
        409
    }

    public fun config_cooldown_not_expired() : u64 {
        302
    }

    public fun cooldown_change_timelock_active() : u64 {
        330
    }

    public fun destination_not_allowlisted() : u64 {
        410
    }

    public fun emergency_withdrawal_timelock_active() : u64 {
        504
    }

    public fun escrow_adapter_already_allowed() : u64 {
        901
    }

    public fun escrow_adapter_already_pending() : u64 {
        902
    }

    public fun escrow_adapter_delay_not_elapsed() : u64 {
        907
    }

    public fun escrow_adapter_disabled() : u64 {
        905
    }

    public fun escrow_adapter_not_active() : u64 {
        904
    }

    public fun escrow_adapter_not_allowed() : u64 {
        900
    }

    public fun escrow_aggregator_not_set() : u64 {
        890
    }

    public fun escrow_already_paused() : u64 {
        821
    }

    public fun escrow_amount_exceeds_max() : u64 {
        840
    }

    public fun escrow_cctp_destination_not_allowed() : u64 {
        880
    }

    public fun escrow_cctp_messenger_not_set() : u64 {
        882
    }

    public fun escrow_config_delay_not_elapsed() : u64 {
        874
    }

    public fun escrow_config_unchanged() : u64 {
        875
    }

    public fun escrow_cooldown_not_elapsed() : u64 {
        842
    }

    public fun escrow_daily_limit_exceeded() : u64 {
        841
    }

    public fun escrow_emergency_cooldown_not_met() : u64 {
        843
    }

    public fun escrow_force_paused_by_admin() : u64 {
        823
    }

    public fun escrow_insufficient_funds() : u64 {
        861
    }

    public fun escrow_insufficient_output() : u64 {
        893
    }

    public fun escrow_invalid_cooldown() : u64 {
        846
    }

    public fun escrow_invalid_limit() : u64 {
        848
    }

    public fun escrow_invalid_manager() : u64 {
        914
    }

    public fun escrow_invalid_mint_recipient() : u64 {
        883
    }

    public fun escrow_invalid_processor() : u64 {
        915
    }

    public fun escrow_limits_change_timelock_active() : u64 {
        847
    }

    public fun escrow_manager_change_cooldown_not_expired() : u64 {
        911
    }

    public fun escrow_max_adapters_reached() : u64 {
        906
    }

    public fun escrow_no_limits_changes() : u64 {
        844
    }

    public fun escrow_no_pending_adapter() : u64 {
        903
    }

    public fun escrow_no_pending_config() : u64 {
        873
    }

    public fun escrow_no_pending_limits_change() : u64 {
        845
    }

    public fun escrow_no_pending_manager_change() : u64 {
        910
    }

    public fun escrow_no_pending_processor_change() : u64 {
        912
    }

    public fun escrow_no_pending_withdraw_destination() : u64 {
        878
    }

    public fun escrow_not_paused() : u64 {
        822
    }

    public fun escrow_processor_change_cooldown_not_expired() : u64 {
        913
    }

    public fun escrow_swap_tokens_must_differ() : u64 {
        892
    }

    public fun escrow_token_not_allowed() : u64 {
        891
    }

    public fun escrow_withdraw_destination_already_allowed() : u64 {
        877
    }

    public fun escrow_withdraw_destination_delay_not_elapsed() : u64 {
        879
    }

    public fun escrow_withdraw_destination_not_allowed() : u64 {
        876
    }

    public fun escrow_zero_amount() : u64 {
        862
    }

    public fun factory_no_pending_version_change() : u64 {
        703
    }

    public fun factory_version_change_timelock_active() : u64 {
        704
    }

    public fun factory_version_unchanged() : u64 {
        702
    }

    public fun fee_calculation_error() : u64 {
        19
    }

    public fun fee_change_timelock_active() : u64 {
        320
    }

    public fun governance_no_op() : u64 {
        343
    }

    public fun incompatible_underlying_tokens() : u64 {
        402
    }

    public fun initialization_failed() : u64 {
        40
    }

    public fun insufficient_balance() : u64 {
        6
    }

    public fun insufficient_shares() : u64 {
        7
    }

    public fun insufficient_vault_funds() : u64 {
        214
    }

    public fun invalid_amount() : u64 {
        4
    }

    public fun invalid_argument() : u64 {
        5
    }

    public fun invalid_fee() : u64 {
        2
    }

    public fun invalid_limit() : u64 {
        43
    }

    public fun invalid_price() : u64 {
        3
    }

    public fun invalid_swap_same_vault() : u64 {
        401
    }

    public fun invalid_timestamp() : u64 {
        18
    }

    public fun limit_exceeds_maximum() : u64 {
        44
    }

    public fun math_overflow() : u64 {
        8
    }

    public fun max_shares_per_user_exceeded() : u64 {
        37
    }

    public fun max_total_idle_exceeded() : u64 {
        38
    }

    public fun max_total_shares_exceeded() : u64 {
        36
    }

    public fun minimum_shares_not_met() : u64 {
        45
    }

    public fun no_config_changes_pending() : u64 {
        303
    }

    public fun no_pending_cooldown_change() : u64 {
        332
    }

    public fun no_pending_fees_change() : u64 {
        322
    }

    public fun no_pending_price() : u64 {
        102
    }

    public fun no_pending_roles_change() : u64 {
        313
    }

    public fun no_pending_whitelist_change() : u64 {
        342
    }

    public fun not_upgrade() : u64 {
        10
    }

    public fun price_cooldown_not_expired() : u64 {
        41
    }

    public fun price_deviation_too_high() : u64 {
        103
    }

    public fun price_pending() : u64 {
        101
    }

    public fun price_too_old() : u64 {
        20
    }

    public fun price_update_too_frequent() : u64 {
        105
    }

    public fun proxy_already_initialized() : u64 {
        681
    }

    public fun proxy_already_paused() : u64 {
        621
    }

    public fun proxy_amount_exceeds_max() : u64 {
        640
    }

    public fun proxy_cooldown_not_elapsed() : u64 {
        642
    }

    public fun proxy_daily_limit_exceeded() : u64 {
        641
    }

    public fun proxy_force_paused() : u64 {
        623
    }

    public fun proxy_limits_change_timelock_active() : u64 {
        645
    }

    public fun proxy_no_limits_changes() : u64 {
        644
    }

    public fun proxy_no_pending_limits_change() : u64 {
        646
    }

    public fun proxy_no_pending_manager_change() : u64 {
        690
    }

    public fun proxy_no_pending_processor_change() : u64 {
        692
    }

    public fun proxy_not_paused() : u64 {
        622
    }

    public fun proxy_paused() : u64 {
        620
    }

    public fun proxy_target_already_exists() : u64 {
        672
    }

    public fun proxy_target_inactive() : u64 {
        671
    }

    public fun proxy_target_not_found() : u64 {
        670
    }

    public fun role_change_timelock_active() : u64 {
        310
    }

    public fun slippage_not_met() : u64 {
        42
    }

    public fun treasury_already_attached() : u64 {
        11
    }

    public fun treasury_attached_use_coin_withdraw() : u64 {
        13
    }

    public fun treasury_not_attached() : u64 {
        12
    }

    public fun unauthorized() : u64 {
        1
    }

    public fun user_not_whitelisted() : u64 {
        28
    }

    public fun vault_not_initialized() : u64 {
        15
    }

    public fun vault_not_paused() : u64 {
        502
    }

    public fun vault_paused() : u64 {
        50
    }

    public fun whitelist_change_timelock_active() : u64 {
        340
    }

    public fun whitelist_mode_not_enabled() : u64 {
        344
    }

    public fun withdrawal_already_cancelled() : u64 {
        203
    }

    public fun withdrawal_already_fulfilled() : u64 {
        202
    }

    public fun withdrawal_amount_too_low() : u64 {
        17
    }

    public fun withdrawal_request_not_found() : u64 {
        16
    }

    public fun wrong_version() : u64 {
        9
    }

    public fun zero_amount_calculated() : u64 {
        27
    }

    public fun zero_shares_calculated() : u64 {
        26
    }

    // decompiled from Move bytecode v7
}

