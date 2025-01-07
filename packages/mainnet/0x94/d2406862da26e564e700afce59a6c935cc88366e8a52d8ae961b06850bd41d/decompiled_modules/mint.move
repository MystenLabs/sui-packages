module 0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::mint {
    struct MintEvent has copy, drop {
        name: 0x1::string::String,
        round: 0x2::object::ID,
        quantity: u64,
        mint_slots: vector<u64>,
        user_address: address,
    }

    public entry fun mint<T0>(arg0: &mut 0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::state::State, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::round::new_round_key<T0>();
        let v4 = 0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::state::borrow<0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::round::RoundKey<T0>, 0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::round::RoundInfo<T0>>(arg0, v3);
        if (!0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::round::is_public<T0>(v4)) {
            assert!(0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::state::contain<0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::ticket::TicketKey<T0>, 0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::ticket::Ticket<T0>>(arg0, 0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::ticket::new_ticket_key<T0>(v1)), 102);
        };
        assert!(v0 >= 0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::round::get_start_timestamp<T0>(v4) && v0 < 0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::round::get_end_timestamp<T0>(v4), 103);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == 0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::round::get_price<T0>(v4) * arg1, 100);
        assert!(0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::round::get_total_minted<T0>(v4) + arg1 <= 0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::round::get_allocation<T0>(v4), 104);
        let v5 = 0x2::object::id<0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::round::RoundInfo<T0>>(v4);
        let v6 = 0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::round::get_limit_per_wallet<T0>(v4);
        0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::state::transfer_fee(arg0, arg2);
        let v7 = 0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::state::borrow_mut<0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::round::RoundKey<T0>, 0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::round::RoundInfo<T0>>(arg0, v3);
        let v8 = 0;
        while (v8 < arg1) {
            let v9 = get_next_slot<T0>(v7);
            0x1::vector::push_back<u64>(&mut v2, v9);
            0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::atlansui_box::new(v9, arg4);
            0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::round::increase_total_minted<T0>(v7);
            v8 = v8 + 1;
        };
        let v10 = 0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::box::new_box_key<T0>(v1);
        if (!0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::state::contain<0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::box::BoxKey<T0>, 0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::box::Box<T0>>(arg0, v10)) {
            0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::state::add<0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::box::BoxKey<T0>, 0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::box::Box<T0>>(arg0, v10, 0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::box::new<T0>(arg4));
        };
        let v11 = 0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::state::borrow_mut<0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::box::BoxKey<T0>, 0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::box::Box<T0>>(arg0, v10);
        assert!(0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::box::get_total_slot<T0>(v11) + arg1 <= v6, 101);
        0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::box::add_slots<T0>(v11, v2);
        let v12 = MintEvent{
            name         : 0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::round::get_name<T0>(v4),
            round        : v5,
            quantity     : arg1,
            mint_slots   : v2,
            user_address : v1,
        };
        0x2::event::emit<MintEvent>(v12);
    }

    fun get_next_slot<T0>(arg0: &0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::round::RoundInfo<T0>) : u64 {
        0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::round::get_start_mint_slot<T0>(arg0) + 0x94d2406862da26e564e700afce59a6c935cc88366e8a52d8ae961b06850bd41d::round::get_total_minted<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}

