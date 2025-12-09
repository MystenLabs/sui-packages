module 0xfe58fd3a7fd30b0df74df5055a169d006f7c6d795d26d6473f3769084382606b::lottery_annual {
    struct AnnualRainbowLottery has key {
        id: 0x2::object::UID,
        year: u64,
        entries: vector<LotteryEntry>,
        prize_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        is_drawing: bool,
        last_draw_timestamp: u64,
        total_entries_all_time: u64,
        total_paid_out_all_time: u64,
    }

    struct LotteryEntry has drop, store {
        player: address,
        nft_id: 0x2::object::ID,
        nft_tier: u8,
        entry_time: u64,
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
        prize_won: u64,
        total_entries: u64,
        total_pool: u64,
    }

    public entry fun draw(arg0: &mut AnnualRainbowLottery, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<LotteryEntry>(&arg0.entries);
        assert!(v0 >= 50, 3);
        assert!(!arg0.is_drawing, 3);
        arg0.is_drawing = true;
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool);
        let v2 = v1 * 10 / 100;
        let v3 = v1 * 20 / 100;
        let v4 = v1 * 70 / 100;
        let v5 = 0x2::random::new_generator(arg1, arg3);
        let v6 = 0x1::vector::borrow<LotteryEntry>(&arg0.entries, 0x2::random::generate_u64_in_range(&mut v5, 0, v0 - 1)).player;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.prize_pool, v4, arg3), v6);
        let v7 = RainbowChampion{
            id            : 0x2::object::new(arg3),
            year          : arg0.year,
            winner        : v6,
            prize_won     : v4,
            total_entries : v0,
        };
        0x2::transfer::transfer<RainbowChampion>(v7, v6);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.prize_pool, v2, arg3), @0x77dd9e0e6bdcf6710721887d5fa5776e2ec1765080afd4fbe36c2d88bdfee6d8);
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.prize_pool, v3, arg3), @0x77dd9e0e6bdcf6710721887d5fa5776e2ec1765080afd4fbe36c2d88bdfee6d8);
        };
        arg0.total_paid_out_all_time = arg0.total_paid_out_all_time + v4;
        let v8 = RainbowChampionCrowned{
            year          : arg0.year,
            champion      : v6,
            prize_won     : v4,
            total_entries : v0,
            total_pool    : v1,
        };
        0x2::event::emit<RainbowChampionCrowned>(v8);
        arg0.entries = 0x1::vector::empty<LotteryEntry>();
        arg0.year = arg0.year + 1;
        arg0.last_draw_timestamp = 0x2::clock::timestamp_ms(arg2);
        arg0.is_drawing = false;
    }

    public entry fun enter(arg0: &mut AnnualRainbowLottery, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::object::ID, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 2000000000, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 2000000000, arg5)));
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
        arg0.total_entries_all_time = arg0.total_entries_all_time + 1;
        let v2 = LotteryEntryAdded{
            year          : arg0.year,
            player        : v0,
            nft_id        : arg2,
            nft_tier      : arg3,
            total_entries : 0x1::vector::length<LotteryEntry>(&arg0.entries),
        };
        0x2::event::emit<LotteryEntryAdded>(v2);
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
            last_draw_timestamp     : 0,
            total_entries_all_time  : 0,
            total_paid_out_all_time : 0,
        };
        0x2::transfer::share_object<AnnualRainbowLottery>(v0);
    }

    // decompiled from Move bytecode v6
}

