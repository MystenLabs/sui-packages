module 0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::lottery_monthly {
    struct MonthlyLottery has key {
        id: 0x2::object::UID,
        round: u64,
        entries: vector<LotteryEntry>,
        prize_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        is_drawing: bool,
        entered_nft_ids: vector<0x2::object::ID>,
        round_start_timestamp: u64,
        next_draw_timestamp: u64,
        last_draw_timestamp: u64,
    }

    struct LotteryEntry has copy, drop, store {
        player: address,
        nft_id: 0x2::object::ID,
        nft_tier: u8,
    }

    struct LockedNFTKey has copy, drop, store {
        nft_id: 0x2::object::ID,
    }

    struct LotteryEntryAdded has copy, drop {
        round: u64,
        player: address,
        nft_id: 0x2::object::ID,
        nft_tier: u8,
        total_entries: u64,
    }

    struct MonthlyDrawn has copy, drop {
        round: u64,
        winners: vector<address>,
        winner_nft_ids: vector<0x2::object::ID>,
        prize_per_winner: u64,
        total_pool: u64,
        total_to_stakers: u64,
    }

    struct NFTReturned has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        was_winner: bool,
    }

    struct EntryWithdrawn has copy, drop {
        round: u64,
        player: address,
        nft_id: 0x2::object::ID,
        withdrawal_fee: u64,
    }

    public fun can_draw(arg0: &MonthlyLottery, arg1: &0x2::clock::Clock) : bool {
        let v0 = arg0.next_draw_timestamp > 0 && 0x2::clock::timestamp_ms(arg1) >= arg0.next_draw_timestamp;
        if (0x1::vector::length<LotteryEntry>(&arg0.entries) >= 10) {
            if (v0) {
                !arg0.is_drawing
            } else {
                false
            }
        } else {
            false
        }
    }

    public entry fun draw(arg0: &mut MonthlyLottery, arg1: &mut 0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::Hall, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<LotteryEntry>(&arg0.entries);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= 10, 7);
        assert!(!arg0.is_drawing, 5);
        assert!(arg0.next_draw_timestamp > 0, 6);
        assert!(v1 >= arg0.next_draw_timestamp, 6);
        arg0.is_drawing = true;
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool);
        let v3 = v2 * 10 / 100;
        let v4 = v2 * 15 / 100;
        let v5 = v2 - v3 - v4;
        let v6 = if (v0 < 5) {
            v0
        } else {
            5
        };
        let v7 = if (v6 > 0) {
            v5 / v6
        } else {
            0
        };
        let v8 = if (v6 > 0) {
            v5 - v7 * v6
        } else {
            v5
        };
        let v9 = v4 + v8;
        let v10 = 0x2::random::new_generator(arg2, arg4);
        let v11 = 0x1::vector::empty<u64>();
        let v12 = 0x1::vector::empty<address>();
        let v13 = 0x1::vector::empty<0x2::object::ID>();
        let v14 = 0;
        let v15 = 0;
        while (v14 < v6 && v15 < v6 * 20) {
            let v16 = 0x2::random::generate_u64_in_range(&mut v10, 0, v0 - 1);
            if (!0x1::vector::contains<u64>(&v11, &v16)) {
                0x1::vector::push_back<u64>(&mut v11, v16);
                let v17 = 0x1::vector::borrow<LotteryEntry>(&arg0.entries, v16);
                0x1::vector::push_back<address>(&mut v12, v17.player);
                0x1::vector::push_back<0x2::object::ID>(&mut v13, v17.nft_id);
                v14 = v14 + 1;
            };
            v15 = v15 + 1;
        };
        let v18 = 0;
        while (v18 < 0x1::vector::length<address>(&v12)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.prize_pool, v7, arg4), *0x1::vector::borrow<address>(&v12, v18));
            v18 = v18 + 1;
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.prize_pool, v3, arg4), @0x77dd9e0e6bdcf6710721887d5fa5776e2ec1765080afd4fbe36c2d88bdfee6d8);
        };
        if (v9 > 0) {
            0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::deposit_lottery_rewards(0x2::coin::take<0x2::sui::SUI>(&mut arg0.prize_pool, v9, arg4), 0x1::string::utf8(b"Monthly Mixed Lottery"), arg1);
        };
        let v19 = 0;
        while (v19 < v0) {
            let v20 = *0x1::vector::borrow<LotteryEntry>(&arg0.entries, v19);
            let v21 = LockedNFTKey{nft_id: v20.nft_id};
            let v22 = NFTReturned{
                nft_id     : v20.nft_id,
                owner      : v20.player,
                was_winner : 0x1::vector::contains<0x2::object::ID>(&v13, &v20.nft_id),
            };
            0x2::event::emit<NFTReturned>(v22);
            0x2::transfer::public_transfer<0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::RoastNFT>(0x2::dynamic_field::remove<LockedNFTKey, 0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::RoastNFT>(&mut arg0.id, v21), v20.player);
            v19 = v19 + 1;
        };
        let v23 = MonthlyDrawn{
            round            : arg0.round,
            winners          : v12,
            winner_nft_ids   : v13,
            prize_per_winner : v7,
            total_pool       : v2,
            total_to_stakers : v9,
        };
        0x2::event::emit<MonthlyDrawn>(v23);
        arg0.entries = 0x1::vector::empty<LotteryEntry>();
        arg0.entered_nft_ids = 0x1::vector::empty<0x2::object::ID>();
        arg0.round = arg0.round + 1;
        arg0.last_draw_timestamp = v1;
        arg0.round_start_timestamp = 0;
        arg0.next_draw_timestamp = v1 + 2592000000;
        arg0.is_drawing = false;
    }

    public entry fun emergency_return_all_nfts(arg0: &mut MonthlyLottery, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x77dd9e0e6bdcf6710721887d5fa5776e2ec1765080afd4fbe36c2d88bdfee6d8, 8);
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
        arg0.round_start_timestamp = 0;
    }

    public entry fun enter(arg0: &mut MonthlyLottery, arg1: 0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::RoastNFT, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 5000000000, 1);
        assert!(!arg0.is_drawing, 5);
        let v0 = 0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::get_nft_id(&arg1);
        let v1 = 0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::get_rarity(&arg1);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg0.entered_nft_ids, &v0), 4);
        let v2 = 0x2::tx_context::sender(arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, 5000000000, arg4)));
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v2);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v3 = LockedNFTKey{nft_id: v0};
        0x2::dynamic_field::add<LockedNFTKey, 0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::RoastNFT>(&mut arg0.id, v3, arg1);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.entered_nft_ids, v0);
        if (arg0.round_start_timestamp == 0) {
            arg0.round_start_timestamp = 0x2::clock::timestamp_ms(arg3);
            if (arg0.round == 1) {
                arg0.next_draw_timestamp = arg0.round_start_timestamp + 604800000;
            } else {
                arg0.next_draw_timestamp = arg0.round_start_timestamp + 2592000000;
            };
        };
        let v4 = LotteryEntry{
            player   : v2,
            nft_id   : v0,
            nft_tier : v1,
        };
        0x1::vector::push_back<LotteryEntry>(&mut arg0.entries, v4);
        let v5 = LotteryEntryAdded{
            round         : arg0.round,
            player        : v2,
            nft_id        : v0,
            nft_tier      : v1,
            total_entries : 0x1::vector::length<LotteryEntry>(&arg0.entries),
        };
        0x2::event::emit<LotteryEntryAdded>(v5);
    }

    public fun get_entry_count(arg0: &MonthlyLottery) : u64 {
        0x1::vector::length<LotteryEntry>(&arg0.entries)
    }

    public fun get_entry_fee() : u64 {
        5000000000
    }

    public fun get_next_draw_timestamp(arg0: &MonthlyLottery) : u64 {
        arg0.next_draw_timestamp
    }

    public fun get_prize_pool(arg0: &MonthlyLottery) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool)
    }

    public fun get_round(arg0: &MonthlyLottery) : u64 {
        arg0.round
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MonthlyLottery{
            id                    : 0x2::object::new(arg0),
            round                 : 1,
            entries               : 0x1::vector::empty<LotteryEntry>(),
            prize_pool            : 0x2::balance::zero<0x2::sui::SUI>(),
            is_drawing            : false,
            entered_nft_ids       : 0x1::vector::empty<0x2::object::ID>(),
            round_start_timestamp : 0,
            next_draw_timestamp   : 0,
            last_draw_timestamp   : 0,
        };
        0x2::transfer::share_object<MonthlyLottery>(v0);
    }

    public fun is_nft_entered(arg0: &MonthlyLottery, arg1: 0x2::object::ID) : bool {
        0x1::vector::contains<0x2::object::ID>(&arg0.entered_nft_ids, &arg1)
    }

    public entry fun withdraw(arg0: &mut MonthlyLottery, arg1: &mut 0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::Hall, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_drawing, 5);
        assert!(0x1::vector::contains<0x2::object::ID>(&arg0.entered_nft_ids, &arg2), 9);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::vector::length<LotteryEntry>(&arg0.entries);
        let v2 = v1;
        let v3 = 0;
        while (v3 < v1) {
            let v4 = 0x1::vector::borrow<LotteryEntry>(&arg0.entries, v3);
            if (v4.nft_id == arg2) {
                assert!(v4.player == v0, 10);
                v2 = v3;
                break
            };
            v3 = v3 + 1;
        };
        assert!(v2 < v1, 9);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= 5000000000, 1);
        let v5 = 0x2::coin::split<0x2::sui::SUI>(&mut arg3, 5000000000, arg4);
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&v5);
        let v7 = v6 * 10 / 100;
        let v8 = v6 * 15 / 100;
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v5, v7, arg4), @0x77dd9e0e6bdcf6710721887d5fa5776e2ec1765080afd4fbe36c2d88bdfee6d8);
        };
        if (v8 > 0) {
            0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::deposit_lottery_rewards(0x2::coin::split<0x2::sui::SUI>(&mut v5, v8, arg4), 0x1::string::utf8(b"Monthly Lottery Withdrawal Fee"), arg1);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x2::sui::SUI>(v5));
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        let v9 = LockedNFTKey{nft_id: arg2};
        0x2::transfer::public_transfer<0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::RoastNFT>(0x2::dynamic_field::remove<LockedNFTKey, 0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::RoastNFT>(&mut arg0.id, v9), v0);
        let (v10, v11) = 0x1::vector::index_of<0x2::object::ID>(&arg0.entered_nft_ids, &arg2);
        if (v10) {
            0x1::vector::remove<0x2::object::ID>(&mut arg0.entered_nft_ids, v11);
        };
        0x1::vector::remove<LotteryEntry>(&mut arg0.entries, v2);
        let v12 = EntryWithdrawn{
            round          : arg0.round,
            player         : v0,
            nft_id         : arg2,
            withdrawal_fee : 5000000000,
        };
        0x2::event::emit<EntryWithdrawn>(v12);
    }

    // decompiled from Move bytecode v6
}

