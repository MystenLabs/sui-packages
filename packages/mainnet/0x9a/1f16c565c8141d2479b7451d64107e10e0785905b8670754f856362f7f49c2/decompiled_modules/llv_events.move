module 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_events {
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
        asset_type: 0x1::type_name::TypeName,
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
        can_supply: bool,
        can_withdraw: bool,
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
        user: address,
        amount: u64,
        shares_minted: u128,
        allocation: vector<0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::ProtocolAmount>,
        timestamp_ms: u64,
    }

    struct Withdrawn has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        shares_burned: u128,
        amount_received: u64,
        recall: vector<0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::ProtocolAmount>,
        timestamp_ms: u64,
    }

    struct BalancesSynced has copy, drop {
        pool_id: 0x2::object::ID,
        balances: vector<0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::ProtocolAmount>,
        total_assets: u128,
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

    struct ProtocolDepositCapUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        protocol_id: u8,
        old_cap: u128,
        new_cap: u128,
        current_balance: u128,
        timestamp_ms: u64,
    }

    struct FeesAccrued has copy, drop {
        pool_id: 0x2::object::ID,
        management_fee_shares: u128,
        performance_fee_shares: u128,
        total_fee_shares: u128,
        fee_recipient: address,
        last_total_assets: u128,
        management_fee_assets: u128,
        performance_fee_assets: u128,
        total_assets: u128,
        total_shares: u128,
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
        caller: address,
        total_withdrawn: u128,
        total_deposited: u128,
        before_total_assets: u128,
        after_total_assets: u128,
        before_idle_balance: u128,
        after_idle_balance: u128,
        withdraw_details: vector<0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::ProtocolAmount>,
        deposit_details: vector<0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::ProtocolAmount>,
        timestamp_ms: u64,
    }

    struct FeeSharesClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        recipient: address,
        shares_claimed: u128,
        asset_value: u128,
        timestamp_ms: u64,
    }

    struct AccrueInterestEvent has copy, drop {
        pool_id: 0x2::object::ID,
        protocol_id: u8,
        old_balance: u128,
        new_balance: u128,
        interest: u128,
        timestamp_ms: u64,
    }

    struct ProtocolTargetsUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        protocol_ids: vector<u8>,
        target_ratios: vector<u64>,
        deposit_caps: vector<u128>,
        can_supply_flags: vector<bool>,
        can_withdraw_flags: vector<bool>,
        timestamp_ms: u64,
    }

    struct AdminRecallStarted has copy, drop {
        pool_id: 0x2::object::ID,
        protocol_id: u8,
        timestamp_ms: u64,
    }

    struct AdminRecalledToIdle has copy, drop {
        pool_id: 0x2::object::ID,
        protocol_id: u8,
        amount: u128,
        idle_balance_after: u128,
        caller: address,
        timestamp_ms: u64,
    }

    struct WithdrawSaturation has copy, drop {
        pool_id: 0x2::object::ID,
        protocol_id: u8,
        field: u8,
        before: u128,
        amount: u128,
    }

    struct RewardInjected has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        timestamp_ms: u64,
    }

    public(friend) fun emit_accrue_interest(arg0: 0x2::object::ID, arg1: u8, arg2: u128, arg3: u128, arg4: u128, arg5: u64) {
        let v0 = AccrueInterestEvent{
            pool_id      : arg0,
            protocol_id  : arg1,
            old_balance  : arg2,
            new_balance  : arg3,
            interest     : arg4,
            timestamp_ms : arg5,
        };
        0x2::event::emit<AccrueInterestEvent>(v0);
    }

    public(friend) fun emit_admin_recall_started(arg0: 0x2::object::ID, arg1: u8, arg2: u64) {
        let v0 = AdminRecallStarted{
            pool_id      : arg0,
            protocol_id  : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<AdminRecallStarted>(v0);
    }

    public(friend) fun emit_admin_recalled_to_idle(arg0: 0x2::object::ID, arg1: u8, arg2: u128, arg3: u128, arg4: address, arg5: u64) {
        let v0 = AdminRecalledToIdle{
            pool_id            : arg0,
            protocol_id        : arg1,
            amount             : arg2,
            idle_balance_after : arg3,
            caller             : arg4,
            timestamp_ms       : arg5,
        };
        0x2::event::emit<AdminRecalledToIdle>(v0);
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

    public(friend) fun emit_balances_synced(arg0: 0x2::object::ID, arg1: vector<0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::ProtocolAmount>, arg2: u128, arg3: u64) {
        let v0 = BalancesSynced{
            pool_id      : arg0,
            balances     : arg1,
            total_assets : arg2,
            timestamp_ms : arg3,
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

    public(friend) fun emit_deposited(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u128, arg4: vector<0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::ProtocolAmount>, arg5: u64) {
        let v0 = Deposited{
            pool_id       : arg0,
            user          : arg1,
            amount        : arg2,
            shares_minted : arg3,
            allocation    : arg4,
            timestamp_ms  : arg5,
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

    public(friend) fun emit_fees_accrued(arg0: 0x2::object::ID, arg1: u128, arg2: u128, arg3: u128, arg4: address, arg5: u128, arg6: u128, arg7: u128, arg8: u128, arg9: u128, arg10: u64) {
        let v0 = FeesAccrued{
            pool_id                : arg0,
            management_fee_shares  : arg1,
            performance_fee_shares : arg2,
            total_fee_shares       : arg3,
            fee_recipient          : arg4,
            last_total_assets      : arg5,
            management_fee_assets  : arg6,
            performance_fee_assets : arg7,
            total_assets           : arg8,
            total_shares           : arg9,
            timestamp_ms           : arg10,
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

    public(friend) fun emit_pool_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: address, arg4: bool, arg5: u64, arg6: u128, arg7: u64, arg8: u64, arg9: address, arg10: u64, arg11: u64, arg12: u64) {
        let v0 = PoolCreated{
            pool_id                     : arg0,
            pool_admin_cap_id           : arg1,
            asset_type                  : arg2,
            creator                     : arg3,
            paused                      : arg4,
            min_deposit                 : arg5,
            deposit_cap                 : arg6,
            performance_fee_bps         : arg7,
            management_fee_bps          : arg8,
            fee_recipient               : arg9,
            min_rebalance_interval_ms   : arg10,
            min_rebalance_deviation_bps : arg11,
            timestamp_ms                : arg12,
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

    public(friend) fun emit_protocol_deposit_cap_updated(arg0: 0x2::object::ID, arg1: u8, arg2: u128, arg3: u128, arg4: u128, arg5: u64) {
        let v0 = ProtocolDepositCapUpdated{
            pool_id         : arg0,
            protocol_id     : arg1,
            old_cap         : arg2,
            new_cap         : arg3,
            current_balance : arg4,
            timestamp_ms    : arg5,
        };
        0x2::event::emit<ProtocolDepositCapUpdated>(v0);
    }

    public(friend) fun emit_protocol_removed(arg0: 0x2::object::ID, arg1: u8, arg2: u64) {
        let v0 = ProtocolRemoved{
            pool_id      : arg0,
            protocol_id  : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<ProtocolRemoved>(v0);
    }

    public(friend) fun emit_protocol_targets_updated(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: vector<u64>, arg3: vector<u128>, arg4: vector<bool>, arg5: vector<bool>, arg6: u64) {
        let v0 = ProtocolTargetsUpdated{
            pool_id            : arg0,
            protocol_ids       : arg1,
            target_ratios      : arg2,
            deposit_caps       : arg3,
            can_supply_flags   : arg4,
            can_withdraw_flags : arg5,
            timestamp_ms       : arg6,
        };
        0x2::event::emit<ProtocolTargetsUpdated>(v0);
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

    public(friend) fun emit_rebalanced(arg0: 0x2::object::ID, arg1: address, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: vector<0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::ProtocolAmount>, arg9: vector<0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::ProtocolAmount>, arg10: u64) {
        let v0 = Rebalanced{
            pool_id             : arg0,
            caller              : arg1,
            total_withdrawn     : arg2,
            total_deposited     : arg3,
            before_total_assets : arg4,
            after_total_assets  : arg5,
            before_idle_balance : arg6,
            after_idle_balance  : arg7,
            withdraw_details    : arg8,
            deposit_details     : arg9,
            timestamp_ms        : arg10,
        };
        0x2::event::emit<Rebalanced>(v0);
    }

    public(friend) fun emit_reward_injected(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = RewardInjected{
            pool_id      : arg0,
            amount       : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<RewardInjected>(v0);
    }

    public(friend) fun emit_update_protocol(arg0: 0x2::object::ID, arg1: u8, arg2: u8, arg3: bool, arg4: bool, arg5: u64, arg6: u128, arg7: u128, arg8: u64, arg9: u64, arg10: u64) {
        let v0 = UpdateProtocol{
            pool_id          : arg0,
            protocol_id      : arg1,
            action           : arg2,
            can_supply       : arg3,
            can_withdraw     : arg4,
            target_ratio_bps : arg5,
            deposited_amount : arg6,
            current_balance  : arg7,
            last_sync_ms     : arg8,
            apr_bps          : arg9,
            timestamp_ms     : arg10,
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

    public(friend) fun emit_withdraw_saturation(arg0: 0x2::object::ID, arg1: u8, arg2: u8, arg3: u128, arg4: u128) {
        let v0 = WithdrawSaturation{
            pool_id     : arg0,
            protocol_id : arg1,
            field       : arg2,
            before      : arg3,
            amount      : arg4,
        };
        0x2::event::emit<WithdrawSaturation>(v0);
    }

    public(friend) fun emit_withdrawn(arg0: 0x2::object::ID, arg1: address, arg2: u128, arg3: u64, arg4: vector<0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::ProtocolAmount>, arg5: u64) {
        let v0 = Withdrawn{
            pool_id         : arg0,
            user            : arg1,
            shares_burned   : arg2,
            amount_received : arg3,
            recall          : arg4,
            timestamp_ms    : arg5,
        };
        0x2::event::emit<Withdrawn>(v0);
    }

    // decompiled from Move bytecode v6
}

