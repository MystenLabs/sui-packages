module 0x73eb5960711aacd31384409620f6396b4cf588711280a2d0f130066bbcbe6293::move_game {
    struct GameHouse has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x1da3df7043698387821405ea29671e20bc0ecfbc5c948c3c1f08cf00940f98fc::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>,
        github_id: vector<u8>,
    }

    struct Game has key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<0x1da3df7043698387821405ea29671e20bc0ecfbc5c948c3c1f08cf00940f98fc::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>,
        ticket: u64,
        reward: u64,
    }

    struct GameResult has key {
        id: 0x2::object::UID,
        player_choice: u8,
        computer_choice: u8,
        result: u8,
        is_win: bool,
    }

    public entry fun deposit(arg0: &mut GameHouse, arg1: 0x2::coin::Coin<0x1da3df7043698387821405ea29671e20bc0ecfbc5c948c3c1f08cf00940f98fc::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>) {
        0x2::balance::join<0x1da3df7043698387821405ea29671e20bc0ecfbc5c948c3c1f08cf00940f98fc::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>(&mut arg0.balance, 0x2::coin::into_balance<0x1da3df7043698387821405ea29671e20bc0ecfbc5c948c3c1f08cf00940f98fc::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>(arg1));
    }

    fun determine_winner(arg0: u8, arg1: u8) : u8 {
        if (arg0 == arg1) {
            return 0
        };
        let v0 = if (arg0 == 0 && arg1 == 2) {
            true
        } else if (arg0 == 1 && arg1 == 0) {
            true
        } else {
            arg0 == 2 && arg1 == 1
        };
        if (v0) {
            return 1
        };
        2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameHouse{
            id        : 0x2::object::new(arg0),
            balance   : 0x2::balance::zero<0x1da3df7043698387821405ea29671e20bc0ecfbc5c948c3c1f08cf00940f98fc::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>(),
            github_id : b"Funnyyanne",
        };
        0x2::transfer::share_object<GameHouse>(v0);
    }

    public entry fun play(arg0: &mut GameHouse, arg1: u8, arg2: 0x2::coin::Coin<0x1da3df7043698387821405ea29671e20bc0ecfbc5c948c3c1f08cf00940f98fc::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 2, 0);
        let v0 = 0x2::random::new_generator(arg3, arg4);
        let v1 = ((0x2::random::generate_u8(&mut v0) % 3) as u8);
        let v2 = determine_winner(arg1, v1);
        let v3 = if (v2 == 1) {
            0x2::coin::join<0x1da3df7043698387821405ea29671e20bc0ecfbc5c948c3c1f08cf00940f98fc::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>(&mut arg2, 0x2::coin::from_balance<0x1da3df7043698387821405ea29671e20bc0ecfbc5c948c3c1f08cf00940f98fc::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>(0x2::balance::split<0x1da3df7043698387821405ea29671e20bc0ecfbc5c948c3c1f08cf00940f98fc::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>(&mut arg0.balance, 0x2::coin::value<0x1da3df7043698387821405ea29671e20bc0ecfbc5c948c3c1f08cf00940f98fc::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>(&arg2)), arg4));
            arg2
        } else if (v2 == 2) {
            0x2::balance::join<0x1da3df7043698387821405ea29671e20bc0ecfbc5c948c3c1f08cf00940f98fc::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>(&mut arg0.balance, 0x2::coin::into_balance<0x1da3df7043698387821405ea29671e20bc0ecfbc5c948c3c1f08cf00940f98fc::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>(arg2));
            0x2::coin::zero<0x1da3df7043698387821405ea29671e20bc0ecfbc5c948c3c1f08cf00940f98fc::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>(arg4)
        } else {
            arg2
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1da3df7043698387821405ea29671e20bc0ecfbc5c948c3c1f08cf00940f98fc::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>>(v3, 0x2::tx_context::sender(arg4));
        let v4 = GameResult{
            id              : 0x2::object::new(arg4),
            player_choice   : arg1,
            computer_choice : v1,
            result          : v2,
            is_win          : v2 == 1,
        };
        0x2::transfer::share_object<GameResult>(v4);
    }

    public entry fun withdraw(arg0: &mut GameHouse, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x1da3df7043698387821405ea29671e20bc0ecfbc5c948c3c1f08cf00940f98fc::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>(&arg0.balance) >= arg1, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1da3df7043698387821405ea29671e20bc0ecfbc5c948c3c1f08cf00940f98fc::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>>(0x2::coin::from_balance<0x1da3df7043698387821405ea29671e20bc0ecfbc5c948c3c1f08cf00940f98fc::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>(0x2::balance::split<0x1da3df7043698387821405ea29671e20bc0ecfbc5c948c3c1f08cf00940f98fc::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>(&mut arg0.balance, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

