module 0xa83270b705705a7e75244afdfab80818ca0e36230a7676f373da8fc1692f076::hello {
    struct InteractionEvent has copy, drop {
        user: address,
        message: 0x1::ascii::String,
    }

    public entry fun trigger_interaction(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InteractionEvent{
            user    : 0x2::tx_context::sender(arg0),
            message : 0x1::ascii::string(b"Success! Contract Interaction Registered."),
        };
        0x2::event::emit<InteractionEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

