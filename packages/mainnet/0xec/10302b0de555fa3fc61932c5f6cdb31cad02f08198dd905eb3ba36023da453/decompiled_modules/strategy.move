module 0xec10302b0de555fa3fc61932c5f6cdb31cad02f08198dd905eb3ba36023da453::strategy {
    struct Strategy has store, key {
        id: 0x2::object::UID,
        encoded: vector<u8>,
        timestamp_ms: u64,
    }

    struct StrategyOpenedEvent has copy, drop {
        sender: address,
        strategy_id: 0x2::object::ID,
        encoded: vector<u8>,
    }

    struct StrategyClosedEvent has copy, drop {
        sender: address,
        strategy_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    public fun delete(arg0: Strategy, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let Strategy {
            id           : v0,
            encoded      : _,
            timestamp_ms : _,
        } = arg0;
        0x2::object::delete(v0);
        let v3 = StrategyClosedEvent{
            sender       : 0x2::tx_context::sender(arg2),
            strategy_id  : 0x2::object::id<Strategy>(&arg0),
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<StrategyClosedEvent>(v3);
    }

    public fun new(arg0: vector<u8>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : Strategy {
        let v0 = Strategy{
            id           : 0x2::object::new(arg2),
            encoded      : arg0,
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        let v1 = StrategyOpenedEvent{
            sender      : 0x2::tx_context::sender(arg2),
            strategy_id : 0x2::object::id<Strategy>(&v0),
            encoded     : arg0,
        };
        0x2::event::emit<StrategyOpenedEvent>(v1);
        v0
    }

    public fun get_encoded(arg0: &Strategy) : vector<u8> {
        arg0.encoded
    }

    public fun get_timestamp_ms(arg0: &Strategy) : u64 {
        arg0.timestamp_ms
    }

    // decompiled from Move bytecode v6
}

