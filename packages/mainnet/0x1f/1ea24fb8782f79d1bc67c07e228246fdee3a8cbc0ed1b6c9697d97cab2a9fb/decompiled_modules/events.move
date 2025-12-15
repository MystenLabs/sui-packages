module 0x1f1ea24fb8782f79d1bc67c07e228246fdee3a8cbc0ed1b6c9697d97cab2a9fb::events {
    struct ExecutionEvent has copy, drop {
        state_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        input_price: u64,
        input_spread: u64,
        effective_spread: u64,
        price_sequence: u64,
        execution_count: u64,
        timestamp_ms: u64,
    }

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
        venue_price: u64,
        hedge_profitable: bool,
        hedge_profit_bps: u64,
        client_order_id: u64,
        bid_posted: bool,
        ask_posted: bool,
        edge_bid_decibps: u64,
        edge_ask_decibps: u64,
        min_edge_decibps: u64,
    }

    struct OrdersPlacedEvent has copy, drop {
        state_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        bid_price: u64,
        bid_quantity: u64,
        ask_price: u64,
        ask_quantity: u64,
        timestamp_ms: u64,
    }

    struct OrdersCancelledEvent has copy, drop {
        state_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct PriceUpdatedEvent has copy, drop {
        state_id: 0x2::object::ID,
        old_price: u64,
        new_price: u64,
        price_sequence: u64,
        timestamp_ms: u64,
    }

    struct PoolRegisteredEvent has copy, drop {
        pool_id: 0x2::object::ID,
        config: 0x1f1ea24fb8782f79d1bc67c07e228246fdee3a8cbc0ed1b6c9697d97cab2a9fb::config::MMConfig,
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

    struct LogEvent has copy, drop {
        message: 0x1::string::String,
    }

    struct DebugPoolParamsEvent has copy, drop {
        tick_size: u64,
        lot_size: u64,
        min_size: u64,
        raw_bid_price: u64,
        raw_ask_price: u64,
        final_bid_price: u64,
        final_ask_price: u64,
    }

    struct SkewAppliedEvent has copy, drop {
        state_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        oracle_price: u64,
        skewed_mid_price: u64,
        skew_bps: u64,
        is_skew_down: bool,
        current_base: u64,
        target_base: u64,
        timestamp_ms: u64,
    }

    struct HedgeOpportunityEvent has copy, drop {
        state_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        oracle_price: u64,
        venue_price: u64,
        effective_venue_price: u64,
        hedge_amount: u64,
        is_sell: bool,
        is_profitable: bool,
        profit_bps: u64,
        timestamp_ms: u64,
    }

    struct HedgeExecutedEvent has copy, drop {
        state_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        venue: vector<u8>,
        is_sell: bool,
        base_amount: u64,
        quote_amount: u64,
        execution_price: u64,
        oracle_price: u64,
        profit_bps: u64,
        timestamp_ms: u64,
    }

    struct OrderbookAnalysisEvent has copy, drop {
        pool_id: 0x2::object::ID,
        timestamp_ms: u64,
        bid_levels_count: u64,
        ask_levels_count: u64,
        raw_best_bid: u64,
        raw_best_ask: u64,
        raw_spread_bps: u64,
        own_bid_quantity_filtered: u64,
        own_ask_quantity_filtered: u64,
        own_orders_count: u64,
        filtered_best_bid: u64,
        filtered_best_ask: u64,
        filtered_spread_bps: u64,
        significant_bid_price: u64,
        significant_bid_qty: u64,
        significant_ask_price: u64,
        significant_ask_qty: u64,
        total_bid_depth: u64,
        total_ask_depth: u64,
    }

    struct OrderPlacementDecisionEvent has copy, drop {
        pool_id: 0x2::object::ID,
        timestamp_ms: u64,
        is_bid: bool,
        oracle_price: u64,
        skewed_mid_price: u64,
        naive_price: u64,
        significant_level_price: u64,
        significant_level_qty: u64,
        final_price: u64,
        price_improvement_ticks: u64,
        is_more_aggressive: bool,
        placement_reason: u8,
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

    struct DeepFeeSavingsEvent has copy, drop {
        timestamp_ms: u64,
        fee_without_deep: u64,
        fee_with_deep: u64,
        savings: u64,
        savings_bps: u64,
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

    struct PostOnlyOrderEvent has copy, drop {
        pool_id: 0x2::object::ID,
        timestamp_ms: u64,
        is_bid: bool,
        price: u64,
        quantity: u64,
        order_id: u128,
        was_posted: bool,
        cancelled_due_to_crossing: bool,
        oracle_price: u64,
        spread_bps: u64,
        client_order_id: u64,
    }

    struct ArbIOCExecutedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        timestamp_ms: u64,
        is_buy: bool,
        deepbook_price: u64,
        requested_qty: u64,
        filled_qty: u64,
        amm_price: u64,
        fill_rate_bps: u64,
    }

    struct CrossingPreventedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        timestamp_ms: u64,
        bid_clamped: bool,
        ask_clamped: bool,
        raw_bid_price: u64,
        raw_ask_price: u64,
        clamped_bid_price: u64,
        clamped_ask_price: u64,
        best_bid: u64,
        best_ask: u64,
        epsilon_bid_bps: u64,
        epsilon_ask_bps: u64,
    }

    public(friend) fun emit_arb_ioc_executed(arg0: 0x2::object::ID, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = if (arg3 > 0) {
            arg4 * 10000 / arg3
        } else {
            0
        };
        let v1 = ArbIOCExecutedEvent{
            pool_id        : arg0,
            timestamp_ms   : arg6,
            is_buy         : arg1,
            deepbook_price : arg2,
            requested_qty  : arg3,
            filled_qty     : arg4,
            amm_price      : arg5,
            fill_rate_bps  : v0,
        };
        0x2::event::emit<ArbIOCExecutedEvent>(v1);
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

    public(friend) fun emit_crossing_prevented(arg0: 0x2::object::ID, arg1: u64, arg2: bool, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64) {
        let v0 = CrossingPreventedEvent{
            pool_id           : arg0,
            timestamp_ms      : arg1,
            bid_clamped       : arg2,
            ask_clamped       : arg3,
            raw_bid_price     : arg4,
            raw_ask_price     : arg5,
            clamped_bid_price : arg6,
            clamped_ask_price : arg7,
            best_bid          : arg8,
            best_ask          : arg9,
            epsilon_bid_bps   : arg10,
            epsilon_ask_bps   : arg11,
        };
        0x2::event::emit<CrossingPreventedEvent>(v0);
    }

    public(friend) fun emit_debug_pool_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = DebugPoolParamsEvent{
            tick_size       : arg0,
            lot_size        : arg1,
            min_size        : arg2,
            raw_bid_price   : arg3,
            raw_ask_price   : arg4,
            final_bid_price : arg5,
            final_ask_price : arg6,
        };
        0x2::event::emit<DebugPoolParamsEvent>(v0);
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

    public(friend) fun emit_deep_fee_savings(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        };
        let v1 = if (arg0 > 0) {
            v0 * 10000 / arg0
        } else {
            0
        };
        let v2 = DeepFeeSavingsEvent{
            timestamp_ms     : arg2,
            fee_without_deep : arg0,
            fee_with_deep    : arg1,
            savings          : v0,
            savings_bps      : v1,
        };
        0x2::event::emit<DeepFeeSavingsEvent>(v2);
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

    public(friend) fun emit_execution(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = ExecutionEvent{
            state_id         : arg0,
            pool_id          : arg1,
            input_price      : arg2,
            input_spread     : arg3,
            effective_spread : arg4,
            price_sequence   : arg5,
            execution_count  : arg6,
            timestamp_ms     : arg7,
        };
        0x2::event::emit<ExecutionEvent>(v0);
    }

    public(friend) fun emit_execution_detail(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: bool, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: bool, arg20: u64, arg21: u64, arg22: bool, arg23: bool, arg24: u64, arg25: u64, arg26: u64) {
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
            venue_price         : arg18,
            hedge_profitable    : arg19,
            hedge_profit_bps    : arg20,
            client_order_id     : arg21,
            bid_posted          : arg22,
            ask_posted          : arg23,
            edge_bid_decibps    : arg24,
            edge_ask_decibps    : arg25,
            min_edge_decibps    : arg26,
        };
        0x2::event::emit<MMExecutionDetailEvent>(v0);
    }

    public(friend) fun emit_hedge_executed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = HedgeExecutedEvent{
            state_id        : arg0,
            pool_id         : arg1,
            venue           : arg2,
            is_sell         : arg3,
            base_amount     : arg4,
            quote_amount    : arg5,
            execution_price : arg6,
            oracle_price    : arg7,
            profit_bps      : arg8,
            timestamp_ms    : arg9,
        };
        0x2::event::emit<HedgeExecutedEvent>(v0);
    }

    public(friend) fun emit_hedge_opportunity(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: bool, arg8: u64, arg9: u64) {
        let v0 = HedgeOpportunityEvent{
            state_id              : arg0,
            pool_id               : arg1,
            oracle_price          : arg2,
            venue_price           : arg3,
            effective_venue_price : arg4,
            hedge_amount          : arg5,
            is_sell               : arg6,
            is_profitable         : arg7,
            profit_bps            : arg8,
            timestamp_ms          : arg9,
        };
        0x2::event::emit<HedgeOpportunityEvent>(v0);
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

    public(friend) fun emit_log(arg0: 0x1::string::String) {
        let v0 = LogEvent{message: arg0};
        0x2::event::emit<LogEvent>(v0);
    }

    public(friend) fun emit_log_bytes(arg0: vector<u8>) {
        let v0 = LogEvent{message: 0x1::string::utf8(arg0)};
        0x2::event::emit<LogEvent>(v0);
    }

    public(friend) fun emit_order_placement_decision(arg0: 0x2::object::ID, arg1: u64, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: bool, arg11: u8) {
        let v0 = OrderPlacementDecisionEvent{
            pool_id                 : arg0,
            timestamp_ms            : arg1,
            is_bid                  : arg2,
            oracle_price            : arg3,
            skewed_mid_price        : arg4,
            naive_price             : arg5,
            significant_level_price : arg6,
            significant_level_qty   : arg7,
            final_price             : arg8,
            price_improvement_ticks : arg9,
            is_more_aggressive      : arg10,
            placement_reason        : arg11,
        };
        0x2::event::emit<OrderPlacementDecisionEvent>(v0);
    }

    public(friend) fun emit_orderbook_analysis(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64) {
        let v0 = OrderbookAnalysisEvent{
            pool_id                   : arg0,
            timestamp_ms              : arg1,
            bid_levels_count          : arg2,
            ask_levels_count          : arg3,
            raw_best_bid              : arg4,
            raw_best_ask              : arg5,
            raw_spread_bps            : arg6,
            own_bid_quantity_filtered : arg7,
            own_ask_quantity_filtered : arg8,
            own_orders_count          : arg9,
            filtered_best_bid         : arg10,
            filtered_best_ask         : arg11,
            filtered_spread_bps       : arg12,
            significant_bid_price     : arg13,
            significant_bid_qty       : arg14,
            significant_ask_price     : arg15,
            significant_ask_qty       : arg16,
            total_bid_depth           : arg17,
            total_ask_depth           : arg18,
        };
        0x2::event::emit<OrderbookAnalysisEvent>(v0);
    }

    public(friend) fun emit_orders_cancelled(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = OrdersCancelledEvent{
            state_id     : arg0,
            pool_id      : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<OrdersCancelledEvent>(v0);
    }

    public(friend) fun emit_orders_placed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = OrdersPlacedEvent{
            state_id     : arg0,
            pool_id      : arg1,
            bid_price    : arg2,
            bid_quantity : arg3,
            ask_price    : arg4,
            ask_quantity : arg5,
            timestamp_ms : arg6,
        };
        0x2::event::emit<OrdersPlacedEvent>(v0);
    }

    public(friend) fun emit_pool_registered(arg0: 0x2::object::ID, arg1: 0x1f1ea24fb8782f79d1bc67c07e228246fdee3a8cbc0ed1b6c9697d97cab2a9fb::config::MMConfig, arg2: u64) {
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

    public(friend) fun emit_post_only_order(arg0: 0x2::object::ID, arg1: bool, arg2: u64, arg3: u64, arg4: u128, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = arg4 > 0;
        let v1 = PostOnlyOrderEvent{
            pool_id                   : arg0,
            timestamp_ms              : arg7,
            is_bid                    : arg1,
            price                     : arg2,
            quantity                  : arg3,
            order_id                  : arg4,
            was_posted                : v0,
            cancelled_due_to_crossing : !v0,
            oracle_price              : arg5,
            spread_bps                : arg6,
            client_order_id           : arg8,
        };
        0x2::event::emit<PostOnlyOrderEvent>(v1);
    }

    public(friend) fun emit_price_updated(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = PriceUpdatedEvent{
            state_id       : arg0,
            old_price      : arg1,
            new_price      : arg2,
            price_sequence : arg3,
            timestamp_ms   : arg4,
        };
        0x2::event::emit<PriceUpdatedEvent>(v0);
    }

    public(friend) fun emit_skew_applied(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = SkewAppliedEvent{
            state_id         : arg0,
            pool_id          : arg1,
            oracle_price     : arg2,
            skewed_mid_price : arg3,
            skew_bps         : arg4,
            is_skew_down     : arg5,
            current_base     : arg6,
            target_base      : arg7,
            timestamp_ms     : arg8,
        };
        0x2::event::emit<SkewAppliedEvent>(v0);
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

