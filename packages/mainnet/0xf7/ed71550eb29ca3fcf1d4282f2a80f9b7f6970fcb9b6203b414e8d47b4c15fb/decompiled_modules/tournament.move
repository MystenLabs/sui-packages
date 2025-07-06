module 0xf7ed71550eb29ca3fcf1d4282f2a80f9b7f6970fcb9b6203b414e8d47b4c15fb::tournament {
    struct Tournament has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        tournament_type: u8,
        status: u8,
        start_time: u64,
        end_time: u64,
        entry_fee: u64,
        prize_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
        participants: 0x2::table::Table<0x2::object::ID, NFTEntry>,
        votes: 0x2::table::Table<address, vector<0x2::object::ID>>,
        total_participants: u64,
        winners: vector<Winner>,
        allowed_collections: vector<0x1::string::String>,
        is_token_gated: bool,
        is_azur_guardian_exclusive: bool,
        participant_ids: vector<0x2::object::ID>,
    }

    struct Winner has copy, drop, store {
        nft_id: 0x2::object::ID,
        owner: address,
        rank: u64,
        prize_amount: u64,
    }

    struct NFTEntry has copy, drop, store {
        nft_id: 0x2::object::ID,
        owner: address,
        votes: u64,
        registration_time: u64,
        image_url: 0x1::option::Option<0x1::string::String>,
        nft_type: 0x1::string::String,
    }

    struct TournamentRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        active_tournaments: vector<0x2::object::ID>,
    }

    struct TournamentCreatedEvent has copy, drop {
        tournament_id: 0x2::object::ID,
        name: 0x1::string::String,
        tournament_type: u8,
        start_time: u64,
        end_time: u64,
        entry_fee: u64,
        admin: address,
        is_azur_guardian_exclusive: bool,
    }

    struct NFTRegisteredEvent has copy, drop {
        tournament_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        owner: address,
        nft_type: 0x1::string::String,
    }

    struct VoteCastEvent has copy, drop {
        tournament_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        voter: address,
    }

    struct TournamentEndedEvent has copy, drop {
        tournament_id: 0x2::object::ID,
        total_participants: u64,
        prize_pool: u64,
    }

    struct PrizeDistributedEvent has copy, drop {
        tournament_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        owner: address,
        rank: u64,
        prize_amount: u64,
    }

    public fun create_tournament(arg0: &mut TournamentRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: vector<0x1::string::String>, arg9: bool, arg10: bool, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg3 == 1) {
            true
        } else if (arg3 == 2) {
            true
        } else {
            arg3 == 3
        };
        assert!(v0, 5);
        let v1 = arg9;
        if (arg10) {
            let v2 = 0x1::string::utf8(b"0xfc9d0c6972cae3f303030b993485af37e2d86ebf3b409d1e6a40cde955a43a77::azur_guardians::Nft");
            let v3 = false;
            let v4 = 0;
            while (v4 < 0x1::vector::length<0x1::string::String>(&arg8)) {
                if (*0x1::vector::borrow<0x1::string::String>(&arg8, v4) == v2) {
                    v3 = true;
                    break
                };
                v4 = v4 + 1;
            };
            if (!v3) {
                0x1::vector::push_back<0x1::string::String>(&mut arg8, v2);
            };
            v1 = true;
        };
        let v5 = 0x2::clock::timestamp_ms(arg7);
        let v6 = Tournament{
            id                         : 0x2::object::new(arg11),
            name                       : arg1,
            description                : arg2,
            tournament_type            : arg3,
            status                     : 1,
            start_time                 : v5,
            end_time                   : v5 + arg4 * 3600000,
            entry_fee                  : arg5,
            prize_pool                 : 0x2::coin::into_balance<0x2::sui::SUI>(arg6),
            admin                      : 0x2::tx_context::sender(arg11),
            participants               : 0x2::table::new<0x2::object::ID, NFTEntry>(arg11),
            votes                      : 0x2::table::new<address, vector<0x2::object::ID>>(arg11),
            total_participants         : 0,
            winners                    : 0x1::vector::empty<Winner>(),
            allowed_collections        : arg8,
            is_token_gated             : v1,
            is_azur_guardian_exclusive : arg10,
            participant_ids            : 0x1::vector::empty<0x2::object::ID>(),
        };
        let v7 = 0x2::object::id<Tournament>(&v6);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.active_tournaments, v7);
        let v8 = TournamentCreatedEvent{
            tournament_id              : v7,
            name                       : v6.name,
            tournament_type            : v6.tournament_type,
            start_time                 : v6.start_time,
            end_time                   : v6.end_time,
            entry_fee                  : v6.entry_fee,
            admin                      : v6.admin,
            is_azur_guardian_exclusive : arg10,
        };
        0x2::event::emit<TournamentCreatedEvent>(v8);
        0x2::transfer::share_object<Tournament>(v6);
    }

    public entry fun create_tournament_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TournamentRegistry{
            id                 : 0x2::object::new(arg0),
            admin              : 0x2::tx_context::sender(arg0),
            active_tournaments : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<TournamentRegistry>(v0);
    }

    public fun end_tournament(arg0: &mut Tournament, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 6);
        assert!(arg0.status == 1, 1);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.end_time, 10);
        arg0.status = 2;
        if (!has_participants_with_votes(arg0)) {
        } else if (arg0.total_participants < 5) {
            let (v0, v1) = find_top_nft(arg0);
            let v2 = v1;
            let v3 = 100000000;
            let v4 = Winner{
                nft_id       : v0,
                owner        : v2.owner,
                rank         : 1,
                prize_amount : v3,
            };
            0x1::vector::push_back<Winner>(&mut arg0.winners, v4);
            0xf7ed71550eb29ca3fcf1d4282f2a80f9b7f6970fcb9b6203b414e8d47b4c15fb::storage::transfer_sui(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.prize_pool, v3), arg2), v2.owner);
            let v5 = PrizeDistributedEvent{
                tournament_id : 0x2::object::id<Tournament>(arg0),
                nft_id        : v0,
                owner         : v2.owner,
                rank          : 1,
                prize_amount  : v3,
            };
            0x2::event::emit<PrizeDistributedEvent>(v5);
        } else {
            let v6 = 60000000;
            let v7 = 30000000;
            let v8 = 10000000;
            let (v9, v10) = find_top_nft(arg0);
            let v11 = v10;
            let (v12, v13) = find_top_nft_excluding(arg0, v9);
            let v14 = v13;
            let (v15, v16) = find_top_nft_excluding_two(arg0, v9, v12);
            let v17 = v16;
            let v18 = Winner{
                nft_id       : v9,
                owner        : v11.owner,
                rank         : 1,
                prize_amount : v6,
            };
            0x1::vector::push_back<Winner>(&mut arg0.winners, v18);
            0xf7ed71550eb29ca3fcf1d4282f2a80f9b7f6970fcb9b6203b414e8d47b4c15fb::storage::transfer_sui(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.prize_pool, v6), arg2), v11.owner);
            let v19 = PrizeDistributedEvent{
                tournament_id : 0x2::object::id<Tournament>(arg0),
                nft_id        : v9,
                owner         : v11.owner,
                rank          : 1,
                prize_amount  : v6,
            };
            0x2::event::emit<PrizeDistributedEvent>(v19);
            let v20 = Winner{
                nft_id       : v12,
                owner        : v14.owner,
                rank         : 2,
                prize_amount : v7,
            };
            0x1::vector::push_back<Winner>(&mut arg0.winners, v20);
            0xf7ed71550eb29ca3fcf1d4282f2a80f9b7f6970fcb9b6203b414e8d47b4c15fb::storage::transfer_sui(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.prize_pool, v7), arg2), v14.owner);
            let v21 = PrizeDistributedEvent{
                tournament_id : 0x2::object::id<Tournament>(arg0),
                nft_id        : v12,
                owner         : v14.owner,
                rank          : 2,
                prize_amount  : v7,
            };
            0x2::event::emit<PrizeDistributedEvent>(v21);
            let v22 = Winner{
                nft_id       : v15,
                owner        : v17.owner,
                rank         : 3,
                prize_amount : v8,
            };
            0x1::vector::push_back<Winner>(&mut arg0.winners, v22);
            0xf7ed71550eb29ca3fcf1d4282f2a80f9b7f6970fcb9b6203b414e8d47b4c15fb::storage::transfer_sui(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.prize_pool, v8), arg2), v17.owner);
            let v23 = PrizeDistributedEvent{
                tournament_id : 0x2::object::id<Tournament>(arg0),
                nft_id        : v15,
                owner         : v17.owner,
                rank          : 3,
                prize_amount  : v8,
            };
            0x2::event::emit<PrizeDistributedEvent>(v23);
        };
        let v24 = TournamentEndedEvent{
            tournament_id      : 0x2::object::id<Tournament>(arg0),
            total_participants : arg0.total_participants,
            prize_pool         : 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<TournamentEndedEvent>(v24);
    }

    fun find_top_nft(arg0: &Tournament) : (0x2::object::ID, NFTEntry) {
        let v0 = 0;
        let v1 = 0x2::object::id_from_address(@0x0);
        let v2 = NFTEntry{
            nft_id            : 0x2::object::id_from_address(@0x0),
            owner             : @0x0,
            votes             : 0,
            registration_time : 0,
            image_url         : 0x1::option::none<0x1::string::String>(),
            nft_type          : 0x1::string::utf8(b""),
        };
        let v3 = &arg0.participants;
        let v4 = vector[@0xb0b, @0xcafe, @0xdead, @0xbeef, @0xface, @0x1, @0x2, @0x3, @0x4, @0x5, @0x42, @0x1337, @0xa, @0xb, @0xc, @0x123, @0x456, @0x789, @0xabc, @0xdef, @0x111, @0x222, @0x333, @0x444, @0x555, @0x666, @0x777, @0x888, @0x999, @0xaaa, @0xbbb, @0xccc, @0xddd, @0xeee, @0xfff];
        let v5 = 0;
        let v6 = 0x1::vector::length<address>(&v4);
        while (v5 < v6) {
            let v7 = 0x2::object::id_from_address(*0x1::vector::borrow<address>(&v4, v5));
            if (0x2::table::contains<0x2::object::ID, NFTEntry>(v3, v7)) {
                let v8 = 0x2::table::borrow<0x2::object::ID, NFTEntry>(v3, v7);
                if (v8.votes > v0) {
                    v0 = v8.votes;
                    v1 = v7;
                    v2 = *v8;
                };
            };
            v5 = v5 + 1;
        };
        if (v0 == 0) {
            v5 = 0;
            while (v5 < v6) {
                let v9 = 0x2::object::id_from_address(*0x1::vector::borrow<address>(&v4, v5));
                if (0x2::table::contains<0x2::object::ID, NFTEntry>(v3, v9)) {
                    v1 = v9;
                    v2 = *0x2::table::borrow<0x2::object::ID, NFTEntry>(v3, v9);
                    break
                };
                v5 = v5 + 1;
            };
        };
        (v1, v2)
    }

    fun find_top_nft_excluding(arg0: &Tournament, arg1: 0x2::object::ID) : (0x2::object::ID, NFTEntry) {
        let v0 = 0;
        let v1 = 0x2::object::id_from_address(@0x0);
        let v2 = NFTEntry{
            nft_id            : 0x2::object::id_from_address(@0x0),
            owner             : @0x0,
            votes             : 0,
            registration_time : 0,
            image_url         : 0x1::option::none<0x1::string::String>(),
            nft_type          : 0x1::string::utf8(b""),
        };
        let v3 = &arg0.participants;
        let v4 = vector[@0xb0b, @0xcafe, @0xdead, @0xbeef, @0xface, @0x1, @0x2, @0x3, @0x4, @0x5, @0x42, @0x1337, @0xa, @0xb, @0xc, @0x123, @0x456, @0x789, @0xabc, @0xdef, @0x111, @0x222, @0x333, @0x444, @0x555, @0x666, @0x777, @0x888, @0x999, @0xaaa, @0xbbb, @0xccc, @0xddd, @0xeee, @0xfff];
        let v5 = 0;
        while (v5 < 0x1::vector::length<address>(&v4)) {
            let v6 = 0x2::object::id_from_address(*0x1::vector::borrow<address>(&v4, v5));
            if (v6 != arg1 && 0x2::table::contains<0x2::object::ID, NFTEntry>(v3, v6)) {
                let v7 = 0x2::table::borrow<0x2::object::ID, NFTEntry>(v3, v6);
                if (v7.votes > v0) {
                    v0 = v7.votes;
                    v1 = v6;
                    v2 = *v7;
                };
            };
            v5 = v5 + 1;
        };
        (v1, v2)
    }

    fun find_top_nft_excluding_two(arg0: &Tournament, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : (0x2::object::ID, NFTEntry) {
        let v0 = 0;
        let v1 = 0x2::object::id_from_address(@0x0);
        let v2 = NFTEntry{
            nft_id            : 0x2::object::id_from_address(@0x0),
            owner             : @0x0,
            votes             : 0,
            registration_time : 0,
            image_url         : 0x1::option::none<0x1::string::String>(),
            nft_type          : 0x1::string::utf8(b""),
        };
        let v3 = &arg0.participants;
        let v4 = vector[@0xb0b, @0xcafe, @0xdead, @0xbeef, @0xface, @0x1, @0x2, @0x3, @0x4, @0x5, @0x42, @0x1337, @0xa, @0xb, @0xc, @0x123, @0x456, @0x789, @0xabc, @0xdef, @0x111, @0x222, @0x333, @0x444, @0x555, @0x666, @0x777, @0x888, @0x999, @0xaaa, @0xbbb, @0xccc, @0xddd, @0xeee, @0xfff];
        let v5 = 0;
        let v6 = 0x1::vector::length<address>(&v4);
        while (v5 < v6) {
            let v7 = 0x2::object::id_from_address(*0x1::vector::borrow<address>(&v4, v5));
            let v8 = if (v7 != arg1) {
                if (v7 != arg2) {
                    0x2::table::contains<0x2::object::ID, NFTEntry>(v3, v7)
                } else {
                    false
                }
            } else {
                false
            };
            if (v8) {
                let v9 = 0x2::table::borrow<0x2::object::ID, NFTEntry>(v3, v7);
                if (v9.votes > v0) {
                    v0 = v9.votes;
                    v1 = v7;
                    v2 = *v9;
                };
            };
            v5 = v5 + 1;
        };
        if (v0 == 0) {
            v5 = 0;
            while (v5 < v6) {
                let v10 = 0x2::object::id_from_address(*0x1::vector::borrow<address>(&v4, v5));
                let v11 = if (v10 != arg1) {
                    if (v10 != arg2) {
                        0x2::table::contains<0x2::object::ID, NFTEntry>(v3, v10)
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v11) {
                    v1 = v10;
                    v2 = *0x2::table::borrow<0x2::object::ID, NFTEntry>(v3, v10);
                    break
                };
                v5 = v5 + 1;
            };
        };
        (v1, v2)
    }

    public fun get_nft_type(arg0: 0x2::object::ID) : 0x1::string::String {
        0x1::string::utf8(b"0xfc9d0c6972cae3f303030b993485af37e2d86ebf3b409d1e6a40cde955a43a77::azur_guardians::Nft")
    }

    public fun get_participant_entry(arg0: &Tournament, arg1: 0x2::object::ID) : 0x1::option::Option<NFTEntry> {
        if (0x2::table::contains<0x2::object::ID, NFTEntry>(&arg0.participants, arg1)) {
            0x1::option::some<NFTEntry>(*0x2::table::borrow<0x2::object::ID, NFTEntry>(&arg0.participants, arg1))
        } else {
            0x1::option::none<NFTEntry>()
        }
    }

    public fun get_participant_ids(arg0: &Tournament) : vector<0x2::object::ID> {
        arg0.participant_ids
    }

    public fun get_tournament_details(arg0: &Tournament) : (0x1::string::String, 0x1::string::String, u8, u8, u64, u64, u64, u64, u64) {
        (arg0.name, arg0.description, arg0.tournament_type, arg0.status, arg0.start_time, arg0.end_time, arg0.entry_fee, 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool), arg0.total_participants)
    }

    public fun get_tournament_winners(arg0: &Tournament) : vector<Winner> {
        arg0.winners
    }

    public fun get_winner_count(arg0: &Tournament) : u64 {
        0x1::vector::length<Winner>(&arg0.winners)
    }

    public fun get_winner_details(arg0: &Tournament, arg1: u64) : (0x2::object::ID, address, u64, u64) {
        let v0 = 0x1::vector::borrow<Winner>(&arg0.winners, arg1);
        (v0.nft_id, v0.owner, v0.rank, v0.prize_amount)
    }

    fun has_participants_with_votes(arg0: &Tournament) : bool {
        if (arg0.total_participants > 1) {
            return true
        };
        if (arg0.total_participants == 0) {
            return false
        };
        let v0 = &arg0.participants;
        let v1 = vector[@0xb0b, @0xcafe, @0xdead, @0xbeef, @0xface, @0x1, @0x2, @0x3, @0x4, @0x5, @0x42, @0x1337, @0xa, @0xb, @0xc, @0x123, @0x456, @0x789, @0xabc, @0xdef, @0x111, @0x222, @0x333, @0x444, @0x555, @0x666, @0x777, @0x888, @0x999, @0xaaa, @0xbbb, @0xccc, @0xddd, @0xeee, @0xfff];
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v1)) {
            let v3 = 0x2::object::id_from_address(*0x1::vector::borrow<address>(&v1, v2));
            if (0x2::table::contains<0x2::object::ID, NFTEntry>(v0, v3)) {
                if (0x2::table::borrow<0x2::object::ID, NFTEntry>(v0, v3).votes > 0) {
                    return true
                };
            };
            v2 = v2 + 1;
        };
        false
    }

    public fun is_azur_guardian(arg0: 0x2::object::ID) : bool {
        get_nft_type(arg0) == 0x1::string::utf8(b"0xfc9d0c6972cae3f303030b993485af37e2d86ebf3b409d1e6a40cde955a43a77::azur_guardians::Nft")
    }

    public fun register_nft(arg0: &mut Tournament, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 < arg0.end_time, 4);
        assert!(!0x2::table::contains<0x2::object::ID, NFTEntry>(&arg0.participants, arg1), 7);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= arg0.entry_fee, 8);
        let v1 = get_nft_type(arg1);
        if (arg0.is_azur_guardian_exclusive) {
            assert!(v1 == 0x1::string::utf8(b"0xfc9d0c6972cae3f303030b993485af37e2d86ebf3b409d1e6a40cde955a43a77::azur_guardians::Nft"), 15);
        } else if (arg0.is_token_gated && 0x1::vector::length<0x1::string::String>(&arg0.allowed_collections) > 0) {
            let v2 = false;
            let v3 = 0;
            while (v3 < 0x1::vector::length<0x1::string::String>(&arg0.allowed_collections)) {
                if (v1 == *0x1::vector::borrow<0x1::string::String>(&arg0.allowed_collections, v3)) {
                    v2 = true;
                    break
                };
                v3 = v3 + 1;
            };
            assert!(v2, 13);
        };
        if (arg0.entry_fee > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, arg0.entry_fee, arg4)));
        };
        let v4 = NFTEntry{
            nft_id            : arg1,
            owner             : 0x2::tx_context::sender(arg4),
            votes             : 0,
            registration_time : v0,
            image_url         : 0x1::option::none<0x1::string::String>(),
            nft_type          : v1,
        };
        0x2::table::add<0x2::object::ID, NFTEntry>(&mut arg0.participants, arg1, v4);
        arg0.total_participants = arg0.total_participants + 1;
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.participant_ids, arg1);
        let v5 = NFTRegisteredEvent{
            tournament_id : 0x2::object::id<Tournament>(arg0),
            nft_id        : arg1,
            owner         : 0x2::tx_context::sender(arg4),
            nft_type      : v1,
        };
        0x2::event::emit<NFTRegisteredEvent>(v5);
    }

    public fun register_nft_with_image(arg0: &mut Tournament, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 < arg0.end_time, 4);
        assert!(!0x2::table::contains<0x2::object::ID, NFTEntry>(&arg0.participants, arg1), 7);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= arg0.entry_fee, 8);
        let v1 = get_nft_type(arg1);
        if (arg0.is_azur_guardian_exclusive) {
            assert!(v1 == 0x1::string::utf8(b"0xfc9d0c6972cae3f303030b993485af37e2d86ebf3b409d1e6a40cde955a43a77::azur_guardians::Nft"), 15);
        } else if (arg0.is_token_gated && 0x1::vector::length<0x1::string::String>(&arg0.allowed_collections) > 0) {
            let v2 = false;
            let v3 = 0;
            while (v3 < 0x1::vector::length<0x1::string::String>(&arg0.allowed_collections)) {
                if (v1 == *0x1::vector::borrow<0x1::string::String>(&arg0.allowed_collections, v3)) {
                    v2 = true;
                    break
                };
                v3 = v3 + 1;
            };
            assert!(v2, 13);
        };
        if (arg0.entry_fee > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg3, arg0.entry_fee, arg5)));
        };
        let v4 = NFTEntry{
            nft_id            : arg1,
            owner             : 0x2::tx_context::sender(arg5),
            votes             : 0,
            registration_time : v0,
            image_url         : 0x1::option::some<0x1::string::String>(arg2),
            nft_type          : v1,
        };
        0x2::table::add<0x2::object::ID, NFTEntry>(&mut arg0.participants, arg1, v4);
        arg0.total_participants = arg0.total_participants + 1;
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.participant_ids, arg1);
        let v5 = NFTRegisteredEvent{
            tournament_id : 0x2::object::id<Tournament>(arg0),
            nft_id        : arg1,
            owner         : 0x2::tx_context::sender(arg5),
            nft_type      : v1,
        };
        0x2::event::emit<NFTRegisteredEvent>(v5);
    }

    public fun vote_for_nft(arg0: &mut Tournament, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 1);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.end_time, 4);
        assert!(0x2::table::contains<0x2::object::ID, NFTEntry>(&arg0.participants, arg1), 14);
        let v0 = 0x2::tx_context::sender(arg3);
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.votes, v0)) {
            let v1 = 0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.votes, v0);
            let v2 = 0;
            while (v2 < 0x1::vector::length<0x2::object::ID>(v1)) {
                assert!(*0x1::vector::borrow<0x2::object::ID>(v1, v2) != arg1, 9);
                v2 = v2 + 1;
            };
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.votes, v0), arg1);
        } else {
            let v3 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v3, arg1);
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.votes, v0, v3);
        };
        let v4 = 0x2::table::borrow_mut<0x2::object::ID, NFTEntry>(&mut arg0.participants, arg1);
        v4.votes = v4.votes + 1;
        let v5 = VoteCastEvent{
            tournament_id : 0x2::object::id<Tournament>(arg0),
            nft_id        : arg1,
            voter         : v0,
        };
        0x2::event::emit<VoteCastEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

