module 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::raffle {
    struct TimeEvent has copy, drop, store {
        timestamp_ms: u64,
        expect_current_round: u64,
        round_will_use: u64,
    }

    struct CoinRaffleCreated has copy, drop {
        raffle_id: 0x2::object::ID,
        raffle_name: 0x1::string::String,
        creator: address,
        round: u64,
        participants_count: u64,
        participants_hash_proof: 0x2::object::ID,
        winnerCount: u64,
        prizeAmount: u64,
        prizeType: 0x1::ascii::String,
    }

    struct CoinRaffleSettled has copy, drop {
        raffle_id: 0x2::object::ID,
        settler: address,
        winners: vector<address>,
    }

    struct Raffle<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        round: u64,
        status: u8,
        creator: address,
        settler: address,
        addressesSubObjs_table: 0x2::object_table::ObjectTable<0x2::object::ID, 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj::AddressesSubObj>,
        addressesSubObjs_keys: vector<0x2::object::ID>,
        participantCount: u64,
        winnerCount: u64,
        winners: vector<address>,
        balance: 0x2::balance::Balance<T0>,
    }

    public entry fun create_coin_raffle<T0>(arg0: vector<u8>, arg1: &0x2::clock::Clock, arg2: vector<address>, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj::table_keys_create(arg2, arg5);
        internal_create_coin_raffle<T0>(arg0, arg1, v0, v1, arg3, arg4, arg5);
    }

    public entry fun create_coin_raffle_by_addresses_obj<T0, T1>(arg0: vector<u8>, arg1: &0x2::clock::Clock, arg2: &mut 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_obj::AddressesObj<T1>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_obj::getFee<T1>(arg2) == 0x2::balance::value<T1>(0x2::coin::balance<T1>(&arg3)), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_obj::getCreator<T1>(arg2));
        0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_obj::setFee<T1>(arg2, 0);
        let (v0, v1) = 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_obj::pop_all<T1>(arg2, arg6);
        internal_create_coin_raffle<T0>(arg0, arg1, v0, v1, arg4, arg5, arg6);
    }

    public fun emit_coin_raffle_created<T0>(arg0: &Raffle<T0>) {
        let v0 = getParticipants<T0>(arg0);
        let v1 = CoinRaffleCreated{
            raffle_id               : *0x2::object::borrow_id<Raffle<T0>>(arg0),
            raffle_name             : arg0.name,
            creator                 : arg0.creator,
            round                   : arg0.round,
            participants_count      : 0x1::vector::length<address>(&v0),
            participants_hash_proof : 0x2::object::id_from_bytes(0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_hash_proof::hash_addresses(v0)),
            winnerCount             : arg0.winnerCount,
            prizeAmount             : 0x2::balance::value<T0>(&arg0.balance),
            prizeType               : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        };
        0x2::event::emit<CoinRaffleCreated>(v1);
    }

    public fun emit_coin_raffle_settled<T0>(arg0: &Raffle<T0>) {
        let v0 = CoinRaffleSettled{
            raffle_id : *0x2::object::borrow_id<Raffle<T0>>(arg0),
            settler   : arg0.settler,
            winners   : arg0.winners,
        };
        0x2::event::emit<CoinRaffleSettled>(v0);
    }

    fun getParticipants<T0>(arg0: &Raffle<T0>) : vector<address> {
        0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj::table_keys_get_all_addresses(&arg0.addressesSubObjs_table, &arg0.addressesSubObjs_keys)
    }

    fun getWinners<T0>(arg0: &Raffle<T0>) : vector<address> {
        arg0.winners
    }

    entry fun get_drandlib_round(arg0: &0x2::clock::Clock) {
        let v0 = 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::drand_lib::get_current_round_by_time(0x2::clock::timestamp_ms(arg0));
        let v1 = TimeEvent{
            timestamp_ms         : 0x2::clock::timestamp_ms(arg0),
            expect_current_round : v0,
            round_will_use       : v0 + 2,
        };
        0x2::event::emit<TimeEvent>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    fun internal_create_coin_raffle<T0>(arg0: vector<u8>, arg1: &0x2::clock::Clock, arg2: 0x2::object_table::ObjectTable<0x2::object::ID, 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj::AddressesSubObj>, arg3: vector<0x2::object::ID>, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj::table_keys_get_all_addresses(&arg2, &arg3);
        let v1 = 0x1::vector::length<address>(&v0);
        assert!(arg4 <= v1, 0);
        let v2 = Raffle<T0>{
            id                     : 0x2::object::new(arg6),
            name                   : 0x1::string::utf8(arg0),
            round                  : 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::drand_lib::get_current_round_by_time(0x2::clock::timestamp_ms(arg1)) + 2,
            status                 : 0,
            creator                : 0x2::tx_context::sender(arg6),
            settler                : @0x0,
            addressesSubObjs_table : arg2,
            addressesSubObjs_keys  : arg3,
            participantCount       : v1,
            winnerCount            : arg4,
            winners                : 0x1::vector::empty<address>(),
            balance                : 0x2::coin::into_balance<T0>(arg5),
        };
        emit_coin_raffle_created<T0>(&v2);
        0x2::transfer::public_share_object<Raffle<T0>>(v2);
    }

    public entry fun settle_coin_raffle<T0>(arg0: &mut Raffle<T0>, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status != 1, 0);
        if (arg0.creator != 0x2::tx_context::sender(arg4)) {
            assert!(0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::drand_lib::get_current_round_by_time(0x2::clock::timestamp_ms(arg1)) >= arg0.round + 10, 0);
        };
        0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::drand_lib::verify_drand_signature(arg2, arg3, arg0.round);
        arg0.status = 1;
        arg0.settler = 0x2::tx_context::sender(arg4);
        let v0 = 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::drand_lib::derive_randomness(arg2);
        let v1 = 0;
        let v2 = getParticipants<T0>(arg0);
        v1 = v1 + 1;
        let v3 = 0x1::vector::swap_remove<address>(&mut v2, 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::drand_lib::safe_selection(0x1::vector::length<address>(&v2), &v0, 0));
        0x1::vector::push_back<address>(&mut arg0.winners, v3);
        while (v1 < arg0.winnerCount) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, 0x2::balance::value<T0>(&arg0.balance) / arg0.winnerCount, arg4), v3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, 0x2::balance::value<T0>(&arg0.balance), arg4), v3);
        0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj::table_keys_clear(&mut arg0.addressesSubObjs_table, &mut arg0.addressesSubObjs_keys);
        emit_coin_raffle_settled<T0>(arg0);
    }

    // decompiled from Move bytecode v6
}

