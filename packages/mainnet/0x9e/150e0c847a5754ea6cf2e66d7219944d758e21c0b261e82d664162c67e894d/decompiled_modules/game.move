module 0x9e150e0c847a5754ea6cf2e66d7219944d758e21c0b261e82d664162c67e894d::game {
    struct GameSession has key {
        id: 0x2::object::UID,
        player: address,
        tier: u8,
        period: u8,
        entry_fee: u64,
        start_time: u64,
        score: u64,
        is_active: bool,
    }

    struct EscrowPool has key {
        id: 0x2::object::UID,
        balance: 0x2::coin::Coin<0x2::sui::SUI>,
        daily_bronze: u64,
        daily_silver: u64,
        daily_gold: u64,
        weekly_bronze: u64,
        weekly_silver: u64,
        weekly_gold: u64,
        monthly_bronze: u64,
        monthly_silver: u64,
        monthly_gold: u64,
        player_cooldowns: 0x2::table::Table<address, u64>,
        dev_address: address,
    }

    struct LeaderboardEntry has copy, drop, store {
        player: address,
        score: u64,
        tier: u8,
        period: u8,
        timestamp: u64,
    }

    struct Leaderboard has key {
        id: 0x2::object::UID,
        daily_bronze: vector<LeaderboardEntry>,
        daily_silver: vector<LeaderboardEntry>,
        daily_gold: vector<LeaderboardEntry>,
        weekly_bronze: vector<LeaderboardEntry>,
        weekly_silver: vector<LeaderboardEntry>,
        weekly_gold: vector<LeaderboardEntry>,
        monthly_bronze: vector<LeaderboardEntry>,
        monthly_silver: vector<LeaderboardEntry>,
        monthly_gold: vector<LeaderboardEntry>,
    }

    struct GameStarted has copy, drop {
        player: address,
        tier: u8,
        period: u8,
        entry_fee: u64,
    }

    struct GameCompleted has copy, drop {
        player: address,
        score: u64,
        tier: u8,
        period: u8,
    }

    struct PayoutProcessed has copy, drop {
        player: address,
        amount: u64,
        tier: u8,
        period: u8,
        rank: u8,
    }

    struct DevFeePaid has copy, drop {
        dev: address,
        amount: u64,
        tier: u8,
        period: u8,
    }

    fun add_to_pool(arg0: &mut EscrowPool, arg1: u8, arg2: u8, arg3: u64) {
        if (arg2 == 0) {
            if (arg1 == 0) {
                arg0.daily_bronze = arg0.daily_bronze + arg3;
            } else if (arg1 == 1) {
                arg0.daily_silver = arg0.daily_silver + arg3;
            } else {
                arg0.daily_gold = arg0.daily_gold + arg3;
            };
        } else if (arg2 == 1) {
            if (arg1 == 0) {
                arg0.weekly_bronze = arg0.weekly_bronze + arg3;
            } else if (arg1 == 1) {
                arg0.weekly_silver = arg0.weekly_silver + arg3;
            } else {
                arg0.weekly_gold = arg0.weekly_gold + arg3;
            };
        } else if (arg1 == 0) {
            arg0.monthly_bronze = arg0.monthly_bronze + arg3;
        } else if (arg1 == 1) {
            arg0.monthly_silver = arg0.monthly_silver + arg3;
        } else {
            arg0.monthly_gold = arg0.monthly_gold + arg3;
        };
    }

    fun borrow_entries(arg0: &Leaderboard, arg1: u8, arg2: u8) : &vector<LeaderboardEntry> {
        if (arg2 == 0) {
            if (arg1 == 0) {
                &arg0.daily_bronze
            } else if (arg1 == 1) {
                &arg0.daily_silver
            } else {
                &arg0.daily_gold
            }
        } else if (arg2 == 1) {
            if (arg1 == 0) {
                &arg0.weekly_bronze
            } else if (arg1 == 1) {
                &arg0.weekly_silver
            } else {
                &arg0.weekly_gold
            }
        } else if (arg1 == 0) {
            &arg0.monthly_bronze
        } else if (arg1 == 1) {
            &arg0.monthly_silver
        } else {
            &arg0.monthly_gold
        }
    }

    fun borrow_entries_mut(arg0: &mut Leaderboard, arg1: u8, arg2: u8) : &mut vector<LeaderboardEntry> {
        if (arg2 == 0) {
            if (arg1 == 0) {
                &mut arg0.daily_bronze
            } else if (arg1 == 1) {
                &mut arg0.daily_silver
            } else {
                &mut arg0.daily_gold
            }
        } else if (arg2 == 1) {
            if (arg1 == 0) {
                &mut arg0.weekly_bronze
            } else if (arg1 == 1) {
                &mut arg0.weekly_silver
            } else {
                &mut arg0.weekly_gold
            }
        } else if (arg1 == 0) {
            &mut arg0.monthly_bronze
        } else if (arg1 == 1) {
            &mut arg0.monthly_silver
        } else {
            &mut arg0.monthly_gold
        }
    }

    public entry fun complete_game(arg0: GameSession, arg1: &mut Leaderboard, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.player == v0, 2);
        assert!(arg0.is_active, 3);
        let v1 = arg0.tier;
        let v2 = arg0.period;
        let v3 = 0x2::tx_context::epoch_timestamp_ms(arg3) - arg0.start_time;
        assert!(v3 >= 150000, 7);
        assert!(v3 <= 210000, 8);
        assert!(arg2 <= 150000, 9);
        let v4 = LeaderboardEntry{
            player    : arg0.player,
            score     : arg2,
            tier      : v1,
            period    : v2,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        push_entry(arg1, v1, v2, v4);
        trim_entries(arg1, v1, v2, 100);
        let v5 = GameCompleted{
            player : v0,
            score  : arg2,
            tier   : v1,
            period : v2,
        };
        0x2::event::emit<GameCompleted>(v5);
        let GameSession {
            id         : v6,
            player     : _,
            tier       : _,
            period     : _,
            entry_fee  : _,
            start_time : _,
            score      : _,
            is_active  : _,
        } = arg0;
        0x2::object::delete(v6);
    }

    fun find_top_index(arg0: &vector<LeaderboardEntry>, arg1: u64, arg2: vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < arg1) {
            if (!0x1::vector::contains<u64>(&arg2, &v1)) {
                if (0x1::vector::borrow<LeaderboardEntry>(arg0, v1).score > 0) {
                    v0 = v1;
                };
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun get_entry_fee(arg0: u8) : u64 {
        100000000
    }

    public fun get_leaderboard(arg0: &Leaderboard, arg1: u8, arg2: u8) : vector<LeaderboardEntry> {
        *borrow_entries(arg0, arg1, arg2)
    }

    fun get_pool_amount(arg0: &EscrowPool, arg1: u8, arg2: u8) : u64 {
        if (arg2 == 0) {
            if (arg1 == 0) {
                arg0.daily_bronze
            } else if (arg1 == 1) {
                arg0.daily_silver
            } else {
                arg0.daily_gold
            }
        } else if (arg2 == 1) {
            if (arg1 == 0) {
                arg0.weekly_bronze
            } else if (arg1 == 1) {
                arg0.weekly_silver
            } else {
                arg0.weekly_gold
            }
        } else if (arg1 == 0) {
            arg0.monthly_bronze
        } else if (arg1 == 1) {
            arg0.monthly_silver
        } else {
            arg0.monthly_gold
        }
    }

    public fun get_pool_balance(arg0: &EscrowPool, arg1: u8, arg2: u8) : u64 {
        get_pool_amount(arg0, arg1, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = EscrowPool{
            id               : 0x2::object::new(arg0),
            balance          : 0x2::coin::zero<0x2::sui::SUI>(arg0),
            daily_bronze     : 0,
            daily_silver     : 0,
            daily_gold       : 0,
            weekly_bronze    : 0,
            weekly_silver    : 0,
            weekly_gold      : 0,
            monthly_bronze   : 0,
            monthly_silver   : 0,
            monthly_gold     : 0,
            player_cooldowns : 0x2::table::new<address, u64>(arg0),
            dev_address      : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<EscrowPool>(v0);
        let v1 = Leaderboard{
            id             : 0x2::object::new(arg0),
            daily_bronze   : 0x1::vector::empty<LeaderboardEntry>(),
            daily_silver   : 0x1::vector::empty<LeaderboardEntry>(),
            daily_gold     : 0x1::vector::empty<LeaderboardEntry>(),
            weekly_bronze  : 0x1::vector::empty<LeaderboardEntry>(),
            weekly_silver  : 0x1::vector::empty<LeaderboardEntry>(),
            weekly_gold    : 0x1::vector::empty<LeaderboardEntry>(),
            monthly_bronze : 0x1::vector::empty<LeaderboardEntry>(),
            monthly_silver : 0x1::vector::empty<LeaderboardEntry>(),
            monthly_gold   : 0x1::vector::empty<LeaderboardEntry>(),
        };
        0x2::transfer::share_object<Leaderboard>(v1);
    }

    public entry fun process_payouts(arg0: &mut EscrowPool, arg1: &mut Leaderboard, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 2, 1);
        assert!(arg3 <= 2, 5);
        let v0 = borrow_entries(arg1, arg2, arg3);
        let v1 = get_pool_amount(arg0, arg2, arg3);
        let v2 = 0x1::vector::length<LeaderboardEntry>(v0);
        if (v2 >= 3 && v1 > 0) {
            let v3 = v1 * 25 / 1000;
            let v4 = v1 - v3;
            let v5 = find_top_index(v0, v2, vector[]);
            let v6 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v6, v5);
            let v7 = find_top_index(v0, v2, v6);
            let v8 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v8, v5);
            0x1::vector::push_back<u64>(&mut v8, v7);
            let v9 = v4 * 50 / 100;
            let v10 = v4 * 30 / 100;
            let v11 = v4 * 20 / 100;
            let v12 = 0x1::vector::borrow<LeaderboardEntry>(v0, v5);
            let v13 = 0x1::vector::borrow<LeaderboardEntry>(v0, v7);
            let v14 = 0x1::vector::borrow<LeaderboardEntry>(v0, find_top_index(v0, v2, v8));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.balance, v3, arg4), arg0.dev_address);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.balance, v9, arg4), v12.player);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.balance, v10, arg4), v13.player);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.balance, v11, arg4), v14.player);
            set_pool_amount(arg0, arg2, arg3, 0);
            let v15 = DevFeePaid{
                dev    : arg0.dev_address,
                amount : v3,
                tier   : arg2,
                period : arg3,
            };
            0x2::event::emit<DevFeePaid>(v15);
            let v16 = PayoutProcessed{
                player : v12.player,
                amount : v9,
                tier   : arg2,
                period : arg3,
                rank   : 1,
            };
            0x2::event::emit<PayoutProcessed>(v16);
            let v17 = PayoutProcessed{
                player : v13.player,
                amount : v10,
                tier   : arg2,
                period : arg3,
                rank   : 2,
            };
            0x2::event::emit<PayoutProcessed>(v17);
            let v18 = PayoutProcessed{
                player : v14.player,
                amount : v11,
                tier   : arg2,
                period : arg3,
                rank   : 3,
            };
            0x2::event::emit<PayoutProcessed>(v18);
        };
    }

    fun push_entry(arg0: &mut Leaderboard, arg1: u8, arg2: u8, arg3: LeaderboardEntry) {
        if (arg2 == 0) {
            if (arg1 == 0) {
                0x1::vector::push_back<LeaderboardEntry>(&mut arg0.daily_bronze, arg3);
            } else if (arg1 == 1) {
                0x1::vector::push_back<LeaderboardEntry>(&mut arg0.daily_silver, arg3);
            } else {
                0x1::vector::push_back<LeaderboardEntry>(&mut arg0.daily_gold, arg3);
            };
        } else if (arg2 == 1) {
            if (arg1 == 0) {
                0x1::vector::push_back<LeaderboardEntry>(&mut arg0.weekly_bronze, arg3);
            } else if (arg1 == 1) {
                0x1::vector::push_back<LeaderboardEntry>(&mut arg0.weekly_silver, arg3);
            } else {
                0x1::vector::push_back<LeaderboardEntry>(&mut arg0.weekly_gold, arg3);
            };
        } else if (arg1 == 0) {
            0x1::vector::push_back<LeaderboardEntry>(&mut arg0.monthly_bronze, arg3);
        } else if (arg1 == 1) {
            0x1::vector::push_back<LeaderboardEntry>(&mut arg0.monthly_silver, arg3);
        } else {
            0x1::vector::push_back<LeaderboardEntry>(&mut arg0.monthly_gold, arg3);
        };
    }

    public entry fun set_dev_address(arg0: &mut EscrowPool, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.dev_address, 2);
        arg0.dev_address = arg1;
    }

    fun set_pool_amount(arg0: &mut EscrowPool, arg1: u8, arg2: u8, arg3: u64) {
        if (arg2 == 0) {
            if (arg1 == 0) {
                arg0.daily_bronze = arg3;
            } else if (arg1 == 1) {
                arg0.daily_silver = arg3;
            } else {
                arg0.daily_gold = arg3;
            };
        } else if (arg2 == 1) {
            if (arg1 == 0) {
                arg0.weekly_bronze = arg3;
            } else if (arg1 == 1) {
                arg0.weekly_silver = arg3;
            } else {
                arg0.weekly_gold = arg3;
            };
        } else if (arg1 == 0) {
            arg0.monthly_bronze = arg3;
        } else if (arg1 == 1) {
            arg0.monthly_silver = arg3;
        } else {
            arg0.monthly_gold = arg3;
        };
    }

    public entry fun start_game(arg0: &mut EscrowPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = get_entry_fee(arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v1, 0);
        assert!(arg2 <= 2, 1);
        assert!(arg3 <= 2, 5);
        let v2 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        if (0x2::table::contains<address, u64>(&arg0.player_cooldowns, v0)) {
            assert!(v2 >= *0x2::table::borrow<address, u64>(&arg0.player_cooldowns, v0) + 10000, 6);
            *0x2::table::borrow_mut<address, u64>(&mut arg0.player_cooldowns, v0) = v2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.player_cooldowns, v0, v2);
        };
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.balance, arg1);
        add_to_pool(arg0, arg2, arg3, v1);
        let v3 = GameSession{
            id         : 0x2::object::new(arg4),
            player     : v0,
            tier       : arg2,
            period     : arg3,
            entry_fee  : v1,
            start_time : 0x2::tx_context::epoch_timestamp_ms(arg4),
            score      : 0,
            is_active  : true,
        };
        0x2::transfer::transfer<GameSession>(v3, v0);
        let v4 = GameStarted{
            player    : v0,
            tier      : arg2,
            period    : arg3,
            entry_fee : v1,
        };
        0x2::event::emit<GameStarted>(v4);
    }

    fun trim_entries(arg0: &mut Leaderboard, arg1: u8, arg2: u8, arg3: u64) {
        let v0 = 0x1::vector::length<LeaderboardEntry>(borrow_entries(arg0, arg1, arg2));
        while (v0 > arg3) {
            0x1::vector::pop_back<LeaderboardEntry>(borrow_entries_mut(arg0, arg1, arg2));
            v0 = v0 - 1;
        };
    }

    // decompiled from Move bytecode v7
}

