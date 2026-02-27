module 0x762709123c0ba545e033d74a07c31c8fe3371cc462b4970248aec750172f323f::events {
    struct MMExecutionDetailEvent has copy, drop {
        state_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        price_sequence: u64,
        execution_count: u64,
        timestamp_ms: u64,
        oracle_price: u64,
        mid_price: u64,
        bid_price: u64,
        ask_price: u64,
        base_balance: u64,
        quote_balance: u64,
        target_base: u64,
        inventory_delta_bps: u64,
        is_long: bool,
        half_spread_bid_bps: u64,
        half_spread_ask_bps: u64,
        bid_quantity: u64,
        ask_quantity: u64,
        client_order_id: u64,
        bid_posted: bool,
        ask_posted: bool,
        anchor_price: u64,
        taker_mid: u64,
    }

    struct OrdersCancelledEvent has copy, drop {
        state_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct PoolRegisteredEvent has copy, drop {
        pool_id: 0x2::object::ID,
        config: 0x762709123c0ba545e033d74a07c31c8fe3371cc462b4970248aec750172f323f::config::MMConfig,
        timestamp_ms: u64,
    }

    struct PoolStatusChangedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        enabled: bool,
        timestamp_ms: u64,
    }

    struct StateCreatedEvent has copy, drop {
        state_id: 0x2::object::ID,
        owner: address,
        timestamp_ms: u64,
    }

    struct TradingPausedEvent has copy, drop {
        state_id: 0x2::object::ID,
        pause_until: u64,
        timestamp_ms: u64,
    }

    struct ArbitrageOpportunityEvent has copy, drop {
        pool_id: 0x2::object::ID,
        timestamp_ms: u64,
        reference_price: u64,
        cetus_bid: u64,
        cetus_ask: u64,
        turbos_bid: u64,
        turbos_ask: u64,
        bluefin_bid: u64,
        bluefin_ask: u64,
        mmt_bid: u64,
        mmt_ask: u64,
        best_buy_venue: u8,
        best_buy_price: u64,
        best_buy_profit_bps: u64,
        best_sell_venue: u8,
        best_sell_price: u64,
        best_sell_profit_bps: u64,
        min_profit_threshold_bps: u64,
        will_execute_buy: bool,
        will_execute_sell: bool,
    }

    struct ArbitrageExecutionEvent has copy, drop {
        pool_id: 0x2::object::ID,
        timestamp_ms: u64,
        venue: u8,
        direction: u8,
        amount_base: u64,
        amount_quote: u64,
        expected_price: u64,
        execution_price: u64,
        reference_price: u64,
        expected_profit_bps: u64,
        actual_profit_bps: u64,
        slippage_bps: u64,
        venue_fee_paid: u64,
        success: bool,
        error_code: u64,
    }

    struct IOCOrderResultEvent has copy, drop {
        pool_id: 0x2::object::ID,
        order_id: u128,
        timestamp_ms: u64,
        is_bid: bool,
        price: u64,
        quantity: u64,
        filled_quantity: u64,
        unfilled_quantity: u64,
        was_fully_filled: bool,
        context: u8,
    }

    struct VenuePriceReadEvent has copy, drop {
        venue: u8,
        venue_name: vector<u8>,
        pool_id: 0x2::object::ID,
        timestamp_ms: u64,
        sqrt_price: u128,
        is_inverse: bool,
        mid_price: u64,
        fee_rate_bps: u64,
        effective_bid: u64,
        effective_ask: u64,
    }

    struct VenueSwapEvent has copy, drop {
        venue: u8,
        pool_id: 0x2::object::ID,
        timestamp_ms: u64,
        direction: u8,
        amount_in: u64,
        amount_out: u64,
        expected_price: u64,
        execution_price: u64,
        slippage_bps: u64,
        fee_paid: u64,
        max_in_limit: u64,
        min_out_limit: u64,
        limit_hit: bool,
    }

    struct DeepBalanceCheckEvent has copy, drop {
        timestamp_ms: u64,
        current_balance: u64,
        required: u64,
        action: u8,
        order_quantity: u64,
        order_price: u64,
        deep_fee_estimate: u64,
    }

    struct DeepPurchaseEvent has copy, drop {
        timestamp_ms: u64,
        amount_requested: u64,
        amount_purchased: u64,
        quote_spent: u64,
        new_deep_balance: u64,
        remaining_quote_balance: u64,
        fully_filled: bool,
    }

    public(friend) fun emit_arbitrage_execution(arg0: 0x2::object::ID, arg1: u64, arg2: u8, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: bool, arg14: u64) {
        let v0 = ArbitrageExecutionEvent{
            pool_id             : arg0,
            timestamp_ms        : arg1,
            venue               : arg2,
            direction           : arg3,
            amount_base         : arg4,
            amount_quote        : arg5,
            expected_price      : arg6,
            execution_price     : arg7,
            reference_price     : arg8,
            expected_profit_bps : arg9,
            actual_profit_bps   : arg10,
            slippage_bps        : arg11,
            venue_fee_paid      : arg12,
            success             : arg13,
            error_code          : arg14,
        };
        0x2::event::emit<ArbitrageExecutionEvent>(v0);
    }

    public(friend) fun emit_arbitrage_opportunity(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u8, arg12: u64, arg13: u64, arg14: u8, arg15: u64, arg16: u64, arg17: u64, arg18: bool, arg19: bool) {
        let v0 = ArbitrageOpportunityEvent{
            pool_id                  : arg0,
            timestamp_ms             : arg1,
            reference_price          : arg2,
            cetus_bid                : arg3,
            cetus_ask                : arg4,
            turbos_bid               : arg5,
            turbos_ask               : arg6,
            bluefin_bid              : arg7,
            bluefin_ask              : arg8,
            mmt_bid                  : arg9,
            mmt_ask                  : arg10,
            best_buy_venue           : arg11,
            best_buy_price           : arg12,
            best_buy_profit_bps      : arg13,
            best_sell_venue          : arg14,
            best_sell_price          : arg15,
            best_sell_profit_bps     : arg16,
            min_profit_threshold_bps : arg17,
            will_execute_buy         : arg18,
            will_execute_sell        : arg19,
        };
        0x2::event::emit<ArbitrageOpportunityEvent>(v0);
    }

    public(friend) fun emit_deep_balance_check(arg0: u64, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = DeepBalanceCheckEvent{
            timestamp_ms      : arg6,
            current_balance   : arg0,
            required          : arg1,
            action            : arg2,
            order_quantity    : arg3,
            order_price       : arg4,
            deep_fee_estimate : arg5,
        };
        0x2::event::emit<DeepBalanceCheckEvent>(v0);
    }

    public(friend) fun emit_deep_purchase(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: u64) {
        let v0 = DeepPurchaseEvent{
            timestamp_ms            : arg6,
            amount_requested        : arg0,
            amount_purchased        : arg1,
            quote_spent             : arg2,
            new_deep_balance        : arg3,
            remaining_quote_balance : arg4,
            fully_filled            : arg5,
        };
        0x2::event::emit<DeepPurchaseEvent>(v0);
    }

    public(friend) fun emit_execution_detail(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: bool, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: bool, arg20: bool, arg21: u64, arg22: u64) {
        let v0 = MMExecutionDetailEvent{
            state_id            : arg0,
            pool_id             : arg1,
            price_sequence      : arg2,
            execution_count     : arg3,
            timestamp_ms        : arg4,
            oracle_price        : arg5,
            mid_price           : arg6,
            bid_price           : arg7,
            ask_price           : arg8,
            base_balance        : arg9,
            quote_balance       : arg10,
            target_base         : arg11,
            inventory_delta_bps : arg12,
            is_long             : arg13,
            half_spread_bid_bps : arg14,
            half_spread_ask_bps : arg15,
            bid_quantity        : arg16,
            ask_quantity        : arg17,
            client_order_id     : arg18,
            bid_posted          : arg19,
            ask_posted          : arg20,
            anchor_price        : arg21,
            taker_mid           : arg22,
        };
        0x2::event::emit<MMExecutionDetailEvent>(v0);
    }

    public(friend) fun emit_ioc_order_result(arg0: 0x2::object::ID, arg1: u128, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: u64) {
        let v0 = if (arg4 > arg5) {
            arg4 - arg5
        } else {
            0
        };
        let v1 = IOCOrderResultEvent{
            pool_id           : arg0,
            order_id          : arg1,
            timestamp_ms      : arg7,
            is_bid            : arg2,
            price             : arg3,
            quantity          : arg4,
            filled_quantity   : arg5,
            unfilled_quantity : v0,
            was_fully_filled  : arg5 >= arg4,
            context           : arg6,
        };
        0x2::event::emit<IOCOrderResultEvent>(v1);
    }

    public(friend) fun emit_orders_cancelled(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = OrdersCancelledEvent{
            state_id     : arg0,
            pool_id      : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<OrdersCancelledEvent>(v0);
    }

    public(friend) fun emit_pool_registered(arg0: 0x2::object::ID, arg1: 0x762709123c0ba545e033d74a07c31c8fe3371cc462b4970248aec750172f323f::config::MMConfig, arg2: u64) {
        let v0 = PoolRegisteredEvent{
            pool_id      : arg0,
            config       : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<PoolRegisteredEvent>(v0);
    }

    public(friend) fun emit_pool_status_changed(arg0: 0x2::object::ID, arg1: bool, arg2: u64) {
        let v0 = PoolStatusChangedEvent{
            pool_id      : arg0,
            enabled      : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<PoolStatusChangedEvent>(v0);
    }

    public(friend) fun emit_state_created(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = StateCreatedEvent{
            state_id     : arg0,
            owner        : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<StateCreatedEvent>(v0);
    }

    public(friend) fun emit_trading_paused(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = TradingPausedEvent{
            state_id     : arg0,
            pause_until  : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<TradingPausedEvent>(v0);
    }

    public(friend) fun emit_venue_price_read(arg0: u8, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: u64, arg4: u128, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = VenuePriceReadEvent{
            venue         : arg0,
            venue_name    : arg1,
            pool_id       : arg2,
            timestamp_ms  : arg3,
            sqrt_price    : arg4,
            is_inverse    : arg5,
            mid_price     : arg6,
            fee_rate_bps  : arg7,
            effective_bid : arg8,
            effective_ask : arg9,
        };
        0x2::event::emit<VenuePriceReadEvent>(v0);
    }

    public(friend) fun emit_venue_swap(arg0: u8, arg1: 0x2::object::ID, arg2: u64, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: bool) {
        let v0 = VenueSwapEvent{
            venue           : arg0,
            pool_id         : arg1,
            timestamp_ms    : arg2,
            direction       : arg3,
            amount_in       : arg4,
            amount_out      : arg5,
            expected_price  : arg6,
            execution_price : arg7,
            slippage_bps    : arg8,
            fee_paid        : arg9,
            max_in_limit    : arg10,
            min_out_limit   : arg11,
            limit_hit       : arg12,
        };
        0x2::event::emit<VenueSwapEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

