module 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::events {
    struct MMOrderRefreshEvent has copy, drop {
        target_price: u64,
        bid_price_inner: u64,
        ask_price_inner: u64,
        bid_price_outer: u64,
        ask_price_outer: u64,
        bid_size_inner: u64,
        ask_size_inner: u64,
        bid_size_outer: u64,
        ask_size_outer: u64,
        spread_inner_bps: u64,
        spread_outer_bps: u64,
        inventory_ratio: u64,
        timestamp_ms: u64,
    }

    struct MMOrderSkipEvent has copy, drop {
        reason: vector<u8>,
        target_price: u64,
        timestamp_ms: u64,
    }

    struct MMFillEvent has copy, drop {
        is_buy: bool,
        fill_price: u64,
        fill_quantity: u64,
        usdc_amount: u64,
        target_price_at_fill: u64,
        estimated_pnl_bps: u64,
        timestamp_ms: u64,
    }

    struct ArbOpportunityEvent has copy, drop {
        pool_name: vector<u8>,
        is_buy: bool,
        amm_price: u64,
        target_price: u64,
        gap_bps: u64,
        executed: bool,
        timestamp_ms: u64,
    }

    struct ArbExecutionEvent has copy, drop {
        pool_name: vector<u8>,
        is_buy: bool,
        sui_amount: u64,
        usdc_amount: u64,
        effective_price: u64,
        target_price: u64,
        estimated_pnl_usdc: u64,
        timestamp_ms: u64,
    }

    struct InventorySnapshotEvent has copy, drop {
        sui_balance: u64,
        usdc_balance: u64,
        sui_in_orders: u64,
        usdc_in_orders: u64,
        inventory_ratio: u64,
        total_value_usdc: u64,
        timestamp_ms: u64,
    }

    struct InventoryAlertEvent has copy, drop {
        alert_type: vector<u8>,
        inventory_ratio: u64,
        threshold: u64,
        timestamp_ms: u64,
    }

    struct BalanceChangeEvent has copy, drop {
        amount: u64,
        balance_after: u64,
        is_sui: bool,
        is_deposit: bool,
    }

    struct ErrorEvent has copy, drop {
        error_message: vector<u8>,
        timestamp_ms: u64,
    }

    struct TickSummaryEvent has copy, drop {
        target_price: u64,
        mm_orders_placed: u8,
        arb_trades_executed: u8,
        gas_price: u64,
        timestamp_ms: u64,
    }

    public fun emit_arb_execution(arg0: vector<u8>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = ArbExecutionEvent{
            pool_name          : arg0,
            is_buy             : arg1,
            sui_amount         : arg2,
            usdc_amount        : arg3,
            effective_price    : arg4,
            target_price       : arg5,
            estimated_pnl_usdc : arg6,
            timestamp_ms       : arg7,
        };
        0x2::event::emit<ArbExecutionEvent>(v0);
    }

    public fun emit_arb_opportunity(arg0: vector<u8>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: u64) {
        let v0 = ArbOpportunityEvent{
            pool_name    : arg0,
            is_buy       : arg1,
            amm_price    : arg2,
            target_price : arg3,
            gap_bps      : arg4,
            executed     : arg5,
            timestamp_ms : arg6,
        };
        0x2::event::emit<ArbOpportunityEvent>(v0);
    }

    public fun emit_balance_change(arg0: u64, arg1: u64, arg2: bool, arg3: bool) {
        let v0 = BalanceChangeEvent{
            amount        : arg0,
            balance_after : arg1,
            is_sui        : arg2,
            is_deposit    : arg3,
        };
        0x2::event::emit<BalanceChangeEvent>(v0);
    }

    public fun emit_error(arg0: vector<u8>, arg1: u64) {
        let v0 = ErrorEvent{
            error_message : arg0,
            timestamp_ms  : arg1,
        };
        0x2::event::emit<ErrorEvent>(v0);
    }

    public fun emit_inventory_snapshot(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = InventorySnapshotEvent{
            sui_balance      : arg0,
            usdc_balance     : arg1,
            sui_in_orders    : arg2,
            usdc_in_orders   : arg3,
            inventory_ratio  : arg4,
            total_value_usdc : arg5,
            timestamp_ms     : arg6,
        };
        0x2::event::emit<InventorySnapshotEvent>(v0);
    }

    public fun emit_mm_refresh(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64) {
        let v0 = MMOrderRefreshEvent{
            target_price     : arg0,
            bid_price_inner  : arg1,
            ask_price_inner  : arg2,
            bid_price_outer  : arg3,
            ask_price_outer  : arg4,
            bid_size_inner   : arg5,
            ask_size_inner   : arg6,
            bid_size_outer   : arg7,
            ask_size_outer   : arg8,
            spread_inner_bps : arg9,
            spread_outer_bps : arg10,
            inventory_ratio  : arg11,
            timestamp_ms     : arg12,
        };
        0x2::event::emit<MMOrderRefreshEvent>(v0);
    }

    public fun emit_mm_skip(arg0: vector<u8>, arg1: u64, arg2: u64) {
        let v0 = MMOrderSkipEvent{
            reason       : arg0,
            target_price : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<MMOrderSkipEvent>(v0);
    }

    public fun emit_tick_summary(arg0: u64, arg1: u8, arg2: u8, arg3: u64, arg4: u64) {
        let v0 = TickSummaryEvent{
            target_price        : arg0,
            mm_orders_placed    : arg1,
            arb_trades_executed : arg2,
            gas_price           : arg3,
            timestamp_ms        : arg4,
        };
        0x2::event::emit<TickSummaryEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

