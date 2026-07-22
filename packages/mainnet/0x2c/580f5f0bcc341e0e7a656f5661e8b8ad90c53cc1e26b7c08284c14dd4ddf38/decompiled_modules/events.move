module 0x2c580f5f0bcc341e0e7a656f5661e8b8ad90c53cc1e26b7c08284c14dd4ddf38::events {
    struct UserDeposit has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        provided_balance: u64,
        lp_coin_minted: u64,
        vault_balance_value: u256,
    }

    struct UserCreateWithdrawRequest has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        provided_lp_coin: u64,
        min_expected_balance_out: u64,
    }

    struct UserRemoveWithdrawRequest has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        provided_lp_coin: u64,
    }

    struct UserWithdrawRequestSetSlippage has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        min_expected_balance_out: u64,
    }

    struct OwnerWithdraw has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        provided_lp_coin: u64,
        withdrawn_balance: u64,
        vault_balance_value: u256,
    }

    struct OwnerLockedLiquidityWithdraw has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        provided_lp_coin: u64,
        withdrawn_balance: u64,
        remaining_locked_lp: u64,
    }

    struct UserForceWithdraw has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        provided_lp_coin: u64,
        withdrawn_balance: u64,
        vault_balance_value: u256,
    }

    struct CreateVault has copy, drop {
        vault_id: 0x2::object::ID,
        owner_cap_id: 0x2::object::ID,
        vault_metadata_id: 0x2::object::ID,
        collateral_storage_id: u32,
        lp_coin_type: 0x1::string::String,
        collateral_type: 0x1::string::String,
        lp_coin_decimals: u8,
        initial_liquidity: u64,
        vault_admin: address,
        account_id: u64,
        lock_period: u64,
    }

    struct CreateVaultAssistantCap has copy, drop {
        vault_id: 0x2::object::ID,
        assistant_cap_id: 0x2::object::ID,
    }

    struct CreateVaultTreasuryCap has copy, drop {
        vault_id: 0x2::object::ID,
        treasury_cap_id: 0x2::object::ID,
    }

    struct RevokedVaultAuthorityCap has copy, drop {
        vault_id: 0x2::object::ID,
        role: 0x1::type_name::TypeName,
        cap_id: 0x2::object::ID,
    }

    struct CreatePackageAssistantCap has copy, drop {
        config_id: 0x2::object::ID,
        assistant_cap_id: 0x2::object::ID,
    }

    struct CreatePackagePauseGuardianCap has copy, drop {
        config_id: 0x2::object::ID,
        pause_guardian_cap_id: 0x2::object::ID,
    }

    struct CreatePackageMaintenanceCap has copy, drop {
        config_id: 0x2::object::ID,
        maintenance_cap_id: 0x2::object::ID,
    }

    struct RevokedPackageAuthorityCap has copy, drop {
        config_id: 0x2::object::ID,
        role: 0x1::type_name::TypeName,
        cap_id: 0x2::object::ID,
    }

    struct CreatedPackageFreezeGuardianCap has copy, drop {
        config_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    struct Froze has copy, drop {
        id: 0x2::object::ID,
        resume_version: u64,
        guardian_cap_id: 0x2::object::ID,
    }

    struct Unfroze has copy, drop {
        id: 0x2::object::ID,
        version: u64,
    }

    struct AddYield has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct AdminPauseVault has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct AdminUnpauseVault has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct UpgradeVaultVersion has copy, drop {
        vault_id: 0x2::object::ID,
        version: u64,
    }

    struct UpdateMinPauseVaultForForceWithdrawFrequencyMs has copy, drop {
        vault_id: 0x2::object::ID,
        min_pause_vault_for_force_withdraw_frequency_ms: u64,
    }

    struct UpdateMinForceWithdrawPositionUsd has copy, drop {
        vault_id: 0x2::object::ID,
        min_force_withdraw_position_usd: u256,
    }

    struct UpdateMinOwnerLockUsd has copy, drop {
        vault_id: 0x2::object::ID,
        min_owner_lock_usd: u256,
    }

    struct UpdateCollateralPfsInfo has copy, drop {
        vault_id: 0x2::object::ID,
        collateral_storage_id: u32,
        collateral_source_id: u16,
    }

    struct UpdateCollateralPfsSourceTolerance has copy, drop {
        vault_id: 0x2::object::ID,
        collateral_pfs_tolerance: u64,
    }

    struct UpdateVaultMetadata has copy, drop {
        vault_id: 0x2::object::ID,
        field: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct UpdateOwnerFeeRate has copy, drop {
        vault_id: 0x2::object::ID,
        owner_fee_rate: u256,
    }

    struct UpdateLockPeriod has copy, drop {
        vault_id: 0x2::object::ID,
        lock_period: u64,
    }

    struct UpdateForceWithdrawDelay has copy, drop {
        vault_id: 0x2::object::ID,
        force_withdraw_delay: u64,
    }

    struct UpdateMaxForceWithdrawMrTolerance has copy, drop {
        vault_id: 0x2::object::ID,
        max_force_withdraw_mr_tolerance: u256,
    }

    struct UpdateMaxTotalDepositedCollateral has copy, drop {
        vault_id: 0x2::object::ID,
        max_total_deposited_collateral: u64,
    }

    struct WithdrawFees has copy, drop {
        vault_id: 0x2::object::ID,
        amount_to_withdraw: u64,
    }

    struct MaxMarketsUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        new_max_markets: u64,
    }

    struct MaxPendingOrdersUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        new_max_pending_orders: u64,
    }

    public(friend) fun emit_add_yield_event(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = AddYield{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<AddYield>(v0);
    }

    public(friend) fun emit_admin_pause_vault(arg0: 0x2::object::ID) {
        let v0 = AdminPauseVault{vault_id: arg0};
        0x2::event::emit<AdminPauseVault>(v0);
    }

    public(friend) fun emit_admin_unpause_vault(arg0: 0x2::object::ID) {
        let v0 = AdminUnpauseVault{vault_id: arg0};
        0x2::event::emit<AdminUnpauseVault>(v0);
    }

    public(friend) fun emit_create_package_assistant_cap(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = CreatePackageAssistantCap{
            config_id        : arg0,
            assistant_cap_id : arg1,
        };
        0x2::event::emit<CreatePackageAssistantCap>(v0);
    }

    public(friend) fun emit_create_package_maintenance_cap(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = CreatePackageMaintenanceCap{
            config_id          : arg0,
            maintenance_cap_id : arg1,
        };
        0x2::event::emit<CreatePackageMaintenanceCap>(v0);
    }

    public(friend) fun emit_create_package_pause_guardian_cap(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = CreatePackagePauseGuardianCap{
            config_id             : arg0,
            pause_guardian_cap_id : arg1,
        };
        0x2::event::emit<CreatePackagePauseGuardianCap>(v0);
    }

    public(friend) fun emit_create_vault_assistant_cap(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = CreateVaultAssistantCap{
            vault_id         : arg0,
            assistant_cap_id : arg1,
        };
        0x2::event::emit<CreateVaultAssistantCap>(v0);
    }

    public(friend) fun emit_create_vault_treasury_cap(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = CreateVaultTreasuryCap{
            vault_id        : arg0,
            treasury_cap_id : arg1,
        };
        0x2::event::emit<CreateVaultTreasuryCap>(v0);
    }

    public(friend) fun emit_create_withdraw_request(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = UserCreateWithdrawRequest{
            vault_id                 : arg0,
            user                     : arg1,
            provided_lp_coin         : arg2,
            min_expected_balance_out : arg3,
        };
        0x2::event::emit<UserCreateWithdrawRequest>(v0);
    }

    public(friend) fun emit_created_package_freeze_guardian_cap(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = CreatedPackageFreezeGuardianCap{
            config_id : arg0,
            cap_id    : arg1,
        };
        0x2::event::emit<CreatedPackageFreezeGuardianCap>(v0);
    }

    public(friend) fun emit_created_vault_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u32, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u8, arg7: u64, arg8: address, arg9: u64, arg10: u64) {
        let v0 = CreateVault{
            vault_id              : arg0,
            owner_cap_id          : arg2,
            vault_metadata_id     : arg1,
            collateral_storage_id : arg3,
            lp_coin_type          : arg4,
            collateral_type       : arg5,
            lp_coin_decimals      : arg6,
            initial_liquidity     : arg7,
            vault_admin           : arg8,
            account_id            : arg9,
            lock_period           : arg10,
        };
        0x2::event::emit<CreateVault>(v0);
    }

    public(friend) fun emit_froze(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::object::ID) {
        let v0 = Froze{
            id              : arg0,
            resume_version  : arg1,
            guardian_cap_id : arg2,
        };
        0x2::event::emit<Froze>(v0);
    }

    public(friend) fun emit_max_markets_updated(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = MaxMarketsUpdated{
            vault_id        : arg0,
            new_max_markets : arg1,
        };
        0x2::event::emit<MaxMarketsUpdated>(v0);
    }

    public(friend) fun emit_max_pending_orders_updated(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = MaxPendingOrdersUpdated{
            vault_id               : arg0,
            new_max_pending_orders : arg1,
        };
        0x2::event::emit<MaxPendingOrdersUpdated>(v0);
    }

    public(friend) fun emit_owner_locked_liquidity_withdraw(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = OwnerLockedLiquidityWithdraw{
            vault_id            : arg0,
            user                : arg1,
            provided_lp_coin    : arg2,
            withdrawn_balance   : arg3,
            remaining_locked_lp : arg4,
        };
        0x2::event::emit<OwnerLockedLiquidityWithdraw>(v0);
    }

    public(friend) fun emit_owner_withdraw(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u256) {
        let v0 = OwnerWithdraw{
            vault_id            : arg0,
            user                : arg1,
            provided_lp_coin    : arg2,
            withdrawn_balance   : arg3,
            vault_balance_value : arg4,
        };
        0x2::event::emit<OwnerWithdraw>(v0);
    }

    public(friend) fun emit_remove_withdraw_request(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = UserRemoveWithdrawRequest{
            vault_id         : arg0,
            user             : arg1,
            provided_lp_coin : arg2,
        };
        0x2::event::emit<UserRemoveWithdrawRequest>(v0);
    }

    public(friend) fun emit_revoked_package_authority_cap(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID) {
        let v0 = RevokedPackageAuthorityCap{
            config_id : arg0,
            role      : arg1,
            cap_id    : arg2,
        };
        0x2::event::emit<RevokedPackageAuthorityCap>(v0);
    }

    public(friend) fun emit_revoked_vault_authority_cap(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID) {
        let v0 = RevokedVaultAuthorityCap{
            vault_id : arg0,
            role     : arg1,
            cap_id   : arg2,
        };
        0x2::event::emit<RevokedVaultAuthorityCap>(v0);
    }

    public(friend) fun emit_unfroze(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = Unfroze{
            id      : arg0,
            version : arg1,
        };
        0x2::event::emit<Unfroze>(v0);
    }

    public(friend) fun emit_update_collateral_pfs_info(arg0: 0x2::object::ID, arg1: u32, arg2: u16) {
        let v0 = UpdateCollateralPfsInfo{
            vault_id              : arg0,
            collateral_storage_id : arg1,
            collateral_source_id  : arg2,
        };
        0x2::event::emit<UpdateCollateralPfsInfo>(v0);
    }

    public(friend) fun emit_update_collateral_pfs_tolerance(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = UpdateCollateralPfsSourceTolerance{
            vault_id                 : arg0,
            collateral_pfs_tolerance : arg1,
        };
        0x2::event::emit<UpdateCollateralPfsSourceTolerance>(v0);
    }

    public(friend) fun emit_update_force_withdraw_delay(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = UpdateForceWithdrawDelay{
            vault_id             : arg0,
            force_withdraw_delay : arg1,
        };
        0x2::event::emit<UpdateForceWithdrawDelay>(v0);
    }

    public(friend) fun emit_update_lock_period(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = UpdateLockPeriod{
            vault_id    : arg0,
            lock_period : arg1,
        };
        0x2::event::emit<UpdateLockPeriod>(v0);
    }

    public(friend) fun emit_update_max_force_withdraw_mr_tolerance(arg0: 0x2::object::ID, arg1: u256) {
        let v0 = UpdateMaxForceWithdrawMrTolerance{
            vault_id                        : arg0,
            max_force_withdraw_mr_tolerance : arg1,
        };
        0x2::event::emit<UpdateMaxForceWithdrawMrTolerance>(v0);
    }

    public(friend) fun emit_update_max_total_deposited_collateral(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = UpdateMaxTotalDepositedCollateral{
            vault_id                       : arg0,
            max_total_deposited_collateral : arg1,
        };
        0x2::event::emit<UpdateMaxTotalDepositedCollateral>(v0);
    }

    public(friend) fun emit_update_min_force_withdraw_position_usd(arg0: 0x2::object::ID, arg1: u256) {
        let v0 = UpdateMinForceWithdrawPositionUsd{
            vault_id                        : arg0,
            min_force_withdraw_position_usd : arg1,
        };
        0x2::event::emit<UpdateMinForceWithdrawPositionUsd>(v0);
    }

    public(friend) fun emit_update_min_owner_lock_usd(arg0: 0x2::object::ID, arg1: u256) {
        let v0 = UpdateMinOwnerLockUsd{
            vault_id           : arg0,
            min_owner_lock_usd : arg1,
        };
        0x2::event::emit<UpdateMinOwnerLockUsd>(v0);
    }

    public(friend) fun emit_update_min_pause_vault_for_force_withdraw_frequency_ms(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = UpdateMinPauseVaultForForceWithdrawFrequencyMs{
            vault_id                                        : arg0,
            min_pause_vault_for_force_withdraw_frequency_ms : arg1,
        };
        0x2::event::emit<UpdateMinPauseVaultForForceWithdrawFrequencyMs>(v0);
    }

    public(friend) fun emit_update_owner_fee_rate(arg0: 0x2::object::ID, arg1: u256) {
        let v0 = UpdateOwnerFeeRate{
            vault_id       : arg0,
            owner_fee_rate : arg1,
        };
        0x2::event::emit<UpdateOwnerFeeRate>(v0);
    }

    public(friend) fun emit_update_vault_metadata(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        let v0 = UpdateVaultMetadata{
            vault_id : arg0,
            field    : arg1,
            value    : arg2,
        };
        0x2::event::emit<UpdateVaultMetadata>(v0);
    }

    public(friend) fun emit_upgrade_vault_version(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = UpgradeVaultVersion{
            vault_id : arg0,
            version  : arg1,
        };
        0x2::event::emit<UpgradeVaultVersion>(v0);
    }

    public(friend) fun emit_user_deposit(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u256) {
        let v0 = UserDeposit{
            vault_id            : arg0,
            user                : arg1,
            provided_balance    : arg2,
            lp_coin_minted      : arg3,
            vault_balance_value : arg4,
        };
        0x2::event::emit<UserDeposit>(v0);
    }

    public(friend) fun emit_user_force_withdraw(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u256) {
        let v0 = UserForceWithdraw{
            vault_id            : arg0,
            user                : arg1,
            provided_lp_coin    : arg2,
            withdrawn_balance   : arg3,
            vault_balance_value : arg4,
        };
        0x2::event::emit<UserForceWithdraw>(v0);
    }

    public(friend) fun emit_user_withdraw_request_set_slippage(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = UserWithdrawRequestSetSlippage{
            vault_id                 : arg0,
            user                     : arg1,
            min_expected_balance_out : arg2,
        };
        0x2::event::emit<UserWithdrawRequestSetSlippage>(v0);
    }

    public(friend) fun emit_withdraw_fees(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = WithdrawFees{
            vault_id           : arg0,
            amount_to_withdraw : arg1,
        };
        0x2::event::emit<WithdrawFees>(v0);
    }

    // decompiled from Move bytecode v7
}

