module 0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::operator {
    struct OperatorCap has key {
        id: 0x2::object::UID,
    }

    public entry fun create_round<T0>(arg0: &OperatorCap, arg1: &mut 0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::state::State, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: bool, arg11: &mut 0x2::tx_context::TxContext) {
        0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::state::add<0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::round::RoundKey<T0>, 0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::round::RoundInfo<T0>>(arg1, 0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::round::new_round_key<T0>(), 0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::round::new<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11));
    }

    public entry fun distribute_ticket<T0>(arg0: &OperatorCap, arg1: &mut 0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::state::State, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::ticket::new_ticket_key<T0>(arg2);
        if (0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::state::contain<0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::ticket::TicketKey<T0>, 0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::ticket::Ticket<T0>>(arg1, v0)) {
            return
        };
        0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::state::add<0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::ticket::TicketKey<T0>, 0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::ticket::Ticket<T0>>(arg1, v0, 0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::ticket::new<T0>(arg3));
    }

    public entry fun distribute_tickets<T0>(arg0: &OperatorCap, arg1: &mut 0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::state::State, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::ticket::new_ticket_key<T0>(*0x1::vector::borrow<address>(&arg2, v0));
            if (0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::state::contain<0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::ticket::TicketKey<T0>, 0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::ticket::Ticket<T0>>(arg1, v1)) {
                return
            };
            0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::state::add<0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::ticket::TicketKey<T0>, 0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::ticket::Ticket<T0>>(arg1, v1, 0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::ticket::new<T0>(arg3));
            v0 = v0 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::state::new(arg0);
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OperatorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun set_admin(arg0: &OperatorCap, arg1: &mut 0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::state::State, arg2: address) {
        0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::state::set_admin(arg1, arg2);
    }

    public entry fun update_round<T0>(arg0: &OperatorCap, arg1: &mut 0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::state::State, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::round::update<T0>(0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::state::borrow_mut<0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::round::RoundKey<T0>, 0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::round::RoundInfo<T0>>(arg1, 0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::round::new_round_key<T0>()), arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    // decompiled from Move bytecode v6
}

