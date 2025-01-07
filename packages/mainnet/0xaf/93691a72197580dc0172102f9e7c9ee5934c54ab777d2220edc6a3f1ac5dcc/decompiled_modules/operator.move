module 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::operator {
    struct OperatorCap has key {
        id: 0x2::object::UID,
    }

    public entry fun create_round<T0>(arg0: &OperatorCap, arg1: &mut 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::state::State, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: bool, arg11: &mut 0x2::tx_context::TxContext) {
        0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::state::add<0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::round::RoundKey<T0>, 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::round::RoundInfo<T0>>(arg1, 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::round::new_round_key<T0>(), 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::round::new<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11));
    }

    public entry fun distribute_ticket<T0>(arg0: &OperatorCap, arg1: &mut 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::state::State, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::ticket::new_ticket_key<T0>(arg2);
        if (0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::state::contain<0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::ticket::TicketKey<T0>, 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::ticket::Ticket<T0>>(arg1, v0)) {
            return
        };
        0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::state::add<0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::ticket::TicketKey<T0>, 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::ticket::Ticket<T0>>(arg1, v0, 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::ticket::new<T0>(arg3));
    }

    public entry fun distribute_tickets<T0>(arg0: &OperatorCap, arg1: &mut 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::state::State, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::ticket::new_ticket_key<T0>(*0x1::vector::borrow<address>(&arg2, v0));
            if (!0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::state::contain<0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::ticket::TicketKey<T0>, 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::ticket::Ticket<T0>>(arg1, v1)) {
                0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::state::add<0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::ticket::TicketKey<T0>, 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::ticket::Ticket<T0>>(arg1, v1, 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::ticket::new<T0>(arg3));
            };
            v0 = v0 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::state::new(arg0);
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OperatorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun set_admin(arg0: &OperatorCap, arg1: &mut 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::state::State, arg2: address) {
        0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::state::set_admin(arg1, arg2);
    }

    public entry fun update_round<T0>(arg0: &OperatorCap, arg1: &mut 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::state::State, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::round::update<T0>(0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::state::borrow_mut<0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::round::RoundKey<T0>, 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::round::RoundInfo<T0>>(arg1, 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::round::new_round_key<T0>()), arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    // decompiled from Move bytecode v6
}

