module 0x59b8620f8d4a1f3c6b776d0e6f564c503aace69bc398b0fb04fe9f28af6719ae::vault_events {
    struct DepositQueued has copy, drop {
        user: address,
        amount: u64,
        fee: u64,
    }

    struct DepositSettled has copy, drop {
        total_usdc: u64,
        minted_shares: u64,
    }

    struct RedeemQueued has copy, drop {
        user: address,
        shares: u64,
        rcusdp_estimate: u64,
    }

    struct RedeemSettled has copy, drop {
        total_rcusdp: u64,
    }

    struct RedeemFinalized has copy, drop {
        total_rcusdp: u64,
        usdc_net: u64,
        fee: u64,
    }

    struct VaultMigrated has copy, drop {
        old_version: u64,
        new_version: u64,
    }

    struct ClaimAllocated has copy, drop {
        user: address,
        amount: u64,
    }

    struct Claimed has copy, drop {
        user: address,
        amount: u64,
    }

    struct FeesTaken has copy, drop {
        amount: u64,
        fee_type: u8,
    }

    struct SharePriceSynced has copy, drop {
        share_price: u128,
        total_shares: u64,
    }

    struct Paused has copy, drop {
        state: bool,
    }

    struct AdminChangeInitiated has copy, drop {
        current_admin: address,
        pending_admin: address,
        effective_ms: u64,
    }

    struct AdminChangeCompleted has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct AdminChangeCancelled has copy, drop {
        cancelled_admin: address,
    }

    struct OperatorChangeInitiated has copy, drop {
        current_operator: address,
        pending_operator: address,
        effective_ms: u64,
    }

    struct OperatorChangeCompleted has copy, drop {
        old_operator: address,
        new_operator: address,
    }

    struct OperatorChangeCancelled has copy, drop {
        cancelled_operator: address,
    }

    struct RoleChangeDelayUpdated has copy, drop {
        old_delay_ms: u64,
        new_delay_ms: u64,
    }

    struct FeesUpdated has copy, drop {
        deposit_fee_bps: u64,
        mgmt_fee_bps: u64,
        redeem_fee_bps: u64,
    }

    struct MgmtFeeCharged has copy, drop {
        amount: u64,
        timestamp_ms: u64,
    }

    struct InstantRedeemed has copy, drop {
        user: address,
        shares: u64,
        usdc_gross: u64,
        usdc_net: u64,
        fee: u64,
    }

    struct ReserveFundDeposited has copy, drop {
        amount: u64,
        new_balance: u64,
    }

    struct ReserveFundWithdrawn has copy, drop {
        amount: u64,
        new_balance: u64,
    }

    struct RcusdpWithdrawn has copy, drop {
        user: address,
        shares: u64,
        rcusdp_gross: u64,
        rcusdp_net: u64,
        fee: u64,
    }

    struct DepositCancelled has copy, drop {
        user: address,
        deposit_id: u64,
        usdc_gross: u64,
        usdc_net: u64,
        fee: u64,
    }

    struct DepositRecordCreated has copy, drop {
        user: address,
        deposit_id: u64,
        amount: u64,
        fee: u64,
        timestamp_ms: u64,
    }

    struct DepositRecordSettled has copy, drop {
        user: address,
        deposit_id: u64,
        shares: u64,
        settle_time: u64,
    }

    struct PendingUsdcTaken has copy, drop {
        operator: address,
        amount: u64,
    }

    struct PendingRcusdpTaken has copy, drop {
        operator: address,
        amount: u64,
    }

    struct DustWithdrawn has copy, drop {
        recipient: address,
        amount: u64,
    }

    struct UserRecordsPruned has copy, drop {
        user: address,
        pruned_count: u64,
        remaining_count: u64,
    }

    public fun emit_admin_change_cancelled(arg0: address) {
        let v0 = AdminChangeCancelled{cancelled_admin: arg0};
        0x2::event::emit<AdminChangeCancelled>(v0);
    }

    public fun emit_admin_change_completed(arg0: address, arg1: address) {
        let v0 = AdminChangeCompleted{
            old_admin : arg0,
            new_admin : arg1,
        };
        0x2::event::emit<AdminChangeCompleted>(v0);
    }

    public fun emit_admin_change_initiated(arg0: address, arg1: address, arg2: u64) {
        let v0 = AdminChangeInitiated{
            current_admin : arg0,
            pending_admin : arg1,
            effective_ms  : arg2,
        };
        0x2::event::emit<AdminChangeInitiated>(v0);
    }

    public fun emit_claim_allocated(arg0: address, arg1: u64) {
        let v0 = ClaimAllocated{
            user   : arg0,
            amount : arg1,
        };
        0x2::event::emit<ClaimAllocated>(v0);
    }

    public fun emit_claimed(arg0: address, arg1: u64) {
        let v0 = Claimed{
            user   : arg0,
            amount : arg1,
        };
        0x2::event::emit<Claimed>(v0);
    }

    public fun emit_deposit_cancelled(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = DepositCancelled{
            user       : arg0,
            deposit_id : arg1,
            usdc_gross : arg2,
            usdc_net   : arg3,
            fee        : arg4,
        };
        0x2::event::emit<DepositCancelled>(v0);
    }

    public fun emit_deposit_queued(arg0: address, arg1: u64, arg2: u64) {
        let v0 = DepositQueued{
            user   : arg0,
            amount : arg1,
            fee    : arg2,
        };
        0x2::event::emit<DepositQueued>(v0);
    }

    public fun emit_deposit_record_created(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = DepositRecordCreated{
            user         : arg0,
            deposit_id   : arg1,
            amount       : arg2,
            fee          : arg3,
            timestamp_ms : arg4,
        };
        0x2::event::emit<DepositRecordCreated>(v0);
    }

    public fun emit_deposit_record_settled(arg0: address, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = DepositRecordSettled{
            user        : arg0,
            deposit_id  : arg1,
            shares      : arg2,
            settle_time : arg3,
        };
        0x2::event::emit<DepositRecordSettled>(v0);
    }

    public fun emit_deposit_settled(arg0: u64, arg1: u64) {
        let v0 = DepositSettled{
            total_usdc    : arg0,
            minted_shares : arg1,
        };
        0x2::event::emit<DepositSettled>(v0);
    }

    public fun emit_dust_withdrawn(arg0: address, arg1: u64) {
        let v0 = DustWithdrawn{
            recipient : arg0,
            amount    : arg1,
        };
        0x2::event::emit<DustWithdrawn>(v0);
    }

    public fun emit_fees_taken(arg0: u64, arg1: u8) {
        let v0 = FeesTaken{
            amount   : arg0,
            fee_type : arg1,
        };
        0x2::event::emit<FeesTaken>(v0);
    }

    public fun emit_fees_updated(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = FeesUpdated{
            deposit_fee_bps : arg0,
            mgmt_fee_bps    : arg1,
            redeem_fee_bps  : arg2,
        };
        0x2::event::emit<FeesUpdated>(v0);
    }

    public fun emit_instant_redeemed(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = InstantRedeemed{
            user       : arg0,
            shares     : arg1,
            usdc_gross : arg2,
            usdc_net   : arg3,
            fee        : arg4,
        };
        0x2::event::emit<InstantRedeemed>(v0);
    }

    public fun emit_mgmt_fee_charged(arg0: u64, arg1: u64) {
        let v0 = MgmtFeeCharged{
            amount       : arg0,
            timestamp_ms : arg1,
        };
        0x2::event::emit<MgmtFeeCharged>(v0);
    }

    public fun emit_operator_change_cancelled(arg0: address) {
        let v0 = OperatorChangeCancelled{cancelled_operator: arg0};
        0x2::event::emit<OperatorChangeCancelled>(v0);
    }

    public fun emit_operator_change_completed(arg0: address, arg1: address) {
        let v0 = OperatorChangeCompleted{
            old_operator : arg0,
            new_operator : arg1,
        };
        0x2::event::emit<OperatorChangeCompleted>(v0);
    }

    public fun emit_operator_change_initiated(arg0: address, arg1: address, arg2: u64) {
        let v0 = OperatorChangeInitiated{
            current_operator : arg0,
            pending_operator : arg1,
            effective_ms     : arg2,
        };
        0x2::event::emit<OperatorChangeInitiated>(v0);
    }

    public fun emit_paused(arg0: bool) {
        let v0 = Paused{state: arg0};
        0x2::event::emit<Paused>(v0);
    }

    public fun emit_pending_rcusdp_taken(arg0: address, arg1: u64) {
        let v0 = PendingRcusdpTaken{
            operator : arg0,
            amount   : arg1,
        };
        0x2::event::emit<PendingRcusdpTaken>(v0);
    }

    public fun emit_pending_usdc_taken(arg0: address, arg1: u64) {
        let v0 = PendingUsdcTaken{
            operator : arg0,
            amount   : arg1,
        };
        0x2::event::emit<PendingUsdcTaken>(v0);
    }

    public fun emit_rcusdp_withdrawn(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = RcusdpWithdrawn{
            user         : arg0,
            shares       : arg1,
            rcusdp_gross : arg2,
            rcusdp_net   : arg3,
            fee          : arg4,
        };
        0x2::event::emit<RcusdpWithdrawn>(v0);
    }

    public fun emit_redeem_finalized(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = RedeemFinalized{
            total_rcusdp : arg0,
            usdc_net     : arg1,
            fee          : arg2,
        };
        0x2::event::emit<RedeemFinalized>(v0);
    }

    public fun emit_redeem_queued(arg0: address, arg1: u64, arg2: u64) {
        let v0 = RedeemQueued{
            user            : arg0,
            shares          : arg1,
            rcusdp_estimate : arg2,
        };
        0x2::event::emit<RedeemQueued>(v0);
    }

    public fun emit_redeem_settled(arg0: u64) {
        let v0 = RedeemSettled{total_rcusdp: arg0};
        0x2::event::emit<RedeemSettled>(v0);
    }

    public fun emit_reserve_fund_deposited(arg0: u64, arg1: u64) {
        let v0 = ReserveFundDeposited{
            amount      : arg0,
            new_balance : arg1,
        };
        0x2::event::emit<ReserveFundDeposited>(v0);
    }

    public fun emit_reserve_fund_withdrawn(arg0: u64, arg1: u64) {
        let v0 = ReserveFundWithdrawn{
            amount      : arg0,
            new_balance : arg1,
        };
        0x2::event::emit<ReserveFundWithdrawn>(v0);
    }

    public fun emit_role_change_delay_updated(arg0: u64, arg1: u64) {
        let v0 = RoleChangeDelayUpdated{
            old_delay_ms : arg0,
            new_delay_ms : arg1,
        };
        0x2::event::emit<RoleChangeDelayUpdated>(v0);
    }

    public fun emit_share_price_synced(arg0: u128, arg1: u64) {
        let v0 = SharePriceSynced{
            share_price  : arg0,
            total_shares : arg1,
        };
        0x2::event::emit<SharePriceSynced>(v0);
    }

    public fun emit_user_records_pruned(arg0: address, arg1: u64, arg2: u64) {
        let v0 = UserRecordsPruned{
            user            : arg0,
            pruned_count    : arg1,
            remaining_count : arg2,
        };
        0x2::event::emit<UserRecordsPruned>(v0);
    }

    public fun emit_vault_migrated(arg0: u64, arg1: u64) {
        let v0 = VaultMigrated{
            old_version : arg0,
            new_version : arg1,
        };
        0x2::event::emit<VaultMigrated>(v0);
    }

    // decompiled from Move bytecode v6
}

