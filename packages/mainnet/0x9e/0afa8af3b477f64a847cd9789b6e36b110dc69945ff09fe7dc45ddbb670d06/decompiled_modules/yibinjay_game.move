module 0x9e0afa8af3b477f64a847cd9789b6e36b110dc69945ff09fe7dc45ddbb670d06::yibinjay_game {
    struct GameResult has copy, drop {
        your_choice: 0x1::string::String,
        npc_choice: 0x1::string::String,
        result: 0x1::string::String,
        is_winner: bool,
    }

    struct Game has key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_faucet_coin::YIBINJAY_FAUCET_COIN>,
        ticket: u64,
        reward: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit(arg0: &mut Game, arg1: 0x2::coin::Coin<0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_faucet_coin::YIBINJAY_FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_faucet_coin::YIBINJAY_FAUCET_COIN>(&arg1);
        assert!(v0 >= arg2, 2);
        let v1 = 0x2::coin::into_balance<0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_faucet_coin::YIBINJAY_FAUCET_COIN>(arg1);
        if (v0 > arg2) {
            0x2::balance::join<0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_faucet_coin::YIBINJAY_FAUCET_COIN>(&mut arg0.pool, 0x2::balance::split<0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_faucet_coin::YIBINJAY_FAUCET_COIN>(&mut v1, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_faucet_coin::YIBINJAY_FAUCET_COIN>>(0x2::coin::from_balance<0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_faucet_coin::YIBINJAY_FAUCET_COIN>(v1, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_faucet_coin::YIBINJAY_FAUCET_COIN>(&mut arg0.pool, v1);
        };
    }

    public fun game_pool(arg0: &Game) : u64 {
        0x2::balance::value<0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_faucet_coin::YIBINJAY_FAUCET_COIN>(&arg0.pool)
    }

    public fun game_reward(arg0: &Game) : u64 {
        arg0.reward
    }

    public fun game_ticket(arg0: &Game) : u64 {
        arg0.ticket
    }

    public entry fun get_faucet_coin(arg0: &mut 0x2::coin::TreasuryCap<0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_faucet_coin::YIBINJAY_FAUCET_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_faucet_coin::mint(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    fun get_random_choice(arg0: &0x2::clock::Clock) : u8 {
        ((0x2::clock::timestamp_ms(arg0) % 3) as u8)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id     : 0x2::object::new(arg0),
            pool   : 0x2::balance::zero<0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_faucet_coin::YIBINJAY_FAUCET_COIN>(),
            ticket : 100000000,
            reward : 200000000,
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun map_choice_to_string(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Rock")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Scissors")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Paper")
        } else {
            0x1::string::utf8(b"Invalid")
        }
    }

    public entry fun play(arg0: u8, arg1: &mut Game, arg2: 0x2::coin::Coin<0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_faucet_coin::YIBINJAY_FAUCET_COIN>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_faucet_coin::YIBINJAY_FAUCET_COIN>(&arg1.pool) >= arg1.reward - arg1.ticket, 1);
        assert!(arg0 < 3, 0);
        let v0 = 0x2::coin::value<0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_faucet_coin::YIBINJAY_FAUCET_COIN>(&arg2);
        assert!(v0 >= arg1.ticket, 2);
        let v1 = 0x2::coin::into_balance<0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_faucet_coin::YIBINJAY_FAUCET_COIN>(arg2);
        if (v0 > arg1.ticket) {
            0x2::balance::join<0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_faucet_coin::YIBINJAY_FAUCET_COIN>(&mut arg1.pool, 0x2::balance::split<0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_faucet_coin::YIBINJAY_FAUCET_COIN>(&mut v1, arg1.ticket));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_faucet_coin::YIBINJAY_FAUCET_COIN>>(0x2::coin::from_balance<0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_faucet_coin::YIBINJAY_FAUCET_COIN>(v1, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_faucet_coin::YIBINJAY_FAUCET_COIN>(&mut arg1.pool, v1);
        };
        let v2 = get_random_choice(arg3);
        let (v3, v4) = if (arg0 == 0 && v2 == 1 || arg0 == 1 && v2 == 2 || arg0 == 2 && v2 == 0) {
            (0x1::string::utf8(b"Win"), true)
        } else if (arg0 == v2) {
            (0x1::string::utf8(b"Draw"), false)
        } else {
            (0x1::string::utf8(b"Lose"), false)
        };
        if (v4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_faucet_coin::YIBINJAY_FAUCET_COIN>>(0x2::coin::from_balance<0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_faucet_coin::YIBINJAY_FAUCET_COIN>(0x2::balance::split<0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_faucet_coin::YIBINJAY_FAUCET_COIN>(&mut arg1.pool, arg1.reward), arg4), 0x2::tx_context::sender(arg4));
        };
        let v5 = GameResult{
            your_choice : map_choice_to_string(arg0),
            npc_choice  : map_choice_to_string(v2),
            result      : v3,
            is_winner   : v4,
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
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_faucet_coin::YIBINJAY_FAUCET_COIN>>(0x2::coin::from_balance<0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_faucet_coin::YIBINJAY_FAUCET_COIN>(0x2::balance::split<0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_faucet_coin::YIBINJAY_FAUCET_COIN>(&mut arg1.pool, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

