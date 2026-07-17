module 0x1d206a072a54109ef50291034c6c8e347ff8a8e071b4b70bf20503408dd39cd::hello {
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

