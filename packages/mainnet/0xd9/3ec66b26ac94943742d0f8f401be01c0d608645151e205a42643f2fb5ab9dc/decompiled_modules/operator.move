module 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::operator {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun take_reward<T0: drop, T1: store + key, T2>(arg0: &mut 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::State, arg1: 0x2::object::ID, arg2: vector<u64>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg2)) {
            take_reward_internal<T0, T1, T2>(arg0, arg1, *0x1::vector::borrow<u64>(&arg2, v0), arg3, arg4, arg5);
            v0 = v0 + 1;
        };
    }

    public entry fun add_operator(arg0: &AdminCap, arg1: &mut 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::State, arg2: address) {
        0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::add_operator(arg1, arg2);
    }

    public fun assert_campaign_end<T0, T1, T2>(arg0: &mut 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::State, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) > 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::ended_at<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_campaign<T0, T1, T2>(arg0, arg1)), 7);
    }

    public fun assert_campaign_not_end<T0, T1, T2>(arg0: &mut 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::State, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) < 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::ended_at<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_campaign<T0, T1, T2>(arg0, arg1)), 6);
    }

    fun assert_offer_coin_amount<T0: drop, T1: store + key, T2>(arg0: &mut 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::State, arg1: 0x2::object::ID, arg2: &0x2::coin::Coin<T0>) {
        let v0 = 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::offered_coin_amount<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_campaign<T0, T1, T2>(arg0, arg1));
        assert!(v0 > 0 && 0x2::coin::value<T0>(arg2) == v0, 11);
    }

    fun assert_offer_nft_asset_amount<T0: drop, T1: store + key, T2>(arg0: &mut 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::State, arg1: 0x2::object::ID) {
        assert!(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::offered_coin_amount<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_campaign<T0, T1, T2>(arg0, arg1)) == 0, 11);
    }

    public fun assert_valid_offer<T0: drop, T1: store + key>(arg0: u64) {
        if (arg0 > 0) {
            let v0 = 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::comparator::compare_u8_vector(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())), 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::dummy_coin::DUMMY_COIN>())));
            let v1 = if (!0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::comparator::is_equal(&v0)) {
                let v2 = 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::comparator::compare_u8_vector(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())), 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::dummy_nft::DUMMY_NFT>())));
                0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::comparator::is_equal(&v2)
            } else {
                false
            };
            assert!(v1, 11);
        } else {
            let v3 = 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::comparator::compare_u8_vector(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())), 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::dummy_coin::DUMMY_COIN>())));
            let v4 = if (0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::comparator::is_equal(&v3)) {
                let v5 = 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::comparator::compare_u8_vector(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())), 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::dummy_nft::DUMMY_NFT>())));
                !0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::comparator::is_equal(&v5)
            } else {
                false
            };
            assert!(v4, 11);
        };
    }

    fun assert_valid_reward<T0: drop>(arg0: &0x2::coin::Coin<T0>, arg1: &vector<u64>, arg2: u8) {
        let v0 = 0x1::vector::length<u64>(arg1);
        let v1 = 0;
        assert!(v0 > 0 && v0 <= 200, 2);
        let v2 = 0;
        while (v1 < v0) {
            let v3 = *0x1::vector::borrow<u64>(arg1, v1);
            assert!(v3 > 0 && (arg2 == 1 || arg2 == 0 && v3 == 0x2::coin::value<T0>(arg0) / v0), 3);
            v2 = v2 + v3;
            v1 = v1 + 1;
        };
        assert!(v2 == 0x2::coin::value<T0>(arg0), 4);
    }

    public entry fun create_campaign<T0: drop, T1: store + key, T2: drop>(arg0: vector<u8>, arg1: u64, arg2: 0x2::coin::Coin<T2>, arg3: vector<u64>, arg4: u8, arg5: u64, arg6: &mut 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::State, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0x2::clock::timestamp_ms(arg7), 0);
        assert!(arg4 == 0 || arg4 == 1, 1);
        assert_valid_offer<T0, T1>(arg5);
        assert_valid_reward<T2>(&arg2, &arg3, arg4);
        0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::add_campaign<T0, T1, T2>(arg6, 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::new<T0, T1, T2>(0x1::string::utf8(arg0), arg1, arg5, 0x2::coin::into_balance<T2>(arg2), arg3, arg7, arg8));
    }

    public entry fun distribution<T0, T1, T2>(arg0: &mut 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::State, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_campaign_end<T0, T1, T2>(arg0, arg1, arg2);
        let v0 = 0x2::tx_context::sender(arg3);
        let (v1, _) = 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::find_operator(arg0, &v0);
        assert!(v1, 8);
        let v3 = *0x2::tx_context::digest(arg3);
        0x1::vector::append<u8>(&mut v3, 0x2::object::id_bytes<0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::State>(arg0));
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<0x2::object::ID>(&arg1));
        let v4 = 0x2::clock::timestamp_ms(arg2);
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<u64>(&v4));
        let v5 = 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::randomness::new(v3);
        let v6 = 0;
        let v7 = 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1);
        let v8 = 0x1::vector::empty<u64>();
        while (v6 < 0x2::math::min(0x1::vector::length<0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::reward::Reward<T2>>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_rewards<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_campaign<T0, T1, T2>(arg0, arg1))), 0x2::table::length<u64, 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::ticket::Ticket>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_tickets<T0, T1, T2>(v7)))) {
            let v9 = 0;
            while (v9 == 0 || 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::utils::exists_<u64>(&v8, &v9) || !0x2::table::contains<u64, 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::ticket::Ticket>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_tickets<T0, T1, T2>(v7), v9)) {
                v9 = (0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::randomness::next_u256_in_range(&mut v5, 1, (0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::current_ticket_id<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_campaign<T0, T1, T2>(arg0, arg1)) as u256) - 1) as u64);
            };
            0x1::vector::push_back<u64>(&mut v8, v9);
            0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::reward::set_winner<T2>(0x1::vector::borrow_mut<0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::reward::Reward<T2>>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_mut_rewards<T0, T1, T2>(v7), v6), v9);
            v6 = v6 + 1;
        };
        0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::set_distributed<T0, T1, T2>(v7);
    }

    public entry fun get_ticket_offer_coin<T0: drop, T1: store + key, T2>(arg0: &mut 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::State, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_campaign_not_end<T0, T1, T2>(arg0, arg1, arg3);
        assert_offer_coin_amount<T0, T1, T2>(arg0, arg1, &arg2);
        let v0 = 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::current_ticket_id<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_campaign<T0, T1, T2>(arg0, arg1));
        0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::increase_ticket_counter<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1));
        0x2::table::add<u64, 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::ticket::Ticket>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_mut_tickets<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), v0, 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::ticket::new(v0, 0x1::vector::singleton<0x2::object::ID>(0x2::object::id<0x2::coin::Coin<T0>>(&arg2)), 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::ticket::ticket_offered_by_coin()));
        let v1 = 0x2::tx_context::sender(arg4);
        0x2::table::add<u64, address>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_mut_owners<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), v0, v1);
        if (!0x2::table::contains<address, vector<u64>>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_owned_tickets<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_campaign<T0, T1, T2>(arg0, arg1)), v1)) {
            0x2::table::add<address, vector<u64>>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_mut_owned_tickets<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), v1, 0x1::vector::singleton<u64>(v0));
        } else {
            0x1::vector::push_back<u64>(0x2::table::borrow_mut<address, vector<u64>>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_mut_owned_tickets<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), v1), v0);
        };
        0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::custodian::hold<0x2::coin::Coin<T0>>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_mut_coin_custodian<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), arg2);
    }

    public entry fun get_ticket_offer_nft_asset<T0: drop, T1: store + key, T2>(arg0: &mut 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::State, arg1: 0x2::object::ID, arg2: T1, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_campaign_not_end<T0, T1, T2>(arg0, arg1, arg3);
        assert_offer_nft_asset_amount<T0, T1, T2>(arg0, arg1);
        let v0 = 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::current_ticket_id<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_campaign<T0, T1, T2>(arg0, arg1));
        0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::increase_ticket_counter<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1));
        0x2::table::add<u64, 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::ticket::Ticket>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_mut_tickets<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), v0, 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::ticket::new(v0, 0x1::vector::singleton<0x2::object::ID>(0x2::object::id<T1>(&arg2)), 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::ticket::ticket_offered_by_nft()));
        let v1 = 0x2::tx_context::sender(arg4);
        0x2::table::add<u64, address>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_mut_owners<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), v0, v1);
        if (!0x2::table::contains<address, vector<u64>>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_owned_tickets<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_campaign<T0, T1, T2>(arg0, arg1)), v1)) {
            0x2::table::add<address, vector<u64>>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_mut_owned_tickets<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), v1, 0x1::vector::singleton<u64>(v0));
        } else {
            0x1::vector::push_back<u64>(0x2::table::borrow_mut<address, vector<u64>>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_mut_owned_tickets<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), v1), v0);
        };
        0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::custodian::hold<T1>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_mut_nft_asset_custodian<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), arg2);
    }

    public entry fun get_ticket_offer_nft_asset_kiosk<T0: drop, T1: store + key, T2>(arg0: &mut 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::State, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_campaign_not_end<T0, T1, T2>(arg0, arg1, arg4);
        assert_offer_nft_asset_amount<T0, T1, T2>(arg0, arg1);
        let v0 = 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::current_ticket_id<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_campaign<T0, T1, T2>(arg0, arg1));
        0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::increase_ticket_counter<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1));
        0x2::table::add<u64, 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::ticket::Ticket>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_mut_tickets<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), v0, 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::ticket::new(v0, 0x1::vector::singleton<0x2::object::ID>(arg2), 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::ticket::ticket_offered_by_nft_kiosk()));
        let v1 = 0x2::tx_context::sender(arg5);
        0x2::table::add<u64, address>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_mut_owners<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), v0, v1);
        if (!0x2::table::contains<address, vector<u64>>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_owned_tickets<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_campaign<T0, T1, T2>(arg0, arg1)), v1)) {
            0x2::table::add<address, vector<u64>>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_mut_owned_tickets<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), v1, 0x1::vector::singleton<u64>(v0));
        } else {
            0x1::vector::push_back<u64>(0x2::table::borrow_mut<address, vector<u64>>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_mut_owned_tickets<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), v1), v0);
        };
        if (!0x2::table::contains<address, 0x2::kiosk::Kiosk>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_ob_kiosks<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_campaign<T0, T1, T2>(arg0, arg1)), 0x2::tx_context::sender(arg5))) {
            let (v2, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new(arg5);
            0x2::table::add<address, 0x2::kiosk::Kiosk>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_mut_ob_kiosks<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), 0x2::tx_context::sender(arg5), v2);
        };
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::transfer_between_owned<T1>(arg3, 0x2::table::borrow_mut<address, 0x2::kiosk::Kiosk>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_mut_ob_kiosks<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), 0x2::tx_context::sender(arg5)), arg2, arg5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let (v1, v2) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v1);
        0x2::transfer::public_freeze_object<0x2::kiosk::KioskOwnerCap>(v2);
    }

    public entry fun remove_kiosk<T0: drop, T1: store + key, T2>(arg0: &mut 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::State, arg1: 0x2::object::ID, arg2: 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::OwnerToken, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::kiosk::item_count(0x2::table::borrow<address, 0x2::kiosk::Kiosk>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_ob_kiosks<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_campaign<T0, T1, T2>(arg0, arg1)), v0)) == 0, 14);
        let v1 = 0x2::table::remove<address, 0x2::kiosk::Kiosk>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_mut_ob_kiosks<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), v0);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::uninstall_extension(&mut v1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::kiosk::Kiosk>(v1, v0);
    }

    public entry fun remove_operator(arg0: &AdminCap, arg1: &mut 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::State, arg2: address) {
        0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::remove_operator(arg1, arg2);
    }

    public entry fun setup(arg0: &AdminCap, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::State>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::new(arg1, arg2));
    }

    public entry fun stop_campaign<T0, T1, T2>(arg0: &AdminCap, arg1: &mut 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::State, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        assert_campaign_not_end<T0, T1, T2>(arg1, arg2, arg3);
        0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::set_ended_at<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg1, arg2), 0x2::clock::timestamp_ms(arg3));
    }

    fun take_reward_internal<T0: drop, T1: store + key, T2>(arg0: &mut 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::State, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg2 < 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::current_ticket_id<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_campaign<T0, T1, T2>(arg0, arg1)), 10);
        assert!(!0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::ticket::is_claimed(0x2::table::borrow<u64, 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::ticket::Ticket>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_tickets<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_campaign<T0, T1, T2>(arg0, arg1)), arg2)), 13);
        let (v0, v1) = 0x1::vector::index_of<u64>(0x2::table::borrow<address, vector<u64>>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_owned_tickets<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_campaign<T0, T1, T2>(arg0, arg1)), 0x2::tx_context::sender(arg5)), &arg2);
        assert!(v0, 12);
        let v2 = 0x2::tx_context::sender(arg5);
        if (0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::ticket::is_offered_by_coin(0x2::table::borrow<u64, 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::ticket::Ticket>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_tickets<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_campaign<T0, T1, T2>(arg0, arg1)), arg2))) {
            let v3 = 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::take_coin_assets<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1), arg2);
            while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&v3)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut v3), v2);
            };
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(v3);
        } else if (0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::ticket::is_offered_by_nft(0x2::table::borrow<u64, 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::ticket::Ticket>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_tickets<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_campaign<T0, T1, T2>(arg0, arg1)), arg2))) {
            let v4 = 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::take_nft_assets<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1), arg2);
            while (!0x1::vector::is_empty<T1>(&v4)) {
                0x2::transfer::public_transfer<T1>(0x1::vector::pop_back<T1>(&mut v4), v2);
            };
            0x1::vector::destroy_empty<T1>(v4);
        } else {
            0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::take_nft_assets_v2<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1), arg3, arg2, arg5);
        };
        let v5 = 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::take_reward<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1), arg2);
        if (0x1::option::is_some<0x2::balance::Balance<T2>>(&v5)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x1::option::destroy_some<0x2::balance::Balance<T2>>(v5), arg5), v2);
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<T2>>(v5);
        };
        if (0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::is_distributed<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_campaign<T0, T1, T2>(arg0, arg1))) {
            0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::ticket::set_claimed(0x2::table::borrow_mut<u64, 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::ticket::Ticket>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_mut_tickets<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), arg2));
        };
        if (!0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::is_ended<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_campaign<T0, T1, T2>(arg0, arg1), arg4)) {
            0x2::table::remove<u64, 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::ticket::Ticket>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_mut_tickets<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), arg2);
            0x2::table::remove<u64, address>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_mut_owners<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), arg2);
            0x1::vector::remove<u64>(0x2::table::borrow_mut<address, vector<u64>>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::borrow_mut_owned_tickets<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), v2), v1);
        };
    }

    public entry fun update_metadata<T0, T1, T2>(arg0: &AdminCap, arg1: &mut 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::State, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        assert_campaign_not_end<T0, T1, T2>(arg1, arg2, arg4);
        0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::set_metadata<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg1, arg2), 0x1::string::utf8(arg3));
    }

    public entry fun withdraw_reward<T0, T1, T2>(arg0: &AdminCap, arg1: &mut 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::State, arg2: 0x2::object::ID, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_campaign_end<T0, T1, T2>(arg1, arg2, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::campaign::withdraw_at<T0, T1, T2>(0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::state::borrow_mut_campaign<T0, T1, T2>(arg1, arg2), arg3), arg6), arg4);
    }

    // decompiled from Move bytecode v6
}

