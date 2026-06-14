module 0x983ef95759eb96520e954536679eafe75b8906af46e1ebd654e7fc1d6443bc5f::coin_flip {
    struct GameConfig has key {
        id: 0x2::object::UID,
        paused: bool,
        total_distributed: u64,
        buyback_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        jackpot_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        dev_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
    }

    struct PlayerState has store, key {
        id: 0x2::object::UID,
        owner: address,
        streak: u64,
        last_checkin_epoch: u64,
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

    public fun daily_checkin(arg0: &mut GameConfig, arg1: &mut PlayerState, arg2: &mut 0x2::coin::TreasuryCap<0x983ef95759eb96520e954536679eafe75b8906af46e1ebd654e7fc1d6443bc5f::flip_token::FLIP_TOKEN>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        let v0 = 0x2::tx_context::epoch(arg3);
        assert!(v0 > arg1.last_checkin_epoch, 4);
        assert!(arg0.total_distributed < 10000000, 3);
        arg1.last_checkin_epoch = v0;
        arg0.total_distributed = arg0.total_distributed + 1;
        0x983ef95759eb96520e954536679eafe75b8906af46e1ebd654e7fc1d6443bc5f::flip_token::mint(arg2, 1, 0x2::tx_context::sender(arg3), arg3);
    }

    public fun flip(arg0: &mut GameConfig, arg1: &mut PlayerState, arg2: &mut 0x2::coin::TreasuryCap<0x983ef95759eb96520e954536679eafe75b8906af46e1ebd654e7fc1d6443bc5f::flip_token::FLIP_TOKEN>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: bool, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == 100000000, 1);
        assert!(arg0.total_distributed < 10000000, 3);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.jackpot_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v0, 100000000 * 20 / 100));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.dev_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v0, 100000000 * 30 / 100));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.buyback_balance, v0);
        let v1 = 0x2::random::new_generator(arg5, arg6);
        let v2 = 0x2::random::generate_bool(&mut v1) == arg4;
        let v3 = if (v2) {
            arg1.streak = arg1.streak + 1;
            let v4 = base_reward(arg0.total_distributed) * streak_multiplier(arg1.streak);
            let v5 = if (arg0.total_distributed + v4 > 10000000) {
                10000000 - arg0.total_distributed
            } else {
                v4
            };
            arg0.total_distributed = arg0.total_distributed + v5;
            0x983ef95759eb96520e954536679eafe75b8906af46e1ebd654e7fc1d6443bc5f::flip_token::mint(arg2, v5, 0x2::tx_context::sender(arg6), arg6);
            v5
        } else {
            arg1.streak = 0;
            0
        };
        let v6 = FlipResult{
            player      : 0x2::tx_context::sender(arg6),
            won         : v2,
            flip_earned : v3,
            streak      : arg1.streak,
        };
        0x2::event::emit<FlipResult>(v6);
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
        };
        0x2::transfer::share_object<GameConfig>(v0);
    }

    public fun jackpot_balance(arg0: &GameConfig) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.jackpot_balance)
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

    public fun player_streak(arg0: &PlayerState) : u64 {
        arg0.streak
    }

    public fun register(arg0: &mut 0x2::tx_context::TxContext) : PlayerState {
        PlayerState{
            id                 : 0x2::object::new(arg0),
            owner              : 0x2::tx_context::sender(arg0),
            streak             : 0,
            last_checkin_epoch : 0,
        }
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

    public fun total_distributed(arg0: &GameConfig) : u64 {
        arg0.total_distributed
    }

    public fun withdraw_dev(arg0: &mut GameConfig, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.dev_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.dev_balance)), arg1)
    }

    // decompiled from Move bytecode v7
}

