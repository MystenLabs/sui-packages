module 0xed17794898ba8a08286efafbf0594ed63a2c1ffb29069586b33c7725d7f102b0::ticket {
    struct Ticket has store, key {
        id: 0x2::object::UID,
        raffle_id: 0x2::object::ID,
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext, arg1: 0x2::object::ID) : Ticket {
        Ticket{
            id        : 0x2::object::new(arg0),
            raffle_id : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

