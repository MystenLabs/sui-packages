module 0x85d566469771c45d0d687c6b3c81f2e5f154eb96736bd6a639d32ddd69755ad2::tools {
    struct ScallopToolsEvent has copy, drop {
        sender: address,
        timestamp: u64,
    }

    public fun emit_tools_event(arg0: &0x2::clock::Clock, arg1: &0x2::tx_context::TxContext) {
        let v0 = ScallopToolsEvent{
            sender    : 0x2::tx_context::sender(arg1),
            timestamp : 0x2::clock::timestamp_ms(arg0) / 1000,
        };
        0x2::event::emit<ScallopToolsEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

