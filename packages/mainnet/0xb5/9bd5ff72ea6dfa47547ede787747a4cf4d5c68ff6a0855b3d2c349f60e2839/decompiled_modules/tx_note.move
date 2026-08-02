module 0xb59bd5ff72ea6dfa47547ede787747a4cf4d5c68ff6a0855b3d2c349f60e2839::tx_note {
    struct TxNote has copy, drop {
        note: 0x1::string::String,
        sender: address,
    }

    public fun emit_note(arg0: 0x1::string::String, arg1: &0x2::tx_context::TxContext) {
        let v0 = TxNote{
            note   : arg0,
            sender : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<TxNote>(v0);
    }

    // decompiled from Move bytecode v7
}

