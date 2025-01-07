module 0xd6eb8b23319439e91fd45221a8f33303db64691af4f3a97c5211ffb174d2880a::wyzzhe_dice_game {
    struct GameResult has copy, drop {
        your_roll: u8,
        npc_roll: u8,
        result: 0x1::string::String,
        is_winner: bool,
    }

    struct Game has key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<0x8232d9a0ed76c80f799e550e05c7f4ab8512b712e181f257b64f20c0a2a53759::wyzzheFaucet::WYZZHEFAUCET>,
        ticket: u64,
        reward: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit(arg0: &mut Game, arg1: 0x2::coin::Coin<0x8232d9a0ed76c80f799e550e05c7f4ab8512b712e181f257b64f20c0a2a53759::wyzzheFaucet::WYZZHEFAUCET>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x8232d9a0ed76c80f799e550e05c7f4ab8512b712e181f257b64f20c0a2a53759::wyzzheFaucet::WYZZHEFAUCET>(&arg1);
        assert!(v0 >= arg2, 2);
        let v1 = 0x2::coin::into_balance<0x8232d9a0ed76c80f799e550e05c7f4ab8512b712e181f257b64f20c0a2a53759::wyzzheFaucet::WYZZHEFAUCET>(arg1);
        if (v0 > arg2) {
            0x2::balance::join<0x8232d9a0ed76c80f799e550e05c7f4ab8512b712e181f257b64f20c0a2a53759::wyzzheFaucet::WYZZHEFAUCET>(&mut arg0.pool, 0x2::balance::split<0x8232d9a0ed76c80f799e550e05c7f4ab8512b712e181f257b64f20c0a2a53759::wyzzheFaucet::WYZZHEFAUCET>(&mut v1, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x8232d9a0ed76c80f799e550e05c7f4ab8512b712e181f257b64f20c0a2a53759::wyzzheFaucet::WYZZHEFAUCET>>(0x2::coin::from_balance<0x8232d9a0ed76c80f799e550e05c7f4ab8512b712e181f257b64f20c0a2a53759::wyzzheFaucet::WYZZHEFAUCET>(v1, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<0x8232d9a0ed76c80f799e550e05c7f4ab8512b712e181f257b64f20c0a2a53759::wyzzheFaucet::WYZZHEFAUCET>(&mut arg0.pool, v1);
        };
    }

    public fun game_pool(arg0: &Game) : u64 {
        0x2::balance::value<0x8232d9a0ed76c80f799e550e05c7f4ab8512b712e181f257b64f20c0a2a53759::wyzzheFaucet::WYZZHEFAUCET>(&arg0.pool)
    }

    public fun game_reward(arg0: &Game) : u64 {
        arg0.reward
    }

    public fun game_ticket(arg0: &Game) : u64 {
        arg0.ticket
    }

    public entry fun get_faucet_coin(arg0: &mut 0x2::coin::TreasuryCap<0x8232d9a0ed76c80f799e550e05c7f4ab8512b712e181f257b64f20c0a2a53759::wyzzheFaucet::WYZZHEFAUCET>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x8232d9a0ed76c80f799e550e05c7f4ab8512b712e181f257b64f20c0a2a53759::wyzzheFaucet::mint(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    fun get_random_roll(arg0: &0x2::clock::Clock) : u8 {
        ((0x2::clock::timestamp_ms(arg0) % 6 + 1) as u8)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id     : 0x2::object::new(arg0),
            pool   : 0x2::balance::zero<0x8232d9a0ed76c80f799e550e05c7f4ab8512b712e181f257b64f20c0a2a53759::wyzzheFaucet::WYZZHEFAUCET>(),
            ticket : 1000,
            reward : 2000,
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun play(arg0: u8, arg1: &mut Game, arg2: 0x2::coin::Coin<0x8232d9a0ed76c80f799e550e05c7f4ab8512b712e181f257b64f20c0a2a53759::wyzzheFaucet::WYZZHEFAUCET>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 < 7, 0);
        assert!(0x2::balance::value<0x8232d9a0ed76c80f799e550e05c7f4ab8512b712e181f257b64f20c0a2a53759::wyzzheFaucet::WYZZHEFAUCET>(&arg1.pool) >= arg1.reward - arg1.ticket, 1);
        let v0 = 0x2::coin::value<0x8232d9a0ed76c80f799e550e05c7f4ab8512b712e181f257b64f20c0a2a53759::wyzzheFaucet::WYZZHEFAUCET>(&arg2);
        assert!(v0 >= arg1.ticket, 2);
        let v1 = 0x2::coin::into_balance<0x8232d9a0ed76c80f799e550e05c7f4ab8512b712e181f257b64f20c0a2a53759::wyzzheFaucet::WYZZHEFAUCET>(arg2);
        if (v0 > arg1.ticket) {
            0x2::balance::join<0x8232d9a0ed76c80f799e550e05c7f4ab8512b712e181f257b64f20c0a2a53759::wyzzheFaucet::WYZZHEFAUCET>(&mut arg1.pool, 0x2::balance::split<0x8232d9a0ed76c80f799e550e05c7f4ab8512b712e181f257b64f20c0a2a53759::wyzzheFaucet::WYZZHEFAUCET>(&mut v1, arg1.ticket));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x8232d9a0ed76c80f799e550e05c7f4ab8512b712e181f257b64f20c0a2a53759::wyzzheFaucet::WYZZHEFAUCET>>(0x2::coin::from_balance<0x8232d9a0ed76c80f799e550e05c7f4ab8512b712e181f257b64f20c0a2a53759::wyzzheFaucet::WYZZHEFAUCET>(v1, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<0x8232d9a0ed76c80f799e550e05c7f4ab8512b712e181f257b64f20c0a2a53759::wyzzheFaucet::WYZZHEFAUCET>(&mut arg1.pool, v1);
        };
        let v2 = get_random_roll(arg3);
        let (v3, v4) = if (arg0 > v2) {
            (0x1::string::utf8(b"Win"), true)
        } else if (arg0 == v2) {
            (0x1::string::utf8(b"Draw"), false)
        } else {
            (0x1::string::utf8(b"Lose"), false)
        };
        if (v4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x8232d9a0ed76c80f799e550e05c7f4ab8512b712e181f257b64f20c0a2a53759::wyzzheFaucet::WYZZHEFAUCET>>(0x2::coin::from_balance<0x8232d9a0ed76c80f799e550e05c7f4ab8512b712e181f257b64f20c0a2a53759::wyzzheFaucet::WYZZHEFAUCET>(0x2::balance::split<0x8232d9a0ed76c80f799e550e05c7f4ab8512b712e181f257b64f20c0a2a53759::wyzzheFaucet::WYZZHEFAUCET>(&mut arg1.pool, arg1.reward), arg4), 0x2::tx_context::sender(arg4));
        };
        let v5 = GameResult{
            your_roll : arg0,
            npc_roll  : v2,
            result    : v3,
            is_winner : v4,
        };
        0x2::event::emit<GameResult>(v5);
    }

    public entry fun set_reward(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.reward = arg2;
    }

    public entry fun set_ticket(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.ticket = arg2;
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8232d9a0ed76c80f799e550e05c7f4ab8512b712e181f257b64f20c0a2a53759::wyzzheFaucet::WYZZHEFAUCET>>(0x2::coin::from_balance<0x8232d9a0ed76c80f799e550e05c7f4ab8512b712e181f257b64f20c0a2a53759::wyzzheFaucet::WYZZHEFAUCET>(0x2::balance::split<0x8232d9a0ed76c80f799e550e05c7f4ab8512b712e181f257b64f20c0a2a53759::wyzzheFaucet::WYZZHEFAUCET>(&mut arg1.pool, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

