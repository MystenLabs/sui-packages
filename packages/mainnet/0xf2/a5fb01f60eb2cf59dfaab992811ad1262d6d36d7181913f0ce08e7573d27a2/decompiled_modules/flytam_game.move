module 0xf2a5fb01f60eb2cf59dfaab992811ad1262d6d36d7181913f0ce08e7573d27a2::flytam_game {
    struct GameResult has copy, drop {
        your_choice: u8,
        npc_choice: u8,
        result: 0x1::string::String,
        is_winner: bool,
    }

    struct Game has key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<0xf2a5fb01f60eb2cf59dfaab992811ad1262d6d36d7181913f0ce08e7573d27a2::flytam_faucet_coin::FLYTAM_FAUCET_COIN>,
        ticket: u64,
        reward: u64,
    }

    fun choice9(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        0x2::random::generate_u8_in_range(&mut v0, 0, 9)
    }

    entry fun creat_game(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id     : 0x2::object::new(arg0),
            pool   : 0x2::balance::zero<0xf2a5fb01f60eb2cf59dfaab992811ad1262d6d36d7181913f0ce08e7573d27a2::flytam_faucet_coin::FLYTAM_FAUCET_COIN>(),
            ticket : 2000000,
            reward : 4000000,
        };
        0x2::transfer::share_object<Game>(v0);
    }

    public entry fun deposit(arg0: &mut Game, arg1: 0x2::coin::Coin<0xf2a5fb01f60eb2cf59dfaab992811ad1262d6d36d7181913f0ce08e7573d27a2::flytam_faucet_coin::FLYTAM_FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xf2a5fb01f60eb2cf59dfaab992811ad1262d6d36d7181913f0ce08e7573d27a2::flytam_faucet_coin::FLYTAM_FAUCET_COIN>(&arg1);
        assert!(v0 >= arg2, 2);
        let v1 = 0x2::coin::into_balance<0xf2a5fb01f60eb2cf59dfaab992811ad1262d6d36d7181913f0ce08e7573d27a2::flytam_faucet_coin::FLYTAM_FAUCET_COIN>(arg1);
        if (v0 > arg2) {
            0x2::balance::join<0xf2a5fb01f60eb2cf59dfaab992811ad1262d6d36d7181913f0ce08e7573d27a2::flytam_faucet_coin::FLYTAM_FAUCET_COIN>(&mut arg0.pool, 0x2::balance::split<0xf2a5fb01f60eb2cf59dfaab992811ad1262d6d36d7181913f0ce08e7573d27a2::flytam_faucet_coin::FLYTAM_FAUCET_COIN>(&mut v1, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf2a5fb01f60eb2cf59dfaab992811ad1262d6d36d7181913f0ce08e7573d27a2::flytam_faucet_coin::FLYTAM_FAUCET_COIN>>(0x2::coin::from_balance<0xf2a5fb01f60eb2cf59dfaab992811ad1262d6d36d7181913f0ce08e7573d27a2::flytam_faucet_coin::FLYTAM_FAUCET_COIN>(v1, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<0xf2a5fb01f60eb2cf59dfaab992811ad1262d6d36d7181913f0ce08e7573d27a2::flytam_faucet_coin::FLYTAM_FAUCET_COIN>(&mut arg0.pool, v1);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun play(arg0: u8, arg1: &mut Game, arg2: 0x2::coin::Coin<0xf2a5fb01f60eb2cf59dfaab992811ad1262d6d36d7181913f0ce08e7573d27a2::flytam_faucet_coin::FLYTAM_FAUCET_COIN>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xf2a5fb01f60eb2cf59dfaab992811ad1262d6d36d7181913f0ce08e7573d27a2::flytam_faucet_coin::FLYTAM_FAUCET_COIN>(&arg1.pool) >= arg1.reward - arg1.ticket, 1);
        assert!(arg0 >= 0 && arg0 < 10, 0);
        let v0 = 0x2::coin::value<0xf2a5fb01f60eb2cf59dfaab992811ad1262d6d36d7181913f0ce08e7573d27a2::flytam_faucet_coin::FLYTAM_FAUCET_COIN>(&arg2);
        assert!(v0 >= arg1.ticket, 2);
        let v1 = 0x2::coin::into_balance<0xf2a5fb01f60eb2cf59dfaab992811ad1262d6d36d7181913f0ce08e7573d27a2::flytam_faucet_coin::FLYTAM_FAUCET_COIN>(arg2);
        if (v0 > arg1.ticket) {
            0x2::balance::join<0xf2a5fb01f60eb2cf59dfaab992811ad1262d6d36d7181913f0ce08e7573d27a2::flytam_faucet_coin::FLYTAM_FAUCET_COIN>(&mut arg1.pool, 0x2::balance::split<0xf2a5fb01f60eb2cf59dfaab992811ad1262d6d36d7181913f0ce08e7573d27a2::flytam_faucet_coin::FLYTAM_FAUCET_COIN>(&mut v1, arg1.ticket));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf2a5fb01f60eb2cf59dfaab992811ad1262d6d36d7181913f0ce08e7573d27a2::flytam_faucet_coin::FLYTAM_FAUCET_COIN>>(0x2::coin::from_balance<0xf2a5fb01f60eb2cf59dfaab992811ad1262d6d36d7181913f0ce08e7573d27a2::flytam_faucet_coin::FLYTAM_FAUCET_COIN>(v1, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<0xf2a5fb01f60eb2cf59dfaab992811ad1262d6d36d7181913f0ce08e7573d27a2::flytam_faucet_coin::FLYTAM_FAUCET_COIN>(&mut arg1.pool, v1);
        };
        let v2 = choice9(arg3, arg4);
        let (v3, v4) = if (v2 < arg0) {
            (0x1::string::utf8(b"Win"), true)
        } else if (arg0 == v2) {
            (0x1::string::utf8(b"Draw"), false)
        } else {
            (0x1::string::utf8(b"Lose"), false)
        };
        if (v4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf2a5fb01f60eb2cf59dfaab992811ad1262d6d36d7181913f0ce08e7573d27a2::flytam_faucet_coin::FLYTAM_FAUCET_COIN>>(0x2::coin::from_balance<0xf2a5fb01f60eb2cf59dfaab992811ad1262d6d36d7181913f0ce08e7573d27a2::flytam_faucet_coin::FLYTAM_FAUCET_COIN>(0x2::balance::split<0xf2a5fb01f60eb2cf59dfaab992811ad1262d6d36d7181913f0ce08e7573d27a2::flytam_faucet_coin::FLYTAM_FAUCET_COIN>(&mut arg1.pool, arg1.reward), arg4), 0x2::tx_context::sender(arg4));
        };
        let v5 = GameResult{
            your_choice : arg0,
            npc_choice  : v2,
            result      : v3,
            is_winner   : v4,
        };
        0x2::event::emit<GameResult>(v5);
    }

    public entry fun withdraw(arg0: &mut Game, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf2a5fb01f60eb2cf59dfaab992811ad1262d6d36d7181913f0ce08e7573d27a2::flytam_faucet_coin::FLYTAM_FAUCET_COIN>>(0x2::coin::from_balance<0xf2a5fb01f60eb2cf59dfaab992811ad1262d6d36d7181913f0ce08e7573d27a2::flytam_faucet_coin::FLYTAM_FAUCET_COIN>(0x2::balance::split<0xf2a5fb01f60eb2cf59dfaab992811ad1262d6d36d7181913f0ce08e7573d27a2::flytam_faucet_coin::FLYTAM_FAUCET_COIN>(&mut arg0.pool, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

