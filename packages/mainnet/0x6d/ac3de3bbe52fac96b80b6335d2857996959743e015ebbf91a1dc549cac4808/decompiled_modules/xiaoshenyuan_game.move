module 0x6dac3de3bbe52fac96b80b6335d2857996959743e015ebbf91a1dc549cac4808::xiaoshenyuan_game {
    struct GameResult has copy, drop {
        your_roll: u64,
        npc_roll: u64,
        result: 0x1::string::String,
        is_winner: bool,
    }

    struct Game has key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<0xbf01d599e92351db4b0192183fe40021d8a84716359efff767100472b978f9e8::xiaoshenyuan_faucet_coin::XIAOSHENYUAN_FAUCET_COIN>,
        ticket: u64,
        reward: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit(arg0: &mut Game, arg1: 0x2::coin::Coin<0xbf01d599e92351db4b0192183fe40021d8a84716359efff767100472b978f9e8::xiaoshenyuan_faucet_coin::XIAOSHENYUAN_FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xbf01d599e92351db4b0192183fe40021d8a84716359efff767100472b978f9e8::xiaoshenyuan_faucet_coin::XIAOSHENYUAN_FAUCET_COIN>(&arg1);
        assert!(v0 >= arg2, 2);
        let v1 = 0x2::coin::into_balance<0xbf01d599e92351db4b0192183fe40021d8a84716359efff767100472b978f9e8::xiaoshenyuan_faucet_coin::XIAOSHENYUAN_FAUCET_COIN>(arg1);
        if (v0 > arg2) {
            0x2::balance::join<0xbf01d599e92351db4b0192183fe40021d8a84716359efff767100472b978f9e8::xiaoshenyuan_faucet_coin::XIAOSHENYUAN_FAUCET_COIN>(&mut arg0.pool, 0x2::balance::split<0xbf01d599e92351db4b0192183fe40021d8a84716359efff767100472b978f9e8::xiaoshenyuan_faucet_coin::XIAOSHENYUAN_FAUCET_COIN>(&mut v1, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xbf01d599e92351db4b0192183fe40021d8a84716359efff767100472b978f9e8::xiaoshenyuan_faucet_coin::XIAOSHENYUAN_FAUCET_COIN>>(0x2::coin::from_balance<0xbf01d599e92351db4b0192183fe40021d8a84716359efff767100472b978f9e8::xiaoshenyuan_faucet_coin::XIAOSHENYUAN_FAUCET_COIN>(v1, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<0xbf01d599e92351db4b0192183fe40021d8a84716359efff767100472b978f9e8::xiaoshenyuan_faucet_coin::XIAOSHENYUAN_FAUCET_COIN>(&mut arg0.pool, v1);
        };
    }

    public fun game_pool(arg0: &Game) : u64 {
        0x2::balance::value<0xbf01d599e92351db4b0192183fe40021d8a84716359efff767100472b978f9e8::xiaoshenyuan_faucet_coin::XIAOSHENYUAN_FAUCET_COIN>(&arg0.pool)
    }

    public fun game_reward(arg0: &Game) : u64 {
        arg0.reward
    }

    public fun game_ticket(arg0: &Game) : u64 {
        arg0.ticket
    }

    public entry fun get_faucet_coin(arg0: &mut 0x2::coin::TreasuryCap<0xbf01d599e92351db4b0192183fe40021d8a84716359efff767100472b978f9e8::xiaoshenyuan_faucet_coin::XIAOSHENYUAN_FAUCET_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0xbf01d599e92351db4b0192183fe40021d8a84716359efff767100472b978f9e8::xiaoshenyuan_faucet_coin::mint(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    fun get_random_roll(arg0: &mut 0x2::tx_context::TxContext) : u64 {
        0x6dac3de3bbe52fac96b80b6335d2857996959743e015ebbf91a1dc549cac4808::random::rand_u64_range(0, 3, arg0)
    }

    fun get_random_roll_2(arg0: &mut 0x2::tx_context::TxContext) : u64 {
        0x6dac3de3bbe52fac96b80b6335d2857996959743e015ebbf91a1dc549cac4808::random::rand_u64_range(0, 3, arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id     : 0x2::object::new(arg0),
            pool   : 0x2::balance::zero<0xbf01d599e92351db4b0192183fe40021d8a84716359efff767100472b978f9e8::xiaoshenyuan_faucet_coin::XIAOSHENYUAN_FAUCET_COIN>(),
            ticket : 1000,
            reward : 2000,
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun play(arg0: &mut Game, arg1: 0x2::coin::Coin<0xbf01d599e92351db4b0192183fe40021d8a84716359efff767100472b978f9e8::xiaoshenyuan_faucet_coin::XIAOSHENYUAN_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xbf01d599e92351db4b0192183fe40021d8a84716359efff767100472b978f9e8::xiaoshenyuan_faucet_coin::XIAOSHENYUAN_FAUCET_COIN>(&arg0.pool) >= arg0.reward - arg0.ticket, 1);
        let v0 = 0x2::coin::value<0xbf01d599e92351db4b0192183fe40021d8a84716359efff767100472b978f9e8::xiaoshenyuan_faucet_coin::XIAOSHENYUAN_FAUCET_COIN>(&arg1);
        assert!(v0 >= arg0.ticket, 2);
        let v1 = 0x2::coin::into_balance<0xbf01d599e92351db4b0192183fe40021d8a84716359efff767100472b978f9e8::xiaoshenyuan_faucet_coin::XIAOSHENYUAN_FAUCET_COIN>(arg1);
        if (v0 > arg0.ticket) {
            0x2::balance::join<0xbf01d599e92351db4b0192183fe40021d8a84716359efff767100472b978f9e8::xiaoshenyuan_faucet_coin::XIAOSHENYUAN_FAUCET_COIN>(&mut arg0.pool, 0x2::balance::split<0xbf01d599e92351db4b0192183fe40021d8a84716359efff767100472b978f9e8::xiaoshenyuan_faucet_coin::XIAOSHENYUAN_FAUCET_COIN>(&mut v1, arg0.ticket));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xbf01d599e92351db4b0192183fe40021d8a84716359efff767100472b978f9e8::xiaoshenyuan_faucet_coin::XIAOSHENYUAN_FAUCET_COIN>>(0x2::coin::from_balance<0xbf01d599e92351db4b0192183fe40021d8a84716359efff767100472b978f9e8::xiaoshenyuan_faucet_coin::XIAOSHENYUAN_FAUCET_COIN>(v1, arg2), 0x2::tx_context::sender(arg2));
        } else {
            0x2::balance::join<0xbf01d599e92351db4b0192183fe40021d8a84716359efff767100472b978f9e8::xiaoshenyuan_faucet_coin::XIAOSHENYUAN_FAUCET_COIN>(&mut arg0.pool, v1);
        };
        let v2 = get_random_roll_2(arg2);
        let v3 = get_random_roll(arg2);
        let (v4, v5) = if (v2 > v3) {
            (0x1::string::utf8(b"Win"), true)
        } else if (v2 == v3) {
            (0x1::string::utf8(b"Draw"), false)
        } else {
            (0x1::string::utf8(b"Lose"), false)
        };
        if (v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xbf01d599e92351db4b0192183fe40021d8a84716359efff767100472b978f9e8::xiaoshenyuan_faucet_coin::XIAOSHENYUAN_FAUCET_COIN>>(0x2::coin::from_balance<0xbf01d599e92351db4b0192183fe40021d8a84716359efff767100472b978f9e8::xiaoshenyuan_faucet_coin::XIAOSHENYUAN_FAUCET_COIN>(0x2::balance::split<0xbf01d599e92351db4b0192183fe40021d8a84716359efff767100472b978f9e8::xiaoshenyuan_faucet_coin::XIAOSHENYUAN_FAUCET_COIN>(&mut arg0.pool, arg0.reward), arg2), 0x2::tx_context::sender(arg2));
        };
        let v6 = GameResult{
            your_roll : v2,
            npc_roll  : v3,
            result    : v4,
            is_winner : v5,
        };
        0x2::event::emit<GameResult>(v6);
    }

    public entry fun set_reward(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.reward = arg2;
    }

    public entry fun set_ticket(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.ticket = arg2;
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xbf01d599e92351db4b0192183fe40021d8a84716359efff767100472b978f9e8::xiaoshenyuan_faucet_coin::XIAOSHENYUAN_FAUCET_COIN>>(0x2::coin::from_balance<0xbf01d599e92351db4b0192183fe40021d8a84716359efff767100472b978f9e8::xiaoshenyuan_faucet_coin::XIAOSHENYUAN_FAUCET_COIN>(0x2::balance::split<0xbf01d599e92351db4b0192183fe40021d8a84716359efff767100472b978f9e8::xiaoshenyuan_faucet_coin::XIAOSHENYUAN_FAUCET_COIN>(&mut arg1.pool, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

