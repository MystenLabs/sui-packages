module 0x73d5aec7241d08ee48e2401a65f60f4e66949202dec58290373798fe9167c25b::ticket {
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

