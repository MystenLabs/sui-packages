module 0xef5724193072afce5248ac97e058c75fe93b11b17f77adbcb24f6562ccadbe42::game {
    struct GameResult has copy, drop {
        your_roll: u64,
        npc_roll: u64,
        result: 0x1::string::String,
        is_winner: bool,
    }

    struct Game has key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<0xf8b2b94d4c27e5330870af87f8c617fd58798e8ae99683bf69e95bf294b7593d::giizhang_faucet_coin::GIIZHANG_FAUCET_COIN>,
        ticket: u64,
        reward: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit(arg0: &mut Game, arg1: 0x2::coin::Coin<0xf8b2b94d4c27e5330870af87f8c617fd58798e8ae99683bf69e95bf294b7593d::giizhang_faucet_coin::GIIZHANG_FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xf8b2b94d4c27e5330870af87f8c617fd58798e8ae99683bf69e95bf294b7593d::giizhang_faucet_coin::GIIZHANG_FAUCET_COIN>(&arg1);
        assert!(v0 >= arg2, 2);
        let v1 = 0x2::coin::into_balance<0xf8b2b94d4c27e5330870af87f8c617fd58798e8ae99683bf69e95bf294b7593d::giizhang_faucet_coin::GIIZHANG_FAUCET_COIN>(arg1);
        if (v0 > arg2) {
            0x2::balance::join<0xf8b2b94d4c27e5330870af87f8c617fd58798e8ae99683bf69e95bf294b7593d::giizhang_faucet_coin::GIIZHANG_FAUCET_COIN>(&mut arg0.pool, 0x2::balance::split<0xf8b2b94d4c27e5330870af87f8c617fd58798e8ae99683bf69e95bf294b7593d::giizhang_faucet_coin::GIIZHANG_FAUCET_COIN>(&mut v1, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf8b2b94d4c27e5330870af87f8c617fd58798e8ae99683bf69e95bf294b7593d::giizhang_faucet_coin::GIIZHANG_FAUCET_COIN>>(0x2::coin::from_balance<0xf8b2b94d4c27e5330870af87f8c617fd58798e8ae99683bf69e95bf294b7593d::giizhang_faucet_coin::GIIZHANG_FAUCET_COIN>(v1, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<0xf8b2b94d4c27e5330870af87f8c617fd58798e8ae99683bf69e95bf294b7593d::giizhang_faucet_coin::GIIZHANG_FAUCET_COIN>(&mut arg0.pool, v1);
        };
    }

    public fun game_pool(arg0: &Game) : u64 {
        0x2::balance::value<0xf8b2b94d4c27e5330870af87f8c617fd58798e8ae99683bf69e95bf294b7593d::giizhang_faucet_coin::GIIZHANG_FAUCET_COIN>(&arg0.pool)
    }

    public fun game_reward(arg0: &Game) : u64 {
        arg0.reward
    }

    public fun game_ticket(arg0: &Game) : u64 {
        arg0.ticket
    }

    public entry fun get_faucet_coin(arg0: &mut 0x2::coin::TreasuryCap<0xf8b2b94d4c27e5330870af87f8c617fd58798e8ae99683bf69e95bf294b7593d::giizhang_faucet_coin::GIIZHANG_FAUCET_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0xf8b2b94d4c27e5330870af87f8c617fd58798e8ae99683bf69e95bf294b7593d::giizhang_faucet_coin::mint(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    fun get_random_roll(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        0x2::random::generate_u64_in_range(&mut v0, 0, 3)
    }

    fun get_random_roll_2(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        0x2::random::generate_u64_in_range(&mut v0, 0, 3)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id     : 0x2::object::new(arg0),
            pool   : 0x2::balance::zero<0xf8b2b94d4c27e5330870af87f8c617fd58798e8ae99683bf69e95bf294b7593d::giizhang_faucet_coin::GIIZHANG_FAUCET_COIN>(),
            ticket : 1000,
            reward : 2000,
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun play(arg0: &mut Game, arg1: 0x2::coin::Coin<0xf8b2b94d4c27e5330870af87f8c617fd58798e8ae99683bf69e95bf294b7593d::giizhang_faucet_coin::GIIZHANG_FAUCET_COIN>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xf8b2b94d4c27e5330870af87f8c617fd58798e8ae99683bf69e95bf294b7593d::giizhang_faucet_coin::GIIZHANG_FAUCET_COIN>(&arg0.pool) >= arg0.reward - arg0.ticket, 1);
        let v0 = 0x2::coin::value<0xf8b2b94d4c27e5330870af87f8c617fd58798e8ae99683bf69e95bf294b7593d::giizhang_faucet_coin::GIIZHANG_FAUCET_COIN>(&arg1);
        assert!(v0 >= arg0.ticket, 2);
        let v1 = 0x2::coin::into_balance<0xf8b2b94d4c27e5330870af87f8c617fd58798e8ae99683bf69e95bf294b7593d::giizhang_faucet_coin::GIIZHANG_FAUCET_COIN>(arg1);
        if (v0 > arg0.ticket) {
            0x2::balance::join<0xf8b2b94d4c27e5330870af87f8c617fd58798e8ae99683bf69e95bf294b7593d::giizhang_faucet_coin::GIIZHANG_FAUCET_COIN>(&mut arg0.pool, 0x2::balance::split<0xf8b2b94d4c27e5330870af87f8c617fd58798e8ae99683bf69e95bf294b7593d::giizhang_faucet_coin::GIIZHANG_FAUCET_COIN>(&mut v1, arg0.ticket));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf8b2b94d4c27e5330870af87f8c617fd58798e8ae99683bf69e95bf294b7593d::giizhang_faucet_coin::GIIZHANG_FAUCET_COIN>>(0x2::coin::from_balance<0xf8b2b94d4c27e5330870af87f8c617fd58798e8ae99683bf69e95bf294b7593d::giizhang_faucet_coin::GIIZHANG_FAUCET_COIN>(v1, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<0xf8b2b94d4c27e5330870af87f8c617fd58798e8ae99683bf69e95bf294b7593d::giizhang_faucet_coin::GIIZHANG_FAUCET_COIN>(&mut arg0.pool, v1);
        };
        let v2 = get_random_roll_2(arg2, arg3);
        let v3 = get_random_roll(arg2, arg3);
        let (v4, v5) = if (v2 > v3) {
            (0x1::string::utf8(b"Win"), true)
        } else if (v2 == v3) {
            (0x1::string::utf8(b"Draw"), false)
        } else {
            (0x1::string::utf8(b"Lose"), false)
        };
        if (v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf8b2b94d4c27e5330870af87f8c617fd58798e8ae99683bf69e95bf294b7593d::giizhang_faucet_coin::GIIZHANG_FAUCET_COIN>>(0x2::coin::from_balance<0xf8b2b94d4c27e5330870af87f8c617fd58798e8ae99683bf69e95bf294b7593d::giizhang_faucet_coin::GIIZHANG_FAUCET_COIN>(0x2::balance::split<0xf8b2b94d4c27e5330870af87f8c617fd58798e8ae99683bf69e95bf294b7593d::giizhang_faucet_coin::GIIZHANG_FAUCET_COIN>(&mut arg0.pool, arg0.reward), arg3), 0x2::tx_context::sender(arg3));
        };
        let v6 = GameResult{
            your_roll : v2,
            npc_roll  : v3,
            result    : v4,
            is_winner : v5,
        };
        0x2::event::emit<GameResult>(v6);
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf8b2b94d4c27e5330870af87f8c617fd58798e8ae99683bf69e95bf294b7593d::giizhang_faucet_coin::GIIZHANG_FAUCET_COIN>>(0x2::coin::from_balance<0xf8b2b94d4c27e5330870af87f8c617fd58798e8ae99683bf69e95bf294b7593d::giizhang_faucet_coin::GIIZHANG_FAUCET_COIN>(0x2::balance::split<0xf8b2b94d4c27e5330870af87f8c617fd58798e8ae99683bf69e95bf294b7593d::giizhang_faucet_coin::GIIZHANG_FAUCET_COIN>(&mut arg1.pool, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

