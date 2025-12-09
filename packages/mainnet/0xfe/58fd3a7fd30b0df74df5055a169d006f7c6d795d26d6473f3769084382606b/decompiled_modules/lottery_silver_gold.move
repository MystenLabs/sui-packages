module 0xfe58fd3a7fd30b0df74df5055a169d006f7c6d795d26d6473f3769084382606b::lottery_silver_gold {
    struct SilverToGoldLottery has key {
        id: 0x2::object::UID,
        round: u64,
        entries: vector<LotteryEntry>,
        prize_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        is_drawing: bool,
    }

    struct LotteryEntry has drop, store {
        player: address,
        nft_id: 0x2::object::ID,
        entry_time: u64,
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
        prize_per_winner: u64,
    }

    public entry fun draw(arg0: &mut SilverToGoldLottery, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<LotteryEntry>(&arg0.entries);
        assert!(v0 >= 50, 3);
        assert!(!arg0.is_drawing, 3);
        arg0.is_drawing = true;
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool);
        let v2 = v1 * 5 / 100;
        let v3 = v1 * 20 / 100;
        let v4 = (v1 - v2 - v3) / 5;
        let v5 = 0x2::random::new_generator(arg1, arg2);
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0x1::vector::empty<address>();
        let v8 = 0;
        let v9 = 0;
        while (v8 < 5 && v9 < 5 * 10) {
            let v10 = 0x2::random::generate_u64_in_range(&mut v5, 0, v0 - 1);
            if (!0x1::vector::contains<u64>(&v6, &v10)) {
                0x1::vector::push_back<u64>(&mut v6, v10);
                0x1::vector::push_back<address>(&mut v7, 0x1::vector::borrow<LotteryEntry>(&arg0.entries, v10).player);
                v8 = v8 + 1;
            };
            v9 = v9 + 1;
        };
        let v11 = 0;
        while (v11 < 0x1::vector::length<address>(&v7)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.prize_pool, v4, arg2), *0x1::vector::borrow<address>(&v7, v11));
            v11 = v11 + 1;
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.prize_pool, v2, arg2), @0x77dd9e0e6bdcf6710721887d5fa5776e2ec1765080afd4fbe36c2d88bdfee6d8);
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.prize_pool, v3, arg2), @0x77dd9e0e6bdcf6710721887d5fa5776e2ec1765080afd4fbe36c2d88bdfee6d8);
        };
        let v12 = LotteryDrawn{
            round            : arg0.round,
            winners          : v7,
            prize_per_winner : v4,
        };
        0x2::event::emit<LotteryDrawn>(v12);
        arg0.entries = 0x1::vector::empty<LotteryEntry>();
        arg0.round = arg0.round + 1;
        arg0.is_drawing = false;
    }

    public entry fun enter(arg0: &mut SilverToGoldLottery, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<LotteryEntry>(&arg0.entries);
        assert!(v0 < 50, 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 5000000000, 1);
        let v1 = 0x2::tx_context::sender(arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 5000000000, arg4)));
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v1);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        let v2 = LotteryEntry{
            player     : v1,
            nft_id     : arg2,
            entry_time : 0x2::clock::timestamp_ms(arg3),
        };
        0x1::vector::push_back<LotteryEntry>(&mut arg0.entries, v2);
        let v3 = LotteryEntryAdded{
            round         : arg0.round,
            player        : v1,
            nft_id        : arg2,
            entry_number  : v0 + 1,
            total_entries : v0 + 1,
        };
        0x2::event::emit<LotteryEntryAdded>(v3);
    }

    public fun get_entry_count(arg0: &SilverToGoldLottery) : u64 {
        0x1::vector::length<LotteryEntry>(&arg0.entries)
    }

    public fun get_entry_fee() : u64 {
        5000000000
    }

    public fun get_max_entries() : u64 {
        50
    }

    public fun get_prize_pool(arg0: &SilverToGoldLottery) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool)
    }

    public fun get_round(arg0: &SilverToGoldLottery) : u64 {
        arg0.round
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SilverToGoldLottery{
            id         : 0x2::object::new(arg0),
            round      : 1,
            entries    : 0x1::vector::empty<LotteryEntry>(),
            prize_pool : 0x2::balance::zero<0x2::sui::SUI>(),
            is_drawing : false,
        };
        0x2::transfer::share_object<SilverToGoldLottery>(v0);
    }

    public fun is_full(arg0: &SilverToGoldLottery) : bool {
        0x1::vector::length<LotteryEntry>(&arg0.entries) >= 50
    }

    // decompiled from Move bytecode v6
}

