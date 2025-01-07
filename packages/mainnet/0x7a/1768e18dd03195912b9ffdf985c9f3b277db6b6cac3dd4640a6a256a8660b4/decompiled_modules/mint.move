module 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::mint {
    public entry fun mint<T0>(arg0: &0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::Version, arg1: &mut 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::custodian::Custodian, arg2: &mut 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::state::State, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::assert_current_version(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::new_round_key<T0>();
        let v4 = 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::state::borrow<0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::RoundKey<T0>, 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::RoundInfo<T0>>(arg2, v3);
        if (!0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::is_public<T0>(v4)) {
            assert!(0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::state::contain<0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::ticket::TicketKey<T0>, 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::ticket::Ticket<T0>>(arg2, 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::ticket::new_ticket_key<T0>(v1)), 102);
        };
        assert!(v0 >= 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::get_start_timestamp<T0>(v4) && v0 < 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::get_end_timestamp<T0>(v4), 103);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::get_price<T0>(v4) * arg3, 100);
        assert!(0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::get_total_minted<T0>(v4) + arg3 <= 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::get_allocation<T0>(v4), 104);
        let v5 = 0;
        let v6 = 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::state::borrow_mut<0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::RoundKey<T0>, 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::RoundInfo<T0>>(arg2, v3);
        loop {
            if (v5 >= arg3) {
                break
            };
            0x1::vector::push_back<u64>(&mut v2, get_next_slot<T0>(v6));
            0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::increase_total_minted<T0>(v6);
            v5 = v5 + 1;
        };
        let v7 = 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::box::new_box_key<T0>(v1);
        if (!0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::state::contain<0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::box::BoxKey<T0>, 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::box::Box<T0>>(arg2, v7)) {
            0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::state::add<0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::box::BoxKey<T0>, 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::box::Box<T0>>(arg2, v7, 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::box::new<T0>(arg6));
        };
        let v8 = 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::state::borrow_mut<0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::box::BoxKey<T0>, 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::box::Box<T0>>(arg2, v7);
        assert!(0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::box::get_total_slot<T0>(v8) + arg3 <= 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::get_limit_per_wallet<T0>(0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::state::borrow<0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::RoundKey<T0>, 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::RoundInfo<T0>>(arg2, v3)), 101);
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::box::add_slots<T0>(v8, v2);
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::custodian::add_treasury_balance(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg4));
    }

    public entry fun claim<T0>(arg0: &0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::Version, arg1: &0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::configuration::Configuration, arg2: &mut 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::custodian::Custodian, arg3: &mut 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::state::State, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::assert_current_version(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v0 >= 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::configuration::get_start_claim_timestamp(arg1) && v0 <= 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::configuration::get_end_claim_timestamp(arg1), 104);
        let v2 = 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::box::new_box_key<T0>(v1);
        assert!(0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::state::contain<0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::box::BoxKey<T0>, 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::box::Box<T0>>(arg3, v2), 105);
        let v3 = 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::state::borrow_mut<0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::box::BoxKey<T0>, 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::box::Box<T0>>(arg3, v2);
        assert!(!0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::box::is_claimed<T0>(v3), 106);
        let v4 = 0;
        loop {
            if (v4 >= 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::box::get_total_slot<T0>(v3)) {
                break
            };
            0x2::transfer::public_transfer<0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::pandorian::Pandorian>(0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::custodian::get_nft(arg2, 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::box::get_slots<T0>(v3, v4)), v1);
            v4 = v4 + 1;
        };
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::box::update_claim<T0>(v3);
    }

    fun get_next_slot<T0>(arg0: &0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::RoundInfo<T0>) : u64 {
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::get_start_mint_slot<T0>(arg0) + 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::get_total_minted<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}

