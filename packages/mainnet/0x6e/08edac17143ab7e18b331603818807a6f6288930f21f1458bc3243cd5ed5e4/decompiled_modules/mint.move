module 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::mint {
    struct MintEvent has copy, drop {
        name: 0x1::string::String,
        round: 0x2::object::ID,
        quantity: u64,
        mint_slots: vector<u64>,
        user_address: address,
        ref: 0x1::string::String,
    }

    public entry fun mint<T0>(arg0: &mut 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::state::State, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::round::new_round_key<T0>();
        let v4 = 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::state::borrow<0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::round::RoundKey<T0>, 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::round::RoundInfo<T0>>(arg0, v3);
        if (!0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::round::is_public<T0>(v4)) {
            assert!(0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::state::contain<0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::ticket::TicketKey<T0>, 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::ticket::Ticket<T0>>(arg0, 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::ticket::new_ticket_key<T0>(v1)), 102);
        };
        assert!(v0 >= 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::round::get_start_timestamp<T0>(v4) && v0 < 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::round::get_end_timestamp<T0>(v4), 103);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::round::get_price<T0>(v4) * arg1, 100);
        assert!(0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::round::get_total_minted<T0>(v4) + arg1 <= 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::round::get_allocation<T0>(v4), 104);
        let v5 = 0x2::object::id<0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::round::RoundInfo<T0>>(v4);
        let v6 = 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::round::get_limit_per_wallet<T0>(v4);
        0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::state::transfer_fee(arg0, arg2);
        let v7 = 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::state::borrow_mut<0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::round::RoundKey<T0>, 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::round::RoundInfo<T0>>(arg0, v3);
        let v8 = 0;
        while (v8 < arg1) {
            let v9 = get_next_slot<T0>(v7);
            0x1::vector::push_back<u64>(&mut v2, v9);
            0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::atlansui_box::new(v9, arg5);
            0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::round::increase_total_minted<T0>(v7);
            v8 = v8 + 1;
        };
        let v10 = 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::box::new_box_key<T0>(v1);
        if (!0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::state::contain<0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::box::BoxKey<T0>, 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::box::Box<T0>>(arg0, v10)) {
            0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::state::add<0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::box::BoxKey<T0>, 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::box::Box<T0>>(arg0, v10, 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::box::new<T0>(arg5));
        };
        let v11 = 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::state::borrow_mut<0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::box::BoxKey<T0>, 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::box::Box<T0>>(arg0, v10);
        assert!(0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::box::get_total_slot<T0>(v11) + arg1 <= v6, 101);
        0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::box::add_slots<T0>(v11, v2);
        let v12 = MintEvent{
            name         : 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::round::get_name<T0>(v4),
            round        : v5,
            quantity     : arg1,
            mint_slots   : v2,
            user_address : v1,
            ref          : arg4,
        };
        0x2::event::emit<MintEvent>(v12);
    }

    fun get_next_slot<T0>(arg0: &0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::round::RoundInfo<T0>) : u64 {
        0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::round::get_start_mint_slot<T0>(arg0) + 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::round::get_total_minted<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}

