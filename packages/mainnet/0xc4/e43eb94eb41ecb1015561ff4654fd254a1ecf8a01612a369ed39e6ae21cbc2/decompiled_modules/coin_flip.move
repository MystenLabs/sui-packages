module 0xc4e43eb94eb41ecb1015561ff4654fd254a1ecf8a01612a369ed39e6ae21cbc2::coin_flip {
    struct PlayerData has drop, store {
        streak: u64,
        last_checkin_epoch: u64,
    }

    struct GameConfig has key {
        id: 0x2::object::UID,
        paused: bool,
        total_distributed: u64,
        buyback_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        jackpot_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        dev_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
        players: 0x2::table::Table<address, PlayerData>,
    }

    struct FlipResult has copy, drop {
        player: address,
        won: bool,
        flip_earned: u64,
        streak: u64,
    }

    struct JackpotWon has copy, drop {
        winner: address,
        amount_sui: u64,
    }

    struct COIN_FLIP has drop {
        dummy_field: bool,
    }

    fun base_reward(arg0: u64) : u64 {
        if (arg0 < 2500000) {
            20
        } else if (arg0 < 5000000) {
            10
        } else {
            5
        }
    }

    public fun daily_checkin(arg0: &mut GameConfig, arg1: &mut 0x2::coin::TreasuryCap<0xc4e43eb94eb41ecb1015561ff4654fd254a1ecf8a01612a369ed39e6ae21cbc2::flip_token::FLIP_TOKEN>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        assert!(arg0.total_distributed < 10000000, 3);
        let v0 = 0x2::tx_context::sender(arg2);
        if (!0x2::table::contains<address, PlayerData>(&arg0.players, v0)) {
            let v1 = PlayerData{
                streak             : 0,
                last_checkin_epoch : 0,
            };
            0x2::table::add<address, PlayerData>(&mut arg0.players, v0, v1);
        };
        let v2 = 0x2::tx_context::epoch(arg2);
        let v3 = 0x2::table::borrow_mut<address, PlayerData>(&mut arg0.players, v0);
        assert!(v2 > v3.last_checkin_epoch, 4);
        v3.last_checkin_epoch = v2;
        arg0.total_distributed = arg0.total_distributed + 1;
        0xc4e43eb94eb41ecb1015561ff4654fd254a1ecf8a01612a369ed39e6ae21cbc2::flip_token::mint(arg1, 1, v0, arg2);
    }

    public fun flip(arg0: &mut GameConfig, arg1: &mut 0x2::coin::TreasuryCap<0xc4e43eb94eb41ecb1015561ff4654fd254a1ecf8a01612a369ed39e6ae21cbc2::flip_token::FLIP_TOKEN>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: bool, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == 100000000, 1);
        assert!(arg0.total_distributed < 10000000, 3);
        let v0 = 0x2::tx_context::sender(arg5);
        if (!0x2::table::contains<address, PlayerData>(&arg0.players, v0)) {
            let v1 = PlayerData{
                streak             : 0,
                last_checkin_epoch : 0,
            };
            0x2::table::add<address, PlayerData>(&mut arg0.players, v0, v1);
        };
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.jackpot_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v2, 100000000 * 20 / 100));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.dev_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v2, 100000000 * 30 / 100));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.buyback_balance, v2);
        let v3 = 0x2::random::new_generator(arg4, arg5);
        let v4 = 0x2::random::generate_bool(&mut v3) == arg3;
        let v5 = 0x2::table::borrow_mut<address, PlayerData>(&mut arg0.players, v0);
        let v6 = if (v4) {
            v5.streak = v5.streak + 1;
            let v7 = base_reward(arg0.total_distributed) * streak_multiplier(v5.streak);
            let v8 = if (arg0.total_distributed + v7 > 10000000) {
                10000000 - arg0.total_distributed
            } else {
                v7
            };
            arg0.total_distributed = arg0.total_distributed + v8;
            0xc4e43eb94eb41ecb1015561ff4654fd254a1ecf8a01612a369ed39e6ae21cbc2::flip_token::mint(arg1, v8, v0, arg5);
            v8
        } else {
            v5.streak = 0;
            0
        };
        let v9 = FlipResult{
            player      : v0,
            won         : v4,
            flip_earned : v6,
            streak      : v5.streak,
        };
        0x2::event::emit<FlipResult>(v9);
    }

    fun init(arg0: COIN_FLIP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GameConfig{
            id                : 0x2::object::new(arg1),
            paused            : false,
            total_distributed : 0,
            buyback_balance   : 0x2::balance::zero<0x2::sui::SUI>(),
            jackpot_balance   : 0x2::balance::zero<0x2::sui::SUI>(),
            dev_balance       : 0x2::balance::zero<0x2::sui::SUI>(),
            admin             : 0x2::tx_context::sender(arg1),
            players           : 0x2::table::new<address, PlayerData>(arg1),
        };
        0x2::transfer::share_object<GameConfig>(v0);
    }

    public fun payout_jackpot(arg0: &mut GameConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.jackpot_balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.jackpot_balance, v0), arg2), arg1);
        let v1 = JackpotWon{
            winner     : arg1,
            amount_sui : v0,
        };
        0x2::event::emit<JackpotWon>(v1);
    }

    public fun set_paused(arg0: &mut GameConfig, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.paused = arg1;
    }

    fun streak_multiplier(arg0: u64) : u64 {
        if (arg0 >= 10) {
            5
        } else if (arg0 >= 5) {
            3
        } else if (arg0 >= 3) {
            2
        } else {
            1
        }
    }

    public fun withdraw_dev(arg0: &mut GameConfig, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.dev_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.dev_balance)), arg1)
    }

    // decompiled from Move bytecode v7
}

