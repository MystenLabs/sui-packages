module 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::events {
    struct MarketCreated has copy, drop {
        market_core_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        maturity_ms: u64,
        package_id: 0x2::object::ID,
        pt_type: 0x1::type_name::TypeName,
        yt_vault_type: 0x1::type_name::TypeName,
        yt_extract_ratio_bps: u16,
        claim_fee_bps: u16,
        redeem_fee_bps: u16,
        combine_fee_bps: u16,
        treasury_id: 0x2::object::ID,
    }

    struct AdapterRegistered has copy, drop {
        adapter_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        adapter_version: u64,
    }

    struct PtVaultRegistered has copy, drop {
        market_core_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        pt_type: 0x1::type_name::TypeName,
    }

    struct YtVaultRegistered has copy, drop {
        market_core_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        yt_vault_type: 0x1::type_name::TypeName,
    }

    struct SplitEvent has copy, drop {
        market_core_id: 0x2::object::ID,
        escrow_id: 0x2::object::ID,
        pt_id: 0x2::object::ID,
        yt_id: 0x2::object::ID,
        notional: u64,
        max_yield_extractable_sy: u64,
        initial_index: u128,
    }

    struct CombineEvent has copy, drop {
        market_core_id: 0x2::object::ID,
        escrow_id: 0x2::object::ID,
        pt_id: 0x2::object::ID,
        yt_id: 0x2::object::ID,
        notional: u64,
        remaining_yield_sui: u64,
        sy_returned: u64,
        fee_sui: u64,
    }

    struct PtRedeemedDirect has copy, drop {
        market_core_id: 0x2::object::ID,
        escrow_id: 0x2::object::ID,
        pt_id: 0x2::object::ID,
        sui_out: u64,
        fee_sui: u64,
    }

    struct YieldClaimed has copy, drop {
        market_core_id: 0x2::object::ID,
        escrow_id: 0x2::object::ID,
        yt_id: 0x2::object::ID,
        index_before: u128,
        index_after: u128,
        sy_out: u64,
        sui_out: u64,
        actual_sy_claimed: u64,
        theoretical_sy: u64,
        hit_hard_cap: bool,
        fee_sui: u64,
    }

    struct PtDepositedToVault has copy, drop {
        market_core_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        pt_id: 0x2::object::ID,
        coin_amount: u64,
    }

    struct PtRedeemedFromVault has copy, drop {
        market_core_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        coin_burned: u64,
        sy_drained: u64,
        escrow_count: u64,
        sui_out: u64,
        fee_sui: u64,
    }

    struct PtVaultCompacted has copy, drop {
        vault_id: 0x2::object::ID,
        slots_reclaimed: u64,
    }

    struct VaultDeposit has copy, drop {
        vault_id: 0x2::object::ID,
        yt_id: 0x2::object::ID,
        notional: u64,
        historical_sui_out: u64,
        shares_minted: u64,
        entry_epoch: u64,
        fee_sui: u64,
    }

    struct VaultCollect has copy, drop {
        vault_id: 0x2::object::ID,
        epoch_id: u64,
        yt_count: u64,
        sui_collected_net: u64,
        fee_sui: u64,
        snapshot_shares: u64,
    }

    struct CollectCancelled has copy, drop {
        vault_id: 0x2::object::ID,
        receipt_id: 0x2::object::ID,
        epoch: u64,
        yt_count: u64,
        sy_forfeited: u64,
        cancelled_at_ms: u64,
        permissionless: bool,
    }

    struct UnallocatedYieldParked has copy, drop {
        vault_id: 0x2::object::ID,
        epoch: u64,
        amount: u64,
    }

    struct UnallocatedYieldWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        caller: address,
    }

    struct ForfeitedSyWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        caller: address,
    }

    struct PausedYtFinalized has copy, drop {
        vault_id: 0x2::object::ID,
        escrow_id: 0x2::object::ID,
        yt_id: 0x2::object::ID,
        sy_forfeited: u64,
        finalized_at_ms: u64,
    }

    struct VaultYieldClaimed has copy, drop {
        vault_id: 0x2::object::ID,
        claimer: address,
        entry_epoch_before: u64,
        entry_epoch_after: u64,
        epochs_claimed: u64,
        sui_out: u64,
    }

    struct NavInventoryRedeemed has copy, drop {
        vault_id: 0x2::object::ID,
        redeemer: address,
        shares_burned: u64,
        entry_epoch: u64,
        epochs_claimed: u64,
        sui_out: u64,
    }

    struct HardCapBreached has copy, drop {
        market_core_id: 0x2::object::ID,
        escrow_id: 0x2::object::ID,
        total_extracted: u64,
        max_extractable: u64,
        timestamp_ms: u64,
    }

    struct FeeCollected has copy, drop {
        market_core_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        operation: u8,
        fee_sui: u64,
        gross_sui: u64,
    }

    struct WatermarkViolation has copy, drop {
        adapter_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        last_index: u128,
        observed_index: u128,
        last_observed_ms: u64,
        now_ms: u64,
        direction: u8,
    }

    struct Paused has copy, drop {
        scope: u8,
        object_id: 0x2::object::ID,
        lock_kind: u8,
        ttl_ms: u64,
        reason: vector<u8>,
    }

    struct Unpaused has copy, drop {
        scope: u8,
        object_id: 0x2::object::ID,
    }

    struct PauseAutoExpired has copy, drop {
        scope: u8,
        object_id: 0x2::object::ID,
        prev_lock_kind: u8,
        expired_at_ms: u64,
    }

    struct WatermarkObservedDuringPause has copy, drop {
        scope: u8,
        object_id: 0x2::object::ID,
        active_lock_kind: u8,
        observed_at_ms: u64,
    }

    public(friend) fun emit_adapter_paused(arg0: 0x2::object::ID, arg1: u8, arg2: u64, arg3: vector<u8>) {
        emit_paused(1, arg0, arg1, arg2, arg3);
    }

    public(friend) fun emit_adapter_registered(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = AdapterRegistered{
            adapter_id      : arg0,
            asset_type      : arg1,
            adapter_version : arg2,
        };
        0x2::event::emit<AdapterRegistered>(v0);
    }

    public(friend) fun emit_adapter_unpaused(arg0: 0x2::object::ID) {
        emit_unpaused(1, arg0);
    }

    public(friend) fun emit_collect_cancelled(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool) {
        let v0 = CollectCancelled{
            vault_id        : arg0,
            receipt_id      : arg1,
            epoch           : arg2,
            yt_count        : arg3,
            sy_forfeited    : arg4,
            cancelled_at_ms : arg5,
            permissionless  : arg6,
        };
        0x2::event::emit<CollectCancelled>(v0);
    }

    public(friend) fun emit_combine(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = CombineEvent{
            market_core_id      : arg0,
            escrow_id           : arg1,
            pt_id               : arg2,
            yt_id               : arg3,
            notional            : arg4,
            remaining_yield_sui : arg5,
            sy_returned         : arg6,
            fee_sui             : arg7,
        };
        0x2::event::emit<CombineEvent>(v0);
    }

    public(friend) fun emit_fee_collected(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8, arg3: u64, arg4: u64) {
        let v0 = FeeCollected{
            market_core_id : arg0,
            treasury_id    : arg1,
            operation      : arg2,
            fee_sui        : arg3,
            gross_sui      : arg4,
        };
        0x2::event::emit<FeeCollected>(v0);
    }

    public(friend) fun emit_forfeited_sy_withdrawn(arg0: 0x2::object::ID, arg1: u64, arg2: address) {
        let v0 = ForfeitedSyWithdrawn{
            vault_id : arg0,
            amount   : arg1,
            caller   : arg2,
        };
        0x2::event::emit<ForfeitedSyWithdrawn>(v0);
    }

    public(friend) fun emit_hard_cap_breached(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = HardCapBreached{
            market_core_id  : arg0,
            escrow_id       : arg1,
            total_extracted : arg2,
            max_extractable : arg3,
            timestamp_ms    : arg4,
        };
        0x2::event::emit<HardCapBreached>(v0);
    }

    public(friend) fun emit_market_created(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: 0x2::object::ID, arg4: 0x1::type_name::TypeName, arg5: 0x1::type_name::TypeName, arg6: u16, arg7: u16, arg8: u16, arg9: u16, arg10: 0x2::object::ID) {
        let v0 = MarketCreated{
            market_core_id       : arg0,
            asset_type           : arg1,
            maturity_ms          : arg2,
            package_id           : arg3,
            pt_type              : arg4,
            yt_vault_type        : arg5,
            yt_extract_ratio_bps : arg6,
            claim_fee_bps        : arg7,
            redeem_fee_bps       : arg8,
            combine_fee_bps      : arg9,
            treasury_id          : arg10,
        };
        0x2::event::emit<MarketCreated>(v0);
    }

    public(friend) fun emit_nav_inventory_redeemed(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = NavInventoryRedeemed{
            vault_id       : arg0,
            redeemer       : arg1,
            shares_burned  : arg2,
            entry_epoch    : arg3,
            epochs_claimed : arg4,
            sui_out        : arg5,
        };
        0x2::event::emit<NavInventoryRedeemed>(v0);
    }

    public(friend) fun emit_pause_auto_expired(arg0: u8, arg1: 0x2::object::ID, arg2: u8, arg3: u64) {
        let v0 = PauseAutoExpired{
            scope          : arg0,
            object_id      : arg1,
            prev_lock_kind : arg2,
            expired_at_ms  : arg3,
        };
        0x2::event::emit<PauseAutoExpired>(v0);
    }

    public(friend) fun emit_paused(arg0: u8, arg1: 0x2::object::ID, arg2: u8, arg3: u64, arg4: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg4) <= 256, 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_pause_reason_too_long());
        let v0 = Paused{
            scope     : arg0,
            object_id : arg1,
            lock_kind : arg2,
            ttl_ms    : arg3,
            reason    : arg4,
        };
        0x2::event::emit<Paused>(v0);
    }

    public(friend) fun emit_paused_yt_finalized(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64) {
        let v0 = PausedYtFinalized{
            vault_id        : arg0,
            escrow_id       : arg1,
            yt_id           : arg2,
            sy_forfeited    : arg3,
            finalized_at_ms : arg4,
        };
        0x2::event::emit<PausedYtFinalized>(v0);
    }

    public(friend) fun emit_pt_deposited_to_vault(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64) {
        let v0 = PtDepositedToVault{
            market_core_id : arg0,
            vault_id       : arg1,
            pt_id          : arg2,
            coin_amount    : arg3,
        };
        0x2::event::emit<PtDepositedToVault>(v0);
    }

    public(friend) fun emit_pt_redeemed_direct(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64) {
        let v0 = PtRedeemedDirect{
            market_core_id : arg0,
            escrow_id      : arg1,
            pt_id          : arg2,
            sui_out        : arg3,
            fee_sui        : arg4,
        };
        0x2::event::emit<PtRedeemedDirect>(v0);
    }

    public(friend) fun emit_pt_redeemed_from_vault(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = PtRedeemedFromVault{
            market_core_id : arg0,
            vault_id       : arg1,
            coin_burned    : arg2,
            sy_drained     : arg3,
            escrow_count   : arg4,
            sui_out        : arg5,
            fee_sui        : arg6,
        };
        0x2::event::emit<PtRedeemedFromVault>(v0);
    }

    public(friend) fun emit_pt_vault_compacted(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = PtVaultCompacted{
            vault_id        : arg0,
            slots_reclaimed : arg1,
        };
        0x2::event::emit<PtVaultCompacted>(v0);
    }

    public(friend) fun emit_pt_vault_registered(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName) {
        let v0 = PtVaultRegistered{
            market_core_id : arg0,
            vault_id       : arg1,
            pt_type        : arg2,
        };
        0x2::event::emit<PtVaultRegistered>(v0);
    }

    public(friend) fun emit_split(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u128) {
        let v0 = SplitEvent{
            market_core_id           : arg0,
            escrow_id                : arg1,
            pt_id                    : arg2,
            yt_id                    : arg3,
            notional                 : arg4,
            max_yield_extractable_sy : arg5,
            initial_index            : arg6,
        };
        0x2::event::emit<SplitEvent>(v0);
    }

    public(friend) fun emit_unallocated_yield_parked(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = UnallocatedYieldParked{
            vault_id : arg0,
            epoch    : arg1,
            amount   : arg2,
        };
        0x2::event::emit<UnallocatedYieldParked>(v0);
    }

    public(friend) fun emit_unallocated_yield_withdrawn(arg0: 0x2::object::ID, arg1: u64, arg2: address) {
        let v0 = UnallocatedYieldWithdrawn{
            vault_id : arg0,
            amount   : arg1,
            caller   : arg2,
        };
        0x2::event::emit<UnallocatedYieldWithdrawn>(v0);
    }

    public(friend) fun emit_unpaused(arg0: u8, arg1: 0x2::object::ID) {
        let v0 = Unpaused{
            scope     : arg0,
            object_id : arg1,
        };
        0x2::event::emit<Unpaused>(v0);
    }

    public(friend) fun emit_vault_collect(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = VaultCollect{
            vault_id          : arg0,
            epoch_id          : arg1,
            yt_count          : arg2,
            sui_collected_net : arg3,
            fee_sui           : arg4,
            snapshot_shares   : arg5,
        };
        0x2::event::emit<VaultCollect>(v0);
    }

    public(friend) fun emit_vault_deposit(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = VaultDeposit{
            vault_id           : arg0,
            yt_id              : arg1,
            notional           : arg2,
            historical_sui_out : arg3,
            shares_minted      : arg4,
            entry_epoch        : arg5,
            fee_sui            : arg6,
        };
        0x2::event::emit<VaultDeposit>(v0);
    }

    public(friend) fun emit_vault_yield_claimed(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = VaultYieldClaimed{
            vault_id           : arg0,
            claimer            : arg1,
            entry_epoch_before : arg2,
            entry_epoch_after  : arg3,
            epochs_claimed     : arg4,
            sui_out            : arg5,
        };
        0x2::event::emit<VaultYieldClaimed>(v0);
    }

    public(friend) fun emit_watermark_observed_during_pause(arg0: u8, arg1: 0x2::object::ID, arg2: u8, arg3: u64) {
        let v0 = WatermarkObservedDuringPause{
            scope            : arg0,
            object_id        : arg1,
            active_lock_kind : arg2,
            observed_at_ms   : arg3,
        };
        0x2::event::emit<WatermarkObservedDuringPause>(v0);
    }

    public(friend) fun emit_watermark_violation(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u128, arg3: u128, arg4: u64, arg5: u64, arg6: u8) {
        let v0 = WatermarkViolation{
            adapter_id       : arg0,
            asset_type       : arg1,
            last_index       : arg2,
            observed_index   : arg3,
            last_observed_ms : arg4,
            now_ms           : arg5,
            direction        : arg6,
        };
        0x2::event::emit<WatermarkViolation>(v0);
    }

    public(friend) fun emit_yield_claimed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u128, arg4: u128, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: u64) {
        let v0 = YieldClaimed{
            market_core_id    : arg0,
            escrow_id         : arg1,
            yt_id             : arg2,
            index_before      : arg3,
            index_after       : arg4,
            sy_out            : arg5,
            sui_out           : arg6,
            actual_sy_claimed : arg7,
            theoretical_sy    : arg8,
            hit_hard_cap      : arg9,
            fee_sui           : arg10,
        };
        0x2::event::emit<YieldClaimed>(v0);
    }

    public(friend) fun emit_yt_vault_registered(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName) {
        let v0 = YtVaultRegistered{
            market_core_id : arg0,
            vault_id       : arg1,
            yt_vault_type  : arg2,
        };
        0x2::event::emit<YtVaultRegistered>(v0);
    }

    public fun scope_adapter() : u8 {
        1
    }

    // decompiled from Move bytecode v7
}

