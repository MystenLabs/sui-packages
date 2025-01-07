module 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::operator {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun take_reward<T0: drop, T1: store + key, T2>(arg0: &mut 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::State, arg1: 0x2::object::ID, arg2: vector<u64>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg2)) {
            take_reward_internal<T0, T1, T2>(arg0, arg1, *0x1::vector::borrow<u64>(&arg2, v0), arg3, arg4);
            v0 = v0 + 1;
        };
    }

    public entry fun add_operator(arg0: &AdminCap, arg1: &mut 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::State, arg2: address) {
        0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::add_operator(arg1, arg2);
    }

    public fun assert_campaign_end<T0, T1, T2>(arg0: &mut 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::State, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) > 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::ended_at<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_campaign<T0, T1, T2>(arg0, arg1)), 7);
    }

    public fun assert_campaign_not_end<T0, T1, T2>(arg0: &mut 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::State, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) < 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::ended_at<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_campaign<T0, T1, T2>(arg0, arg1)), 6);
    }

    fun assert_offer_coin_amount<T0: drop, T1: store + key, T2>(arg0: &mut 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::State, arg1: 0x2::object::ID, arg2: &0x2::coin::Coin<T0>) {
        let v0 = 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::offered_coin_amount<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_campaign<T0, T1, T2>(arg0, arg1));
        assert!(v0 > 0 && 0x2::coin::value<T0>(arg2) == v0, 11);
    }

    fun assert_offer_nft_asset_amount<T0: drop, T1: store + key, T2>(arg0: &mut 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::State, arg1: 0x2::object::ID, arg2: &vector<T1>) {
        let v0 = 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::offered_nft_asset_amount<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_campaign<T0, T1, T2>(arg0, arg1));
        assert!(v0 > 0 && 0x1::vector::length<T1>(arg2) == v0, 11);
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

    public entry fun create_campaign<T0: drop, T1: store + key, T2: drop>(arg0: vector<u8>, arg1: u64, arg2: 0x2::coin::Coin<T2>, arg3: vector<u64>, arg4: u8, arg5: u64, arg6: u64, arg7: &mut 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::State, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0x2::clock::timestamp_ms(arg8), 0);
        assert!(arg4 == 0 || arg4 == 1, 1);
        assert_valid_reward<T2>(&arg2, &arg3, arg4);
        assert!(arg5 + arg6 > 0 && (arg5 == 0 || arg6 == 0), 5);
        0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::add_campaign<T0, T1, T2>(arg7, 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::new<T0, T1, T2>(0x1::string::utf8(arg0), arg1, arg5, arg6, 0x2::coin::into_balance<T2>(arg2), arg3, arg8, arg9));
    }

    public entry fun distribution<T0, T1, T2>(arg0: &mut 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::State, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_campaign_end<T0, T1, T2>(arg0, arg1, arg2);
        let v0 = 0x2::tx_context::sender(arg3);
        let (v1, _) = 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::find_operator(arg0, &v0);
        assert!(v1, 8);
        let v3 = *0x2::tx_context::digest(arg3);
        0x1::vector::append<u8>(&mut v3, 0x2::object::id_bytes<0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::State>(arg0));
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<0x2::object::ID>(&arg1));
        let v4 = 0x2::clock::timestamp_ms(arg2);
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<u64>(&v4));
        let v5 = 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::randomness::new(v3);
        let v6 = 0;
        let v7 = 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1);
        let v8 = 0x1::vector::empty<u64>();
        while (v6 < 0x2::math::min(0x1::vector::length<0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::reward::Reward<T2>>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::borrow_rewards<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_campaign<T0, T1, T2>(arg0, arg1))), 0x2::table::length<u64, 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::ticket::Ticket>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::borrow_tickets<T0, T1, T2>(v7)))) {
            let v9 = 0;
            while (v9 == 0 || 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::utils::exists_<u64>(&v8, &v9) || !0x2::table::contains<u64, 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::ticket::Ticket>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::borrow_tickets<T0, T1, T2>(v7), v9)) {
                v9 = (0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::randomness::next_u256_in_range(&mut v5, 1, (0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::current_ticket_id<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_campaign<T0, T1, T2>(arg0, arg1)) as u256) - 1) as u64);
            };
            0x1::vector::push_back<u64>(&mut v8, v9);
            0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::reward::set_winner<T2>(0x1::vector::borrow_mut<0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::reward::Reward<T2>>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::borrow_mut_rewards<T0, T1, T2>(v7), v6), v9);
            v6 = v6 + 1;
        };
        0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::set_distributed<T0, T1, T2>(v7);
    }

    public entry fun get_ticket_offer_coin<T0: drop, T1: store + key, T2>(arg0: &mut 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::State, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_campaign_not_end<T0, T1, T2>(arg0, arg1, arg3);
        assert_offer_coin_amount<T0, T1, T2>(arg0, arg1, &arg2);
        let v0 = 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::current_ticket_id<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_campaign<T0, T1, T2>(arg0, arg1));
        0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::increase_ticket_counter<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1));
        0x2::table::add<u64, 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::ticket::Ticket>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::borrow_mut_tickets<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), v0, 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::ticket::new(v0, 0x1::vector::singleton<0x2::object::ID>(0x2::object::id<0x2::coin::Coin<T0>>(&arg2))));
        let v1 = 0x2::tx_context::sender(arg4);
        0x2::table::add<u64, address>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::borrow_mut_owners<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), v0, v1);
        if (!0x2::table::contains<address, vector<u64>>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::borrow_owned_tickets<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_campaign<T0, T1, T2>(arg0, arg1)), v1)) {
            0x2::table::add<address, vector<u64>>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::borrow_mut_owned_tickets<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), v1, 0x1::vector::singleton<u64>(v0));
        } else {
            0x1::vector::push_back<u64>(0x2::table::borrow_mut<address, vector<u64>>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::borrow_mut_owned_tickets<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), v1), v0);
        };
        0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::custodian::hold<0x2::coin::Coin<T0>>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::borrow_mut_coin_custodian<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), arg2);
    }

    public entry fun get_ticket_offer_nft_asset<T0: drop, T1: store + key, T2>(arg0: &mut 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::State, arg1: 0x2::object::ID, arg2: vector<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_campaign_not_end<T0, T1, T2>(arg0, arg1, arg3);
        assert_offer_nft_asset_amount<T0, T1, T2>(arg0, arg1, &arg2);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<T1>(&arg2)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id<T1>(0x1::vector::borrow<T1>(&arg2, v1)));
            v1 = v1 + 1;
        };
        let v2 = 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::current_ticket_id<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_campaign<T0, T1, T2>(arg0, arg1));
        0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::increase_ticket_counter<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1));
        0x2::table::add<u64, 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::ticket::Ticket>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::borrow_mut_tickets<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), v2, 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::ticket::new(v2, v0));
        let v3 = 0x2::tx_context::sender(arg4);
        0x2::table::add<u64, address>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::borrow_mut_owners<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), v2, v3);
        if (!0x2::table::contains<address, vector<u64>>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::borrow_owned_tickets<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_campaign<T0, T1, T2>(arg0, arg1)), v3)) {
            0x2::table::add<address, vector<u64>>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::borrow_mut_owned_tickets<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), v3, 0x1::vector::singleton<u64>(v2));
        } else {
            0x1::vector::push_back<u64>(0x2::table::borrow_mut<address, vector<u64>>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::borrow_mut_owned_tickets<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), v3), v2);
        };
        while (!0x1::vector::is_empty<T1>(&arg2)) {
            0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::custodian::hold<T1>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::borrow_mut_nft_asset_custodian<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), 0x1::vector::pop_back<T1>(&mut arg2));
        };
        0x1::vector::destroy_empty<T1>(arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun remove_operator(arg0: &AdminCap, arg1: &mut 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::State, arg2: address) {
        0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::remove_operator(arg1, arg2);
    }

    public entry fun setup(arg0: &AdminCap, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::State>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::new(arg1, arg2));
    }

    public entry fun stop_campaign<T0, T1, T2>(arg0: &AdminCap, arg1: &mut 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::State, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        assert_campaign_not_end<T0, T1, T2>(arg1, arg2, arg3);
        0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::set_ended_at<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_mut_campaign<T0, T1, T2>(arg1, arg2), 0x2::clock::timestamp_ms(arg3));
    }

    fun take_reward_internal<T0: drop, T1: store + key, T2>(arg0: &mut 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::State, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg2 < 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::current_ticket_id<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_campaign<T0, T1, T2>(arg0, arg1)), 10);
        assert!(!0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::ticket::is_claimed(0x2::table::borrow<u64, 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::ticket::Ticket>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::borrow_tickets<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_campaign<T0, T1, T2>(arg0, arg1)), arg2)), 13);
        let (v0, v1) = 0x1::vector::index_of<u64>(0x2::table::borrow<address, vector<u64>>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::borrow_owned_tickets<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_campaign<T0, T1, T2>(arg0, arg1)), 0x2::tx_context::sender(arg4)), &arg2);
        assert!(v0, 12);
        let v2 = 0x2::tx_context::sender(arg4);
        if (0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::offered_coin_amount<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_campaign<T0, T1, T2>(arg0, arg1)) > 0) {
            let v3 = 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::take_coin_assets<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1), arg2);
            while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&v3)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut v3), v2);
            };
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(v3);
        } else {
            let v4 = 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::take_nft_assets<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1), arg2);
            while (!0x1::vector::is_empty<T1>(&v4)) {
                0x2::transfer::public_transfer<T1>(0x1::vector::pop_back<T1>(&mut v4), v2);
            };
            0x1::vector::destroy_empty<T1>(v4);
        };
        let v5 = 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::take_reward<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1), arg2);
        if (0x1::option::is_some<0x2::balance::Balance<T2>>(&v5)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x1::option::destroy_some<0x2::balance::Balance<T2>>(v5), arg4), v2);
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<T2>>(v5);
        };
        if (0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::is_distributed<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_campaign<T0, T1, T2>(arg0, arg1))) {
            0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::ticket::set_claimed(0x2::table::borrow_mut<u64, 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::ticket::Ticket>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::borrow_mut_tickets<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), arg2));
        };
        if (!0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::is_ended<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_campaign<T0, T1, T2>(arg0, arg1), arg3)) {
            0x2::table::remove<u64, 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::ticket::Ticket>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::borrow_mut_tickets<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), arg2);
            0x2::table::remove<u64, address>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::borrow_mut_owners<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), arg2);
            0x1::vector::remove<u64>(0x2::table::borrow_mut<address, vector<u64>>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::borrow_mut_owned_tickets<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_mut_campaign<T0, T1, T2>(arg0, arg1)), v2), v1);
        };
    }

    public entry fun update_metadata<T0, T1, T2>(arg0: &AdminCap, arg1: &mut 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::State, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        assert_campaign_not_end<T0, T1, T2>(arg1, arg2, arg4);
        0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::set_metadata<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_mut_campaign<T0, T1, T2>(arg1, arg2), 0x1::string::utf8(arg3));
    }

    public entry fun withdraw_reward<T0, T1, T2>(arg0: &AdminCap, arg1: &mut 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::State, arg2: 0x2::object::ID, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_campaign_end<T0, T1, T2>(arg1, arg2, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign::withdraw_at<T0, T1, T2>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::state::borrow_mut_campaign<T0, T1, T2>(arg1, arg2), arg3), arg6), arg4);
    }

    // decompiled from Move bytecode v6
}

