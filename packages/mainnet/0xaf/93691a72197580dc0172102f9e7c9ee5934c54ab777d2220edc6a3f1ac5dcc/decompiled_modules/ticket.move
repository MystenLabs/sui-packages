module 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::ticket {
    struct TicketKey<phantom T0> has copy, drop, store {
        user_address: address,
    }

    struct Ticket<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) : Ticket<T0> {
        Ticket<T0>{id: 0x2::object::new(arg0)}
    }

    public(friend) fun new_ticket_key<T0>(arg0: address) : TicketKey<T0> {
        TicketKey<T0>{user_address: arg0}
    }

    // decompiled from Move bytecode v6
}

