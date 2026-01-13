module 0x76e4320f0df1ba0964fe93bd8283df97011242fa6614f1906efc38d30d67adde::context {
    struct MarginTradingContext {
        trace_id: 0x1::string::String,
        market_id: 0x2::object::ID,
        position_cap_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        action: 0x1::string::String,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        sender: address,
        operation_executed: bool,
    }

    struct MarginTradingConfirmEvent has copy, drop {
        trace_id: 0x1::string::String,
        market_id: 0x2::object::ID,
        position_cap_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        action: 0x1::string::String,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        sender: address,
    }

    public fun sender(arg0: &MarginTradingContext) : address {
        arg0.sender
    }

    public fun action(arg0: &MarginTradingContext) : 0x1::string::String {
        arg0.action
    }

    public fun amount(arg0: &MarginTradingContext) : u64 {
        arg0.amount
    }

    fun bytes_to_hex_string(arg0: vector<u8>) : 0x1::string::String {
        let v0 = b"0123456789abcdef";
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::length<u8>(&arg0);
        let v3 = if (v2 > 16) {
            16
        } else {
            v2
        };
        let v4 = 0;
        while (v4 < v3) {
            let v5 = *0x1::vector::borrow<u8>(&arg0, v4);
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, ((v5 >> 4 & 15) as u64)));
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, ((v5 & 15) as u64)));
            v4 = v4 + 1;
        };
        0x1::string::utf8(v1)
    }

    public fun coin_type(arg0: &MarginTradingContext) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public(friend) fun destroy_margin_trading_context(arg0: MarginTradingContext) {
        let MarginTradingContext {
            trace_id           : _,
            market_id          : _,
            position_cap_id    : _,
            position_id        : _,
            action             : _,
            coin_type          : _,
            amount             : _,
            sender             : _,
            operation_executed : _,
        } = arg0;
    }

    public(friend) fun emit_margin_trading_confirm_event(arg0: &MarginTradingContext) {
        assert!(arg0.operation_executed, 0x76e4320f0df1ba0964fe93bd8283df97011242fa6614f1906efc38d30d67adde::errors::err_invalid_action());
        let v0 = MarginTradingConfirmEvent{
            trace_id        : trace_id(arg0),
            market_id       : market_id(arg0),
            position_cap_id : position_cap_id(arg0),
            position_id     : position_id(arg0),
            action          : action(arg0),
            coin_type       : coin_type(arg0),
            amount          : amount(arg0),
            sender          : sender(arg0),
        };
        0x2::event::emit<MarginTradingConfirmEvent>(v0);
    }

    fun generate_trace_id(arg0: &mut 0x2::tx_context::TxContext) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x2::tx_context::sender(arg0);
        let v2 = 0x2::tx_context::epoch(arg0);
        let v3 = 0x2::tx_context::fresh_object_address(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&v3));
        bytes_to_hex_string(0x2::hash::blake2b256(&v0))
    }

    public(friend) fun mark_operation_executed(arg0: &mut MarginTradingContext) {
        arg0.operation_executed = true;
    }

    public fun market_id(arg0: &MarginTradingContext) : 0x2::object::ID {
        arg0.market_id
    }

    public(friend) fun new_margin_trading_context(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::type_name::TypeName, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : MarginTradingContext {
        let v0 = generate_trace_id(arg6);
        MarginTradingContext{
            trace_id           : v0,
            market_id          : arg0,
            position_cap_id    : arg1,
            position_id        : arg2,
            action             : arg3,
            coin_type          : arg4,
            amount             : arg5,
            sender             : 0x2::tx_context::sender(arg6),
            operation_executed : false,
        }
    }

    public fun operation_executed(arg0: &MarginTradingContext) : bool {
        arg0.operation_executed
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

