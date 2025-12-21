module 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1 {
    struct CreateAdminCapEvent has copy, drop {
        admin_cap: 0x2::object::ID,
    }

    struct FeeVaultEvent has copy, drop {
        fee_vault: 0x2::object::ID,
        old_balance: u64,
        new_balance: u64,
    }

    struct GlobalMintDoriFeeVault has copy, drop {
        amount: u64,
    }

    struct GlobalMintDoriSP has copy, drop {
        amount: u64,
    }

    struct GlobalMintAndTransfer has copy, drop {
        amount: u64,
    }

    struct GlobalBurn has copy, drop {
        amount: u64,
    }

    struct StabilityPoolYieldDistributionEvent has copy, drop {
        stability_pool_id: 0x2::object::ID,
        vault_registry_id: 0x2::object::ID,
        yield_gain_pending: u64,
        active_yield_balance: u64,
        new_yield_index_decimal: u256,
        new_added_yield: u64,
    }

    struct FarmYieldDistributionEvent has copy, drop {
        farm_id: 0x2::object::ID,
        vault_registry_id: 0x2::object::ID,
        new_added_yield: u64,
    }

    struct OffsetEvent has copy, drop {
        stability_pool_id: 0x2::object::ID,
        vault_registry_id: 0x2::object::ID,
        debt_offset: u64,
        collateral_to_add: u64,
        new_pool_index_decimal: u256,
        current_scale: u64,
        balance: u64,
        collateral: u64,
        new_collateral_index_decimal: u256,
        new_added_collateral: u64,
    }

    struct NewStakeEvent has copy, drop {
        stability_pool_id: 0x2::object::ID,
        vault_registry_id: 0x2::object::ID,
        sender: address,
        staker_id: 0x2::object::ID,
        balance: u64,
        snapshot_pool_index_decimal: u256,
        snapshot_collateral_index_decimal: u256,
        snapshot_yield_index_decimal: u256,
        snapshot_scale: u64,
        total_dori_balance: u64,
    }

    struct UpdateStakeEvent has copy, drop {
        stability_pool_id: 0x2::object::ID,
        vault_registry_id: 0x2::object::ID,
        sender: address,
        staker_id: 0x2::object::ID,
        is_collecting_rewards: bool,
        collateral_rewards: u64,
        pending_collateral_rewards: u64,
        yield_rewards: u64,
        deposit: u64,
        balance: u64,
        snapshot_pool_index_decimal: u256,
        snapshot_collateral_index_decimal: u256,
        snapshot_yield_index_decimal: u256,
        snapshot_scale: u64,
        total_dori_balance: u64,
    }

    struct UnstakeEvent has copy, drop {
        stability_pool_id: 0x2::object::ID,
        vault_registry_id: 0x2::object::ID,
        sender: address,
        staker_id: 0x2::object::ID,
        is_collecting_rewards: bool,
        collateral_rewards: u64,
        pending_collateral_rewards: u64,
        yield_rewards: u64,
        withdraw: u64,
        balance: u64,
        snapshot_pool_index_decimal: u256,
        snapshot_collateral_index_decimal: u256,
        snapshot_yield_index_decimal: u256,
        snapshot_scale: u64,
        total_dori_balance: u64,
    }

    struct ClaimAllRewardsEvent has copy, drop {
        sender: address,
        staker_id: 0x2::object::ID,
        collateral_rewards: u64,
        pending_collateral_rewards: u64,
    }

    struct NewSurplusEvent has copy, drop {
        vault_admin_id: 0x2::object::ID,
        surplus_pool_id: 0x2::object::ID,
        add_balance: u64,
        total_balance: u64,
    }

    struct ClaimSurplusEvent has copy, drop {
        sender: address,
        vault_admin_id: 0x2::object::ID,
        surplus_pool_id: 0x2::object::ID,
        withdraw: u64,
    }

    struct CreateVaultAdminEvent has copy, drop {
        vault_id: 0x2::object::ID,
        vault_admin_id: 0x2::object::ID,
    }

    struct DeleteVaultAdminEvent has copy, drop {
        vault_admin_id: 0x2::object::ID,
    }

    struct CreateVaultEvent has copy, drop {
        vault_id: 0x2::object::ID,
        vault_registry_id: 0x2::object::ID,
        owner: 0x2::object::ID,
        interest_rate_bps: u64,
        collateral: u64,
        borrowed_amount: u64,
        debt: u64,
        stake_decimal: u256,
        coin_type: 0x1::ascii::String,
    }

    struct AddCollateralEvent has copy, drop {
        vault_id: 0x2::object::ID,
        vault_registry_id: 0x2::object::ID,
        added_collateral: u64,
        old_collateral: u64,
        new_collateral: u64,
        debt: u64,
        old_stake_decimal: u256,
        new_stake_decimal: u256,
    }

    struct WithdrawCollateralEvent has copy, drop {
        vault_id: 0x2::object::ID,
        vault_registry_id: 0x2::object::ID,
        withdrawn_collateral: u64,
        old_collateral: u64,
        new_collateral: u64,
        debt: u64,
        old_stake_decimal: u256,
        new_stake_decimal: u256,
    }

    struct BorrowMoreEvent has copy, drop {
        vault_id: 0x2::object::ID,
        vault_registry_id: 0x2::object::ID,
        collateral: u64,
        borrowed_amount: u64,
        old_debt: u64,
        new_debt: u64,
    }

    struct RepayDebtEvent has copy, drop {
        vault_id: 0x2::object::ID,
        vault_registry_id: 0x2::object::ID,
        collateral: u64,
        repaid_amount: u64,
        old_debt: u64,
        new_debt: u64,
    }

    struct InterestUpdateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        vault_registry_id: 0x2::object::ID,
        collateral: u64,
        old_debt: u64,
        new_debt: u64,
        old_interest_rate_bps: u64,
        new_interest_rate_bps: u64,
        updated_at_timestamp_ms: u64,
    }

    struct CloseVaultEvent has copy, drop {
        vault_id: 0x2::object::ID,
        vault_registry_id: 0x2::object::ID,
        vault_closed: bool,
        withdrawn_collateral: u64,
        debt_repaid: u64,
    }

    struct LiquidationEvent has copy, drop {
        vault_id: 0x2::object::ID,
        vault_registry_id: 0x2::object::ID,
        old_collateral: u64,
        new_collateral: u64,
        old_debt: u64,
        new_debt: u64,
        old_stake_decimal: u256,
        new_stake_decimal: u256,
        old_interest_rate_bps: u64,
        new_interest_rate_bps: u64,
    }

    struct RedemptionEvent has copy, drop {
        vault_id: 0x2::object::ID,
        vault_registry_id: 0x2::object::ID,
        collateral_redeemed: u64,
        old_collateral: u64,
        new_collateral: u64,
        debt_offset: u64,
        old_debt: u64,
        new_debt: u64,
        old_stake_decimal: u256,
        new_stake_decimal: u256,
        old_interest_rate_bps: u64,
        new_interest_rate_bps: u64,
    }

    struct UrgentRedemptionEvent has copy, drop {
        vault_id: 0x2::object::ID,
        vault_registry_id: 0x2::object::ID,
        collateral_redeemed: u64,
        old_collateral: u64,
        new_collateral: u64,
        debt_offset: u64,
        old_debt: u64,
        new_debt: u64,
        old_stake_decimal: u256,
        new_stake_decimal: u256,
        old_interest_rate_bps: u64,
        new_interest_rate_bps: u64,
    }

    struct UpdateVaultRegistryEvent has copy, drop {
        vault_registry_id: 0x2::object::ID,
        total_collateral: u64,
        total_debt: u64,
        total_weighted_contribution_bps: u64,
        annual_interest_index_decimal: u256,
    }

    struct LastInterestUpdateEvent has copy, drop {
        vault_registry_id: 0x2::object::ID,
        last_interest_distribution_timestamp: u64,
    }

    struct CollateralDebtRedistributionEvent has copy, drop {
        vault_registry_id: 0x2::object::ID,
        lifetime_collateral: u256,
        lifetime_debt: u256,
        total_stakes: u256,
        debt_redistribution_amount: u64,
        collateral_redistribution_amount: u64,
    }

    struct UpdateAndGetNewStakeEvent has copy, drop {
        vault_registry_id: 0x2::object::ID,
        new_stake: u256,
    }

    struct LiquidationUpdateSnapshotEvent has copy, drop {
        vault_registry_id: 0x2::object::ID,
        total_stakes_snapshot: u256,
        total_collateral_snapshot: u256,
    }

    struct NewVaultRegistryEvent has copy, drop {
        vault_registry_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        token_decimals: u256,
    }

    struct DepositEvent has copy, drop {
        user: address,
        dori_amount: u64,
        sdori_amount: u64,
        exchange_rate: u64,
    }

    struct WithdrawEvent has copy, drop {
        user: address,
        sdori_amount: u64,
        dori_amount: u64,
        exchange_rate: u64,
    }

    struct YieldDistributedEvent has copy, drop {
        amount: u64,
        new_exchange_rate: u64,
        total_dori: u64,
        total_sdori: u64,
    }

    struct PSMCreatedEvent has copy, drop {
        psm_id: 0x2::object::ID,
        fee_bps: u64,
        max_total_balance: u64,
        max_swap_amount: u64,
    }

    struct PSMSwapToDoriEvent has copy, drop {
        psm_id: 0x2::object::ID,
        user: address,
        collateral_amount: u64,
        dori_amount: u64,
        fee_amount: u64,
    }

    struct PSMSwapToCollateralEvent has copy, drop {
        psm_id: 0x2::object::ID,
        user: address,
        dori_amount: u64,
        collateral_amount: u64,
        fee_amount: u64,
    }

    struct PSMFeeUpdatedEvent has copy, drop {
        psm_id: 0x2::object::ID,
        old_fee_bps: u64,
        new_fee_bps: u64,
    }

    struct PSMCapsUpdatedEvent has copy, drop {
        psm_id: 0x2::object::ID,
        new_max_total_balance: u64,
        new_max_swap_amount: u64,
    }

    struct PSMPausedEvent has copy, drop {
        psm_id: 0x2::object::ID,
    }

    struct PSMUnpausedEvent has copy, drop {
        psm_id: 0x2::object::ID,
    }

    struct PSMEmergencyWithdrawEvent has copy, drop {
        psm_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
    }

    struct PSMFeeRangeUpdatedEvent has copy, drop {
        psm_id: 0x2::object::ID,
        new_min_fee_bps: u64,
        new_max_fee_bps: u64,
    }

    public fun emit_add_collateral_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u256, arg7: u256) {
        let v0 = AddCollateralEvent{
            vault_id          : arg0,
            vault_registry_id : arg1,
            added_collateral  : arg2,
            old_collateral    : arg3,
            new_collateral    : arg4,
            debt              : arg5,
            old_stake_decimal : arg6,
            new_stake_decimal : arg7,
        };
        0x2::event::emit<AddCollateralEvent>(v0);
    }

    public fun emit_borrow_more_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = BorrowMoreEvent{
            vault_id          : arg0,
            vault_registry_id : arg1,
            collateral        : arg3,
            borrowed_amount   : arg2,
            old_debt          : arg4,
            new_debt          : arg5,
        };
        0x2::event::emit<BorrowMoreEvent>(v0);
    }

    public fun emit_claim_all_rewards_event(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = ClaimAllRewardsEvent{
            sender                     : arg0,
            staker_id                  : arg1,
            collateral_rewards         : arg2,
            pending_collateral_rewards : arg3,
        };
        0x2::event::emit<ClaimAllRewardsEvent>(v0);
    }

    public fun emit_claim_surplus_event(arg0: address, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64) {
        let v0 = ClaimSurplusEvent{
            sender          : arg0,
            vault_admin_id  : arg1,
            surplus_pool_id : arg2,
            withdraw        : arg3,
        };
        0x2::event::emit<ClaimSurplusEvent>(v0);
    }

    public fun emit_close_vault_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: bool, arg3: u64, arg4: u64) {
        let v0 = CloseVaultEvent{
            vault_id             : arg0,
            vault_registry_id    : arg1,
            vault_closed         : arg2,
            withdrawn_collateral : arg3,
            debt_repaid          : arg4,
        };
        0x2::event::emit<CloseVaultEvent>(v0);
    }

    public fun emit_collateral_debt_redistribution_event(arg0: 0x2::object::ID, arg1: u256, arg2: u256, arg3: u256, arg4: u64, arg5: u64) {
        let v0 = CollateralDebtRedistributionEvent{
            vault_registry_id                : arg0,
            lifetime_collateral              : arg1,
            lifetime_debt                    : arg2,
            total_stakes                     : arg3,
            debt_redistribution_amount       : arg4,
            collateral_redistribution_amount : arg5,
        };
        0x2::event::emit<CollateralDebtRedistributionEvent>(v0);
    }

    public fun emit_create_admin_cap_event(arg0: 0x2::object::ID) {
        let v0 = CreateAdminCapEvent{admin_cap: arg0};
        0x2::event::emit<CreateAdminCapEvent>(v0);
    }

    public fun emit_create_vault_admin_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = CreateVaultAdminEvent{
            vault_id       : arg0,
            vault_admin_id : arg1,
        };
        0x2::event::emit<CreateVaultAdminEvent>(v0);
    }

    public fun emit_create_vault_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u256, arg8: 0x1::ascii::String) {
        let v0 = CreateVaultEvent{
            vault_id          : arg0,
            vault_registry_id : arg1,
            owner             : arg2,
            interest_rate_bps : arg3,
            collateral        : arg4,
            borrowed_amount   : arg5,
            debt              : arg6,
            stake_decimal     : arg7,
            coin_type         : arg8,
        };
        0x2::event::emit<CreateVaultEvent>(v0);
    }

    public fun emit_delete_vault_admin_event(arg0: 0x2::object::ID) {
        let v0 = DeleteVaultAdminEvent{vault_admin_id: arg0};
        0x2::event::emit<DeleteVaultAdminEvent>(v0);
    }

    public fun emit_farm_yield_distribution_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = FarmYieldDistributionEvent{
            farm_id           : arg0,
            vault_registry_id : arg1,
            new_added_yield   : arg2,
        };
        0x2::event::emit<FarmYieldDistributionEvent>(v0);
    }

    public fun emit_fee_vault_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = FeeVaultEvent{
            fee_vault   : arg0,
            old_balance : arg1,
            new_balance : arg2,
        };
        0x2::event::emit<FeeVaultEvent>(v0);
    }

    public fun emit_global_burn(arg0: u64) {
        let v0 = GlobalBurn{amount: arg0};
        0x2::event::emit<GlobalBurn>(v0);
    }

    public fun emit_global_mint_and_transfer(arg0: u64) {
        let v0 = GlobalMintAndTransfer{amount: arg0};
        0x2::event::emit<GlobalMintAndTransfer>(v0);
    }

    public fun emit_global_mint_dori_fee_vault(arg0: u64) {
        let v0 = GlobalMintDoriFeeVault{amount: arg0};
        0x2::event::emit<GlobalMintDoriFeeVault>(v0);
    }

    public fun emit_global_mint_dori_sp(arg0: u64) {
        let v0 = GlobalMintDoriSP{amount: arg0};
        0x2::event::emit<GlobalMintDoriSP>(v0);
    }

    public fun emit_interest_update_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = InterestUpdateEvent{
            vault_id                : arg0,
            vault_registry_id       : arg1,
            collateral              : arg2,
            old_debt                : arg3,
            new_debt                : arg4,
            old_interest_rate_bps   : arg5,
            new_interest_rate_bps   : arg6,
            updated_at_timestamp_ms : arg7,
        };
        0x2::event::emit<InterestUpdateEvent>(v0);
    }

    public fun emit_last_interest_update_event(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = LastInterestUpdateEvent{
            vault_registry_id                    : arg0,
            last_interest_distribution_timestamp : arg1,
        };
        0x2::event::emit<LastInterestUpdateEvent>(v0);
    }

    public fun emit_liquidation_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u256, arg7: u256, arg8: u64, arg9: u64) {
        let v0 = LiquidationEvent{
            vault_id              : arg0,
            vault_registry_id     : arg1,
            old_collateral        : arg2,
            new_collateral        : arg3,
            old_debt              : arg4,
            new_debt              : arg5,
            old_stake_decimal     : arg6,
            new_stake_decimal     : arg7,
            old_interest_rate_bps : arg8,
            new_interest_rate_bps : arg9,
        };
        0x2::event::emit<LiquidationEvent>(v0);
    }

    public fun emit_liquidation_update_snapshot_event(arg0: 0x2::object::ID, arg1: u256, arg2: u256) {
        let v0 = LiquidationUpdateSnapshotEvent{
            vault_registry_id         : arg0,
            total_stakes_snapshot     : arg1,
            total_collateral_snapshot : arg2,
        };
        0x2::event::emit<LiquidationUpdateSnapshotEvent>(v0);
    }

    public fun emit_new_stake_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: u256, arg6: u256, arg7: u256, arg8: u64, arg9: u64) {
        let v0 = NewStakeEvent{
            stability_pool_id                 : arg0,
            vault_registry_id                 : arg1,
            sender                            : arg2,
            staker_id                         : arg3,
            balance                           : arg4,
            snapshot_pool_index_decimal       : arg5,
            snapshot_collateral_index_decimal : arg6,
            snapshot_yield_index_decimal      : arg7,
            snapshot_scale                    : arg8,
            total_dori_balance                : arg9,
        };
        0x2::event::emit<NewStakeEvent>(v0);
    }

    public fun emit_new_surplus_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = NewSurplusEvent{
            vault_admin_id  : arg0,
            surplus_pool_id : arg1,
            add_balance     : arg2,
            total_balance   : arg3,
        };
        0x2::event::emit<NewSurplusEvent>(v0);
    }

    public fun emit_new_vault_registry_event(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: u256) {
        let v0 = NewVaultRegistryEvent{
            vault_registry_id : arg0,
            coin_type         : arg1,
            token_decimals    : arg2,
        };
        0x2::event::emit<NewVaultRegistryEvent>(v0);
    }

    public fun emit_psm_caps_updated_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = PSMCapsUpdatedEvent{
            psm_id                : arg0,
            new_max_total_balance : arg1,
            new_max_swap_amount   : arg2,
        };
        0x2::event::emit<PSMCapsUpdatedEvent>(v0);
    }

    public fun emit_psm_created_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = PSMCreatedEvent{
            psm_id            : arg0,
            fee_bps           : arg1,
            max_total_balance : arg2,
            max_swap_amount   : arg3,
        };
        0x2::event::emit<PSMCreatedEvent>(v0);
    }

    public fun emit_psm_emergency_withdraw_event(arg0: 0x2::object::ID, arg1: u64, arg2: address) {
        let v0 = PSMEmergencyWithdrawEvent{
            psm_id    : arg0,
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<PSMEmergencyWithdrawEvent>(v0);
    }

    public fun emit_psm_fee_range_updated_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = PSMFeeRangeUpdatedEvent{
            psm_id          : arg0,
            new_min_fee_bps : arg1,
            new_max_fee_bps : arg2,
        };
        0x2::event::emit<PSMFeeRangeUpdatedEvent>(v0);
    }

    public fun emit_psm_fee_updated_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = PSMFeeUpdatedEvent{
            psm_id      : arg0,
            old_fee_bps : arg1,
            new_fee_bps : arg2,
        };
        0x2::event::emit<PSMFeeUpdatedEvent>(v0);
    }

    public fun emit_psm_paused_event(arg0: 0x2::object::ID) {
        let v0 = PSMPausedEvent{psm_id: arg0};
        0x2::event::emit<PSMPausedEvent>(v0);
    }

    public fun emit_psm_swap_to_collateral_event(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = PSMSwapToCollateralEvent{
            psm_id            : arg0,
            user              : arg1,
            dori_amount       : arg2,
            collateral_amount : arg3,
            fee_amount        : arg4,
        };
        0x2::event::emit<PSMSwapToCollateralEvent>(v0);
    }

    public fun emit_psm_swap_to_dori_event(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = PSMSwapToDoriEvent{
            psm_id            : arg0,
            user              : arg1,
            collateral_amount : arg2,
            dori_amount       : arg3,
            fee_amount        : arg4,
        };
        0x2::event::emit<PSMSwapToDoriEvent>(v0);
    }

    public fun emit_psm_unpaused_event(arg0: 0x2::object::ID) {
        let v0 = PSMUnpausedEvent{psm_id: arg0};
        0x2::event::emit<PSMUnpausedEvent>(v0);
    }

    public fun emit_redemption_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u256, arg9: u256, arg10: u64, arg11: u64) {
        let v0 = RedemptionEvent{
            vault_id              : arg0,
            vault_registry_id     : arg1,
            collateral_redeemed   : arg2,
            old_collateral        : arg3,
            new_collateral        : arg4,
            debt_offset           : arg5,
            old_debt              : arg6,
            new_debt              : arg7,
            old_stake_decimal     : arg8,
            new_stake_decimal     : arg9,
            old_interest_rate_bps : arg10,
            new_interest_rate_bps : arg11,
        };
        0x2::event::emit<RedemptionEvent>(v0);
    }

    public fun emit_repay_debt_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = RepayDebtEvent{
            vault_id          : arg0,
            vault_registry_id : arg1,
            collateral        : arg2,
            repaid_amount     : arg3,
            old_debt          : arg4,
            new_debt          : arg5,
        };
        0x2::event::emit<RepayDebtEvent>(v0);
    }

    public fun emit_savings_deposit_event(arg0: address, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = DepositEvent{
            user          : arg0,
            dori_amount   : arg1,
            sdori_amount  : arg2,
            exchange_rate : arg3,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public fun emit_savings_withdraw_event(arg0: address, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = WithdrawEvent{
            user          : arg0,
            sdori_amount  : arg2,
            dori_amount   : arg1,
            exchange_rate : arg3,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    public fun emit_savings_yield_distributed_event(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = YieldDistributedEvent{
            amount            : arg0,
            new_exchange_rate : arg1,
            total_dori        : arg2,
            total_sdori       : arg3,
        };
        0x2::event::emit<YieldDistributedEvent>(v0);
    }

    public fun emit_stability_pool_offset_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u256, arg5: u64, arg6: u64, arg7: u64, arg8: u256, arg9: u64) {
        let v0 = OffsetEvent{
            stability_pool_id            : arg0,
            vault_registry_id            : arg1,
            debt_offset                  : arg2,
            collateral_to_add            : arg3,
            new_pool_index_decimal       : arg4,
            current_scale                : arg5,
            balance                      : arg6,
            collateral                   : arg7,
            new_collateral_index_decimal : arg8,
            new_added_collateral         : arg9,
        };
        0x2::event::emit<OffsetEvent>(v0);
    }

    public fun emit_stability_pool_yield_distribution_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u256, arg5: u64) {
        let v0 = StabilityPoolYieldDistributionEvent{
            stability_pool_id       : arg0,
            vault_registry_id       : arg1,
            yield_gain_pending      : arg2,
            active_yield_balance    : arg3,
            new_yield_index_decimal : arg4,
            new_added_yield         : arg5,
        };
        0x2::event::emit<StabilityPoolYieldDistributionEvent>(v0);
    }

    public fun emit_unstake_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: 0x2::object::ID, arg4: bool, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u256, arg11: u256, arg12: u256, arg13: u64, arg14: u64) {
        let v0 = UnstakeEvent{
            stability_pool_id                 : arg0,
            vault_registry_id                 : arg1,
            sender                            : arg2,
            staker_id                         : arg3,
            is_collecting_rewards             : arg4,
            collateral_rewards                : arg5,
            pending_collateral_rewards        : arg6,
            yield_rewards                     : arg7,
            withdraw                          : arg8,
            balance                           : arg9,
            snapshot_pool_index_decimal       : arg10,
            snapshot_collateral_index_decimal : arg11,
            snapshot_yield_index_decimal      : arg12,
            snapshot_scale                    : arg13,
            total_dori_balance                : arg14,
        };
        0x2::event::emit<UnstakeEvent>(v0);
    }

    public fun emit_update_and_get_new_stake_event(arg0: 0x2::object::ID, arg1: u256) {
        let v0 = UpdateAndGetNewStakeEvent{
            vault_registry_id : arg0,
            new_stake         : arg1,
        };
        0x2::event::emit<UpdateAndGetNewStakeEvent>(v0);
    }

    public fun emit_update_stake_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: 0x2::object::ID, arg4: bool, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u256, arg11: u256, arg12: u256, arg13: u64, arg14: u64) {
        let v0 = UpdateStakeEvent{
            stability_pool_id                 : arg0,
            vault_registry_id                 : arg1,
            sender                            : arg2,
            staker_id                         : arg3,
            is_collecting_rewards             : arg4,
            collateral_rewards                : arg5,
            pending_collateral_rewards        : arg6,
            yield_rewards                     : arg7,
            deposit                           : arg8,
            balance                           : arg9,
            snapshot_pool_index_decimal       : arg10,
            snapshot_collateral_index_decimal : arg11,
            snapshot_yield_index_decimal      : arg12,
            snapshot_scale                    : arg13,
            total_dori_balance                : arg14,
        };
        0x2::event::emit<UpdateStakeEvent>(v0);
    }

    public fun emit_update_vault_registry_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u256) {
        let v0 = UpdateVaultRegistryEvent{
            vault_registry_id               : arg0,
            total_collateral                : arg1,
            total_debt                      : arg2,
            total_weighted_contribution_bps : arg3,
            annual_interest_index_decimal   : arg4,
        };
        0x2::event::emit<UpdateVaultRegistryEvent>(v0);
    }

    public fun emit_urgent_redemption_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u256, arg9: u256, arg10: u64, arg11: u64) {
        let v0 = UrgentRedemptionEvent{
            vault_id              : arg0,
            vault_registry_id     : arg1,
            collateral_redeemed   : arg2,
            old_collateral        : arg3,
            new_collateral        : arg4,
            debt_offset           : arg5,
            old_debt              : arg6,
            new_debt              : arg7,
            old_stake_decimal     : arg8,
            new_stake_decimal     : arg9,
            old_interest_rate_bps : arg10,
            new_interest_rate_bps : arg11,
        };
        0x2::event::emit<UrgentRedemptionEvent>(v0);
    }

    public fun emit_withdraw_collateral_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u256, arg7: u256) {
        let v0 = WithdrawCollateralEvent{
            vault_id             : arg0,
            vault_registry_id    : arg1,
            withdrawn_collateral : arg2,
            old_collateral       : arg3,
            new_collateral       : arg4,
            debt                 : arg5,
            old_stake_decimal    : arg6,
            new_stake_decimal    : arg7,
        };
        0x2::event::emit<WithdrawCollateralEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

