module 0x3bb2a074ce90b437464b8705c5a4ad5321aed8fc102dd7809b27beb2118f94eb::hello {
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

