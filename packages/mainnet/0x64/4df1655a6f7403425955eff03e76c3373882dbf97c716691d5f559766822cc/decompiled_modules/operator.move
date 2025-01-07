module 0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::operator {
    struct OperatorCap has key {
        id: 0x2::object::UID,
    }

    public entry fun create_round<T0>(arg0: &OperatorCap, arg1: &mut 0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::state::State, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: bool, arg11: &mut 0x2::tx_context::TxContext) {
        0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::state::add<0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::round::RoundKey<T0>, 0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::round::RoundInfo<T0>>(arg1, 0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::round::new_round_key<T0>(), 0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::round::new<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11));
    }

    public entry fun distribute_ticket<T0>(arg0: &OperatorCap, arg1: &mut 0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::state::State, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::ticket::new_ticket_key<T0>(arg2);
        if (0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::state::contain<0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::ticket::TicketKey<T0>, 0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::ticket::Ticket<T0>>(arg1, v0)) {
            return
        };
        0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::state::add<0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::ticket::TicketKey<T0>, 0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::ticket::Ticket<T0>>(arg1, v0, 0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::ticket::new<T0>(arg3));
    }

    public entry fun distribute_tickets<T0>(arg0: &OperatorCap, arg1: &mut 0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::state::State, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::ticket::new_ticket_key<T0>(*0x1::vector::borrow<address>(&arg2, v0));
            if (0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::state::contain<0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::ticket::TicketKey<T0>, 0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::ticket::Ticket<T0>>(arg1, v1)) {
                return
            };
            0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::state::add<0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::ticket::TicketKey<T0>, 0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::ticket::Ticket<T0>>(arg1, v1, 0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::ticket::new<T0>(arg3));
            v0 = v0 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::state::new(arg0);
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OperatorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun set_admin(arg0: &OperatorCap, arg1: &mut 0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::state::State, arg2: address) {
        0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::state::set_admin(arg1, arg2);
    }

    public entry fun update_round<T0>(arg0: &OperatorCap, arg1: &mut 0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::state::State, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::round::update<T0>(0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::state::borrow_mut<0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::round::RoundKey<T0>, 0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::round::RoundInfo<T0>>(arg1, 0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::round::new_round_key<T0>()), arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    // decompiled from Move bytecode v6
}

