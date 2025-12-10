module 0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::lottery_common_silver {
    struct CommonToSilverLottery has key {
        id: 0x2::object::UID,
        round: u64,
        entries: vector<LotteryEntry>,
        prize_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        is_drawing: bool,
        entered_nft_ids: vector<0x2::object::ID>,
    }

    struct LotteryEntry has copy, drop, store {
        player: address,
        nft_id: 0x2::object::ID,
        entry_index: u64,
    }

    struct LockedNFTKey has copy, drop, store {
        nft_id: 0x2::object::ID,
    }

    struct LotteryEntryAdded has copy, drop {
        round: u64,
        player: address,
        nft_id: 0x2::object::ID,
        entry_number: u64,
        total_entries: u64,
    }

    struct LotteryDrawn has copy, drop {
        round: u64,
        winners: vector<address>,
        winner_nft_ids: vector<0x2::object::ID>,
        prize_per_winner: u64,
        total_to_stakers: u64,
    }

    struct NFTReturned has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        was_winner: bool,
    }

    public entry fun draw(arg0: &mut CommonToSilverLottery, arg1: &mut 0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::Hall, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<LotteryEntry>(&arg0.entries);
        assert!(v0 >= 20, 3);
        assert!(!arg0.is_drawing, 5);
        arg0.is_drawing = true;
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool);
        let v2 = v1 * 5 / 100;
        let v3 = v1 * 15 / 100;
        let v4 = v1 - v2 - v3;
        let v5 = v4 / 3;
        let v6 = v3 + v4 - v5 * 3;
        let v7 = 0x2::random::new_generator(arg2, arg3);
        let v8 = 0x1::vector::empty<u64>();
        let v9 = 0x1::vector::empty<address>();
        let v10 = 0x1::vector::empty<0x2::object::ID>();
        let v11 = 0;
        let v12 = 0;
        while (v11 < 3 && v12 < 3 * 20) {
            let v13 = 0x2::random::generate_u64_in_range(&mut v7, 0, v0 - 1);
            if (!0x1::vector::contains<u64>(&v8, &v13)) {
                0x1::vector::push_back<u64>(&mut v8, v13);
                let v14 = 0x1::vector::borrow<LotteryEntry>(&arg0.entries, v13);
                0x1::vector::push_back<address>(&mut v9, v14.player);
                0x1::vector::push_back<0x2::object::ID>(&mut v10, v14.nft_id);
                v11 = v11 + 1;
            };
            v12 = v12 + 1;
        };
        let v15 = 0;
        while (v15 < 0x1::vector::length<address>(&v9)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.prize_pool, v5, arg3), *0x1::vector::borrow<address>(&v9, v15));
            v15 = v15 + 1;
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.prize_pool, v2, arg3), @0x77dd9e0e6bdcf6710721887d5fa5776e2ec1765080afd4fbe36c2d88bdfee6d8);
        };
        if (v6 > 0) {
            0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::deposit_lottery_rewards(0x2::coin::take<0x2::sui::SUI>(&mut arg0.prize_pool, v6, arg3), 0x1::string::utf8(b"CommonToSilver Lottery"), arg1);
        };
        let v16 = 0;
        while (v16 < v0) {
            let v17 = *0x1::vector::borrow<LotteryEntry>(&arg0.entries, v16);
            let v18 = LockedNFTKey{nft_id: v17.nft_id};
            let v19 = NFTReturned{
                nft_id     : v17.nft_id,
                owner      : v17.player,
                was_winner : 0x1::vector::contains<0x2::object::ID>(&v10, &v17.nft_id),
            };
            0x2::event::emit<NFTReturned>(v19);
            0x2::transfer::public_transfer<0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::RoastNFT>(0x2::dynamic_field::remove<LockedNFTKey, 0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::RoastNFT>(&mut arg0.id, v18), v17.player);
            v16 = v16 + 1;
        };
        let v20 = LotteryDrawn{
            round            : arg0.round,
            winners          : v9,
            winner_nft_ids   : v10,
            prize_per_winner : v5,
            total_to_stakers : v6,
        };
        0x2::event::emit<LotteryDrawn>(v20);
        arg0.entries = 0x1::vector::empty<LotteryEntry>();
        arg0.entered_nft_ids = 0x1::vector::empty<0x2::object::ID>();
        arg0.round = arg0.round + 1;
        arg0.is_drawing = false;
    }

    public entry fun emergency_return_all_nfts(arg0: &mut CommonToSilverLottery, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x77dd9e0e6bdcf6710721887d5fa5776e2ec1765080afd4fbe36c2d88bdfee6d8, 6);
        let v0 = 0;
        while (v0 < 0x1::vector::length<LotteryEntry>(&arg0.entries)) {
            let v1 = *0x1::vector::borrow<LotteryEntry>(&arg0.entries, v0);
            let v2 = LockedNFTKey{nft_id: v1.nft_id};
            0x2::transfer::public_transfer<0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::RoastNFT>(0x2::dynamic_field::remove<LockedNFTKey, 0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::RoastNFT>(&mut arg0.id, v2), v1.player);
            v0 = v0 + 1;
        };
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.prize_pool, v3, arg1), @0x77dd9e0e6bdcf6710721887d5fa5776e2ec1765080afd4fbe36c2d88bdfee6d8);
        };
        arg0.entries = 0x1::vector::empty<LotteryEntry>();
        arg0.entered_nft_ids = 0x1::vector::empty<0x2::object::ID>();
        arg0.is_drawing = false;
    }

    public entry fun enter(arg0: &mut CommonToSilverLottery, arg1: 0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::RoastNFT, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<LotteryEntry>(&arg0.entries);
        assert!(v0 < 20, 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 2000000000, 1);
        assert!(!arg0.is_drawing, 5);
        assert!(0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::is_common(&arg1), 2);
        let v1 = 0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::get_nft_id(&arg1);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg0.entered_nft_ids, &v1), 4);
        let v2 = 0x2::tx_context::sender(arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, 2000000000, arg4)));
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v2);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v3 = LockedNFTKey{nft_id: v1};
        0x2::dynamic_field::add<LockedNFTKey, 0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::RoastNFT>(&mut arg0.id, v3, arg1);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.entered_nft_ids, v1);
        let v4 = LotteryEntry{
            player      : v2,
            nft_id      : v1,
            entry_index : v0,
        };
        0x1::vector::push_back<LotteryEntry>(&mut arg0.entries, v4);
        let v5 = LotteryEntryAdded{
            round         : arg0.round,
            player        : v2,
            nft_id        : v1,
            entry_number  : v0 + 1,
            total_entries : v0 + 1,
        };
        0x2::event::emit<LotteryEntryAdded>(v5);
    }

    public fun get_entry_count(arg0: &CommonToSilverLottery) : u64 {
        0x1::vector::length<LotteryEntry>(&arg0.entries)
    }

    public fun get_entry_fee() : u64 {
        2000000000
    }

    public fun get_max_entries() : u64 {
        20
    }

    public fun get_prize_pool(arg0: &CommonToSilverLottery) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool)
    }

    public fun get_round(arg0: &CommonToSilverLottery) : u64 {
        arg0.round
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CommonToSilverLottery{
            id              : 0x2::object::new(arg0),
            round           : 1,
            entries         : 0x1::vector::empty<LotteryEntry>(),
            prize_pool      : 0x2::balance::zero<0x2::sui::SUI>(),
            is_drawing      : false,
            entered_nft_ids : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<CommonToSilverLottery>(v0);
    }

    public fun is_full(arg0: &CommonToSilverLottery) : bool {
        0x1::vector::length<LotteryEntry>(&arg0.entries) >= 20
    }

    public fun is_nft_entered(arg0: &CommonToSilverLottery, arg1: 0x2::object::ID) : bool {
        0x1::vector::contains<0x2::object::ID>(&arg0.entered_nft_ids, &arg1)
    }

    public fun is_ready_for_draw(arg0: &CommonToSilverLottery) : bool {
        0x1::vector::length<LotteryEntry>(&arg0.entries) >= 20 && !arg0.is_drawing
    }

    // decompiled from Move bytecode v6
}

