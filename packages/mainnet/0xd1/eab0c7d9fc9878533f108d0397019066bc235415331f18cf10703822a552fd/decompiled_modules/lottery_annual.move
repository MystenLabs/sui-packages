module 0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::lottery_annual {
    struct AnnualRainbowLottery has key {
        id: 0x2::object::UID,
        year: u64,
        entries: vector<LotteryEntry>,
        prize_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        is_drawing: bool,
        entered_nft_ids: vector<0x2::object::ID>,
        round_start_timestamp: u64,
        next_draw_timestamp: u64,
        last_draw_timestamp: u64,
        total_entries_all_time: u64,
        total_paid_out_all_time: u64,
    }

    struct LotteryEntry has copy, drop, store {
        player: address,
        nft_id: 0x2::object::ID,
        nft_tier: u8,
    }

    struct LockedNFTKey has copy, drop, store {
        nft_id: 0x2::object::ID,
    }

    struct RainbowChampion has store, key {
        id: 0x2::object::UID,
        year: u64,
        winner: address,
        prize_won: u64,
        total_entries: u64,
    }

    struct LotteryEntryAdded has copy, drop {
        year: u64,
        player: address,
        nft_id: 0x2::object::ID,
        nft_tier: u8,
        total_entries: u64,
    }

    struct RainbowChampionCrowned has copy, drop {
        year: u64,
        champion: address,
        champion_nft_id: 0x2::object::ID,
        prize_won: u64,
        total_entries: u64,
        total_pool: u64,
        total_to_stakers: u64,
    }

    struct NFTReturned has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        was_winner: bool,
    }

    struct EntryWithdrawn has copy, drop {
        year: u64,
        player: address,
        nft_id: 0x2::object::ID,
        withdrawal_fee: u64,
    }

    public fun can_draw(arg0: &AnnualRainbowLottery, arg1: &0x2::clock::Clock) : bool {
        let v0 = arg0.next_draw_timestamp > 0 && 0x2::clock::timestamp_ms(arg1) >= arg0.next_draw_timestamp;
        if (0x1::vector::length<LotteryEntry>(&arg0.entries) >= 50) {
            if (v0) {
                !arg0.is_drawing
            } else {
                false
            }
        } else {
            false
        }
    }

    public entry fun draw(arg0: &mut AnnualRainbowLottery, arg1: &mut 0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::Hall, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<LotteryEntry>(&arg0.entries);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= 50, 7);
        assert!(!arg0.is_drawing, 5);
        assert!(arg0.next_draw_timestamp > 0, 6);
        assert!(v1 >= arg0.next_draw_timestamp, 6);
        arg0.is_drawing = true;
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool);
        let v3 = v2 * 70 / 100;
        let v4 = v2 * 10 / 100;
        let v5 = v2 * 15 / 100;
        let v6 = v5 + v2 - v3 - v4 - v5;
        let v7 = 0x2::random::new_generator(arg2, arg4);
        let v8 = 0x1::vector::borrow<LotteryEntry>(&arg0.entries, 0x2::random::generate_u64_in_range(&mut v7, 0, v0 - 1));
        let v9 = v8.player;
        let v10 = v8.nft_id;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.prize_pool, v3, arg4), v9);
        let v11 = RainbowChampion{
            id            : 0x2::object::new(arg4),
            year          : arg0.year,
            winner        : v9,
            prize_won     : v3,
            total_entries : v0,
        };
        0x2::transfer::public_transfer<RainbowChampion>(v11, v9);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.prize_pool, v4, arg4), @0x77dd9e0e6bdcf6710721887d5fa5776e2ec1765080afd4fbe36c2d88bdfee6d8);
        };
        if (v6 > 0) {
            0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::deposit_lottery_rewards(0x2::coin::take<0x2::sui::SUI>(&mut arg0.prize_pool, v6, arg4), 0x1::string::utf8(b"Annual Rainbow Lottery"), arg1);
        };
        arg0.total_paid_out_all_time = arg0.total_paid_out_all_time + v3;
        let v12 = 0;
        while (v12 < v0) {
            let v13 = *0x1::vector::borrow<LotteryEntry>(&arg0.entries, v12);
            let v14 = LockedNFTKey{nft_id: v13.nft_id};
            let v15 = NFTReturned{
                nft_id     : v13.nft_id,
                owner      : v13.player,
                was_winner : v13.nft_id == v10,
            };
            0x2::event::emit<NFTReturned>(v15);
            0x2::transfer::public_transfer<0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::RoastNFT>(0x2::dynamic_field::remove<LockedNFTKey, 0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::RoastNFT>(&mut arg0.id, v14), v13.player);
            v12 = v12 + 1;
        };
        let v16 = RainbowChampionCrowned{
            year             : arg0.year,
            champion         : v9,
            champion_nft_id  : v10,
            prize_won        : v3,
            total_entries    : v0,
            total_pool       : v2,
            total_to_stakers : v6,
        };
        0x2::event::emit<RainbowChampionCrowned>(v16);
        arg0.entries = 0x1::vector::empty<LotteryEntry>();
        arg0.entered_nft_ids = 0x1::vector::empty<0x2::object::ID>();
        arg0.year = arg0.year + 1;
        arg0.last_draw_timestamp = v1;
        arg0.round_start_timestamp = 0;
        arg0.next_draw_timestamp = v1 + 31536000000;
        arg0.is_drawing = false;
    }

    public entry fun emergency_return_all_nfts(arg0: &mut AnnualRainbowLottery, arg1: &mut 0x2::tx_context::TxContext) {
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

    public entry fun enter(arg0: &mut AnnualRainbowLottery, arg1: 0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::RoastNFT, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 2000000000, 1);
        assert!(!arg0.is_drawing, 5);
        let v0 = 0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::get_nft_id(&arg1);
        let v1 = 0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::get_rarity(&arg1);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg0.entered_nft_ids, &v0), 4);
        let v2 = 0x2::tx_context::sender(arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, 2000000000, arg4)));
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
            if (arg0.year == 2025) {
                arg0.next_draw_timestamp = arg0.round_start_timestamp + 2592000000;
            } else {
                arg0.next_draw_timestamp = arg0.round_start_timestamp + 31536000000;
            };
        };
        let v4 = LotteryEntry{
            player   : v2,
            nft_id   : v0,
            nft_tier : v1,
        };
        0x1::vector::push_back<LotteryEntry>(&mut arg0.entries, v4);
        arg0.total_entries_all_time = arg0.total_entries_all_time + 1;
        let v5 = LotteryEntryAdded{
            year          : arg0.year,
            player        : v2,
            nft_id        : v0,
            nft_tier      : v1,
            total_entries : 0x1::vector::length<LotteryEntry>(&arg0.entries),
        };
        0x2::event::emit<LotteryEntryAdded>(v5);
    }

    public fun get_current_year(arg0: &AnnualRainbowLottery) : u64 {
        arg0.year
    }

    public fun get_entry_count(arg0: &AnnualRainbowLottery) : u64 {
        0x1::vector::length<LotteryEntry>(&arg0.entries)
    }

    public fun get_entry_fee() : u64 {
        2000000000
    }

    public fun get_next_draw_timestamp(arg0: &AnnualRainbowLottery) : u64 {
        arg0.next_draw_timestamp
    }

    public fun get_prize_pool(arg0: &AnnualRainbowLottery) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool)
    }

    public fun get_total_entries_all_time(arg0: &AnnualRainbowLottery) : u64 {
        arg0.total_entries_all_time
    }

    public fun get_total_paid_out(arg0: &AnnualRainbowLottery) : u64 {
        arg0.total_paid_out_all_time
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AnnualRainbowLottery{
            id                      : 0x2::object::new(arg0),
            year                    : 2025,
            entries                 : 0x1::vector::empty<LotteryEntry>(),
            prize_pool              : 0x2::balance::zero<0x2::sui::SUI>(),
            is_drawing              : false,
            entered_nft_ids         : 0x1::vector::empty<0x2::object::ID>(),
            round_start_timestamp   : 0,
            next_draw_timestamp     : 0,
            last_draw_timestamp     : 0,
            total_entries_all_time  : 0,
            total_paid_out_all_time : 0,
        };
        0x2::transfer::share_object<AnnualRainbowLottery>(v0);
    }

    public fun is_nft_entered(arg0: &AnnualRainbowLottery, arg1: 0x2::object::ID) : bool {
        0x1::vector::contains<0x2::object::ID>(&arg0.entered_nft_ids, &arg1)
    }

    public entry fun withdraw(arg0: &mut AnnualRainbowLottery, arg1: &mut 0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::Hall, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
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
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= 2000000000, 1);
        let v5 = 0x2::coin::split<0x2::sui::SUI>(&mut arg3, 2000000000, arg4);
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&v5);
        let v7 = v6 * 10 / 100;
        let v8 = v6 * 15 / 100;
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v5, v7, arg4), @0x77dd9e0e6bdcf6710721887d5fa5776e2ec1765080afd4fbe36c2d88bdfee6d8);
        };
        if (v8 > 0) {
            0xd1eab0c7d9fc9878533f108d0397019066bc235415331f18cf10703822a552fd::hall_of_shame::deposit_lottery_rewards(0x2::coin::split<0x2::sui::SUI>(&mut v5, v8, arg4), 0x1::string::utf8(b"Annual Lottery Withdrawal Fee"), arg1);
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
            year           : arg0.year,
            player         : v0,
            nft_id         : arg2,
            withdrawal_fee : 2000000000,
        };
        0x2::event::emit<EntryWithdrawn>(v12);
    }

    // decompiled from Move bytecode v6
}

