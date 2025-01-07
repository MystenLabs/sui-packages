module 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::mint {
    struct MintEvent has copy, drop {
        name: 0x1::string::String,
        round: 0x2::object::ID,
        quantity: u64,
        price: u64,
        mint_slots: vector<u64>,
        user_address: address,
        ref: 0x1::string::String,
    }

    public entry fun mint<T0>(arg0: &mut 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::state::State, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::round::new_round_key<T0>();
        let v4 = 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::state::borrow<0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::round::RoundKey<T0>, 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::round::RoundInfo<T0>>(arg0, v3);
        if (!0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::round::is_public<T0>(v4)) {
            assert!(0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::state::contain<0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::ticket::TicketKey<T0>, 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::ticket::Ticket<T0>>(arg0, 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::ticket::new_ticket_key<T0>(v1)), 102);
        };
        assert!(v0 >= 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::round::get_start_timestamp<T0>(v4) && v0 < 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::round::get_end_timestamp<T0>(v4), 103);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::round::get_price<T0>(v4) * arg1, 100);
        assert!(0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::round::get_total_minted<T0>(v4) + arg1 <= 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::round::get_allocation<T0>(v4), 104);
        let v5 = 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::round::get_limit_per_wallet<T0>(v4);
        let v6 = 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::round::get_limit_per_tx<T0>(v4);
        let v7 = 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::round::get_price<T0>(v4);
        if (v6 > 0) {
            assert!(arg1 <= v6, 110);
        };
        0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::state::transfer_fee(arg0, arg2);
        let v8 = 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::state::borrow_mut<0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::round::RoundKey<T0>, 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::round::RoundInfo<T0>>(arg0, v3);
        let v9 = 0;
        while (v9 < arg1) {
            let v10 = get_next_slot<T0>(v8);
            0x1::vector::push_back<u64>(&mut v2, v10);
            0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::atlansui_lab::new(v10, arg5);
            0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::round::increase_total_minted<T0>(v8);
            v9 = v9 + 1;
        };
        let v11 = 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::box::new_box_key<T0>(v1);
        if (!0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::state::contain<0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::box::BoxKey<T0>, 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::box::Box<T0>>(arg0, v11)) {
            0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::state::add<0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::box::BoxKey<T0>, 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::box::Box<T0>>(arg0, v11, 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::box::new<T0>(arg5));
        };
        let v12 = 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::state::borrow_mut<0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::box::BoxKey<T0>, 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::box::Box<T0>>(arg0, v11);
        if (v5 > 0) {
            assert!(0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::box::get_total_slot<T0>(v12) + arg1 <= v5, 101);
        };
        0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::box::add_slots<T0>(v12, v2);
        let v13 = MintEvent{
            name         : 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::round::get_name<T0>(v4),
            round        : 0x2::object::id<0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::round::RoundInfo<T0>>(v4),
            quantity     : arg1,
            price        : v7,
            mint_slots   : v2,
            user_address : v1,
            ref          : arg4,
        };
        0x2::event::emit<MintEvent>(v13);
    }

    fun get_next_slot<T0>(arg0: &0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::round::RoundInfo<T0>) : u64 {
        0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::round::get_start_mint_slot<T0>(arg0) + 0xaf93691a72197580dc0172102f9e7c9ee5934c54ab777d2220edc6a3f1ac5dcc::round::get_total_minted<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}

