module 0x9e26f8abebf948f6d585d1abed8d91e122365e67a66427f20f782ac8b35f6e37::tools {
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

