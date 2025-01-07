module 0x9ae247cde4a77d20affc099a17a48fc4bb38d0de68e1862486d6fc7e64262b6c::tools {
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

