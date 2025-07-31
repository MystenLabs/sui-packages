module 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin {
    public fun add_force_rebalance_df<T0, T1, T2, T3: copy + drop + store>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::RiskAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, T3>) {
        0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::add_force_rebalance_df<T0, T1, T2, T3>(arg1);
    }

    public fun issue_vault_cap<T0, T1, T2, T3: copy + drop + store>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::TreasuryAdminCap, arg1: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, T3>, arg2: &mut 0x2::tx_context::TxContext) {
        0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::issue_vault_cap<T0, T1, T2, T3>(arg1, arg2);
    }

    public fun pause_vault<T0, T1, T2, T3: copy + drop + store>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::PauseAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, T3>) {
        0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::pause<T0, T1, T2, T3>(arg1);
    }

    public fun set_active_vault_cap<T0, T1, T2, T3: copy + drop + store>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::TreasuryAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, T3>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::set_active_vault_cap_internal<T0, T1, T2, T3>(arg1, arg2, arg3);
    }

    public fun set_deposit_enable<T0, T1, T2, T3: copy + drop + store>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::RiskAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, T3>, arg2: bool) {
        0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::set_deposit_enable<T0, T1, T2, T3>(arg1, arg2);
    }

    public fun set_deposit_limit<T0, T1, T2, T3: copy + drop + store>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::RiskAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, T3>, arg2: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::VaultCap, arg3: u64) {
        abort 0
    }

    public fun set_deposit_limit_safe<T0, T1, T2, T3: copy + drop + store>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::RiskAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, T3>, arg2: u64) {
        0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::set_deposit_limit_internal<T0, T1, T2, T3>(arg1, arg2);
    }

    public fun set_fee<T0, T1, T2, T3: copy + drop + store>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::FeeAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, T3>, arg2: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::VaultCap, arg3: u64) {
        abort 0
    }

    public fun set_fee_safe<T0, T1, T2, T3: copy + drop + store>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::FeeAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, T3>, arg2: u64) {
        0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::set_fee_val_internal<T0, T1, T2, T3>(arg1, arg2);
    }

    public fun set_free_threshold_a<T0, T1, T2, T3: copy + drop + store>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::RiskAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, T3>, arg2: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::VaultCap, arg3: u64) {
        abort 0
    }

    public fun set_free_threshold_a_safe<T0, T1, T2, T3: copy + drop + store>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::RiskAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, T3>, arg2: u64) {
        0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::set_free_threshold_a_internal<T0, T1, T2, T3>(arg1, arg2);
    }

    public fun set_free_threshold_b<T0, T1, T2, T3: copy + drop + store>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::RiskAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, T3>, arg2: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::VaultCap, arg3: u64) {
        abort 0
    }

    public fun set_free_threshold_b_safe<T0, T1, T2, T3: copy + drop + store>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::RiskAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, T3>, arg2: u64) {
        0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::set_free_threshold_b_internal<T0, T1, T2, T3>(arg1, arg2);
    }

    public fun set_lock_threshold_a<T0, T1, T2, T3: copy + drop + store>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::RiskAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, T3>, arg2: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::VaultCap, arg3: u64) {
        abort 0
    }

    public fun set_lock_threshold_a_safe<T0, T1, T2, T3: copy + drop + store>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::RiskAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, T3>, arg2: u64) {
        0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::set_lock_threshold_a_internal<T0, T1, T2, T3>(arg1, arg2);
    }

    public fun set_lock_threshold_b<T0, T1, T2, T3: copy + drop + store>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::RiskAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, T3>, arg2: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::VaultCap, arg3: u64) {
        abort 0
    }

    public fun set_lock_threshold_b_safe<T0, T1, T2, T3: copy + drop + store>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::RiskAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, T3>, arg2: u64) {
        0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::set_lock_threshold_b_internal<T0, T1, T2, T3>(arg1, arg2);
    }

    public fun set_position_price_scaling_for_vault<T0, T1, T2, T3: copy + drop + store>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::VaultConfigAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, T3>, arg2: u128, arg3: u128) {
        assert!(arg3 > arg2, 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::error::upper_lower_trigger_price_incompatible());
        0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::set_price_scalling<T0, T1, T2, T3>(arg1, arg2, arg3);
    }

    public fun set_rebalance_price_source<T0, T1, T2, T3: copy + drop + store>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::RebalanceAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, T3>, arg2: u8) {
        0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::set_rebalance_price_source<T0, T1, T2, T3>(arg1, arg2);
    }

    public fun set_slippage<T0, T1, T2>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::RiskAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::config::Uncorrelated>, arg2: u128, arg3: u128) {
        0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::set_slippage<T0, T1, T2, 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::config::Uncorrelated>(arg1, arg2, arg3);
    }

    public fun set_target_adapter<T0, T1, T2>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::RebalanceAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::config::Drift>, arg2: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::VaultCap, arg3: 0x1::ascii::String) {
        abort 0
    }

    public fun set_target_adapter_safe<T0, T1, T2>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::RebalanceAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::config::Drift>, arg2: 0x1::ascii::String) {
        0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::set_target_adapter_internal<T0, T1, T2>(arg1, arg2);
    }

    public fun set_trigger_scalling<T0, T1, T2>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::VaultConfigAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::config::Uncorrelated>, arg2: u128, arg3: u128) {
        assert!(arg3 > arg2, 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::error::upper_lower_trigger_price_incompatible());
        0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::config::set_trigger_price_scalling(0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::borrow_mut_config<T0, T1, T2, 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::config::Uncorrelated>(arg1), arg2, arg3);
    }

    public fun set_uc_is_target_reverse<T0, T1, T2>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::RebalanceAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::config::Uncorrelated>, arg2: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::VaultCap, arg3: bool) {
        abort 0
    }

    public fun set_uc_is_target_reverse_safe<T0, T1, T2>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::RebalanceAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::config::Uncorrelated>, arg2: bool) {
        0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::set_uc_is_target_reverse_internal<T0, T1, T2>(arg1, arg2);
    }

    public fun set_uc_target_adapter<T0, T1, T2>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::RebalanceAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::config::Uncorrelated>, arg2: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::VaultCap, arg3: 0x1::ascii::String) {
        abort 0
    }

    public fun set_uc_target_adapter_safe<T0, T1, T2>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::RebalanceAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::config::Uncorrelated>, arg2: 0x1::ascii::String) {
        0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::set_uc_target_adapter_internal<T0, T1, T2>(arg1, arg2);
    }

    public fun set_upgeer_trigger_price_factor_drift<T0, T1, T2>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::VaultConfigAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::config::Drift>, arg2: u128) {
        0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::config::set_drift_upper_trigger_price_scalling(0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::borrow_mut_config<T0, T1, T2, 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::config::Drift>(arg1), arg2);
    }

    public fun set_vault_parameters<T0, T1, T2, T3: copy + drop + store>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::VaultConfigAdminCap, arg1: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::RiskAdminCap, arg2: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, T3>, arg3: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::VaultCap, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64) {
        abort 0
    }

    public fun set_withdraw_fee<T0, T1, T2, T3: copy + drop + store>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::FeeAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, T3>, arg2: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::VaultCap, arg3: u64) {
        abort 0
    }

    public fun set_withdraw_fee_safe<T0, T1, T2, T3: copy + drop + store>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::FeeAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, T3>, arg2: u64) {
        0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::set_withdraw_fee_val_internal<T0, T1, T2, T3>(arg1, arg2);
    }

    public fun unpause_vault<T0, T1, T2, T3: copy + drop + store>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::UnpauseAdminCap, arg1: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, T3>) {
        0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::unpause<T0, T1, T2, T3>(arg1);
    }

    public fun withdraw_fee_a<T0, T1, T2, T3: copy + drop + store>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::FeeAdminCap, arg1: &0x84e9c31d961436709798f0c4b69e2b9cf4e006517f2e3b4245349b2358d2a7d9::acl::FeeReceiptAcl, arg2: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, T3>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::PermissionedReceipt {
        0x84e9c31d961436709798f0c4b69e2b9cf4e006517f2e3b4245349b2358d2a7d9::fee_receipt::issue_fee_receipt_with_coins<T0, T2>(arg1, 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::withdraw_fee_a<T0, T1, T2, T3>(arg2, arg3, arg4), arg4)
    }

    public fun withdraw_fee_b<T0, T1, T2, T3: copy + drop + store>(arg0: &0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::admin_control::FeeAdminCap, arg1: &0x84e9c31d961436709798f0c4b69e2b9cf4e006517f2e3b4245349b2358d2a7d9::acl::FeeReceiptAcl, arg2: &mut 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::Vault<T0, T1, T2, T3>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::PermissionedReceipt {
        0x84e9c31d961436709798f0c4b69e2b9cf4e006517f2e3b4245349b2358d2a7d9::fee_receipt::issue_fee_receipt_with_coins<T1, T2>(arg1, 0xaa5c53240d338514907ce7254a14730716adc3c0d1d4f55485b0178d61881947::vault::withdraw_fee_b<T0, T1, T2, T3>(arg2, arg3, arg4), arg4)
    }

    // decompiled from Move bytecode v6
}

