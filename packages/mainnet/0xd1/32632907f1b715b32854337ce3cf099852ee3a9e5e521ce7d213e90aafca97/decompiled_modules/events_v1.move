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

    struct GuardSavingsLiquidationNotifiedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
    }

    struct GuardSavingsCollateralClaimedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        collateral_amount: u64,
        yield_compounded: u64,
    }

    struct GuardSavingsDoriRestakedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        new_total_staked: u64,
    }

    struct GuardSavingsSettlementCompletedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
    }

    struct GuardSavingsDepositedEvent has copy, drop {
        user: address,
        dori_amount: u64,
        pool_id: 0x2::object::ID,
    }

    struct GuardSavingsGdoriMintedEvent has copy, drop {
        user: address,
        gdori_minted: u64,
        total_dori_deposited: u64,
    }

    struct GuardSavingsGdoriBurnedEvent has copy, drop {
        user: address,
        gdori_burned: u64,
        dori_entitled: u64,
    }

    struct GuardSavingsWithdrawnEvent has copy, drop {
        user: address,
        dori_redeemed: u64,
        pool_id: 0x2::object::ID,
    }

    struct SavingsVaultInitializedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        version: u64,
        dori_balance: u64,
        sdori_supply: u64,
        total_yield_distributed: u64,
        last_distribution_timestamp: u64,
    }

    struct GuardSavingsVaultInitializedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        version: u64,
        gdori_supply: u64,
        total_staked: u64,
        sp_ids: vector<0x2::object::ID>,
    }

    struct GuardSavingsPoolRegisteredEvent has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        type_name: 0x1::ascii::String,
        pool_balance: u64,
        all_sp_ids: vector<0x2::object::ID>,
        total_pools: u64,
    }

    struct GuardSavingsAllocationSetEvent has copy, drop {
        vault_id: 0x2::object::ID,
        type_name: 0x1::ascii::String,
        allocation_bps: u64,
        total_staked: u64,
        gdori_supply: u64,
    }

    struct SavingsDepositEnrichedEvent has copy, drop {
        user: address,
        dori_deposited: u64,
        sdori_minted: u64,
        total_dori_balance: u64,
        total_sdori_supply: u64,
        exchange_rate: u64,
    }

    struct SavingsWithdrawEnrichedEvent has copy, drop {
        user: address,
        sdori_burned: u64,
        dori_withdrawn: u64,
        total_dori_balance: u64,
        total_sdori_supply: u64,
        exchange_rate: u64,
    }

    struct GuardSavingsDepositEnrichedEvent has copy, drop {
        user: address,
        dori_deposited: u64,
        gdori_minted: u64,
        total_staked: u64,
        gdori_supply: u64,
        exchange_rate: u64,
    }

    struct GuardSavingsWithdrawEnrichedEvent has copy, drop {
        user: address,
        gdori_burned: u64,
        dori_withdrawn: u64,
        total_staked: u64,
        gdori_supply: u64,
        exchange_rate: u64,
    }

    struct GuardSavingsDoriRestakedEnrichedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        total_staked: u64,
        gdori_supply: u64,
        exchange_rate: u64,
    }

    struct GuardSavingsDepositRateSnapshotEvent has copy, drop {
        total_staked: u64,
        gdori_supply: u64,
        exchange_rate: u64,
    }

    struct GuardSavingsWithdrawRateSnapshotEvent has copy, drop {
        total_staked: u64,
        gdori_supply: u64,
        exchange_rate: u64,
    }

    public fun emit_add_collateral_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u256, arg7: u256) {
    }

    public fun emit_borrow_more_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
    }

    public fun emit_claim_all_rewards_event(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
    }

    public fun emit_claim_surplus_event(arg0: address, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64) {
    }

    public fun emit_close_vault_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: bool, arg3: u64, arg4: u64) {
    }

    public fun emit_collateral_debt_redistribution_event(arg0: 0x2::object::ID, arg1: u256, arg2: u256, arg3: u256, arg4: u64, arg5: u64) {
    }

    public fun emit_create_admin_cap_event(arg0: 0x2::object::ID) {
    }

    public fun emit_create_vault_admin_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
    }

    public fun emit_create_vault_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u256, arg8: 0x1::ascii::String) {
    }

    public fun emit_delete_vault_admin_event(arg0: 0x2::object::ID) {
    }

    public fun emit_farm_yield_distribution_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
    }

    public fun emit_fee_vault_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
    }

    public fun emit_global_burn(arg0: u64) {
    }

    public fun emit_global_mint_and_transfer(arg0: u64) {
    }

    public fun emit_global_mint_dori_fee_vault(arg0: u64) {
    }

    public fun emit_global_mint_dori_sp(arg0: u64) {
    }

    public fun emit_guard_savings_allocation_set_event(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: u64, arg3: u64, arg4: u64) {
    }

    public fun emit_guard_savings_collateral_claimed_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
    }

    public fun emit_guard_savings_deposit_enriched_event(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
    }

    public fun emit_guard_savings_deposit_rate_snapshot_event(arg0: u64, arg1: u64, arg2: u64) {
    }

    public fun emit_guard_savings_deposited_event(arg0: address, arg1: u64, arg2: 0x2::object::ID) {
    }

    public fun emit_guard_savings_dori_restaked_enriched_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
    }

    public fun emit_guard_savings_dori_restaked_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
    }

    public fun emit_guard_savings_gdori_burned_event(arg0: address, arg1: u64, arg2: u64) {
    }

    public fun emit_guard_savings_gdori_minted_event(arg0: address, arg1: u64, arg2: u64) {
    }

    public fun emit_guard_savings_liquidation_notified_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
    }

    public fun emit_guard_savings_pool_registered_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::ascii::String, arg3: u64, arg4: vector<0x2::object::ID>, arg5: u64) {
    }

    public fun emit_guard_savings_settlement_completed_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
    }

    public fun emit_guard_savings_vault_initialized_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: vector<0x2::object::ID>) {
    }

    public fun emit_guard_savings_withdraw_enriched_event(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
    }

    public fun emit_guard_savings_withdraw_rate_snapshot_event(arg0: u64, arg1: u64, arg2: u64) {
    }

    public fun emit_guard_savings_withdrawn_event(arg0: address, arg1: u64, arg2: 0x2::object::ID) {
    }

    public fun emit_interest_update_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
    }

    public fun emit_last_interest_update_event(arg0: 0x2::object::ID, arg1: u64) {
    }

    public fun emit_liquidation_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u256, arg7: u256, arg8: u64, arg9: u64) {
    }

    public fun emit_liquidation_update_snapshot_event(arg0: 0x2::object::ID, arg1: u256, arg2: u256) {
    }

    public fun emit_new_stake_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: u256, arg6: u256, arg7: u256, arg8: u64, arg9: u64) {
    }

    public fun emit_new_surplus_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
    }

    public fun emit_new_vault_registry_event(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: u256) {
    }

    public fun emit_psm_caps_updated_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
    }

    public fun emit_psm_created_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
    }

    public fun emit_psm_emergency_withdraw_event(arg0: 0x2::object::ID, arg1: u64, arg2: address) {
    }

    public fun emit_psm_fee_range_updated_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
    }

    public fun emit_psm_fee_updated_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
    }

    public fun emit_psm_paused_event(arg0: 0x2::object::ID) {
    }

    public fun emit_psm_swap_to_collateral_event(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
    }

    public fun emit_psm_swap_to_dori_event(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
    }

    public fun emit_psm_unpaused_event(arg0: 0x2::object::ID) {
    }

    public fun emit_redemption_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u256, arg9: u256, arg10: u64, arg11: u64) {
    }

    public fun emit_repay_debt_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
    }

    public fun emit_savings_deposit_enriched_event(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
    }

    public fun emit_savings_deposit_event(arg0: address, arg1: u64, arg2: u64, arg3: u64) {
    }

    public fun emit_savings_vault_initialized_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
    }

    public fun emit_savings_withdraw_enriched_event(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
    }

    public fun emit_savings_withdraw_event(arg0: address, arg1: u64, arg2: u64, arg3: u64) {
    }

    public fun emit_savings_yield_distributed_event(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
    }

    public fun emit_stability_pool_offset_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u256, arg5: u64, arg6: u64, arg7: u64, arg8: u256, arg9: u64) {
    }

    public fun emit_stability_pool_yield_distribution_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u256, arg5: u64) {
    }

    public fun emit_unstake_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: 0x2::object::ID, arg4: bool, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u256, arg11: u256, arg12: u256, arg13: u64, arg14: u64) {
    }

    public fun emit_update_and_get_new_stake_event(arg0: 0x2::object::ID, arg1: u256) {
    }

    public fun emit_update_stake_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: 0x2::object::ID, arg4: bool, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u256, arg11: u256, arg12: u256, arg13: u64, arg14: u64) {
    }

    public fun emit_update_vault_registry_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u256) {
    }

    public fun emit_urgent_redemption_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u256, arg9: u256, arg10: u64, arg11: u64) {
    }

    public fun emit_withdraw_collateral_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u256, arg7: u256) {
    }

    // decompiled from Move bytecode v6
}

