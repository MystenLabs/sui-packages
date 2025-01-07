module 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::mint {
    struct MintEvent has copy, drop {
        name: 0x1::string::String,
        round: 0x2::object::ID,
        quantity: u64,
        mint_slots: vector<u64>,
        user_address: address,
    }

    struct ClaimEvent has copy, drop {
        name: 0x1::string::String,
        round: 0x2::object::ID,
        kiosk: 0x2::object::ID,
        claimed_nfts: vector<0x2::object::ID>,
        user_address: address,
    }

    public entry fun mint<T0>(arg0: &0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::version::Version, arg1: &mut 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::custodian::Custodian, arg2: &mut 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::state::State, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::version::assert_current_version(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        let v4 = 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::new_round_key<T0>();
        let v5 = 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::state::borrow<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::RoundKey<T0>, 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::RoundInfo<T0>>(arg2, v4);
        if (!0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::is_public<T0>(v5)) {
            assert!(0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::state::contain<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::ticket::TicketKey<T0>, 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::ticket::Ticket<T0>>(arg2, 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::ticket::new_ticket_key<T0>(v1)), 102);
        };
        assert!(v0 >= 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::get_start_timestamp<T0>(v5) && v0 < 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::get_end_timestamp<T0>(v5), 103);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::get_price<T0>(v5) * arg3, 100);
        assert!(0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::get_total_minted<T0>(v5) + arg3 <= 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::get_allocation<T0>(v5), 104);
        let v6 = 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::state::borrow<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::RoundKey<T0>, 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::RoundInfo<T0>>(arg2, v4);
        let v7 = 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::get_name<T0>(v6);
        let v8 = 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::get_limit_per_wallet<T0>(v6);
        let v9 = 0;
        let v10 = 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::state::borrow_mut<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::RoundKey<T0>, 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::RoundInfo<T0>>(arg2, v4);
        loop {
            if (v9 >= arg3) {
                break
            };
            let v11 = get_next_slot<T0>(v10);
            0x1::vector::push_back<u64>(&mut v2, v11);
            0x1::vector::push_back<0x2::object::ID>(&mut v3, 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::pandorian_box::new(v11, arg6));
            0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::increase_total_minted<T0>(v10);
            v9 = v9 + 1;
        };
        let v12 = 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::box::new_box_key<T0>(v1);
        if (!0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::state::contain<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::box::BoxKey<T0>, 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::box::Box<T0>>(arg2, v12)) {
            0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::state::add<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::box::BoxKey<T0>, 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::box::Box<T0>>(arg2, v12, 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::box::new<T0>(arg6));
        };
        let v13 = 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::state::borrow_mut<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::box::BoxKey<T0>, 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::box::Box<T0>>(arg2, v12);
        assert!(0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::box::get_total_slot<T0>(v13) + arg3 <= v8, 101);
        0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::box::add_slots<T0>(v13, v2);
        0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::box::add_pandorian_boxs<T0>(v13, v3);
        0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::custodian::add_treasury_balance(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg4));
        let v14 = MintEvent{
            name         : v7,
            round        : 0x2::object::id<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::RoundInfo<T0>>(v6),
            quantity     : arg3,
            mint_slots   : v2,
            user_address : v1,
        };
        0x2::event::emit<MintEvent>(v14);
    }

    fun claim<T0>(arg0: &0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::configuration::Configuration, arg1: &mut 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::custodian::Custodian, arg2: &mut 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::state::State, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::pandorian::Pandorian>, arg6: vector<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::pandorian_box::PandorianBox>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(arg7 >= 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::configuration::get_start_claim_timestamp(arg0) && arg7 <= 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::configuration::get_end_claim_timestamp(arg0), 104);
        let v1 = 0x1::vector::length<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::pandorian_box::PandorianBox>(&arg6);
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0;
        while (v3 < v1) {
            0x1::vector::push_back<0x2::object::ID>(&mut v2, 0x2::object::id<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::pandorian_box::PandorianBox>(0x1::vector::borrow<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::pandorian_box::PandorianBox>(&arg6, v3)));
            v3 = v3 + 1;
        };
        let v4 = 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::box::new_box_key<T0>(v0);
        assert!(0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::state::contain<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::box::BoxKey<T0>, 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::box::Box<T0>>(arg2, v4), 105);
        let v5 = 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::state::borrow_mut<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::box::BoxKey<T0>, 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::box::Box<T0>>(arg2, v4);
        assert!(0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::box::is_matched_pandorian_box_ids<T0>(v5, v2), 108);
        assert!(!0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::box::is_claimed<T0>(v5), 106);
        let v6 = 0x1::vector::empty<0x2::object::ID>();
        v3 = 0;
        while (v3 < v1) {
            let v7 = 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::custodian::get_nft(arg1, 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::box::get_slots<T0>(v5, v3));
            0x1::vector::push_back<0x2::object::ID>(&mut v6, 0x2::object::id<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::pandorian::Pandorian>(&v7));
            0x2::kiosk::lock<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::pandorian::Pandorian>(arg3, arg4, arg5, v7);
            0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::pandorian_box::burn(0x1::vector::pop_back<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::pandorian_box::PandorianBox>(&mut arg6));
            v3 = v3 + 1;
        };
        0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::box::update_claim<T0>(v5);
        0x1::vector::destroy_empty<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::pandorian_box::PandorianBox>(arg6);
        let v8 = 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::state::borrow<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::RoundKey<T0>, 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::RoundInfo<T0>>(arg2, 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::new_round_key<T0>());
        let v9 = ClaimEvent{
            name         : 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::get_name<T0>(v8),
            round        : 0x2::object::id<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::RoundInfo<T0>>(v8),
            kiosk        : 0x2::object::id<0x2::kiosk::Kiosk>(arg3),
            claimed_nfts : v6,
            user_address : v0,
        };
        0x2::event::emit<ClaimEvent>(v9);
    }

    public entry fun claim_and_create_kiosk<T0>(arg0: &0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::version::Version, arg1: &0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::configuration::Configuration, arg2: &mut 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::custodian::Custodian, arg3: &mut 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::state::State, arg4: &0x2::transfer_policy::TransferPolicy<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::pandorian::Pandorian>, arg5: vector<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::pandorian_box::PandorianBox>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::version::assert_current_version(arg0);
        let (v0, v1) = 0x2::kiosk::new(arg7);
        let v2 = v0;
        let v3 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v2, v1, arg7);
        let v4 = &mut v2;
        claim<T0>(arg1, arg2, arg3, v4, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(&v3), arg4, arg5, 0x2::clock::timestamp_ms(arg6), arg7);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(v3, arg7);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    public entry fun claim_to_kiosk<T0>(arg0: &0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::version::Version, arg1: &0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::configuration::Configuration, arg2: &mut 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::custodian::Custodian, arg3: &mut 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::state::State, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg6: &0x2::transfer_policy::TransferPolicy<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::pandorian::Pandorian>, arg7: vector<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::pandorian_box::PandorianBox>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::version::assert_current_version(arg0);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::is_personal(arg4), 107);
        claim<T0>(arg1, arg2, arg3, arg4, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg5), arg6, arg7, 0x2::clock::timestamp_ms(arg8), arg9);
    }

    fun get_next_slot<T0>(arg0: &0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::RoundInfo<T0>) : u64 {
        0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::get_start_mint_slot<T0>(arg0) + 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::get_total_minted<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}

