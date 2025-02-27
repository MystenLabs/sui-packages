module 0x778bba9a91461de3f3b0a072ec4cb935beb8738b10f5654ee8809411cff8beca::tools {
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

