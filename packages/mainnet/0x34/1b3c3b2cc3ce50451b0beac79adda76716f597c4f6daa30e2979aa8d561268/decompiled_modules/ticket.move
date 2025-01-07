module 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::ticket {
    struct Ticket has store, key {
        id: 0x2::object::UID,
        raffle_id: 0x2::object::ID,
        ticket_number: u64,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Ticket {
        Ticket{
            id            : 0x2::object::new(arg2),
            raffle_id     : arg0,
            ticket_number : arg1,
        }
    }

    public fun raffle_id(arg0: &Ticket) : 0x2::object::ID {
        arg0.raffle_id
    }

    public fun ticket_number(arg0: &Ticket) : u64 {
        arg0.ticket_number
    }

    // decompiled from Move bytecode v6
}

