module 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::events {
    struct VaultCreatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        creator: address,
        agent_id: vector<u8>,
        vault_kind: u8,
        seed_usdc: u64,
        seed_shares: u128,
        created_at_ms: u64,
    }

    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        usdc_in: u64,
        shares_out: u128,
        share_price_scaled: u128,
        nav_snapshot_scaled: u128,
        at_ms: u64,
    }

    struct RedemptionRequestedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        request_id: 0x2::object::ID,
        owner: address,
        shares: u128,
        epoch_id: u64,
        requested_at_ms: u64,
    }

    struct ClaimedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        request_id: 0x2::object::ID,
        epoch_id: u64,
        owner: address,
        shares_burned: u128,
        usdc_out: u64,
        at_ms: u64,
    }

    struct EpochOpenedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        epoch_id: u64,
        epoch_state_id: 0x2::object::ID,
        opened_at_ms: u64,
    }

    struct EpochClosedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        epoch_id: u64,
        closed_at_ms: u64,
        total_shares_locked: u128,
        requests_total: u64,
    }

    struct EpochFinalizedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        epoch_id: u64,
        usdc_delivered: u64,
        shares_burned: u128,
        finalized_at_ms: u64,
    }

    struct EpochDestroyedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        epoch_id: u64,
        dust_swept_usdc: u64,
    }

    struct NavReportedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        nav_scaled: u128,
        share_price_scaled: u128,
        idle_usdc: u128,
        in_flight_inbound: u128,
        in_flight_outbound: u128,
        external_value: u128,
        ts_ms: u64,
    }

    struct PerformanceFeeEvent has copy, drop {
        vault_id: 0x2::object::ID,
        shares_minted_to_fee_recipient: u128,
        shares_minted_to_protocol: u128,
        new_hwm_scaled: u128,
        ts_ms: u64,
    }

    struct ManagementFeeEvent has copy, drop {
        vault_id: 0x2::object::ID,
        shares_minted: u128,
        elapsed_ms: u64,
        ts_ms: u64,
    }

    struct BufferOpEvent has copy, drop {
        vault_id: 0x2::object::ID,
        kind: u8,
        amount: u64,
        idle_usdc_after: u64,
        ts_ms: u64,
    }

    struct PauseEvent has copy, drop {
        vault_id: 0x2::object::ID,
        deposits_paused: bool,
        redemptions_paused: bool,
        ts_ms: u64,
    }

    struct EmergencyModeEvent has copy, drop {
        vault_id: 0x2::object::ID,
        enabled: bool,
        ts_ms: u64,
    }

    struct EmergencyWithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        shares_burned: u128,
        usdc_out: u64,
        idle_usdc_after: u64,
        ts_ms: u64,
    }

    struct ForceWithdrawQueuedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
        effective_ms: u64,
        ts_ms: u64,
    }

    struct ForceWithdrawCancelledEvent has copy, drop {
        vault_id: 0x2::object::ID,
        ts_ms: u64,
    }

    struct ForceWithdrawExecutedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
        idle_usdc_after: u64,
        ts_ms: u64,
    }

    struct OracleRotationQueuedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        new_authority: address,
        effective_ms: u64,
    }

    struct OracleRotationExecutedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        new_authority: address,
        executed_at_ms: u64,
    }

    struct FulfillerRotatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        new_authority: address,
        ts_ms: u64,
    }

    struct FeesUpdatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        performance_fee_bps: u64,
        management_fee_bps: u64,
        ts_ms: u64,
    }

    struct FeeRecipientUpdatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        old_recipient: address,
        new_recipient: address,
        ts_ms: u64,
    }

    struct ProtocolFeeUpdatedEvent has copy, drop {
        protocol_fee_recipient: address,
        protocol_fee_bps: u64,
        ts_ms: u64,
    }

    struct MinSeedUpdatedEvent has copy, drop {
        min_seed_deposit_usdc: u64,
        ts_ms: u64,
    }

    struct CapsUpdatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        deposit_cap_usdc: u64,
        per_user_cap_usdc: u64,
        ts_ms: u64,
    }

    struct BufferParamsUpdatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        target_buffer_bps: u64,
        refill_threshold_bps: u64,
        max_buffer_bps: u64,
        ts_ms: u64,
    }

    struct RegistryPauseEvent has copy, drop {
        paused: bool,
        ts_ms: u64,
    }

    struct RampingFlippedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        ramping: bool,
        ts_ms: u64,
    }

    public(friend) fun emit_buffer_op(arg0: BufferOpEvent) {
        0x2::event::emit<BufferOpEvent>(arg0);
    }

    public(friend) fun emit_buffer_params_updated(arg0: BufferParamsUpdatedEvent) {
        0x2::event::emit<BufferParamsUpdatedEvent>(arg0);
    }

    public(friend) fun emit_caps_updated(arg0: CapsUpdatedEvent) {
        0x2::event::emit<CapsUpdatedEvent>(arg0);
    }

    public(friend) fun emit_claimed(arg0: ClaimedEvent) {
        0x2::event::emit<ClaimedEvent>(arg0);
    }

    public(friend) fun emit_deposit(arg0: DepositEvent) {
        0x2::event::emit<DepositEvent>(arg0);
    }

    public(friend) fun emit_emergency_mode(arg0: EmergencyModeEvent) {
        0x2::event::emit<EmergencyModeEvent>(arg0);
    }

    public(friend) fun emit_emergency_withdraw(arg0: EmergencyWithdrawEvent) {
        0x2::event::emit<EmergencyWithdrawEvent>(arg0);
    }

    public(friend) fun emit_epoch_closed(arg0: EpochClosedEvent) {
        0x2::event::emit<EpochClosedEvent>(arg0);
    }

    public(friend) fun emit_epoch_destroyed(arg0: EpochDestroyedEvent) {
        0x2::event::emit<EpochDestroyedEvent>(arg0);
    }

    public(friend) fun emit_epoch_finalized(arg0: EpochFinalizedEvent) {
        0x2::event::emit<EpochFinalizedEvent>(arg0);
    }

    public(friend) fun emit_epoch_opened(arg0: EpochOpenedEvent) {
        0x2::event::emit<EpochOpenedEvent>(arg0);
    }

    public(friend) fun emit_fee_recipient_updated(arg0: FeeRecipientUpdatedEvent) {
        0x2::event::emit<FeeRecipientUpdatedEvent>(arg0);
    }

    public(friend) fun emit_fees_updated(arg0: FeesUpdatedEvent) {
        0x2::event::emit<FeesUpdatedEvent>(arg0);
    }

    public(friend) fun emit_force_withdraw_cancelled(arg0: ForceWithdrawCancelledEvent) {
        0x2::event::emit<ForceWithdrawCancelledEvent>(arg0);
    }

    public(friend) fun emit_force_withdraw_executed(arg0: ForceWithdrawExecutedEvent) {
        0x2::event::emit<ForceWithdrawExecutedEvent>(arg0);
    }

    public(friend) fun emit_force_withdraw_queued(arg0: ForceWithdrawQueuedEvent) {
        0x2::event::emit<ForceWithdrawQueuedEvent>(arg0);
    }

    public(friend) fun emit_fulfiller_rotated(arg0: FulfillerRotatedEvent) {
        0x2::event::emit<FulfillerRotatedEvent>(arg0);
    }

    public(friend) fun emit_management_fee(arg0: ManagementFeeEvent) {
        0x2::event::emit<ManagementFeeEvent>(arg0);
    }

    public(friend) fun emit_min_seed_updated(arg0: MinSeedUpdatedEvent) {
        0x2::event::emit<MinSeedUpdatedEvent>(arg0);
    }

    public(friend) fun emit_nav_reported(arg0: NavReportedEvent) {
        0x2::event::emit<NavReportedEvent>(arg0);
    }

    public(friend) fun emit_oracle_rotation_executed(arg0: OracleRotationExecutedEvent) {
        0x2::event::emit<OracleRotationExecutedEvent>(arg0);
    }

    public(friend) fun emit_oracle_rotation_queued(arg0: OracleRotationQueuedEvent) {
        0x2::event::emit<OracleRotationQueuedEvent>(arg0);
    }

    public(friend) fun emit_pause(arg0: PauseEvent) {
        0x2::event::emit<PauseEvent>(arg0);
    }

    public(friend) fun emit_performance_fee(arg0: PerformanceFeeEvent) {
        0x2::event::emit<PerformanceFeeEvent>(arg0);
    }

    public(friend) fun emit_protocol_fee_updated(arg0: ProtocolFeeUpdatedEvent) {
        0x2::event::emit<ProtocolFeeUpdatedEvent>(arg0);
    }

    public(friend) fun emit_ramping_flipped(arg0: RampingFlippedEvent) {
        0x2::event::emit<RampingFlippedEvent>(arg0);
    }

    public(friend) fun emit_redemption_requested(arg0: RedemptionRequestedEvent) {
        0x2::event::emit<RedemptionRequestedEvent>(arg0);
    }

    public(friend) fun emit_registry_pause(arg0: RegistryPauseEvent) {
        0x2::event::emit<RegistryPauseEvent>(arg0);
    }

    public(friend) fun emit_vault_created(arg0: VaultCreatedEvent) {
        0x2::event::emit<VaultCreatedEvent>(arg0);
    }

    public(friend) fun new_buffer_op(arg0: 0x2::object::ID, arg1: u8, arg2: u64, arg3: u64, arg4: u64) : BufferOpEvent {
        BufferOpEvent{
            vault_id        : arg0,
            kind            : arg1,
            amount          : arg2,
            idle_usdc_after : arg3,
            ts_ms           : arg4,
        }
    }

    public(friend) fun new_buffer_params_updated(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : BufferParamsUpdatedEvent {
        BufferParamsUpdatedEvent{
            vault_id             : arg0,
            target_buffer_bps    : arg1,
            refill_threshold_bps : arg2,
            max_buffer_bps       : arg3,
            ts_ms                : arg4,
        }
    }

    public(friend) fun new_caps_updated(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) : CapsUpdatedEvent {
        CapsUpdatedEvent{
            vault_id          : arg0,
            deposit_cap_usdc  : arg1,
            per_user_cap_usdc : arg2,
            ts_ms             : arg3,
        }
    }

    public(friend) fun new_claimed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: u128, arg5: u64, arg6: u64) : ClaimedEvent {
        ClaimedEvent{
            vault_id      : arg0,
            request_id    : arg1,
            epoch_id      : arg2,
            owner         : arg3,
            shares_burned : arg4,
            usdc_out      : arg5,
            at_ms         : arg6,
        }
    }

    public(friend) fun new_deposit(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u128, arg4: u128, arg5: u128, arg6: u64) : DepositEvent {
        DepositEvent{
            vault_id            : arg0,
            user                : arg1,
            usdc_in             : arg2,
            shares_out          : arg3,
            share_price_scaled  : arg4,
            nav_snapshot_scaled : arg5,
            at_ms               : arg6,
        }
    }

    public(friend) fun new_emergency_mode(arg0: 0x2::object::ID, arg1: bool, arg2: u64) : EmergencyModeEvent {
        EmergencyModeEvent{
            vault_id : arg0,
            enabled  : arg1,
            ts_ms    : arg2,
        }
    }

    public(friend) fun new_emergency_withdraw(arg0: 0x2::object::ID, arg1: address, arg2: u128, arg3: u64, arg4: u64, arg5: u64) : EmergencyWithdrawEvent {
        EmergencyWithdrawEvent{
            vault_id        : arg0,
            owner           : arg1,
            shares_burned   : arg2,
            usdc_out        : arg3,
            idle_usdc_after : arg4,
            ts_ms           : arg5,
        }
    }

    public(friend) fun new_epoch_closed(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u128, arg4: u64) : EpochClosedEvent {
        EpochClosedEvent{
            vault_id            : arg0,
            epoch_id            : arg1,
            closed_at_ms        : arg2,
            total_shares_locked : arg3,
            requests_total      : arg4,
        }
    }

    public(friend) fun new_epoch_destroyed(arg0: 0x2::object::ID, arg1: u64, arg2: u64) : EpochDestroyedEvent {
        EpochDestroyedEvent{
            vault_id        : arg0,
            epoch_id        : arg1,
            dust_swept_usdc : arg2,
        }
    }

    public(friend) fun new_epoch_finalized(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u128, arg4: u64) : EpochFinalizedEvent {
        EpochFinalizedEvent{
            vault_id        : arg0,
            epoch_id        : arg1,
            usdc_delivered  : arg2,
            shares_burned   : arg3,
            finalized_at_ms : arg4,
        }
    }

    public(friend) fun new_epoch_opened(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::object::ID, arg3: u64) : EpochOpenedEvent {
        EpochOpenedEvent{
            vault_id       : arg0,
            epoch_id       : arg1,
            epoch_state_id : arg2,
            opened_at_ms   : arg3,
        }
    }

    public(friend) fun new_fee_recipient_updated(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64) : FeeRecipientUpdatedEvent {
        FeeRecipientUpdatedEvent{
            vault_id      : arg0,
            old_recipient : arg1,
            new_recipient : arg2,
            ts_ms         : arg3,
        }
    }

    public(friend) fun new_fees_updated(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) : FeesUpdatedEvent {
        FeesUpdatedEvent{
            vault_id            : arg0,
            performance_fee_bps : arg1,
            management_fee_bps  : arg2,
            ts_ms               : arg3,
        }
    }

    public(friend) fun new_force_withdraw_cancelled(arg0: 0x2::object::ID, arg1: u64) : ForceWithdrawCancelledEvent {
        ForceWithdrawCancelledEvent{
            vault_id : arg0,
            ts_ms    : arg1,
        }
    }

    public(friend) fun new_force_withdraw_executed(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: u64, arg4: u64) : ForceWithdrawExecutedEvent {
        ForceWithdrawExecutedEvent{
            vault_id        : arg0,
            amount          : arg1,
            recipient       : arg2,
            idle_usdc_after : arg3,
            ts_ms           : arg4,
        }
    }

    public(friend) fun new_force_withdraw_queued(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: u64, arg4: u64) : ForceWithdrawQueuedEvent {
        ForceWithdrawQueuedEvent{
            vault_id     : arg0,
            amount       : arg1,
            recipient    : arg2,
            effective_ms : arg3,
            ts_ms        : arg4,
        }
    }

    public(friend) fun new_fulfiller_rotated(arg0: 0x2::object::ID, arg1: address, arg2: u64) : FulfillerRotatedEvent {
        FulfillerRotatedEvent{
            vault_id      : arg0,
            new_authority : arg1,
            ts_ms         : arg2,
        }
    }

    public(friend) fun new_management_fee(arg0: 0x2::object::ID, arg1: u128, arg2: u64, arg3: u64) : ManagementFeeEvent {
        ManagementFeeEvent{
            vault_id      : arg0,
            shares_minted : arg1,
            elapsed_ms    : arg2,
            ts_ms         : arg3,
        }
    }

    public(friend) fun new_min_seed_updated(arg0: u64, arg1: u64) : MinSeedUpdatedEvent {
        MinSeedUpdatedEvent{
            min_seed_deposit_usdc : arg0,
            ts_ms                 : arg1,
        }
    }

    public(friend) fun new_nav_reported(arg0: 0x2::object::ID, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u64) : NavReportedEvent {
        NavReportedEvent{
            vault_id           : arg0,
            nav_scaled         : arg1,
            share_price_scaled : arg2,
            idle_usdc          : arg3,
            in_flight_inbound  : arg4,
            in_flight_outbound : arg5,
            external_value     : arg6,
            ts_ms              : arg7,
        }
    }

    public(friend) fun new_oracle_rotation_executed(arg0: 0x2::object::ID, arg1: address, arg2: u64) : OracleRotationExecutedEvent {
        OracleRotationExecutedEvent{
            vault_id       : arg0,
            new_authority  : arg1,
            executed_at_ms : arg2,
        }
    }

    public(friend) fun new_oracle_rotation_queued(arg0: 0x2::object::ID, arg1: address, arg2: u64) : OracleRotationQueuedEvent {
        OracleRotationQueuedEvent{
            vault_id      : arg0,
            new_authority : arg1,
            effective_ms  : arg2,
        }
    }

    public(friend) fun new_pause(arg0: 0x2::object::ID, arg1: bool, arg2: bool, arg3: u64) : PauseEvent {
        PauseEvent{
            vault_id           : arg0,
            deposits_paused    : arg1,
            redemptions_paused : arg2,
            ts_ms              : arg3,
        }
    }

    public(friend) fun new_performance_fee(arg0: 0x2::object::ID, arg1: u128, arg2: u128, arg3: u128, arg4: u64) : PerformanceFeeEvent {
        PerformanceFeeEvent{
            vault_id                       : arg0,
            shares_minted_to_fee_recipient : arg1,
            shares_minted_to_protocol      : arg2,
            new_hwm_scaled                 : arg3,
            ts_ms                          : arg4,
        }
    }

    public(friend) fun new_protocol_fee_updated(arg0: address, arg1: u64, arg2: u64) : ProtocolFeeUpdatedEvent {
        ProtocolFeeUpdatedEvent{
            protocol_fee_recipient : arg0,
            protocol_fee_bps       : arg1,
            ts_ms                  : arg2,
        }
    }

    public(friend) fun new_ramping_flipped(arg0: 0x2::object::ID, arg1: bool, arg2: u64) : RampingFlippedEvent {
        RampingFlippedEvent{
            vault_id : arg0,
            ramping  : arg1,
            ts_ms    : arg2,
        }
    }

    public(friend) fun new_redemption_requested(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u128, arg4: u64, arg5: u64) : RedemptionRequestedEvent {
        RedemptionRequestedEvent{
            vault_id        : arg0,
            request_id      : arg1,
            owner           : arg2,
            shares          : arg3,
            epoch_id        : arg4,
            requested_at_ms : arg5,
        }
    }

    public(friend) fun new_registry_pause(arg0: bool, arg1: u64) : RegistryPauseEvent {
        RegistryPauseEvent{
            paused : arg0,
            ts_ms  : arg1,
        }
    }

    public(friend) fun new_vault_created(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: u128, arg6: u64) : VaultCreatedEvent {
        VaultCreatedEvent{
            vault_id      : arg0,
            creator       : arg1,
            agent_id      : arg2,
            vault_kind    : arg3,
            seed_usdc     : arg4,
            seed_shares   : arg5,
            created_at_ms : arg6,
        }
    }

    // decompiled from Move bytecode v7
}

