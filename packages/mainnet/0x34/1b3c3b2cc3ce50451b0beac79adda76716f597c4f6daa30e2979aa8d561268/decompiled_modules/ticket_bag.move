module 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::ticket_bag {
    struct TicketBag has store, key {
        id: 0x2::object::UID,
    }

    struct RaffleEnvelope has store {
        raffle_id: 0x2::object::ID,
        tickets: 0x2::table_vec::TableVec<0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::ticket::Ticket>,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : TicketBag {
        TicketBag{id: 0x2::object::new(arg0)}
    }

    public(friend) fun add_ticket(arg0: &mut TicketBag, arg1: 0x2::object::ID, arg2: 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::ticket::Ticket, arg3: &mut 0x2::tx_context::TxContext) {
        if (!has_envelope(arg0, arg1)) {
            let v0 = RaffleEnvelope{
                raffle_id : arg1,
                tickets   : 0x2::table_vec::empty<0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::ticket::Ticket>(arg3),
            };
            0x2::dynamic_field::add<0x2::object::ID, RaffleEnvelope>(&mut arg0.id, arg1, v0);
        };
        0x2::table_vec::push_back<0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::ticket::Ticket>(&mut envelope_mut(arg0, arg1).tickets, arg2);
    }

    public fun envelope(arg0: &TicketBag, arg1: 0x2::object::ID) : &RaffleEnvelope {
        0x2::dynamic_field::borrow<0x2::object::ID, RaffleEnvelope>(&arg0.id, arg1)
    }

    fun envelope_mut(arg0: &mut TicketBag, arg1: 0x2::object::ID) : &mut RaffleEnvelope {
        0x2::dynamic_field::borrow_mut<0x2::object::ID, RaffleEnvelope>(&mut arg0.id, arg1)
    }

    public fun has_envelope(arg0: &TicketBag, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_field::exists_with_type<0x2::object::ID, RaffleEnvelope>(&arg0.id, arg1)
    }

    public entry fun init_ticket_bag(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = new(arg0);
        0x2::transfer::public_transfer<TicketBag>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun tickets(arg0: &RaffleEnvelope) : &0x2::table_vec::TableVec<0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::ticket::Ticket> {
        &arg0.tickets
    }

    // decompiled from Move bytecode v6
}

