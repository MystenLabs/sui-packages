module 0xf57b4317fff813316297725694d50b04bf8ca46123424107686723298b35b96c::meta_vault_events {
    struct VaultEvent has copy, drop {
        vault_id: address,
        owner: address,
        curator: address,
        allocator: address,
        guardian: address,
        asset_decimals: u8,
        asset_type: 0x1::type_name::TypeName,
        htoken_type: 0x1::type_name::TypeName,
    }

    struct SetOwnerEvent has copy, drop {
        vault_id: address,
        caller: address,
        previous_owner: address,
        new_owner: address,
        timestamp_ms: u64,
    }

    struct SetCuratorEvent has copy, drop {
        vault_id: address,
        caller: address,
        previous_curator: address,
        new_curator: address,
        timestamp_ms: u64,
    }

    struct SetAllocatorEvent has copy, drop {
        vault_id: address,
        caller: address,
        previous_allocator: address,
        new_allocator: address,
        timestamp_ms: u64,
    }

    struct SetGuardianEvent has copy, drop {
        vault_id: address,
        caller: address,
        previous_guardian: address,
        new_guardian: address,
        timestamp_ms: u64,
    }

    struct SubmitTimelockEvent has copy, drop {
        vault_id: address,
        caller: address,
        new_timelock_minutes: u64,
        valid_at_ms: u64,
        event_type: u8,
        timestamp_ms: u64,
    }

    struct SetAllocationEvent has copy, drop {
        vault_id: address,
        caller: address,
        market_id: u64,
        cap: u128,
        weight_bps: u64,
        timestamp_ms: u64,
    }

    struct SetSupplyQueueEvent has copy, drop {
        vault_id: address,
        caller: address,
        queue: vector<u64>,
        timestamp_ms: u64,
    }

    struct SetWithdrawQueueEvent has copy, drop {
        vault_id: address,
        caller: address,
        queue: vector<u64>,
        timestamp_ms: u64,
    }

    struct SubmitSupplyCapEvent has copy, drop {
        vault_id: address,
        caller: address,
        new_cap: u128,
        valid_at_ms: u64,
        event_type: u8,
        timestamp_ms: u64,
    }

    struct ApplySupplyCapEvent has copy, drop {
        vault_id: address,
        caller: address,
        new_cap: u128,
        timestamp_ms: u64,
    }

    struct SubmitMarketRemovalEvent has copy, drop {
        vault_id: address,
        caller: address,
        market_id: u64,
        valid_at_ms: u64,
        event_type: u8,
        timestamp_ms: u64,
    }

    struct RemoveMarketEvent has copy, drop {
        vault_id: address,
        caller: address,
        market_id: u64,
        is_emergency: bool,
        timestamp_ms: u64,
    }

    struct SetMinDepositEvent has copy, drop {
        vault_id: address,
        caller: address,
        min_deposit: u128,
        timestamp_ms: u64,
    }

    struct SetMaxDepositEvent has copy, drop {
        vault_id: address,
        caller: address,
        max_deposit: u128,
        timestamp_ms: u64,
    }

    struct SetWithdrawCooldownEvent has copy, drop {
        vault_id: address,
        caller: address,
        cooldown_ms: u64,
        timestamp_ms: u64,
    }

    struct SetMinRebalanceIntervalEvent has copy, drop {
        vault_id: address,
        caller: address,
        interval: u64,
        timestamp_ms: u64,
    }

    struct UpdateLastRebalanceEvent has copy, drop {
        vault_id: address,
        caller: address,
        rebalance_time: u64,
        timestamp_ms: u64,
    }

    struct SetFeeRecipientEvent has copy, drop {
        vault_id: address,
        caller: address,
        previous_fee_recipient: address,
        new_fee_recipient: address,
        timestamp_ms: u64,
    }

    struct SubmitPerformanceFeeEvent has copy, drop {
        vault_id: address,
        caller: address,
        fee_bps: u64,
        valid_at_ms: u64,
        event_type: u8,
        timestamp_ms: u64,
    }

    struct ApplyPerformanceFeeEvent has copy, drop {
        vault_id: address,
        caller: address,
        fee_bps: u64,
        timestamp_ms: u64,
    }

    struct SubmitManagementFeeEvent has copy, drop {
        vault_id: address,
        caller: address,
        fee_bps: u64,
        valid_at_ms: u64,
        event_type: u8,
        timestamp_ms: u64,
    }

    struct ApplyManagementFeeEvent has copy, drop {
        vault_id: address,
        caller: address,
        fee_bps: u64,
        timestamp_ms: u64,
    }

    struct VaultDepositEvent has copy, drop {
        vault_id: address,
        user: address,
        asset_amount: u128,
        shares_minted: u128,
        asset_type: 0x1::type_name::TypeName,
        htoken_type: 0x1::type_name::TypeName,
        timestamp_ms: u64,
    }

    struct VaultWithdrawEvent has copy, drop {
        vault_id: address,
        user: address,
        asset_amount: u128,
        shares_burned: u128,
        asset_type: 0x1::type_name::TypeName,
        htoken_type: 0x1::type_name::TypeName,
        timestamp_ms: u64,
    }

    struct SetVaultNameEvent has copy, drop {
        vault_id: address,
        caller: address,
        old_name: 0x1::string::String,
        new_name: 0x1::string::String,
        asset_type: 0x1::type_name::TypeName,
        htoken_type: 0x1::type_name::TypeName,
        timestamp_ms: u64,
    }

    struct CompensateLostAssetsEvent has copy, drop {
        vault_id: address,
        caller: address,
        amount: u128,
        remaining_lost: u128,
        asset_type: 0x1::type_name::TypeName,
        htoken_type: 0x1::type_name::TypeName,
        timestamp_ms: u64,
    }

    struct AccrueFeesEvent has copy, drop {
        vault_id: address,
        management_fee_shares: u128,
        performance_fee_shares: u128,
        last_total_assets: u128,
        management_fee_assets: u128,
        performance_fee_assets: u128,
        total_shares_minted: u128,
        total_assets: u128,
        total_shares: u64,
        asset_type: 0x1::type_name::TypeName,
        htoken_type: 0x1::type_name::TypeName,
        timestamp_ms: u64,
    }

    struct RebalanceEvent has copy, drop {
        vault_id: address,
        caller: address,
        total_assets_before: u128,
        total_assets_after: u128,
        asset_type: 0x1::type_name::TypeName,
        htoken_type: 0x1::type_name::TypeName,
        timestamp_ms: u64,
    }

    public(friend) fun emit_accrue_fees(arg0: address, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: u64, arg9: 0x1::type_name::TypeName, arg10: 0x1::type_name::TypeName, arg11: &0x2::tx_context::TxContext) {
        let (_, v1) = timestamp(arg11);
        let v2 = AccrueFeesEvent{
            vault_id               : arg0,
            management_fee_shares  : arg1,
            performance_fee_shares : arg2,
            last_total_assets      : arg3,
            management_fee_assets  : arg4,
            performance_fee_assets : arg5,
            total_shares_minted    : arg6,
            total_assets           : arg7,
            total_shares           : arg8,
            asset_type             : arg9,
            htoken_type            : arg10,
            timestamp_ms           : v1,
        };
        0x2::event::emit<AccrueFeesEvent>(v2);
    }

    public(friend) fun emit_apply_management_fee(arg0: address, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg2);
        let v2 = ApplyManagementFeeEvent{
            vault_id     : arg0,
            caller       : v0,
            fee_bps      : arg1,
            timestamp_ms : v1,
        };
        0x2::event::emit<ApplyManagementFeeEvent>(v2);
    }

    public(friend) fun emit_apply_performance_fee(arg0: address, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg2);
        let v2 = ApplyPerformanceFeeEvent{
            vault_id     : arg0,
            caller       : v0,
            fee_bps      : arg1,
            timestamp_ms : v1,
        };
        0x2::event::emit<ApplyPerformanceFeeEvent>(v2);
    }

    public(friend) fun emit_apply_supply_cap(arg0: address, arg1: u128, arg2: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg2);
        let v2 = ApplySupplyCapEvent{
            vault_id     : arg0,
            caller       : v0,
            new_cap      : arg1,
            timestamp_ms : v1,
        };
        0x2::event::emit<ApplySupplyCapEvent>(v2);
    }

    public(friend) fun emit_compensate_lost_assets(arg0: address, arg1: u128, arg2: u128, arg3: 0x1::type_name::TypeName, arg4: 0x1::type_name::TypeName, arg5: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg5);
        let v2 = CompensateLostAssetsEvent{
            vault_id       : arg0,
            caller         : v0,
            amount         : arg1,
            remaining_lost : arg2,
            asset_type     : arg3,
            htoken_type    : arg4,
            timestamp_ms   : v1,
        };
        0x2::event::emit<CompensateLostAssetsEvent>(v2);
    }

    public(friend) fun emit_rebalance(arg0: address, arg1: u128, arg2: u128, arg3: 0x1::type_name::TypeName, arg4: 0x1::type_name::TypeName, arg5: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg5);
        let v2 = RebalanceEvent{
            vault_id            : arg0,
            caller              : v0,
            total_assets_before : arg1,
            total_assets_after  : arg2,
            asset_type          : arg3,
            htoken_type         : arg4,
            timestamp_ms        : v1,
        };
        0x2::event::emit<RebalanceEvent>(v2);
    }

    public(friend) fun emit_remove_market(arg0: address, arg1: u64, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg3);
        let v2 = RemoveMarketEvent{
            vault_id     : arg0,
            caller       : v0,
            market_id    : arg1,
            is_emergency : arg2,
            timestamp_ms : v1,
        };
        0x2::event::emit<RemoveMarketEvent>(v2);
    }

    public(friend) fun emit_set_allocation(arg0: address, arg1: u64, arg2: u128, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg4);
        let v2 = SetAllocationEvent{
            vault_id     : arg0,
            caller       : v0,
            market_id    : arg1,
            cap          : arg2,
            weight_bps   : arg3,
            timestamp_ms : v1,
        };
        0x2::event::emit<SetAllocationEvent>(v2);
    }

    public(friend) fun emit_set_allocator(arg0: address, arg1: address, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg3);
        let v2 = SetAllocatorEvent{
            vault_id           : arg0,
            caller             : v0,
            previous_allocator : arg1,
            new_allocator      : arg2,
            timestamp_ms       : v1,
        };
        0x2::event::emit<SetAllocatorEvent>(v2);
    }

    public(friend) fun emit_set_curator(arg0: address, arg1: address, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg3);
        let v2 = SetCuratorEvent{
            vault_id         : arg0,
            caller           : v0,
            previous_curator : arg1,
            new_curator      : arg2,
            timestamp_ms     : v1,
        };
        0x2::event::emit<SetCuratorEvent>(v2);
    }

    public(friend) fun emit_set_fee_recipient(arg0: address, arg1: address, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg3);
        let v2 = SetFeeRecipientEvent{
            vault_id               : arg0,
            caller                 : v0,
            previous_fee_recipient : arg1,
            new_fee_recipient      : arg2,
            timestamp_ms           : v1,
        };
        0x2::event::emit<SetFeeRecipientEvent>(v2);
    }

    public(friend) fun emit_set_guardian(arg0: address, arg1: address, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg3);
        let v2 = SetGuardianEvent{
            vault_id          : arg0,
            caller            : v0,
            previous_guardian : arg1,
            new_guardian      : arg2,
            timestamp_ms      : v1,
        };
        0x2::event::emit<SetGuardianEvent>(v2);
    }

    public(friend) fun emit_set_max_deposit(arg0: address, arg1: u128, arg2: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg2);
        let v2 = SetMaxDepositEvent{
            vault_id     : arg0,
            caller       : v0,
            max_deposit  : arg1,
            timestamp_ms : v1,
        };
        0x2::event::emit<SetMaxDepositEvent>(v2);
    }

    public(friend) fun emit_set_min_deposit(arg0: address, arg1: u128, arg2: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg2);
        let v2 = SetMinDepositEvent{
            vault_id     : arg0,
            caller       : v0,
            min_deposit  : arg1,
            timestamp_ms : v1,
        };
        0x2::event::emit<SetMinDepositEvent>(v2);
    }

    public(friend) fun emit_set_min_rebalance_interval(arg0: address, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg2);
        let v2 = SetMinRebalanceIntervalEvent{
            vault_id     : arg0,
            caller       : v0,
            interval     : arg1,
            timestamp_ms : v1,
        };
        0x2::event::emit<SetMinRebalanceIntervalEvent>(v2);
    }

    public(friend) fun emit_set_owner(arg0: address, arg1: address, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg3);
        let v2 = SetOwnerEvent{
            vault_id       : arg0,
            caller         : v0,
            previous_owner : arg1,
            new_owner      : arg2,
            timestamp_ms   : v1,
        };
        0x2::event::emit<SetOwnerEvent>(v2);
    }

    public(friend) fun emit_set_supply_queue(arg0: address, arg1: vector<u64>, arg2: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg2);
        let v2 = SetSupplyQueueEvent{
            vault_id     : arg0,
            caller       : v0,
            queue        : arg1,
            timestamp_ms : v1,
        };
        0x2::event::emit<SetSupplyQueueEvent>(v2);
    }

    public(friend) fun emit_set_vault_name(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::type_name::TypeName, arg4: 0x1::type_name::TypeName, arg5: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg5);
        let v2 = SetVaultNameEvent{
            vault_id     : arg0,
            caller       : v0,
            old_name     : arg1,
            new_name     : arg2,
            asset_type   : arg3,
            htoken_type  : arg4,
            timestamp_ms : v1,
        };
        0x2::event::emit<SetVaultNameEvent>(v2);
    }

    public(friend) fun emit_set_withdraw_cooldown(arg0: address, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg2);
        let v2 = SetWithdrawCooldownEvent{
            vault_id     : arg0,
            caller       : v0,
            cooldown_ms  : arg1,
            timestamp_ms : v1,
        };
        0x2::event::emit<SetWithdrawCooldownEvent>(v2);
    }

    public(friend) fun emit_set_withdraw_queue(arg0: address, arg1: vector<u64>, arg2: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg2);
        let v2 = SetWithdrawQueueEvent{
            vault_id     : arg0,
            caller       : v0,
            queue        : arg1,
            timestamp_ms : v1,
        };
        0x2::event::emit<SetWithdrawQueueEvent>(v2);
    }

    public(friend) fun emit_submit_management_fee(arg0: address, arg1: u64, arg2: u64, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg4);
        let v2 = SubmitManagementFeeEvent{
            vault_id     : arg0,
            caller       : v0,
            fee_bps      : arg1,
            valid_at_ms  : arg2,
            event_type   : arg3,
            timestamp_ms : v1,
        };
        0x2::event::emit<SubmitManagementFeeEvent>(v2);
    }

    public(friend) fun emit_submit_market_removal(arg0: address, arg1: u64, arg2: u64, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg4);
        let v2 = SubmitMarketRemovalEvent{
            vault_id     : arg0,
            caller       : v0,
            market_id    : arg1,
            valid_at_ms  : arg2,
            event_type   : arg3,
            timestamp_ms : v1,
        };
        0x2::event::emit<SubmitMarketRemovalEvent>(v2);
    }

    public(friend) fun emit_submit_performance_fee(arg0: address, arg1: u64, arg2: u64, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg4);
        let v2 = SubmitPerformanceFeeEvent{
            vault_id     : arg0,
            caller       : v0,
            fee_bps      : arg1,
            valid_at_ms  : arg2,
            event_type   : arg3,
            timestamp_ms : v1,
        };
        0x2::event::emit<SubmitPerformanceFeeEvent>(v2);
    }

    public(friend) fun emit_submit_supply_cap(arg0: address, arg1: u128, arg2: u64, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg4);
        let v2 = SubmitSupplyCapEvent{
            vault_id     : arg0,
            caller       : v0,
            new_cap      : arg1,
            valid_at_ms  : arg2,
            event_type   : arg3,
            timestamp_ms : v1,
        };
        0x2::event::emit<SubmitSupplyCapEvent>(v2);
    }

    public(friend) fun emit_submit_timelock(arg0: address, arg1: u64, arg2: u64, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg4);
        let v2 = SubmitTimelockEvent{
            vault_id             : arg0,
            caller               : v0,
            new_timelock_minutes : arg1,
            valid_at_ms          : arg2,
            event_type           : arg3,
            timestamp_ms         : v1,
        };
        0x2::event::emit<SubmitTimelockEvent>(v2);
    }

    public(friend) fun emit_update_last_rebalance(arg0: address, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg2);
        let v2 = UpdateLastRebalanceEvent{
            vault_id       : arg0,
            caller         : v0,
            rebalance_time : arg1,
            timestamp_ms   : v1,
        };
        0x2::event::emit<UpdateLastRebalanceEvent>(v2);
    }

    public(friend) fun emit_vault(arg0: address, arg1: address, arg2: address, arg3: address, arg4: address, arg5: u8, arg6: 0x1::type_name::TypeName, arg7: 0x1::type_name::TypeName) {
        let v0 = VaultEvent{
            vault_id       : arg0,
            owner          : arg1,
            curator        : arg2,
            allocator      : arg3,
            guardian       : arg4,
            asset_decimals : arg5,
            asset_type     : arg6,
            htoken_type    : arg7,
        };
        0x2::event::emit<VaultEvent>(v0);
    }

    public(friend) fun emit_vault_deposit(arg0: address, arg1: address, arg2: u128, arg3: u128, arg4: 0x1::type_name::TypeName, arg5: 0x1::type_name::TypeName, arg6: &0x2::tx_context::TxContext) {
        let (_, v1) = timestamp(arg6);
        let v2 = VaultDepositEvent{
            vault_id      : arg0,
            user          : arg1,
            asset_amount  : arg2,
            shares_minted : arg3,
            asset_type    : arg4,
            htoken_type   : arg5,
            timestamp_ms  : v1,
        };
        0x2::event::emit<VaultDepositEvent>(v2);
    }

    public(friend) fun emit_vault_withdraw(arg0: address, arg1: address, arg2: u128, arg3: u128, arg4: 0x1::type_name::TypeName, arg5: 0x1::type_name::TypeName, arg6: &0x2::tx_context::TxContext) {
        let (_, v1) = timestamp(arg6);
        let v2 = VaultWithdrawEvent{
            vault_id      : arg0,
            user          : arg1,
            asset_amount  : arg2,
            shares_burned : arg3,
            asset_type    : arg4,
            htoken_type   : arg5,
            timestamp_ms  : v1,
        };
        0x2::event::emit<VaultWithdrawEvent>(v2);
    }

    public(friend) fun event_type_accept() : u8 {
        2
    }

    public(friend) fun event_type_cancel() : u8 {
        4
    }

    public(friend) fun event_type_revoke() : u8 {
        3
    }

    public(friend) fun event_type_submit() : u8 {
        1
    }

    fun timestamp(arg0: &0x2::tx_context::TxContext) : (address, u64) {
        (0x2::tx_context::sender(arg0), 0x2::tx_context::epoch_timestamp_ms(arg0))
    }

    // decompiled from Move bytecode v6
}

