module 0xf7ed71550eb29ca3fcf1d4282f2a80f9b7f6970fcb9b6203b414e8d47b4c15fb::simple_tournament {
    struct Tournament has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        banner_url: 0x1::string::String,
        end_time: u64,
        entries: vector<Entry>,
        voters: vector<address>,
        prize_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        ended: bool,
    }

    struct Entry has copy, drop, store {
        nft_id: 0x2::object::ID,
        submitter: address,
        image_url: 0x1::string::String,
        vote_count: u64,
    }

    struct TournamentCreated has copy, drop {
        tournament_id: 0x2::object::ID,
        name: 0x1::string::String,
        end_time: u64,
    }

    struct EntrySubmitted has copy, drop {
        tournament_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        submitter: address,
    }

    struct VoteCast has copy, drop {
        tournament_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        voter: address,
    }

    struct TournamentEnded has copy, drop {
        tournament_id: 0x2::object::ID,
        total_entries: u64,
        total_prize: u64,
    }

    struct PrizeDistributed has copy, drop {
        tournament_id: 0x2::object::ID,
        winner: address,
        rank: u64,
        amount: u64,
    }

    public entry fun create_tournament(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Tournament{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            banner_url  : 0x1::string::utf8(arg2),
            end_time    : 0x2::clock::timestamp_ms(arg4) + arg3 * 3600 * 1000,
            entries     : 0x1::vector::empty<Entry>(),
            voters      : 0x1::vector::empty<address>(),
            prize_pool  : 0x2::balance::zero<0x2::sui::SUI>(),
            ended       : false,
        };
        let v1 = TournamentCreated{
            tournament_id : 0x2::object::id<Tournament>(&v0),
            name          : v0.name,
            end_time      : v0.end_time,
        };
        0x2::event::emit<TournamentCreated>(v1);
        0x2::transfer::share_object<Tournament>(v0);
    }

    public entry fun create_tournament_minutes(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Tournament{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            banner_url  : 0x1::string::utf8(arg2),
            end_time    : 0x2::clock::timestamp_ms(arg4) + arg3 * 60 * 1000,
            entries     : 0x1::vector::empty<Entry>(),
            voters      : 0x1::vector::empty<address>(),
            prize_pool  : 0x2::balance::zero<0x2::sui::SUI>(),
            ended       : false,
        };
        let v1 = TournamentCreated{
            tournament_id : 0x2::object::id<Tournament>(&v0),
            name          : v0.name,
            end_time      : v0.end_time,
        };
        0x2::event::emit<TournamentCreated>(v1);
        0x2::transfer::share_object<Tournament>(v0);
    }

    public entry fun end_tournament(arg0: &mut Tournament, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.end_time, 2);
        assert!(!arg0.ended, 6);
        arg0.ended = true;
        let v0 = 0x1::vector::length<Entry>(&arg0.entries);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool);
        let v2 = TournamentEnded{
            tournament_id : 0x2::object::id<Tournament>(arg0),
            total_entries : v0,
            total_prize   : v1,
        };
        0x2::event::emit<TournamentEnded>(v2);
        if (v0 < 5) {
            let v3 = 0;
            while (v3 < v0) {
                let v4 = 0x1::vector::borrow<Entry>(&arg0.entries, v3);
                if (0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool) >= 10000000) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.prize_pool, 10000000), arg2), v4.submitter);
                };
                v3 = v3 + 1;
            };
            return
        };
        let v5 = arg0.entries;
        let v6 = 0x1::vector::length<Entry>(&v5);
        let v7 = 0;
        while (v7 < v6) {
            let v8 = 0;
            while (v8 < v6 - v7 - 1) {
                let v9 = 0x1::vector::borrow<Entry>(&v5, v8);
                let v10 = 0x1::vector::borrow<Entry>(&v5, v8 + 1);
                if (v9.vote_count < v10.vote_count) {
                    *0x1::vector::borrow_mut<Entry>(&mut v5, v8) = *v10;
                    *0x1::vector::borrow_mut<Entry>(&mut v5, v8 + 1) = *v9;
                };
                v8 = v8 + 1;
            };
            v7 = v7 + 1;
        };
        let v11 = v1 * 60 / 100;
        let v12 = v1 * 30 / 100;
        let v13 = v1 * 10 / 100;
        if (v0 >= 1 && v11 > 0) {
            let v14 = 0x1::vector::borrow<Entry>(&v5, 0);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.prize_pool, v11), arg2), v14.submitter);
            let v15 = PrizeDistributed{
                tournament_id : 0x2::object::id<Tournament>(arg0),
                winner        : v14.submitter,
                rank          : 1,
                amount        : v11,
            };
            0x2::event::emit<PrizeDistributed>(v15);
        };
        if (v0 >= 2 && v12 > 0) {
            let v16 = 0x1::vector::borrow<Entry>(&v5, 1);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.prize_pool, v12), arg2), v16.submitter);
            let v17 = PrizeDistributed{
                tournament_id : 0x2::object::id<Tournament>(arg0),
                winner        : v16.submitter,
                rank          : 2,
                amount        : v12,
            };
            0x2::event::emit<PrizeDistributed>(v17);
        };
        if (v0 >= 3 && v13 > 0) {
            let v18 = 0x1::vector::borrow<Entry>(&v5, 2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.prize_pool, v13), arg2), v18.submitter);
            let v19 = PrizeDistributed{
                tournament_id : 0x2::object::id<Tournament>(arg0),
                winner        : v18.submitter,
                rank          : 3,
                amount        : v13,
            };
            0x2::event::emit<PrizeDistributed>(v19);
        };
    }

    public entry fun enter_tournament(arg0: &mut Tournament, arg1: address, arg2: vector<u8>, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) < arg0.end_time, 1);
        assert!(!arg0.ended, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= 10000000, 3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg3, 10000000, arg5)));
        let v0 = 0x2::object::id_from_address(arg1);
        let v1 = Entry{
            nft_id     : v0,
            submitter  : 0x2::tx_context::sender(arg5),
            image_url  : 0x1::string::utf8(arg2),
            vote_count : 0,
        };
        0x1::vector::push_back<Entry>(&mut arg0.entries, v1);
        let v2 = EntrySubmitted{
            tournament_id : 0x2::object::id<Tournament>(arg0),
            nft_id        : v0,
            submitter     : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<EntrySubmitted>(v2);
    }

    public fun get_entries_count(arg0: &Tournament) : u64 {
        0x1::vector::length<Entry>(&arg0.entries)
    }

    public fun get_entry_at(arg0: &Tournament, arg1: u64) : (0x2::object::ID, address, 0x1::string::String, u64) {
        let v0 = 0x1::vector::borrow<Entry>(&arg0.entries, arg1);
        (v0.nft_id, v0.submitter, v0.image_url, v0.vote_count)
    }

    public fun get_tournament_info(arg0: &Tournament) : (0x1::string::String, 0x1::string::String, 0x1::string::String, u64, bool, u64) {
        (arg0.name, arg0.description, arg0.banner_url, arg0.end_time, arg0.ended, 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool))
    }

    public entry fun vote(arg0: &mut Tournament, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.end_time, 1);
        assert!(!arg0.ended, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.voters)) {
            if (0x1::vector::borrow<address>(&arg0.voters, v1) == &v0) {
                abort 4
            };
            v1 = v1 + 1;
        };
        0x1::vector::push_back<address>(&mut arg0.voters, v0);
        let v2 = 0x2::object::id_from_address(arg1);
        let v3 = false;
        let v4 = 0;
        while (v4 < 0x1::vector::length<Entry>(&arg0.entries)) {
            let v5 = 0x1::vector::borrow_mut<Entry>(&mut arg0.entries, v4);
            if (v5.nft_id == v2) {
                v5.vote_count = v5.vote_count + 1;
                v3 = true;
                break
            };
            v4 = v4 + 1;
        };
        assert!(v3, 5);
        let v6 = VoteCast{
            tournament_id : 0x2::object::id<Tournament>(arg0),
            nft_id        : v2,
            voter         : v0,
        };
        0x2::event::emit<VoteCast>(v6);
    }

    // decompiled from Move bytecode v6
}

