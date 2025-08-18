module 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin {
    struct PositionPriceScalingSetEvent has copy, drop {
        vault_id: 0x2::object::ID,
        lower_price_factor: u128,
        upper_price_factor: u128,
    }

    struct TriggerScalingSetEvent has copy, drop {
        vault_id: 0x2::object::ID,
        lower_trigger_price_scaling: u128,
        upper_trigger_price_scaling: u128,
    }

    struct DriftUpperTriggerPriceSetEvent has copy, drop {
        vault_id: 0x2::object::ID,
        upper_trigger_price_factor: u128,
    }

    struct SlippageSetEvent has copy, drop {
        vault_id: 0x2::object::ID,
        slippage_up: u128,
        slippage_down: u128,
    }

    struct FreeThresholdSetEvent has copy, drop {
        vault_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        threshold_value: u64,
    }

    struct LockThresholdSetEvent has copy, drop {
        vault_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        threshold_value: u64,
    }

    struct DepositLimitSetEvent has copy, drop {
        vault_id: 0x2::object::ID,
        deposit_limit: u64,
    }

    struct FeeSetEvent has copy, drop {
        vault_id: 0x2::object::ID,
        fee: u64,
    }

    struct WithdrawFeeSetEvent has copy, drop {
        vault_id: 0x2::object::ID,
        withdraw_fee: u64,
    }

    struct VaultPausedEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct VaultUnpausedEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct ForceRebalanceSetEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct DepositEnableSetEvent has copy, drop {
        vault_id: 0x2::object::ID,
        enabled: bool,
    }

    struct RebalancePriceSourceSetEvent has copy, drop {
        vault_id: 0x2::object::ID,
        price_source: u8,
    }

    struct TargetAdapterSetEvent has copy, drop {
        vault_id: 0x2::object::ID,
        target_adapter: 0x1::ascii::String,
        vault_strategy: 0x1::ascii::String,
    }

    struct TargetReverseSetEvent has copy, drop {
        vault_id: 0x2::object::ID,
        is_target_reverse: bool,
    }

    struct VaultCapIssuedEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct ActiveVaultCapSetEvent has copy, drop {
        vault_id: 0x2::object::ID,
        vault_cap_id: 0x2::object::ID,
    }

    public fun add_force_rebalance_df<T0, T1, T2, T3: copy + drop + store>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RiskAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>) {
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::is_cap_valid<T0, T1, T2, T3>(arg1, 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RiskAdminCap>(arg0));
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::add_force_rebalance_df<T0, T1, T2, T3>(arg1);
        let v0 = ForceRebalanceSetEvent{vault_id: 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>>(arg1)};
        0x2::event::emit<ForceRebalanceSetEvent>(v0);
    }

    public fun issue_vault_cap<T0, T1, T2, T3: copy + drop + store>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::TreasuryAdminCap, arg1: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>, arg2: &mut 0x2::tx_context::TxContext) {
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::is_cap_valid<T0, T1, T2, T3>(arg1, 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::TreasuryAdminCap>(arg0));
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::issue_vault_cap<T0, T1, T2, T3>(arg1, arg2);
        let v0 = VaultCapIssuedEvent{vault_id: 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>>(arg1)};
        0x2::event::emit<VaultCapIssuedEvent>(v0);
    }

    public fun pause_vault<T0, T1, T2, T3: copy + drop + store>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::PauseAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>) {
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::is_cap_valid<T0, T1, T2, T3>(arg1, 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::PauseAdminCap>(arg0));
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::pause<T0, T1, T2, T3>(arg1);
        let v0 = VaultPausedEvent{vault_id: 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>>(arg1)};
        0x2::event::emit<VaultPausedEvent>(v0);
    }

    public fun revoke_caps<T0, T1, T2, T3: copy + drop + store>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::AdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>, arg2: 0x2::object::ID) {
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::revoke_cap<T0, T1, T2, T3>(arg1, arg2);
    }

    public fun set_active_vault_cap<T0, T1, T2, T3: copy + drop + store>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::TreasuryAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::is_cap_valid<T0, T1, T2, T3>(arg1, 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::TreasuryAdminCap>(arg0));
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::set_active_vault_cap_internal<T0, T1, T2, T3>(arg1, arg2, arg3);
        let v0 = ActiveVaultCapSetEvent{
            vault_id     : 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>>(arg1),
            vault_cap_id : arg2,
        };
        0x2::event::emit<ActiveVaultCapSetEvent>(v0);
    }

    public fun set_deposit_enable<T0, T1, T2, T3: copy + drop + store>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RiskAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>, arg2: bool) {
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::is_cap_valid<T0, T1, T2, T3>(arg1, 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RiskAdminCap>(arg0));
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::set_deposit_enable<T0, T1, T2, T3>(arg1, arg2);
        let v0 = DepositEnableSetEvent{
            vault_id : 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>>(arg1),
            enabled  : arg2,
        };
        0x2::event::emit<DepositEnableSetEvent>(v0);
    }

    public fun set_deposit_limit<T0, T1, T2, T3: copy + drop + store>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RiskAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>, arg2: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::VaultCap, arg3: u64) {
        abort 0
    }

    public fun set_deposit_limit_safe<T0, T1, T2, T3: copy + drop + store>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RiskAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>, arg2: u64) {
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::is_cap_valid<T0, T1, T2, T3>(arg1, 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RiskAdminCap>(arg0));
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::set_deposit_limit_internal<T0, T1, T2, T3>(arg1, arg2);
        let v0 = DepositLimitSetEvent{
            vault_id      : 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>>(arg1),
            deposit_limit : arg2,
        };
        0x2::event::emit<DepositLimitSetEvent>(v0);
    }

    public fun set_fee<T0, T1, T2, T3: copy + drop + store>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::FeeAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>, arg2: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::VaultCap, arg3: u64) {
        abort 0
    }

    public fun set_fee_safe<T0, T1, T2, T3: copy + drop + store>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::FeeAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>, arg2: u64) {
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::is_cap_valid<T0, T1, T2, T3>(arg1, 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::FeeAdminCap>(arg0));
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::set_fee_val_internal<T0, T1, T2, T3>(arg1, arg2);
        let v0 = FeeSetEvent{
            vault_id : 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>>(arg1),
            fee      : arg2,
        };
        0x2::event::emit<FeeSetEvent>(v0);
    }

    public fun set_free_threshold_a<T0, T1, T2, T3: copy + drop + store>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RiskAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>, arg2: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::VaultCap, arg3: u64) {
        abort 0
    }

    public fun set_free_threshold_a_safe<T0, T1, T2, T3: copy + drop + store>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RiskAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>, arg2: u64) {
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::is_cap_valid<T0, T1, T2, T3>(arg1, 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RiskAdminCap>(arg0));
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::set_free_threshold_a_internal<T0, T1, T2, T3>(arg1, arg2);
        let v0 = FreeThresholdSetEvent{
            vault_id        : 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>>(arg1),
            asset_type      : 0x1::type_name::get<T0>(),
            threshold_value : arg2,
        };
        0x2::event::emit<FreeThresholdSetEvent>(v0);
    }

    public fun set_free_threshold_b<T0, T1, T2, T3: copy + drop + store>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RiskAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>, arg2: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::VaultCap, arg3: u64) {
        abort 0
    }

    public fun set_free_threshold_b_safe<T0, T1, T2, T3: copy + drop + store>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RiskAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>, arg2: u64) {
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::is_cap_valid<T0, T1, T2, T3>(arg1, 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RiskAdminCap>(arg0));
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::set_free_threshold_b_internal<T0, T1, T2, T3>(arg1, arg2);
        let v0 = FreeThresholdSetEvent{
            vault_id        : 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>>(arg1),
            asset_type      : 0x1::type_name::get<T1>(),
            threshold_value : arg2,
        };
        0x2::event::emit<FreeThresholdSetEvent>(v0);
    }

    public fun set_lock_threshold_a<T0, T1, T2, T3: copy + drop + store>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RiskAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>, arg2: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::VaultCap, arg3: u64) {
        abort 0
    }

    public fun set_lock_threshold_a_safe<T0, T1, T2, T3: copy + drop + store>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RiskAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>, arg2: u64) {
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::is_cap_valid<T0, T1, T2, T3>(arg1, 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RiskAdminCap>(arg0));
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::set_lock_threshold_a_internal<T0, T1, T2, T3>(arg1, arg2);
        let v0 = LockThresholdSetEvent{
            vault_id        : 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>>(arg1),
            asset_type      : 0x1::type_name::get<T0>(),
            threshold_value : arg2,
        };
        0x2::event::emit<LockThresholdSetEvent>(v0);
    }

    public fun set_lock_threshold_b<T0, T1, T2, T3: copy + drop + store>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RiskAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>, arg2: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::VaultCap, arg3: u64) {
        abort 0
    }

    public fun set_lock_threshold_b_safe<T0, T1, T2, T3: copy + drop + store>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RiskAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>, arg2: u64) {
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::is_cap_valid<T0, T1, T2, T3>(arg1, 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RiskAdminCap>(arg0));
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::set_lock_threshold_b_internal<T0, T1, T2, T3>(arg1, arg2);
        let v0 = LockThresholdSetEvent{
            vault_id        : 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>>(arg1),
            asset_type      : 0x1::type_name::get<T1>(),
            threshold_value : arg2,
        };
        0x2::event::emit<LockThresholdSetEvent>(v0);
    }

    public fun set_position_price_scaling_for_vault<T0, T1, T2, T3: copy + drop + store>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::VaultConfigAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>, arg2: u128, arg3: u128) {
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::is_cap_valid<T0, T1, T2, T3>(arg1, 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::VaultConfigAdminCap>(arg0));
        assert!(arg3 > arg2, 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::error::upper_lower_trigger_price_incompatible());
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::set_price_scalling<T0, T1, T2, T3>(arg1, arg2, arg3);
        let v0 = PositionPriceScalingSetEvent{
            vault_id           : 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>>(arg1),
            lower_price_factor : arg2,
            upper_price_factor : arg3,
        };
        0x2::event::emit<PositionPriceScalingSetEvent>(v0);
    }

    public fun set_rebalance_price_source<T0, T1, T2, T3: copy + drop + store>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RebalanceAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>, arg2: u8) {
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::is_cap_valid<T0, T1, T2, T3>(arg1, 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RebalanceAdminCap>(arg0));
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::set_rebalance_price_source<T0, T1, T2, T3>(arg1, arg2);
        let v0 = RebalancePriceSourceSetEvent{
            vault_id     : 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>>(arg1),
            price_source : arg2,
        };
        0x2::event::emit<RebalancePriceSourceSetEvent>(v0);
    }

    public fun set_slippage<T0, T1, T2>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RiskAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::config::Uncorrelated>, arg2: u128, arg3: u128) {
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::is_cap_valid<T0, T1, T2, 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::config::Uncorrelated>(arg1, 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RiskAdminCap>(arg0));
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::set_slippage<T0, T1, T2, 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::config::Uncorrelated>(arg1, arg2, arg3);
        let v0 = SlippageSetEvent{
            vault_id      : 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::config::Uncorrelated>>(arg1),
            slippage_up   : arg2,
            slippage_down : arg3,
        };
        0x2::event::emit<SlippageSetEvent>(v0);
    }

    public fun set_target_adapter<T0, T1, T2>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RebalanceAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::config::Drift>, arg2: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::VaultCap, arg3: 0x1::ascii::String) {
        abort 0
    }

    public fun set_target_adapter_safe<T0, T1, T2>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RebalanceAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::config::Drift>, arg2: 0x1::ascii::String) {
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::is_cap_valid<T0, T1, T2, 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::config::Drift>(arg1, 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RebalanceAdminCap>(arg0));
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::set_target_adapter_internal<T0, T1, T2>(arg1, arg2);
        let v0 = TargetAdapterSetEvent{
            vault_id       : 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::config::Drift>>(arg1),
            target_adapter : arg2,
            vault_strategy : 0x1::ascii::string(b"Drift"),
        };
        0x2::event::emit<TargetAdapterSetEvent>(v0);
    }

    public fun set_trigger_scalling<T0, T1, T2>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::VaultConfigAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::config::Uncorrelated>, arg2: u128, arg3: u128) {
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::is_cap_valid<T0, T1, T2, 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::config::Uncorrelated>(arg1, 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::VaultConfigAdminCap>(arg0));
        assert!(arg3 > arg2, 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::error::upper_lower_trigger_price_incompatible());
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::config::set_trigger_price_scalling(0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::borrow_mut_config<T0, T1, T2, 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::config::Uncorrelated>(arg1), arg2, arg3);
        let v0 = TriggerScalingSetEvent{
            vault_id                    : 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::config::Uncorrelated>>(arg1),
            lower_trigger_price_scaling : arg2,
            upper_trigger_price_scaling : arg3,
        };
        0x2::event::emit<TriggerScalingSetEvent>(v0);
    }

    public fun set_uc_is_target_reverse<T0, T1, T2>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RebalanceAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::config::Uncorrelated>, arg2: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::VaultCap, arg3: bool) {
        abort 0
    }

    public fun set_uc_is_target_reverse_safe<T0, T1, T2>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RebalanceAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::config::Uncorrelated>, arg2: bool) {
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::is_cap_valid<T0, T1, T2, 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::config::Uncorrelated>(arg1, 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RebalanceAdminCap>(arg0));
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::set_uc_is_target_reverse_internal<T0, T1, T2>(arg1, arg2);
        let v0 = TargetReverseSetEvent{
            vault_id          : 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::config::Uncorrelated>>(arg1),
            is_target_reverse : arg2,
        };
        0x2::event::emit<TargetReverseSetEvent>(v0);
    }

    public fun set_uc_target_adapter<T0, T1, T2>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RebalanceAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::config::Uncorrelated>, arg2: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::VaultCap, arg3: 0x1::ascii::String) {
        abort 0
    }

    public fun set_uc_target_adapter_safe<T0, T1, T2>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RebalanceAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::config::Uncorrelated>, arg2: 0x1::ascii::String) {
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::is_cap_valid<T0, T1, T2, 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::config::Uncorrelated>(arg1, 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RebalanceAdminCap>(arg0));
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::set_uc_target_adapter_internal<T0, T1, T2>(arg1, arg2);
        let v0 = TargetAdapterSetEvent{
            vault_id       : 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::config::Uncorrelated>>(arg1),
            target_adapter : arg2,
            vault_strategy : 0x1::ascii::string(b"Uncorrelated"),
        };
        0x2::event::emit<TargetAdapterSetEvent>(v0);
    }

    public fun set_upgeer_trigger_price_factor_drift<T0, T1, T2>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::VaultConfigAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::config::Drift>, arg2: u128) {
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::is_cap_valid<T0, T1, T2, 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::config::Drift>(arg1, 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::VaultConfigAdminCap>(arg0));
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::config::set_drift_upper_trigger_price_scalling(0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::borrow_mut_config<T0, T1, T2, 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::config::Drift>(arg1), arg2);
        let v0 = DriftUpperTriggerPriceSetEvent{
            vault_id                   : 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::config::Drift>>(arg1),
            upper_trigger_price_factor : arg2,
        };
        0x2::event::emit<DriftUpperTriggerPriceSetEvent>(v0);
    }

    public fun set_vault_parameters<T0, T1, T2, T3: copy + drop + store>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::VaultConfigAdminCap, arg1: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::RiskAdminCap, arg2: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>, arg3: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::VaultCap, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64) {
        abort 0
    }

    public fun set_withdraw_fee<T0, T1, T2, T3: copy + drop + store>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::FeeAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>, arg2: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::VaultCap, arg3: u64) {
        abort 0
    }

    public fun set_withdraw_fee_safe<T0, T1, T2, T3: copy + drop + store>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::FeeAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>, arg2: u64) {
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::is_cap_valid<T0, T1, T2, T3>(arg1, 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::FeeAdminCap>(arg0));
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::set_withdraw_fee_val_internal<T0, T1, T2, T3>(arg1, arg2);
        let v0 = WithdrawFeeSetEvent{
            vault_id     : 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>>(arg1),
            withdraw_fee : arg2,
        };
        0x2::event::emit<WithdrawFeeSetEvent>(v0);
    }

    public fun unpause_vault<T0, T1, T2, T3: copy + drop + store>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::UnpauseAdminCap, arg1: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>) {
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::is_cap_valid<T0, T1, T2, T3>(arg1, 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::UnpauseAdminCap>(arg0));
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::unpause<T0, T1, T2, T3>(arg1);
        let v0 = VaultUnpausedEvent{vault_id: 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>>(arg1)};
        0x2::event::emit<VaultUnpausedEvent>(v0);
    }

    public fun withdraw_fee_a<T0, T1, T2, T3: copy + drop + store>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::FeeAdminCap, arg1: &0x84e9c31d961436709798f0c4b69e2b9cf4e006517f2e3b4245349b2358d2a7d9::acl::FeeReceiptAcl, arg2: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::PermissionedReceipt {
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::is_cap_valid<T0, T1, T2, T3>(arg2, 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::FeeAdminCap>(arg0));
        0x84e9c31d961436709798f0c4b69e2b9cf4e006517f2e3b4245349b2358d2a7d9::fee_receipt::issue_fee_receipt_with_coins<T0, T2>(arg1, 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::withdraw_fee_a<T0, T1, T2, T3>(arg2, arg3, arg4), arg4)
    }

    public fun withdraw_fee_b<T0, T1, T2, T3: copy + drop + store>(arg0: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::FeeAdminCap, arg1: &0x84e9c31d961436709798f0c4b69e2b9cf4e006517f2e3b4245349b2358d2a7d9::acl::FeeReceiptAcl, arg2: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::PermissionedReceipt {
        0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::is_cap_valid<T0, T1, T2, T3>(arg2, 0x2::object::id<0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::admin_control::FeeAdminCap>(arg0));
        0x84e9c31d961436709798f0c4b69e2b9cf4e006517f2e3b4245349b2358d2a7d9::fee_receipt::issue_fee_receipt_with_coins<T1, T2>(arg1, 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::withdraw_fee_b<T0, T1, T2, T3>(arg2, arg3, arg4), arg4)
    }

    // decompiled from Move bytecode v6
}

