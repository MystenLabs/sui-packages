module 0xfe58fd3a7fd30b0df74df5055a169d006f7c6d795d26d6473f3769084382606b::lottery_monthly {
    struct MonthlyLottery has key {
        id: 0x2::object::UID,
        round: u64,
        month: u64,
        year: u64,
        entries: vector<LotteryEntry>,
        prize_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        is_drawing: bool,
        last_draw_timestamp: u64,
    }

    struct LotteryEntry has drop, store {
        player: address,
        nft_id: 0x2::object::ID,
        nft_tier: u8,
        entry_time: u64,
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
        month: u64,
        year: u64,
        winners: vector<address>,
        prize_per_winner: u64,
        total_pool: u64,
    }

    public entry fun draw(arg0: &mut MonthlyLottery, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<LotteryEntry>(&arg0.entries);
        assert!(v0 >= 10, 3);
        assert!(!arg0.is_drawing, 3);
        arg0.is_drawing = true;
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool);
        let v2 = v1 * 10 / 100;
        let v3 = v1 * 20 / 100;
        let v4 = (v1 - v2 - v3) / 5;
        let v5 = 0x2::random::new_generator(arg1, arg3);
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0x1::vector::empty<address>();
        let v8 = if (v0 < 5) {
            v0
        } else {
            5
        };
        let v9 = 0;
        let v10 = 0;
        while (v9 < v8 && v10 < v8 * 10) {
            let v11 = 0x2::random::generate_u64_in_range(&mut v5, 0, v0 - 1);
            if (!0x1::vector::contains<u64>(&v6, &v11)) {
                0x1::vector::push_back<u64>(&mut v6, v11);
                0x1::vector::push_back<address>(&mut v7, 0x1::vector::borrow<LotteryEntry>(&arg0.entries, v11).player);
                v9 = v9 + 1;
            };
            v10 = v10 + 1;
        };
        let v12 = 0;
        while (v12 < 0x1::vector::length<address>(&v7)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.prize_pool, v4, arg3), *0x1::vector::borrow<address>(&v7, v12));
            v12 = v12 + 1;
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.prize_pool, v2, arg3), @0x77dd9e0e6bdcf6710721887d5fa5776e2ec1765080afd4fbe36c2d88bdfee6d8);
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.prize_pool, v3, arg3), @0x77dd9e0e6bdcf6710721887d5fa5776e2ec1765080afd4fbe36c2d88bdfee6d8);
        };
        let v13 = MonthlyDrawn{
            round            : arg0.round,
            month            : arg0.month,
            year             : arg0.year,
            winners          : v7,
            prize_per_winner : v4,
            total_pool       : v1,
        };
        0x2::event::emit<MonthlyDrawn>(v13);
        arg0.entries = 0x1::vector::empty<LotteryEntry>();
        arg0.round = arg0.round + 1;
        arg0.last_draw_timestamp = 0x2::clock::timestamp_ms(arg2);
        if (arg0.month == 12) {
            arg0.month = 1;
            arg0.year = arg0.year + 1;
        } else {
            arg0.month = arg0.month + 1;
        };
        arg0.is_drawing = false;
    }

    public entry fun enter(arg0: &mut MonthlyLottery, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::object::ID, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 5000000000, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 5000000000, arg5)));
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        let v1 = LotteryEntry{
            player     : v0,
            nft_id     : arg2,
            nft_tier   : arg3,
            entry_time : 0x2::clock::timestamp_ms(arg4),
        };
        0x1::vector::push_back<LotteryEntry>(&mut arg0.entries, v1);
        let v2 = LotteryEntryAdded{
            round         : arg0.round,
            player        : v0,
            nft_id        : arg2,
            nft_tier      : arg3,
            total_entries : 0x1::vector::length<LotteryEntry>(&arg0.entries) + 1,
        };
        0x2::event::emit<LotteryEntryAdded>(v2);
    }

    public fun get_current_month(arg0: &MonthlyLottery) : u64 {
        arg0.month
    }

    public fun get_current_year(arg0: &MonthlyLottery) : u64 {
        arg0.year
    }

    public fun get_entry_count(arg0: &MonthlyLottery) : u64 {
        0x1::vector::length<LotteryEntry>(&arg0.entries)
    }

    public fun get_entry_fee() : u64 {
        5000000000
    }

    public fun get_prize_pool(arg0: &MonthlyLottery) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool)
    }

    public fun get_round(arg0: &MonthlyLottery) : u64 {
        arg0.round
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MonthlyLottery{
            id                  : 0x2::object::new(arg0),
            round               : 1,
            month               : 1,
            year                : 2025,
            entries             : 0x1::vector::empty<LotteryEntry>(),
            prize_pool          : 0x2::balance::zero<0x2::sui::SUI>(),
            is_drawing          : false,
            last_draw_timestamp : 0,
        };
        0x2::transfer::share_object<MonthlyLottery>(v0);
    }

    // decompiled from Move bytecode v6
}

