module 0x473e8516cfa7db33574546a8983c24a3d3bc2d5b56850ae5b2e53ccc165daba1::context {
    struct MarginTradingContext {
        trace_id: 0x1::string::String,
        market_id: 0x2::object::ID,
        position_cap_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        action: 0x1::string::String,
        sender: address,
    }

    struct MarginTradingConfirmEvent has copy, drop {
        trace_id: 0x1::string::String,
        market_id: 0x2::object::ID,
        position_cap_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        action: 0x1::string::String,
        sender: address,
    }

    public fun sender(arg0: &MarginTradingContext) : address {
        arg0.sender
    }

    public fun action(arg0: &MarginTradingContext) : 0x1::string::String {
        arg0.action
    }

    public(friend) fun destroy_margin_trading_context(arg0: MarginTradingContext) {
        let MarginTradingContext {
            trace_id        : _,
            market_id       : _,
            position_cap_id : _,
            position_id     : _,
            action          : _,
            sender          : _,
        } = arg0;
    }

    public(friend) fun emit_margin_trading_confirm_event(arg0: &MarginTradingContext) {
        let v0 = MarginTradingConfirmEvent{
            trace_id        : trace_id(arg0),
            market_id       : market_id(arg0),
            position_cap_id : position_cap_id(arg0),
            position_id     : position_id(arg0),
            action          : action(arg0),
            sender          : sender(arg0),
        };
        0x2::event::emit<MarginTradingConfirmEvent>(v0);
    }

    public fun market_id(arg0: &MarginTradingContext) : 0x2::object::ID {
        arg0.market_id
    }

    public(friend) fun new_margin_trading_context(arg0: 0x1::string::String, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: &0x2::tx_context::TxContext) : MarginTradingContext {
        MarginTradingContext{
            trace_id        : arg0,
            market_id       : arg1,
            position_cap_id : arg2,
            position_id     : arg3,
            action          : arg4,
            sender          : 0x2::tx_context::sender(arg5),
        }
    }

    public fun position_cap_id(arg0: &MarginTradingContext) : 0x2::object::ID {
        arg0.position_cap_id
    }

    public fun position_id(arg0: &MarginTradingContext) : 0x2::object::ID {
        arg0.position_id
    }

    public fun trace_id(arg0: &MarginTradingContext) : 0x1::string::String {
        arg0.trace_id
    }

    // decompiled from Move bytecode v6
}

