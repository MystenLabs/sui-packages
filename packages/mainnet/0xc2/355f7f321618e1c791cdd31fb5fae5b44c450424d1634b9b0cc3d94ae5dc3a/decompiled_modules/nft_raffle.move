module 0xc2355f7f321618e1c791cdd31fb5fae5b44c450424d1634b9b0cc3d94ae5dc3a::nft_raffle {
    struct NFT_Raffle<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        round: u64,
        status: u8,
        creator: address,
        settler: address,
        participants: vector<address>,
        reward_nfts: 0x2::object_table::ObjectTable<0x2::object::ID, T0>,
        reward_nfts_table_keys: vector<0x2::object::ID>,
        winnerCount: u64,
        winners: vector<address>,
    }

    struct NftRaffleCreated has copy, drop {
        raffle_id: 0x2::object::ID,
        raffle_name: 0x1::string::String,
        creator: address,
        round: u64,
        participants_count: u64,
        winnerCount: u64,
        prizeType: 0x1::ascii::String,
        reward_nft_ids: vector<0x2::object::ID>,
    }

    struct NftRaffleSettled has copy, drop {
        raffle_id: 0x2::object::ID,
        settler: address,
    }

    public entry fun create_nft_raffle<T0: store + key>(arg0: vector<u8>, arg1: &0x2::clock::Clock, arg2: vector<address>, arg3: vector<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<T0>(&arg3);
        assert!(v0 <= 0x1::vector::length<address>(&arg2), 0);
        let v1 = 0;
        let v2 = 0x2::object_table::new<0x2::object::ID, T0>(arg4);
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        while (!0x1::vector::is_empty<T0>(&arg3)) {
            let v4 = 0x1::vector::pop_back<T0>(&mut arg3);
            let v5 = 0x2::object::id<T0>(&v4);
            0x2::object_table::add<0x2::object::ID, T0>(&mut v2, v5, v4);
            0x1::vector::push_back<0x2::object::ID>(&mut v3, v5);
            v1 = v1 + 1;
        };
        let v6 = NFT_Raffle<T0>{
            id                     : 0x2::object::new(arg4),
            name                   : 0x1::string::utf8(arg0),
            round                  : 0xc2355f7f321618e1c791cdd31fb5fae5b44c450424d1634b9b0cc3d94ae5dc3a::drand_lib::get_current_round_by_time(0x2::clock::timestamp_ms(arg1)) + 2,
            status                 : 0,
            creator                : 0x2::tx_context::sender(arg4),
            settler                : @0x0,
            participants           : arg2,
            reward_nfts            : v2,
            reward_nfts_table_keys : v3,
            winnerCount            : v0,
            winners                : 0x1::vector::empty<address>(),
        };
        emit_nft_raffle_created<T0>(&v6);
        0x2::transfer::public_share_object<NFT_Raffle<T0>>(v6);
        0x1::vector::destroy_empty<T0>(arg3);
    }

    public fun emit_nft_raffle_created<T0: store + key>(arg0: &NFT_Raffle<T0>) {
        let v0 = NftRaffleCreated{
            raffle_id          : *0x2::object::borrow_id<NFT_Raffle<T0>>(arg0),
            raffle_name        : arg0.name,
            creator            : arg0.creator,
            round              : arg0.round,
            participants_count : 0x1::vector::length<address>(&arg0.participants),
            winnerCount        : arg0.winnerCount,
            prizeType          : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            reward_nft_ids     : arg0.reward_nfts_table_keys,
        };
        0x2::event::emit<NftRaffleCreated>(v0);
    }

    public fun emit_nft_raffle_settled<T0: store + key>(arg0: &NFT_Raffle<T0>) {
        let v0 = NftRaffleSettled{
            raffle_id : *0x2::object::borrow_id<NFT_Raffle<T0>>(arg0),
            settler   : arg0.settler,
        };
        0x2::event::emit<NftRaffleSettled>(v0);
    }

    fun getWinners<T0: store + key>(arg0: &NFT_Raffle<T0>) : vector<address> {
        arg0.winners
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun settle_nft_raffle<T0: store + key>(arg0: &mut NFT_Raffle<T0>, arg1: vector<u8>, arg2: vector<u8>) {
        assert!(arg0.status != 1, 0);
        0xc2355f7f321618e1c791cdd31fb5fae5b44c450424d1634b9b0cc3d94ae5dc3a::drand_lib::verify_drand_signature(arg1, arg2, arg0.round);
        arg0.status = 1;
        let v0 = 0xc2355f7f321618e1c791cdd31fb5fae5b44c450424d1634b9b0cc3d94ae5dc3a::drand_lib::derive_randomness(arg1);
        let v1 = 0;
        v1 = v1 + 1;
        let v2 = 0x1::vector::length<address>(&arg0.participants);
        0x1::vector::swap<address>(&mut arg0.participants, 0xc2355f7f321618e1c791cdd31fb5fae5b44c450424d1634b9b0cc3d94ae5dc3a::drand_lib::safe_selection(v2, &v0, 0), v2 - 1);
        let v3 = 0x1::vector::pop_back<address>(&mut arg0.participants);
        0x1::vector::push_back<address>(&mut arg0.winners, v3);
        let v4 = 0x2::object_table::remove<0x2::object::ID, T0>(&mut arg0.reward_nfts, 0x1::vector::pop_back<0x2::object::ID>(&mut arg0.reward_nfts_table_keys));
        while (v1 < arg0.winnerCount) {
            0x2::transfer::public_transfer<T0>(v4, v3);
        };
        0x2::transfer::public_transfer<T0>(v4, v3);
        emit_nft_raffle_settled<T0>(arg0);
    }

    // decompiled from Move bytecode v6
}

