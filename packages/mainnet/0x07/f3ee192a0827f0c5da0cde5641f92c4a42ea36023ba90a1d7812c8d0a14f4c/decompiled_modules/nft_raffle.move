module 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::nft_raffle {
    struct NFT_Raffle<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        round: u64,
        status: u8,
        creator: address,
        settler: address,
        addressesSubObjs_table: 0x2::object_table::ObjectTable<0x2::object::ID, 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj::AddressesSubObj>,
        addressesSubObjs_keys: vector<0x2::object::ID>,
        reward_nfts: 0x2::object_table::ObjectTable<0x2::object::ID, T0>,
        reward_nfts_table_keys: vector<0x2::object::ID>,
        participantCount: u64,
        winnerCount: u64,
        winners: vector<address>,
    }

    struct NftRaffleCreated has copy, drop {
        raffle_id: 0x2::object::ID,
        raffle_name: 0x1::string::String,
        creator: address,
        round: u64,
        participants_count: u64,
        participants_hash_proof: 0x2::object::ID,
        winnerCount: u64,
        prizeType: 0x1::ascii::String,
        reward_nft_ids: vector<0x2::object::ID>,
    }

    struct NftRaffleSettled has copy, drop {
        raffle_id: 0x2::object::ID,
        settler: address,
        winners: vector<address>,
    }

    public entry fun create_nft_raffle<T0: store + key>(arg0: vector<u8>, arg1: &0x2::clock::Clock, arg2: vector<address>, arg3: vector<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj::table_keys_create(arg2, arg4);
        internal_create_nft_raffle<T0>(arg0, arg1, v0, v1, arg3, arg4);
    }

    public entry fun create_nft_raffle_by_addresses_obj<T0: store + key, T1: drop>(arg0: vector<u8>, arg1: &0x2::clock::Clock, arg2: &mut 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_obj::AddressesObj<T1>, arg3: 0x2::coin::Coin<T1>, arg4: vector<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_obj::getFee<T1>(arg2) == 0x2::balance::value<T1>(0x2::coin::balance<T1>(&arg3)), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_obj::getCreator<T1>(arg2));
        0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_obj::setFee<T1>(arg2, 0);
        let (v0, v1) = 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_obj::pop_all<T1>(arg2, arg5);
        internal_create_nft_raffle<T0>(arg0, arg1, v0, v1, arg4, arg5);
    }

    public fun emit_nft_raffle_created<T0: store + key>(arg0: &NFT_Raffle<T0>) {
        let v0 = getParticipants<T0>(arg0);
        let v1 = NftRaffleCreated{
            raffle_id               : *0x2::object::borrow_id<NFT_Raffle<T0>>(arg0),
            raffle_name             : arg0.name,
            creator                 : arg0.creator,
            round                   : arg0.round,
            participants_count      : 0x1::vector::length<address>(&v0),
            participants_hash_proof : 0x2::object::id_from_bytes(0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_hash_proof::hash_addresses(v0)),
            winnerCount             : arg0.winnerCount,
            prizeType               : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            reward_nft_ids          : arg0.reward_nfts_table_keys,
        };
        0x2::event::emit<NftRaffleCreated>(v1);
    }

    public fun emit_nft_raffle_settled<T0: store + key>(arg0: &NFT_Raffle<T0>) {
        let v0 = NftRaffleSettled{
            raffle_id : *0x2::object::borrow_id<NFT_Raffle<T0>>(arg0),
            settler   : arg0.settler,
            winners   : arg0.winners,
        };
        0x2::event::emit<NftRaffleSettled>(v0);
    }

    fun getParticipants<T0: store + key>(arg0: &NFT_Raffle<T0>) : vector<address> {
        0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj::table_keys_get_all_addresses(&arg0.addressesSubObjs_table, &arg0.addressesSubObjs_keys)
    }

    fun getWinners<T0: store + key>(arg0: &NFT_Raffle<T0>) : vector<address> {
        arg0.winners
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    fun internal_create_nft_raffle<T0: store + key>(arg0: vector<u8>, arg1: &0x2::clock::Clock, arg2: 0x2::object_table::ObjectTable<0x2::object::ID, 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj::AddressesSubObj>, arg3: vector<0x2::object::ID>, arg4: vector<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj::table_keys_get_all_addresses(&arg2, &arg3);
        let v1 = 0x1::vector::length<address>(&v0);
        let v2 = 0x1::vector::length<T0>(&arg4);
        assert!(v2 <= v1, 0);
        let v3 = 0;
        let v4 = 0x2::object_table::new<0x2::object::ID, T0>(arg5);
        let v5 = 0x1::vector::empty<0x2::object::ID>();
        while (!0x1::vector::is_empty<T0>(&arg4)) {
            let v6 = 0x1::vector::pop_back<T0>(&mut arg4);
            let v7 = 0x2::object::id<T0>(&v6);
            0x2::object_table::add<0x2::object::ID, T0>(&mut v4, v7, v6);
            0x1::vector::push_back<0x2::object::ID>(&mut v5, v7);
            v3 = v3 + 1;
        };
        let v8 = NFT_Raffle<T0>{
            id                     : 0x2::object::new(arg5),
            name                   : 0x1::string::utf8(arg0),
            round                  : 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::drand_lib::get_current_round_by_time(0x2::clock::timestamp_ms(arg1)) + 2,
            status                 : 0,
            creator                : 0x2::tx_context::sender(arg5),
            settler                : @0x0,
            addressesSubObjs_table : arg2,
            addressesSubObjs_keys  : arg3,
            reward_nfts            : v4,
            reward_nfts_table_keys : v5,
            participantCount       : v1,
            winnerCount            : v2,
            winners                : 0x1::vector::empty<address>(),
        };
        emit_nft_raffle_created<T0>(&v8);
        0x2::transfer::public_share_object<NFT_Raffle<T0>>(v8);
        0x1::vector::destroy_empty<T0>(arg4);
    }

    public entry fun settle_nft_raffle<T0: store + key>(arg0: &mut NFT_Raffle<T0>, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status != 1, 0);
        if (arg0.creator != 0x2::tx_context::sender(arg4)) {
            assert!(0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::drand_lib::get_current_round_by_time(0x2::clock::timestamp_ms(arg1)) >= arg0.round + 10, 0);
        };
        0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::drand_lib::verify_drand_signature(arg2, arg3, arg0.round);
        arg0.status = 1;
        let v0 = 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::drand_lib::derive_randomness(arg2);
        let v1 = getParticipants<T0>(arg0);
        let v2 = 0;
        v2 = v2 + 1;
        let v3 = 0x1::vector::swap_remove<address>(&mut v1, 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::drand_lib::safe_selection(0x1::vector::length<address>(&v1), &v0, 0));
        0x1::vector::push_back<address>(&mut arg0.winners, v3);
        let v4 = 0x2::object_table::remove<0x2::object::ID, T0>(&mut arg0.reward_nfts, 0x1::vector::pop_back<0x2::object::ID>(&mut arg0.reward_nfts_table_keys));
        while (v2 < arg0.winnerCount) {
            0x2::transfer::public_transfer<T0>(v4, v3);
        };
        0x2::transfer::public_transfer<T0>(v4, v3);
        0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj::table_keys_clear(&mut arg0.addressesSubObjs_table, &mut arg0.addressesSubObjs_keys);
        emit_nft_raffle_settled<T0>(arg0);
    }

    // decompiled from Move bytecode v6
}

