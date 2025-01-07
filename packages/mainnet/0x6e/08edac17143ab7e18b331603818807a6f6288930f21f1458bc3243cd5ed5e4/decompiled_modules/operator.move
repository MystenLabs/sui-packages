module 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::operator {
    struct OperatorCap has key {
        id: 0x2::object::UID,
    }

    public entry fun create_round<T0>(arg0: &OperatorCap, arg1: &mut 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::state::State, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::state::add<0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::round::RoundKey<T0>, 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::round::RoundInfo<T0>>(arg1, 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::round::new_round_key<T0>(), 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::round::new<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10));
    }

    public entry fun distribute_ticket<T0>(arg0: &OperatorCap, arg1: &mut 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::state::State, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::ticket::new_ticket_key<T0>(arg2);
        if (0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::state::contain<0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::ticket::TicketKey<T0>, 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::ticket::Ticket<T0>>(arg1, v0)) {
            return
        };
        0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::state::add<0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::ticket::TicketKey<T0>, 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::ticket::Ticket<T0>>(arg1, v0, 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::ticket::new<T0>(arg3));
    }

    public entry fun distribute_tickets<T0>(arg0: &OperatorCap, arg1: &mut 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::state::State, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::ticket::new_ticket_key<T0>(*0x1::vector::borrow<address>(&arg2, v0));
            if (0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::state::contain<0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::ticket::TicketKey<T0>, 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::ticket::Ticket<T0>>(arg1, v1)) {
                return
            };
            0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::state::add<0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::ticket::TicketKey<T0>, 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::ticket::Ticket<T0>>(arg1, v1, 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::ticket::new<T0>(arg3));
            v0 = v0 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::state::new(arg0);
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OperatorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun set_admin(arg0: &OperatorCap, arg1: &mut 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::state::State, arg2: address) {
        0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::state::set_admin(arg1, arg2);
    }

    public entry fun update_round<T0>(arg0: &OperatorCap, arg1: &mut 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::state::State, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::round::update<T0>(0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::state::borrow_mut<0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::round::RoundKey<T0>, 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::round::RoundInfo<T0>>(arg1, 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::round::new_round_key<T0>()), arg2, arg3, arg4, arg5, arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

