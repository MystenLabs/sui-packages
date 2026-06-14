module 0x11d3008cff6976ed7eed6347343884a1f1cc0b957373dfc4ca35ad054cc6b344::flip_game {
    struct FLIP_GAME has drop {
        dummy_field: bool,
    }

    struct PlayerData has drop, store {
        streak: u64,
        last_checkin_epoch: u64,
    }

    struct GameConfig has key {
        id: 0x2::object::UID,
        paused: bool,
        total_distributed: u64,
        treasury: 0x2::coin::TreasuryCap<FLIP_GAME>,
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

    fun base_reward(arg0: u64) : u64 {
        if (arg0 < 2500000) {
            20
        } else if (arg0 < 5000000) {
            10
        } else {
            5
        }
    }

    public fun daily_checkin(arg0: &mut GameConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        assert!(arg0.total_distributed < 10000000, 3);
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::table::contains<address, PlayerData>(&arg0.players, v0)) {
            let v1 = PlayerData{
                streak             : 0,
                last_checkin_epoch : 0,
            };
            0x2::table::add<address, PlayerData>(&mut arg0.players, v0, v1);
        };
        let v2 = 0x2::tx_context::epoch(arg1);
        let v3 = 0x2::table::borrow_mut<address, PlayerData>(&mut arg0.players, v0);
        assert!(v2 > v3.last_checkin_epoch, 4);
        v3.last_checkin_epoch = v2;
        arg0.total_distributed = arg0.total_distributed + 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<FLIP_GAME>>(0x2::coin::mint<FLIP_GAME>(&mut arg0.treasury, 1, arg1), v0);
    }

    public fun flip(arg0: &mut GameConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: bool, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == 100000000, 1);
        assert!(arg0.total_distributed < 10000000, 3);
        let v0 = 0x2::tx_context::sender(arg4);
        if (!0x2::table::contains<address, PlayerData>(&arg0.players, v0)) {
            let v1 = PlayerData{
                streak             : 0,
                last_checkin_epoch : 0,
            };
            0x2::table::add<address, PlayerData>(&mut arg0.players, v0, v1);
        };
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.jackpot_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v2, 100000000 * 20 / 100));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.dev_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v2, 100000000 * 30 / 100));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.buyback_balance, v2);
        let v3 = 0x2::random::new_generator(arg3, arg4);
        let v4 = 0x2::random::generate_bool(&mut v3) == arg2;
        let v5 = 0x2::table::borrow_mut<address, PlayerData>(&mut arg0.players, v0);
        let v6 = if (v4) {
            v5.streak = v5.streak + 1;
            let v7 = base_reward(arg0.total_distributed) * streak_mult(v5.streak);
            let v8 = if (arg0.total_distributed + v7 > 10000000) {
                10000000 - arg0.total_distributed
            } else {
                v7
            };
            arg0.total_distributed = arg0.total_distributed + v8;
            0x2::transfer::public_transfer<0x2::coin::Coin<FLIP_GAME>>(0x2::coin::mint<FLIP_GAME>(&mut arg0.treasury, v8, arg4), v0);
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

    fun init(arg0: FLIP_GAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIP_GAME>(arg0, 0, b"FLIP", b"FLIP", b"Earn FLIP by playing Coin Flip. Convert to USDT on DEX.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sui-flip.xyz/logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLIP_GAME>>(v1);
        let v2 = GameConfig{
            id                : 0x2::object::new(arg1),
            paused            : false,
            total_distributed : 0,
            treasury          : v0,
            buyback_balance   : 0x2::balance::zero<0x2::sui::SUI>(),
            jackpot_balance   : 0x2::balance::zero<0x2::sui::SUI>(),
            dev_balance       : 0x2::balance::zero<0x2::sui::SUI>(),
            admin             : 0x2::tx_context::sender(arg1),
            players           : 0x2::table::new<address, PlayerData>(arg1),
        };
        0x2::transfer::share_object<GameConfig>(v2);
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

    fun streak_mult(arg0: u64) : u64 {
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

