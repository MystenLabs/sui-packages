module 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::admin {
    public fun add_force_rebalance_df<T0, T1, T2, T3: copy + drop + store>(arg0: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::admin_control::RiskAdminCap, arg1: &mut 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::Vault<T0, T1, T2, T3>) {
        0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::add_force_rebalance_df<T0, T1, T2, T3>(arg1);
    }

    public fun issue_vault_cap<T0, T1, T2, T3: copy + drop + store>(arg0: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::admin_control::TreasuryAdminCap, arg1: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::Vault<T0, T1, T2, T3>, arg2: &mut 0x2::tx_context::TxContext) {
        0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::issue_vault_cap<T0, T1, T2, T3>(arg1, arg2);
    }

    public fun pause_vault<T0, T1, T2, T3: copy + drop + store>(arg0: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::admin_control::PauseAdminCap, arg1: &mut 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::Vault<T0, T1, T2, T3>) {
        0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::pause<T0, T1, T2, T3>(arg1);
    }

    public fun set_active_vault_cap<T0, T1, T2, T3: copy + drop + store>(arg0: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::admin_control::TreasuryAdminCap, arg1: &mut 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::Vault<T0, T1, T2, T3>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::set_active_vault_cap<T0, T1, T2, T3>(arg1, arg2, arg3);
    }

    public fun set_deposit_enable<T0, T1, T2, T3: copy + drop + store>(arg0: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::admin_control::RiskAdminCap, arg1: &mut 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::Vault<T0, T1, T2, T3>, arg2: bool) {
        0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::set_deposit_enable<T0, T1, T2, T3>(arg1, arg2);
    }

    public fun set_deposit_limit<T0, T1, T2, T3: copy + drop + store>(arg0: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::admin_control::RiskAdminCap, arg1: &mut 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::Vault<T0, T1, T2, T3>, arg2: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::VaultCap, arg3: u64) {
        0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::set_deposit_limit<T0, T1, T2, T3>(arg1, arg2, arg3);
    }

    public fun set_fee<T0, T1, T2, T3: copy + drop + store>(arg0: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::admin_control::FeeAdminCap, arg1: &mut 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::Vault<T0, T1, T2, T3>, arg2: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::VaultCap, arg3: u64) {
        0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::set_fee<T0, T1, T2, T3>(arg1, arg2, arg3);
    }

    public fun set_free_threshold_a<T0, T1, T2, T3: copy + drop + store>(arg0: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::admin_control::RiskAdminCap, arg1: &mut 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::Vault<T0, T1, T2, T3>, arg2: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::VaultCap, arg3: u64) {
        0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::set_free_threshold_a<T0, T1, T2, T3>(arg1, arg2, arg3);
    }

    public fun set_free_threshold_b<T0, T1, T2, T3: copy + drop + store>(arg0: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::admin_control::RiskAdminCap, arg1: &mut 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::Vault<T0, T1, T2, T3>, arg2: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::VaultCap, arg3: u64) {
        0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::set_free_threshold_b<T0, T1, T2, T3>(arg1, arg2, arg3);
    }

    public fun set_lock_threshold_a<T0, T1, T2, T3: copy + drop + store>(arg0: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::admin_control::RiskAdminCap, arg1: &mut 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::Vault<T0, T1, T2, T3>, arg2: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::VaultCap, arg3: u64) {
        0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::set_lock_threshold_a<T0, T1, T2, T3>(arg1, arg2, arg3);
    }

    public fun set_lock_threshold_b<T0, T1, T2, T3: copy + drop + store>(arg0: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::admin_control::RiskAdminCap, arg1: &mut 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::Vault<T0, T1, T2, T3>, arg2: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::VaultCap, arg3: u64) {
        0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::set_lock_threshold_b<T0, T1, T2, T3>(arg1, arg2, arg3);
    }

    public fun set_position_price_scaling_for_vault<T0, T1, T2, T3: copy + drop + store>(arg0: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::admin_control::VaultConfigAdminCap, arg1: &mut 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::Vault<T0, T1, T2, T3>, arg2: u128, arg3: u128) {
        assert!(arg3 > arg2, 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::error::upper_lower_trigger_price_incompatible());
        0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::set_price_scalling<T0, T1, T2, T3>(arg1, arg2, arg3);
    }

    public fun set_rebalance_price_source<T0, T1, T2, T3: copy + drop + store>(arg0: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::admin_control::RebalanceAdminCap, arg1: &mut 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::Vault<T0, T1, T2, T3>, arg2: u8) {
        0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::set_rebalance_price_source<T0, T1, T2, T3>(arg1, arg2);
    }

    public fun set_slippage<T0, T1, T2>(arg0: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::admin_control::RiskAdminCap, arg1: &mut 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::Vault<T0, T1, T2, 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::config::Uncorrelated>, arg2: u128, arg3: u128) {
        0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::set_slippage<T0, T1, T2, 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::config::Uncorrelated>(arg1, arg2, arg3);
    }

    public fun set_target_adapter<T0, T1, T2>(arg0: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::admin_control::RebalanceAdminCap, arg1: &mut 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::Vault<T0, T1, T2, 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::config::Drift>, arg2: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::VaultCap, arg3: 0x1::ascii::String) {
        0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::set_target_adapter<T0, T1, T2>(arg1, arg2, arg3);
    }

    public fun set_trigger_scalling<T0, T1, T2>(arg0: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::admin_control::VaultConfigAdminCap, arg1: &mut 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::Vault<T0, T1, T2, 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::config::Uncorrelated>, arg2: u128, arg3: u128) {
        assert!(arg3 > arg2, 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::error::upper_lower_trigger_price_incompatible());
        0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::config::set_trigger_price_scalling(0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::borrow_mut_config<T0, T1, T2, 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::config::Uncorrelated>(arg1), arg2, arg3);
    }

    public fun set_uc_is_target_reverse<T0, T1, T2>(arg0: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::admin_control::RebalanceAdminCap, arg1: &mut 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::Vault<T0, T1, T2, 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::config::Uncorrelated>, arg2: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::VaultCap, arg3: bool) {
        0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::set_uc_is_target_reverse<T0, T1, T2>(arg1, arg2, arg3);
    }

    public fun set_uc_target_adapter<T0, T1, T2>(arg0: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::admin_control::RebalanceAdminCap, arg1: &mut 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::Vault<T0, T1, T2, 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::config::Uncorrelated>, arg2: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::VaultCap, arg3: 0x1::ascii::String) {
        0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::set_uc_target_adapter<T0, T1, T2>(arg1, arg2, arg3);
    }

    public fun set_upgeer_trigger_price_factor_drift<T0, T1, T2>(arg0: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::admin_control::VaultConfigAdminCap, arg1: &mut 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::Vault<T0, T1, T2, 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::config::Drift>, arg2: u128) {
        0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::config::set_drift_upper_trigger_price_scalling(0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::borrow_mut_config<T0, T1, T2, 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::config::Drift>(arg1), arg2);
    }

    public fun set_vault_parameters<T0, T1, T2, T3: copy + drop + store>(arg0: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::admin_control::VaultConfigAdminCap, arg1: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::admin_control::RiskAdminCap, arg2: &mut 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::Vault<T0, T1, T2, T3>, arg3: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::VaultCap, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64) {
        set_position_price_scaling_for_vault<T0, T1, T2, T3>(arg0, arg2, arg4, arg5);
        set_free_threshold_a<T0, T1, T2, T3>(arg1, arg2, arg3, arg8);
        set_free_threshold_b<T0, T1, T2, T3>(arg1, arg2, arg3, arg9);
        set_lock_threshold_a<T0, T1, T2, T3>(arg1, arg2, arg3, arg10);
        set_lock_threshold_b<T0, T1, T2, T3>(arg1, arg2, arg3, arg11);
        set_deposit_limit<T0, T1, T2, T3>(arg1, arg2, arg3, arg12);
    }

    public fun set_withdraw_fee<T0, T1, T2, T3: copy + drop + store>(arg0: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::admin_control::FeeAdminCap, arg1: &mut 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::Vault<T0, T1, T2, T3>, arg2: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::VaultCap, arg3: u64) {
        0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::set_withdraw_fee<T0, T1, T2, T3>(arg1, arg2, arg3);
    }

    public fun unpause_vault<T0, T1, T2, T3: copy + drop + store>(arg0: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::admin_control::UnpauseAdminCap, arg1: &mut 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::Vault<T0, T1, T2, T3>) {
        0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::unpause<T0, T1, T2, T3>(arg1);
    }

    public fun withdraw_fee_a<T0, T1, T2, T3: copy + drop + store>(arg0: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::admin_control::FeeAdminCap, arg1: &0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::acl::FeeReceiptAcl, arg2: &mut 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::Vault<T0, T1, T2, T3>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::PermissionedReceipt {
        0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::fee_receipt::issue_fee_receipt_with_coins<T0, T2>(arg1, 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::withdraw_fee_a<T0, T1, T2, T3>(arg2, arg3, arg4), arg4)
    }

    public fun withdraw_fee_b<T0, T1, T2, T3: copy + drop + store>(arg0: &0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::admin_control::FeeAdminCap, arg1: &0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::acl::FeeReceiptAcl, arg2: &mut 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::Vault<T0, T1, T2, T3>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::PermissionedReceipt {
        0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::fee_receipt::issue_fee_receipt_with_coins<T1, T2>(arg1, 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::vault::withdraw_fee_b<T0, T1, T2, T3>(arg2, arg3, arg4), arg4)
    }

    // decompiled from Move bytecode v6
}

