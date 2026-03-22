module 0xdfba199dbb89f7833a52f155ce4f40c0bd60b9f9645c9357af53d95118c18cda::market_maker {
    struct BotState has store, key {
        id: 0x2::object::UID,
        owner: address,
        current_bid_order_id: u128,
        current_ask_order_id: u128,
        ewma_price: u64,
        spread_bps: u64,
        order_ttl_ms: u64,
        last_update_ts: u64,
        next_client_order_id: u64,
        total_quote_volume: u64,
        total_base_volume: u64,
    }

    struct QuoteUpdated has copy, drop {
        bid_price: u64,
        ask_price: u64,
        ewma_price: u64,
        spread_bps: u64,
        timestamp: u64,
    }

    struct StateCreated has copy, drop {
        owner: address,
        spread_bps: u64,
    }

    public fun calc_expire_ts(arg0: &BotState, arg1: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg1) + arg0.order_ttl_ms
    }

    public fun calc_prices(arg0: &BotState, arg1: u64) : (u64, u64, u64) {
        let v0 = if (arg0.ewma_price == 0) {
            arg1
        } else {
            (100 * arg1 + (1000 - 100) * arg0.ewma_price) / 1000
        };
        let v1 = v0 * arg0.spread_bps / 20000;
        (v0 - v1, v0 + v1, v0)
    }

    public fun commit_update(arg0: &mut BotState, arg1: u128, arg2: u128, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        if (arg0.ewma_price == 0) {
            arg0.ewma_price = arg3;
        } else {
            arg0.ewma_price = (100 * arg3 + (1000 - 100) * arg0.ewma_price) / 1000;
        };
        arg0.current_bid_order_id = arg1;
        arg0.current_ask_order_id = arg2;
        arg0.next_client_order_id = arg0.next_client_order_id + 2;
        arg0.last_update_ts = v0;
        let v1 = arg0.ewma_price * arg0.spread_bps / 20000;
        let v2 = QuoteUpdated{
            bid_price  : arg0.ewma_price - v1,
            ask_price  : arg0.ewma_price + v1,
            ewma_price : arg0.ewma_price,
            spread_bps : arg0.spread_bps,
            timestamp  : v0,
        };
        0x2::event::emit<QuoteUpdated>(v2);
    }

    public fun create_bot_state(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 >= 5, 2);
        assert!(arg0 <= 500, 2);
        let v0 = if (arg1 == 0) {
            60000
        } else {
            arg1
        };
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = BotState{
            id                   : 0x2::object::new(arg2),
            owner                : v1,
            current_bid_order_id : 0,
            current_ask_order_id : 0,
            ewma_price           : 0,
            spread_bps           : arg0,
            order_ttl_ms         : v0,
            last_update_ts       : 0,
            next_client_order_id : 1,
            total_quote_volume   : 0,
            total_base_volume    : 0,
        };
        let v3 = StateCreated{
            owner      : v1,
            spread_bps : arg0,
        };
        0x2::event::emit<StateCreated>(v3);
        0x2::transfer::transfer<BotState>(v2, v1);
    }

    public fun get_active_orders(arg0: &BotState) : (u128, u128) {
        (arg0.current_bid_order_id, arg0.current_ask_order_id)
    }

    public fun get_ewma_price(arg0: &BotState) : u64 {
        arg0.ewma_price
    }

    public fun get_last_update(arg0: &BotState) : u64 {
        arg0.last_update_ts
    }

    public fun get_next_coids(arg0: &BotState) : (u64, u64) {
        (arg0.next_client_order_id, arg0.next_client_order_id + 1)
    }

    public fun get_order_ttl(arg0: &BotState) : u64 {
        arg0.order_ttl_ms
    }

    public fun get_spread_bps(arg0: &BotState) : u64 {
        arg0.spread_bps
    }

    public fun reset_orders(arg0: &mut BotState, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        arg0.current_bid_order_id = 0;
        arg0.current_ask_order_id = 0;
    }

    public fun set_order_ttl(arg0: &mut BotState, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.order_ttl_ms = arg1;
    }

    public fun set_spread(arg0: &mut BotState, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(arg1 >= 5, 2);
        assert!(arg1 <= 500, 2);
        arg0.spread_bps = arg1;
    }

    // decompiled from Move bytecode v6
}

