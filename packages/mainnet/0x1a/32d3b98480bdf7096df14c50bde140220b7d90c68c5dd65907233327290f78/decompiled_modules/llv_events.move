module 0x1a32d3b98480bdf7096df14c50bde140220b7d90c68c5dd65907233327290f78::llv_events {
    struct GlobalMigrated has copy, drop {
        new_version: u64,
    }

    struct GlobalPaused has copy, drop {
        paused: bool,
    }

    struct OwnerChanged has copy, drop {
        old_owner: address,
        new_owner: address,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        pool_admin_cap_id: 0x2::object::ID,
        creator: address,
        paused: bool,
        min_deposit: u64,
        deposit_cap: u128,
        performance_fee_bps: u64,
        management_fee_bps: u64,
        fee_recipient: address,
        min_rebalance_interval_ms: u64,
        min_rebalance_deviation_bps: u64,
        timestamp_ms: u64,
    }

    struct PoolPaused has copy, drop {
        pool_id: 0x2::object::ID,
        paused: bool,
        timestamp_ms: u64,
    }

    struct UpdateProtocol has copy, drop {
        pool_id: 0x2::object::ID,
        protocol_id: u8,
        action: u8,
        enabled: bool,
        target_ratio_bps: u64,
        deposited_amount: u128,
        current_balance: u128,
        last_sync_ms: u64,
        apr_bps: u64,
        timestamp_ms: u64,
    }

    struct UpdateProtocolConfig has copy, drop {
        pool_id: 0x2::object::ID,
        protocol_id: u8,
        is_new: bool,
        ids: vector<0x2::object::ID>,
        values: vector<u64>,
        type_bytes: vector<vector<u8>>,
        timestamp_ms: u64,
    }

    struct ProtocolRemoved has copy, drop {
        pool_id: 0x2::object::ID,
        protocol_id: u8,
        timestamp_ms: u64,
    }

    struct AprUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        protocol_id: u8,
        old_apr_bps: u64,
        new_apr_bps: u64,
        timestamp_ms: u64,
    }

    struct Deposited has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        user: address,
        amount: u64,
        shares_minted: u128,
        allocation: vector<0x1a32d3b98480bdf7096df14c50bde140220b7d90c68c5dd65907233327290f78::llv_allocation_plan::ProtocolAmount>,
        timestamp_ms: u64,
    }

    struct Withdrawn has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        user: address,
        shares_burned: u128,
        amount_received: u64,
        recall: vector<0x1a32d3b98480bdf7096df14c50bde140220b7d90c68c5dd65907233327290f78::llv_allocation_plan::ProtocolAmount>,
        timestamp_ms: u64,
    }

    struct BalancesSynced has copy, drop {
        pool_id: 0x2::object::ID,
        balances: vector<0x1a32d3b98480bdf7096df14c50bde140220b7d90c68c5dd65907233327290f78::llv_allocation_plan::ProtocolAmount>,
        total_assets: u128,
        global_yield_index: u128,
        timestamp_ms: u64,
    }

    struct InstantUnstakeFee has copy, drop {
        pool_id: 0x2::object::ID,
        hasui_amount: u64,
        sui_received: u64,
        fee_amount: u64,
        fee_rate_bps: u64,
        timestamp_ms: u64,
    }

    struct QueueUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        queue_type: u8,
        new_queue: vector<u8>,
        timestamp_ms: u64,
    }

    struct DepositCapUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        old_cap: u128,
        new_cap: u128,
        timestamp_ms: u64,
    }

    struct FeesAccrued has copy, drop {
        pool_id: 0x2::object::ID,
        management_fee_shares: u128,
        performance_fee_shares: u128,
        total_fee_shares: u128,
        fee_recipient: address,
        timestamp_ms: u64,
    }

    struct FeeConfigUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        config_type: u8,
        timestamp_ms: u64,
    }

    struct KeeperUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        keeper: address,
        added: bool,
        timestamp_ms: u64,
    }

    struct Rebalanced has copy, drop {
        pool_id: 0x2::object::ID,
        total_withdrawn: u128,
        total_deposited: u128,
        timestamp_ms: u64,
    }

    struct FeeSharesClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        recipient: address,
        shares_claimed: u128,
        asset_value: u128,
        timestamp_ms: u64,
    }

    public(friend) fun emit_apr_updated(arg0: 0x2::object::ID, arg1: u8, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = AprUpdated{
            pool_id      : arg0,
            protocol_id  : arg1,
            old_apr_bps  : arg2,
            new_apr_bps  : arg3,
            timestamp_ms : arg4,
        };
        0x2::event::emit<AprUpdated>(v0);
    }

    public(friend) fun emit_balances_synced(arg0: 0x2::object::ID, arg1: vector<0x1a32d3b98480bdf7096df14c50bde140220b7d90c68c5dd65907233327290f78::llv_allocation_plan::ProtocolAmount>, arg2: u128, arg3: u128, arg4: u64) {
        let v0 = BalancesSynced{
            pool_id            : arg0,
            balances           : arg1,
            total_assets       : arg2,
            global_yield_index : arg3,
            timestamp_ms       : arg4,
        };
        0x2::event::emit<BalancesSynced>(v0);
    }

    public(friend) fun emit_deposit_cap_updated(arg0: 0x2::object::ID, arg1: u128, arg2: u128, arg3: u64) {
        let v0 = DepositCapUpdated{
            pool_id      : arg0,
            old_cap      : arg1,
            new_cap      : arg2,
            timestamp_ms : arg3,
        };
        0x2::event::emit<DepositCapUpdated>(v0);
    }

    public(friend) fun emit_deposited(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u128, arg5: vector<0x1a32d3b98480bdf7096df14c50bde140220b7d90c68c5dd65907233327290f78::llv_allocation_plan::ProtocolAmount>, arg6: u64) {
        let v0 = Deposited{
            pool_id       : arg0,
            position_id   : arg1,
            user          : arg2,
            amount        : arg3,
            shares_minted : arg4,
            allocation    : arg5,
            timestamp_ms  : arg6,
        };
        0x2::event::emit<Deposited>(v0);
    }

    public(friend) fun emit_fee_config_updated(arg0: 0x2::object::ID, arg1: u8, arg2: u64) {
        let v0 = FeeConfigUpdated{
            pool_id      : arg0,
            config_type  : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<FeeConfigUpdated>(v0);
    }

    public(friend) fun emit_fee_shares_claimed(arg0: 0x2::object::ID, arg1: address, arg2: u128, arg3: u128, arg4: u64) {
        let v0 = FeeSharesClaimed{
            pool_id        : arg0,
            recipient      : arg1,
            shares_claimed : arg2,
            asset_value    : arg3,
            timestamp_ms   : arg4,
        };
        0x2::event::emit<FeeSharesClaimed>(v0);
    }

    public(friend) fun emit_fees_accrued(arg0: 0x2::object::ID, arg1: u128, arg2: u128, arg3: u128, arg4: address, arg5: u64) {
        let v0 = FeesAccrued{
            pool_id                : arg0,
            management_fee_shares  : arg1,
            performance_fee_shares : arg2,
            total_fee_shares       : arg3,
            fee_recipient          : arg4,
            timestamp_ms           : arg5,
        };
        0x2::event::emit<FeesAccrued>(v0);
    }

    public(friend) fun emit_global_migrated(arg0: u64) {
        let v0 = GlobalMigrated{new_version: arg0};
        0x2::event::emit<GlobalMigrated>(v0);
    }

    public(friend) fun emit_global_paused(arg0: bool) {
        let v0 = GlobalPaused{paused: arg0};
        0x2::event::emit<GlobalPaused>(v0);
    }

    public(friend) fun emit_instant_unstake_fee(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = if (arg1 > arg2) {
            arg1 - arg2
        } else {
            0
        };
        let v1 = if (arg1 > 0) {
            (((v0 as u128) * 10000 / (arg1 as u128)) as u64)
        } else {
            0
        };
        let v2 = InstantUnstakeFee{
            pool_id      : arg0,
            hasui_amount : arg1,
            sui_received : arg2,
            fee_amount   : v0,
            fee_rate_bps : v1,
            timestamp_ms : arg3,
        };
        0x2::event::emit<InstantUnstakeFee>(v2);
    }

    public(friend) fun emit_keeper_updated(arg0: 0x2::object::ID, arg1: address, arg2: bool, arg3: u64) {
        let v0 = KeeperUpdated{
            pool_id      : arg0,
            keeper       : arg1,
            added        : arg2,
            timestamp_ms : arg3,
        };
        0x2::event::emit<KeeperUpdated>(v0);
    }

    public(friend) fun emit_owner_changed(arg0: address, arg1: address) {
        let v0 = OwnerChanged{
            old_owner : arg0,
            new_owner : arg1,
        };
        0x2::event::emit<OwnerChanged>(v0);
    }

    public(friend) fun emit_pool_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: bool, arg4: u64, arg5: u128, arg6: u64, arg7: u64, arg8: address, arg9: u64, arg10: u64, arg11: u64) {
        let v0 = PoolCreated{
            pool_id                     : arg0,
            pool_admin_cap_id           : arg1,
            creator                     : arg2,
            paused                      : arg3,
            min_deposit                 : arg4,
            deposit_cap                 : arg5,
            performance_fee_bps         : arg6,
            management_fee_bps          : arg7,
            fee_recipient               : arg8,
            min_rebalance_interval_ms   : arg9,
            min_rebalance_deviation_bps : arg10,
            timestamp_ms                : arg11,
        };
        0x2::event::emit<PoolCreated>(v0);
    }

    public(friend) fun emit_pool_paused(arg0: 0x2::object::ID, arg1: bool, arg2: u64) {
        let v0 = PoolPaused{
            pool_id      : arg0,
            paused       : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<PoolPaused>(v0);
    }

    public(friend) fun emit_protocol_removed(arg0: 0x2::object::ID, arg1: u8, arg2: u64) {
        let v0 = ProtocolRemoved{
            pool_id      : arg0,
            protocol_id  : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<ProtocolRemoved>(v0);
    }

    public(friend) fun emit_queue_updated(arg0: 0x2::object::ID, arg1: u8, arg2: vector<u8>, arg3: u64) {
        let v0 = QueueUpdated{
            pool_id      : arg0,
            queue_type   : arg1,
            new_queue    : arg2,
            timestamp_ms : arg3,
        };
        0x2::event::emit<QueueUpdated>(v0);
    }

    public(friend) fun emit_rebalanced(arg0: 0x2::object::ID, arg1: u128, arg2: u128, arg3: u64) {
        let v0 = Rebalanced{
            pool_id         : arg0,
            total_withdrawn : arg1,
            total_deposited : arg2,
            timestamp_ms    : arg3,
        };
        0x2::event::emit<Rebalanced>(v0);
    }

    public(friend) fun emit_update_protocol(arg0: 0x2::object::ID, arg1: u8, arg2: u8, arg3: bool, arg4: u64, arg5: u128, arg6: u128, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = UpdateProtocol{
            pool_id          : arg0,
            protocol_id      : arg1,
            action           : arg2,
            enabled          : arg3,
            target_ratio_bps : arg4,
            deposited_amount : arg5,
            current_balance  : arg6,
            last_sync_ms     : arg7,
            apr_bps          : arg8,
            timestamp_ms     : arg9,
        };
        0x2::event::emit<UpdateProtocol>(v0);
    }

    public(friend) fun emit_update_protocol_config(arg0: 0x2::object::ID, arg1: u8, arg2: bool, arg3: vector<0x2::object::ID>, arg4: vector<u64>, arg5: vector<vector<u8>>, arg6: u64) {
        let v0 = UpdateProtocolConfig{
            pool_id      : arg0,
            protocol_id  : arg1,
            is_new       : arg2,
            ids          : arg3,
            values       : arg4,
            type_bytes   : arg5,
            timestamp_ms : arg6,
        };
        0x2::event::emit<UpdateProtocolConfig>(v0);
    }

    public(friend) fun emit_withdrawn(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u128, arg4: u64, arg5: vector<0x1a32d3b98480bdf7096df14c50bde140220b7d90c68c5dd65907233327290f78::llv_allocation_plan::ProtocolAmount>, arg6: u64) {
        let v0 = Withdrawn{
            pool_id         : arg0,
            position_id     : arg1,
            user            : arg2,
            shares_burned   : arg3,
            amount_received : arg4,
            recall          : arg5,
            timestamp_ms    : arg6,
        };
        0x2::event::emit<Withdrawn>(v0);
    }

    // decompiled from Move bytecode v6
}

