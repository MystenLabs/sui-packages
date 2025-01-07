module 0xdffabcc0ad51a5954f7a99b07937192cd2b0d392d6c19d12bd069332fb365430::ticket {
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

