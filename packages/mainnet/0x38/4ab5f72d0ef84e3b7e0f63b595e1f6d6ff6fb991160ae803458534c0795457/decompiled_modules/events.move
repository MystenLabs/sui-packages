module 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::events {
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
        vault_admin: address,
        lock_period: u64,
    }

    struct UpdateVaultVersion has copy, drop {
        vault_id: 0x2::object::ID,
        version: u64,
    }

    struct UpdateCollateralPfsInfo has copy, drop {
        vault_id: 0x2::object::ID,
        collateral_pfs_id: 0x2::object::ID,
        collateral_pfs_source_id: 0x2::object::ID,
    }

    struct UpdateCollateralPfsSourceTolerance has copy, drop {
        vault_id: 0x2::object::ID,
        collateral_pfs_tolerance: u64,
    }

    struct UpdateVaultName has copy, drop {
        vault_id: 0x2::object::ID,
        vault_name: 0x1::string::String,
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

    public(friend) fun emit_create_withdraw_request(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = UserCreateWithdrawRequest{
            vault_id                 : arg0,
            user                     : arg1,
            provided_lp_coin         : arg2,
            min_expected_balance_out : arg3,
        };
        0x2::event::emit<UserCreateWithdrawRequest>(v0);
    }

    public(friend) fun emit_created_vault_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = CreateVault{
            vault_id     : arg0,
            owner_cap_id : arg1,
            vault_admin  : arg2,
            lock_period  : arg3,
        };
        0x2::event::emit<CreateVault>(v0);
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

    public(friend) fun emit_update_collateral_pfs_info(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        let v0 = UpdateCollateralPfsInfo{
            vault_id                 : arg0,
            collateral_pfs_id        : arg1,
            collateral_pfs_source_id : arg2,
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

    public(friend) fun emit_update_max_total_deposited_collateral(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = UpdateMaxTotalDepositedCollateral{
            vault_id                       : arg0,
            max_total_deposited_collateral : arg1,
        };
        0x2::event::emit<UpdateMaxTotalDepositedCollateral>(v0);
    }

    public(friend) fun emit_update_owner_fee_rate(arg0: 0x2::object::ID, arg1: u256) {
        let v0 = UpdateOwnerFeeRate{
            vault_id       : arg0,
            owner_fee_rate : arg1,
        };
        0x2::event::emit<UpdateOwnerFeeRate>(v0);
    }

    public(friend) fun emit_update_vault_name(arg0: 0x2::object::ID, arg1: 0x1::string::String) {
        let v0 = UpdateVaultName{
            vault_id   : arg0,
            vault_name : arg1,
        };
        0x2::event::emit<UpdateVaultName>(v0);
    }

    public(friend) fun emit_update_vault_version(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = UpdateVaultVersion{
            vault_id : arg0,
            version  : arg1,
        };
        0x2::event::emit<UpdateVaultVersion>(v0);
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

    // decompiled from Move bytecode v6
}

