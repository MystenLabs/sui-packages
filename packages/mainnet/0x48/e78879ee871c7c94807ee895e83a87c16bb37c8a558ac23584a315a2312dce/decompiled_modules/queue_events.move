module 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue_events {
    struct OrderEnqueued has copy, drop, store {
        expiry_market_id: 0x2::object::ID,
        record_id: u64,
        account_id: 0x2::object::ID,
        kind: u8,
        request: 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::OrderRequest,
        position: 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::HeldPosition,
        timing: 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::OrderTiming,
        vol: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::VolSnapshot,
        budget: u64,
        order_fee: u64,
        cash_need: u64,
        subsidy_bound: u64,
        builder_code_id: 0x1::option::Option<0x2::object::ID>,
        referrer_account_id: 0x1::option::Option<0x2::object::ID>,
        source_record_id: 0x1::option::Option<u64>,
        market_cash: u64,
        required_cash: u64,
        waiting_cash_need: u64,
        onchain_timestamp_ms: u64,
    }

    struct CohortCommitted has copy, drop, store {
        expiry_market_id: 0x2::object::ID,
        tau_ms: u64,
        tick_ms: u64,
        first_record_id: u64,
        last_record_id: u64,
        spot: u64,
        generation_us: u64,
        pyth_source_id: u32,
        pyth_channel: u8,
        sender: address,
        onchain_timestamp_ms: u64,
    }

    struct QueuedOrderFilled has copy, drop, store {
        market_cash: u64,
        required_cash: u64,
        waiting_cash_need: u64,
        expiry_market_id: 0x2::object::ID,
        record_id: u64,
        account_id: 0x2::object::ID,
        kind: u8,
        quantity: u64,
        amount: u64,
        trading_fee: u64,
        builder_fee: u64,
        referral_fee: u64,
        order_fee: u64,
        subsidy_used: u64,
        inventory_impact: u64,
        tau_ms: u64,
        tick_ms: u64,
        position: 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::HeldPosition,
        sender: address,
        onchain_timestamp_ms: u64,
    }

    struct QueuedOrderRefunded has copy, drop, store {
        market_cash: u64,
        required_cash: u64,
        waiting_cash_need: u64,
        expiry_market_id: 0x2::object::ID,
        record_id: u64,
        account_id: 0x2::object::ID,
        kind: u8,
        reason: u8,
        escrow_returned: u64,
        order_fee_returned: u64,
        subsidy_returned: u64,
        position_returned: bool,
        sender: address,
        onchain_timestamp_ms: u64,
    }

    struct QueuedOrdersCleaned has copy, drop, store {
        expiry_market_id: 0x2::object::ID,
        record_ids: vector<u64>,
        onchain_timestamp_ms: u64,
    }

    struct OpenRecordSettled has copy, drop, store {
        expiry_market_id: 0x2::object::ID,
        record_id: u64,
        account_id: 0x2::object::ID,
        order_id: u256,
        payout: u64,
        onchain_timestamp_ms: u64,
    }

    struct OpenRecordPayoutSkipped has copy, drop, store {
        expiry_market_id: 0x2::object::ID,
        record_id: u64,
        account_id: 0x2::object::ID,
        order_id: u256,
        payout: u64,
        onchain_timestamp_ms: u64,
    }

    struct RecordFundsParked has copy, drop, store {
        expiry_market_id: 0x2::object::ID,
        record_id: u64,
        account_id: 0x2::object::ID,
        receive_address: address,
        amount: u64,
        onchain_timestamp_ms: u64,
    }

    struct RecordFundsClaimed has copy, drop, store {
        expiry_market_id: 0x2::object::ID,
        record_id: u64,
        account_id: 0x2::object::ID,
        receive_address: address,
        amount: u64,
        onchain_timestamp_ms: u64,
    }

    struct MarketPayoutsCompleted has copy, drop, store {
        expiry_market_id: 0x2::object::ID,
        onchain_timestamp_ms: u64,
    }

    struct DelayedExecutionPolicyUpdated has copy, drop, store {
        desk_id: 0x2::object::ID,
        policy: 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::DelayedExecutionPolicy,
        onchain_timestamp_ms: u64,
    }

    public(friend) fun emit_cohort_committed(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u32, arg8: u8, arg9: address, arg10: u64) {
        let v0 = CohortCommitted{
            expiry_market_id     : arg0,
            tau_ms               : arg1,
            tick_ms              : arg2,
            first_record_id      : arg3,
            last_record_id       : arg4,
            spot                 : arg5,
            generation_us        : arg6,
            pyth_source_id       : arg7,
            pyth_channel         : arg8,
            sender               : arg9,
            onchain_timestamp_ms : arg10,
        };
        0x2::event::emit<CohortCommitted>(v0);
    }

    public(friend) fun emit_market_payouts_completed(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = MarketPayoutsCompleted{
            expiry_market_id     : arg0,
            onchain_timestamp_ms : arg1,
        };
        0x2::event::emit<MarketPayoutsCompleted>(v0);
    }

    public(friend) fun emit_open_record_payout_skipped(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::object::ID, arg3: u256, arg4: u64, arg5: u64) {
        let v0 = OpenRecordPayoutSkipped{
            expiry_market_id     : arg0,
            record_id            : arg1,
            account_id           : arg2,
            order_id             : arg3,
            payout               : arg4,
            onchain_timestamp_ms : arg5,
        };
        0x2::event::emit<OpenRecordPayoutSkipped>(v0);
    }

    public(friend) fun emit_open_record_settled(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::object::ID, arg3: u256, arg4: u64, arg5: u64) {
        let v0 = OpenRecordSettled{
            expiry_market_id     : arg0,
            record_id            : arg1,
            account_id           : arg2,
            order_id             : arg3,
            payout               : arg4,
            onchain_timestamp_ms : arg5,
        };
        0x2::event::emit<OpenRecordSettled>(v0);
    }

    public(friend) fun emit_order_enqueued(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::object::ID, arg3: u8, arg4: 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::OrderRequest, arg5: 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::HeldPosition, arg6: 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::OrderTiming, arg7: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::VolSnapshot, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: 0x1::option::Option<0x2::object::ID>, arg13: 0x1::option::Option<0x2::object::ID>, arg14: 0x1::option::Option<u64>, arg15: u64, arg16: u64, arg17: u64, arg18: u64) {
        let v0 = OrderEnqueued{
            expiry_market_id     : arg0,
            record_id            : arg1,
            account_id           : arg2,
            kind                 : arg3,
            request              : arg4,
            position             : arg5,
            timing               : arg6,
            vol                  : arg7,
            budget               : arg8,
            order_fee            : arg9,
            cash_need            : arg10,
            subsidy_bound        : arg11,
            builder_code_id      : arg12,
            referrer_account_id  : arg13,
            source_record_id     : arg14,
            market_cash          : arg15,
            required_cash        : arg16,
            waiting_cash_need    : arg17,
            onchain_timestamp_ms : arg18,
        };
        0x2::event::emit<OrderEnqueued>(v0);
    }

    public(friend) fun emit_policy_updated(arg0: 0x2::object::ID, arg1: 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::DelayedExecutionPolicy, arg2: u64) {
        let v0 = DelayedExecutionPolicyUpdated{
            desk_id              : arg0,
            policy               : arg1,
            onchain_timestamp_ms : arg2,
        };
        0x2::event::emit<DelayedExecutionPolicyUpdated>(v0);
    }

    public(friend) fun emit_queued_order_filled(arg0: u64, arg1: u64, arg2: u64, arg3: 0x2::object::ID, arg4: u64, arg5: 0x2::object::ID, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::HeldPosition, arg18: address, arg19: u64) {
        let v0 = QueuedOrderFilled{
            market_cash          : arg0,
            required_cash        : arg1,
            waiting_cash_need    : arg2,
            expiry_market_id     : arg3,
            record_id            : arg4,
            account_id           : arg5,
            kind                 : arg6,
            quantity             : arg7,
            amount               : arg8,
            trading_fee          : arg9,
            builder_fee          : arg10,
            referral_fee         : arg11,
            order_fee            : arg12,
            subsidy_used         : arg13,
            inventory_impact     : arg14,
            tau_ms               : arg15,
            tick_ms              : arg16,
            position             : arg17,
            sender               : arg18,
            onchain_timestamp_ms : arg19,
        };
        0x2::event::emit<QueuedOrderFilled>(v0);
    }

    public(friend) fun emit_queued_order_refunded(arg0: u64, arg1: u64, arg2: u64, arg3: 0x2::object::ID, arg4: u64, arg5: 0x2::object::ID, arg6: u8, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: bool, arg12: address, arg13: u64) {
        let v0 = QueuedOrderRefunded{
            market_cash          : arg0,
            required_cash        : arg1,
            waiting_cash_need    : arg2,
            expiry_market_id     : arg3,
            record_id            : arg4,
            account_id           : arg5,
            kind                 : arg6,
            reason               : arg7,
            escrow_returned      : arg8,
            order_fee_returned   : arg9,
            subsidy_returned     : arg10,
            position_returned    : arg11,
            sender               : arg12,
            onchain_timestamp_ms : arg13,
        };
        0x2::event::emit<QueuedOrderRefunded>(v0);
    }

    public(friend) fun emit_queued_orders_cleaned(arg0: 0x2::object::ID, arg1: vector<u64>, arg2: u64) {
        let v0 = QueuedOrdersCleaned{
            expiry_market_id     : arg0,
            record_ids           : arg1,
            onchain_timestamp_ms : arg2,
        };
        0x2::event::emit<QueuedOrdersCleaned>(v0);
    }

    public(friend) fun emit_record_funds_claimed(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::object::ID, arg3: address, arg4: u64, arg5: u64) {
        let v0 = RecordFundsClaimed{
            expiry_market_id     : arg0,
            record_id            : arg1,
            account_id           : arg2,
            receive_address      : arg3,
            amount               : arg4,
            onchain_timestamp_ms : arg5,
        };
        0x2::event::emit<RecordFundsClaimed>(v0);
    }

    public(friend) fun emit_record_funds_parked(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::object::ID, arg3: address, arg4: u64, arg5: u64) {
        let v0 = RecordFundsParked{
            expiry_market_id     : arg0,
            record_id            : arg1,
            account_id           : arg2,
            receive_address      : arg3,
            amount               : arg4,
            onchain_timestamp_ms : arg5,
        };
        0x2::event::emit<RecordFundsParked>(v0);
    }

    // decompiled from Move bytecode v7
}

