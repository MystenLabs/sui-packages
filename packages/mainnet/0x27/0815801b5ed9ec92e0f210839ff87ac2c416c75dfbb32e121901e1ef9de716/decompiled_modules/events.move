module 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::events {
    struct KeeperAdded has copy, drop {
        global_config_id: address,
        keeper: address,
    }

    struct KeeperRemoved has copy, drop {
        global_config_id: address,
        keeper: address,
    }

    struct TransferOperatorAdded has copy, drop {
        global_config_id: address,
        operator: address,
    }

    struct TransferOperatorRemoved has copy, drop {
        global_config_id: address,
        operator: address,
    }

    struct MarketCreated has copy, drop {
        market_registry_id: address,
        market_key: u64,
        market_id: vector<u8>,
        by_admin: bool,
        event_ts: u64,
    }

    struct OrderPlaced has copy, drop {
        market_registry_id: address,
        order_id: u64,
        account_id: 0x2::object::ID,
        receiver_account_id: 0x2::object::ID,
        market_key: u64,
        market_id: vector<u8>,
        selection: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection,
        max_spend: u64,
        min_shares: u64,
        price_cap: u64,
        expiry_ts: u64,
        self_cancel_after_ts: u64,
        created_ts: u64,
        by_admin: bool,
        event_ts: u64,
    }

    struct OrderFilled has copy, drop {
        market_registry_id: address,
        order_id: u64,
        account_id: 0x2::object::ID,
        position_id: u64,
        market_key: u64,
        market_id: vector<u8>,
        selection: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection,
        filled_shares: u64,
        filled_cost: u64,
        event_ts: u64,
    }

    struct OrderCancelled has copy, drop {
        market_registry_id: address,
        order_id: u64,
        account_id: 0x2::object::ID,
        market_key: u64,
        market_id: vector<u8>,
        selection: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection,
        refund_amount: u64,
        by_self: bool,
        event_ts: u64,
    }

    struct MarketResolved has copy, drop {
        market_registry_id: address,
        market_key: u64,
        market_id: vector<u8>,
        outcome: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::outcome::Outcome,
        unclaimed_count: u64,
        event_ts: u64,
    }

    struct MarketResolvedByOracle has copy, drop {
        market_registry_id: address,
        market_key: u64,
        market_id: vector<u8>,
        outcome: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::outcome::Outcome,
        settle_ticker: 0x1::string::String,
        settle_timestamp_ms: u64,
        price: u128,
        threshold: u128,
        comparison: u8,
        unclaimed_count: u64,
        event_ts: u64,
    }

    struct PriceSettlementSet has copy, drop {
        market_registry_id: address,
        market_id: vector<u8>,
        settle_ticker: 0x1::string::String,
        settle_timestamp_ms: u64,
        threshold: u128,
        comparison: u8,
        event_ts: u64,
    }

    struct PositionClaimed has copy, drop {
        market_registry_id: address,
        account_id: 0x2::object::ID,
        position_id: u64,
        market_key: u64,
        market_id: vector<u8>,
        selection: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection,
        outcome: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::outcome::Outcome,
        filled_shares: u64,
        filled_cost: u64,
        payout: u64,
        event_ts: u64,
    }

    struct PositionTransferred has copy, drop {
        market_registry_id: address,
        position_id: u64,
        from_account_id: 0x2::object::ID,
        to_account_id: 0x2::object::ID,
        market_key: u64,
        market_id: vector<u8>,
        selection: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection,
        filled_shares: u64,
        filled_cost: u64,
        event_ts: u64,
    }

    struct PositionSplit has copy, drop {
        market_registry_id: address,
        source_position_id: u64,
        split_position_id: u64,
        from_account_id: 0x2::object::ID,
        to_account_id: 0x2::object::ID,
        market_key: u64,
        market_id: vector<u8>,
        selection: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection,
        split_shares: u64,
        split_cost: u64,
        remaining_shares: u64,
        remaining_cost: u64,
        event_ts: u64,
    }

    struct CloseRequested has copy, drop {
        market_registry_id: address,
        order_id: u64,
        account_id: 0x2::object::ID,
        position_id: u64,
        market_key: u64,
        market_id: vector<u8>,
        selection: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection,
        min_proceeds: u64,
        expiry_ts: u64,
        self_cancel_after_ts: u64,
        created_ts: u64,
        event_ts: u64,
    }

    struct PartialCloseRequested has copy, drop {
        market_registry_id: address,
        source_position_id: u64,
        new_position_id: u64,
        close_order_id: u64,
        account_id: 0x2::object::ID,
        market_key: u64,
        market_id: vector<u8>,
        selection: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection,
        close_shares: u64,
        close_cost: u64,
        remaining_shares: u64,
        remaining_cost: u64,
        min_proceeds: u64,
        expiry_ts: u64,
        event_ts: u64,
    }

    struct CloseConfirmed has copy, drop {
        market_registry_id: address,
        order_id: u64,
        account_id: 0x2::object::ID,
        position_id: u64,
        market_key: u64,
        market_id: vector<u8>,
        selection: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection,
        filled_shares: u64,
        filled_cost: u64,
        proceeds: u64,
        event_ts: u64,
    }

    struct CloseCancelled has copy, drop {
        market_registry_id: address,
        order_id: u64,
        account_id: 0x2::object::ID,
        position_id: u64,
        market_key: u64,
        market_id: vector<u8>,
        selection: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection,
        by_self: bool,
        event_ts: u64,
    }

    struct MarketPaused has copy, drop {
        market_registry_id: address,
        market_key: u64,
        market_id: vector<u8>,
    }

    struct MarketUnpaused has copy, drop {
        market_registry_id: address,
        market_key: u64,
        market_id: vector<u8>,
    }

    struct MarketRegistryWithdrawn has copy, drop {
        market_registry_id: address,
        amount: u64,
        recipient: address,
        new_balance: u64,
    }

    struct MinReserveUpdated has copy, drop {
        market_registry_id: address,
        old_reserve: u64,
        new_reserve: u64,
    }

    struct OrderCancelCooldownUpdated has copy, drop {
        market_registry_id: address,
        old_cooldown_ms: u64,
        new_cooldown_ms: u64,
    }

    public(friend) fun emit_close_cancelled(arg0: address, arg1: u64, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection, arg7: bool, arg8: u64) {
        let v0 = CloseCancelled{
            market_registry_id : arg0,
            order_id           : arg1,
            account_id         : arg2,
            position_id        : arg3,
            market_key         : arg4,
            market_id          : arg5,
            selection          : arg6,
            by_self            : arg7,
            event_ts           : arg8,
        };
        0x2::event::emit<CloseCancelled>(v0);
    }

    public(friend) fun emit_close_confirmed(arg0: address, arg1: u64, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection, arg7: u64, arg8: u64, arg9: u64, arg10: u64) {
        let v0 = CloseConfirmed{
            market_registry_id : arg0,
            order_id           : arg1,
            account_id         : arg2,
            position_id        : arg3,
            market_key         : arg4,
            market_id          : arg5,
            selection          : arg6,
            filled_shares      : arg7,
            filled_cost        : arg8,
            proceeds           : arg9,
            event_ts           : arg10,
        };
        0x2::event::emit<CloseConfirmed>(v0);
    }

    public(friend) fun emit_close_requested(arg0: address, arg1: u64, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64) {
        let v0 = CloseRequested{
            market_registry_id   : arg0,
            order_id             : arg1,
            account_id           : arg2,
            position_id          : arg3,
            market_key           : arg4,
            market_id            : arg5,
            selection            : arg6,
            min_proceeds         : arg7,
            expiry_ts            : arg8,
            self_cancel_after_ts : arg9,
            created_ts           : arg10,
            event_ts             : arg11,
        };
        0x2::event::emit<CloseRequested>(v0);
    }

    public(friend) fun emit_keeper_added(arg0: address, arg1: address) {
        let v0 = KeeperAdded{
            global_config_id : arg0,
            keeper           : arg1,
        };
        0x2::event::emit<KeeperAdded>(v0);
    }

    public(friend) fun emit_keeper_removed(arg0: address, arg1: address) {
        let v0 = KeeperRemoved{
            global_config_id : arg0,
            keeper           : arg1,
        };
        0x2::event::emit<KeeperRemoved>(v0);
    }

    public(friend) fun emit_market_created(arg0: address, arg1: u64, arg2: vector<u8>, arg3: bool, arg4: u64) {
        let v0 = MarketCreated{
            market_registry_id : arg0,
            market_key         : arg1,
            market_id          : arg2,
            by_admin           : arg3,
            event_ts           : arg4,
        };
        0x2::event::emit<MarketCreated>(v0);
    }

    public(friend) fun emit_market_paused(arg0: address, arg1: u64, arg2: vector<u8>) {
        let v0 = MarketPaused{
            market_registry_id : arg0,
            market_key         : arg1,
            market_id          : arg2,
        };
        0x2::event::emit<MarketPaused>(v0);
    }

    public(friend) fun emit_market_registry_withdrawn(arg0: address, arg1: u64, arg2: address, arg3: u64) {
        let v0 = MarketRegistryWithdrawn{
            market_registry_id : arg0,
            amount             : arg1,
            recipient          : arg2,
            new_balance        : arg3,
        };
        0x2::event::emit<MarketRegistryWithdrawn>(v0);
    }

    public(friend) fun emit_market_resolved(arg0: address, arg1: u64, arg2: vector<u8>, arg3: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::outcome::Outcome, arg4: u64, arg5: u64) {
        let v0 = MarketResolved{
            market_registry_id : arg0,
            market_key         : arg1,
            market_id          : arg2,
            outcome            : arg3,
            unclaimed_count    : arg4,
            event_ts           : arg5,
        };
        0x2::event::emit<MarketResolved>(v0);
    }

    public(friend) fun emit_market_resolved_by_oracle(arg0: address, arg1: u64, arg2: vector<u8>, arg3: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::outcome::Outcome, arg4: 0x1::string::String, arg5: u64, arg6: u128, arg7: u128, arg8: u8, arg9: u64, arg10: u64) {
        let v0 = MarketResolvedByOracle{
            market_registry_id  : arg0,
            market_key          : arg1,
            market_id           : arg2,
            outcome             : arg3,
            settle_ticker       : arg4,
            settle_timestamp_ms : arg5,
            price               : arg6,
            threshold           : arg7,
            comparison          : arg8,
            unclaimed_count     : arg9,
            event_ts            : arg10,
        };
        0x2::event::emit<MarketResolvedByOracle>(v0);
    }

    public(friend) fun emit_market_unpaused(arg0: address, arg1: u64, arg2: vector<u8>) {
        let v0 = MarketUnpaused{
            market_registry_id : arg0,
            market_key         : arg1,
            market_id          : arg2,
        };
        0x2::event::emit<MarketUnpaused>(v0);
    }

    public(friend) fun emit_min_reserve_updated(arg0: address, arg1: u64, arg2: u64) {
        let v0 = MinReserveUpdated{
            market_registry_id : arg0,
            old_reserve        : arg1,
            new_reserve        : arg2,
        };
        0x2::event::emit<MinReserveUpdated>(v0);
    }

    public(friend) fun emit_order_cancel_cooldown_updated(arg0: address, arg1: u64, arg2: u64) {
        let v0 = OrderCancelCooldownUpdated{
            market_registry_id : arg0,
            old_cooldown_ms    : arg1,
            new_cooldown_ms    : arg2,
        };
        0x2::event::emit<OrderCancelCooldownUpdated>(v0);
    }

    public(friend) fun emit_order_cancelled(arg0: address, arg1: u64, arg2: 0x2::object::ID, arg3: u64, arg4: vector<u8>, arg5: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection, arg6: u64, arg7: bool, arg8: u64) {
        let v0 = OrderCancelled{
            market_registry_id : arg0,
            order_id           : arg1,
            account_id         : arg2,
            market_key         : arg3,
            market_id          : arg4,
            selection          : arg5,
            refund_amount      : arg6,
            by_self            : arg7,
            event_ts           : arg8,
        };
        0x2::event::emit<OrderCancelled>(v0);
    }

    public(friend) fun emit_order_filled(arg0: address, arg1: u64, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = OrderFilled{
            market_registry_id : arg0,
            order_id           : arg1,
            account_id         : arg2,
            position_id        : arg3,
            market_key         : arg4,
            market_id          : arg5,
            selection          : arg6,
            filled_shares      : arg7,
            filled_cost        : arg8,
            event_ts           : arg9,
        };
        0x2::event::emit<OrderFilled>(v0);
    }

    public(friend) fun emit_order_placed(arg0: address, arg1: u64, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: vector<u8>, arg6: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: bool, arg14: u64) {
        let v0 = OrderPlaced{
            market_registry_id   : arg0,
            order_id             : arg1,
            account_id           : arg2,
            receiver_account_id  : arg3,
            market_key           : arg4,
            market_id            : arg5,
            selection            : arg6,
            max_spend            : arg7,
            min_shares           : arg8,
            price_cap            : arg9,
            expiry_ts            : arg10,
            self_cancel_after_ts : arg11,
            created_ts           : arg12,
            by_admin             : arg13,
            event_ts             : arg14,
        };
        0x2::event::emit<OrderPlaced>(v0);
    }

    public(friend) fun emit_partial_close_requested(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::object::ID, arg5: u64, arg6: vector<u8>, arg7: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64) {
        let v0 = PartialCloseRequested{
            market_registry_id : arg0,
            source_position_id : arg1,
            new_position_id    : arg2,
            close_order_id     : arg3,
            account_id         : arg4,
            market_key         : arg5,
            market_id          : arg6,
            selection          : arg7,
            close_shares       : arg8,
            close_cost         : arg9,
            remaining_shares   : arg10,
            remaining_cost     : arg11,
            min_proceeds       : arg12,
            expiry_ts          : arg13,
            event_ts           : arg14,
        };
        0x2::event::emit<PartialCloseRequested>(v0);
    }

    public(friend) fun emit_position_claimed(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection, arg6: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::outcome::Outcome, arg7: u64, arg8: u64, arg9: u64, arg10: u64) {
        let v0 = PositionClaimed{
            market_registry_id : arg0,
            account_id         : arg1,
            position_id        : arg2,
            market_key         : arg3,
            market_id          : arg4,
            selection          : arg5,
            outcome            : arg6,
            filled_shares      : arg7,
            filled_cost        : arg8,
            payout             : arg9,
            event_ts           : arg10,
        };
        0x2::event::emit<PositionClaimed>(v0);
    }

    public(friend) fun emit_position_split(arg0: address, arg1: u64, arg2: u64, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: vector<u8>, arg7: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64) {
        let v0 = PositionSplit{
            market_registry_id : arg0,
            source_position_id : arg1,
            split_position_id  : arg2,
            from_account_id    : arg3,
            to_account_id      : arg4,
            market_key         : arg5,
            market_id          : arg6,
            selection          : arg7,
            split_shares       : arg8,
            split_cost         : arg9,
            remaining_shares   : arg10,
            remaining_cost     : arg11,
            event_ts           : arg12,
        };
        0x2::event::emit<PositionSplit>(v0);
    }

    public(friend) fun emit_position_transferred(arg0: address, arg1: u64, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: vector<u8>, arg6: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = PositionTransferred{
            market_registry_id : arg0,
            position_id        : arg1,
            from_account_id    : arg2,
            to_account_id      : arg3,
            market_key         : arg4,
            market_id          : arg5,
            selection          : arg6,
            filled_shares      : arg7,
            filled_cost        : arg8,
            event_ts           : arg9,
        };
        0x2::event::emit<PositionTransferred>(v0);
    }

    public(friend) fun emit_price_settlement_set(arg0: address, arg1: vector<u8>, arg2: 0x1::string::String, arg3: u64, arg4: u128, arg5: u8, arg6: u64) {
        let v0 = PriceSettlementSet{
            market_registry_id  : arg0,
            market_id           : arg1,
            settle_ticker       : arg2,
            settle_timestamp_ms : arg3,
            threshold           : arg4,
            comparison          : arg5,
            event_ts            : arg6,
        };
        0x2::event::emit<PriceSettlementSet>(v0);
    }

    public(friend) fun emit_transfer_operator_added(arg0: address, arg1: address) {
        let v0 = TransferOperatorAdded{
            global_config_id : arg0,
            operator         : arg1,
        };
        0x2::event::emit<TransferOperatorAdded>(v0);
    }

    public(friend) fun emit_transfer_operator_removed(arg0: address, arg1: address) {
        let v0 = TransferOperatorRemoved{
            global_config_id : arg0,
            operator         : arg1,
        };
        0x2::event::emit<TransferOperatorRemoved>(v0);
    }

    // decompiled from Move bytecode v7
}

