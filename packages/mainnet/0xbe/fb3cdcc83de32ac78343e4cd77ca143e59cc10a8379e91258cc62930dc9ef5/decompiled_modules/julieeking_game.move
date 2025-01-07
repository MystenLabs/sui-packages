module 0xbefb3cdcc83de32ac78343e4cd77ca143e59cc10a8379e91258cc62930dc9ef5::julieeking_game {
    struct GameResult has copy, drop {
        your_roll: u64,
        npc_roll: u64,
        result: 0x1::string::String,
        is_winner: bool,
    }

    struct Game has key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<0xf52cb81aeb0aa35ec076d48f86479971ab2f1c9f8e569994b6055e115f09245::julieeking_faucet_coin::JULIEEKING_FAUCET_COIN>,
        ticket: u64,
        reward: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun bytes_to_u64(arg0: vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            v0 = v0 | (*0x1::vector::borrow<u8>(&arg0, v1) as u64) << ((8 * (7 - v1)) as u8);
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun deposit(arg0: &mut Game, arg1: 0x2::coin::Coin<0xf52cb81aeb0aa35ec076d48f86479971ab2f1c9f8e569994b6055e115f09245::julieeking_faucet_coin::JULIEEKING_FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xf52cb81aeb0aa35ec076d48f86479971ab2f1c9f8e569994b6055e115f09245::julieeking_faucet_coin::JULIEEKING_FAUCET_COIN>(&arg1);
        assert!(v0 >= arg2, 2);
        let v1 = 0x2::coin::into_balance<0xf52cb81aeb0aa35ec076d48f86479971ab2f1c9f8e569994b6055e115f09245::julieeking_faucet_coin::JULIEEKING_FAUCET_COIN>(arg1);
        if (v0 > arg2) {
            0x2::balance::join<0xf52cb81aeb0aa35ec076d48f86479971ab2f1c9f8e569994b6055e115f09245::julieeking_faucet_coin::JULIEEKING_FAUCET_COIN>(&mut arg0.pool, 0x2::balance::split<0xf52cb81aeb0aa35ec076d48f86479971ab2f1c9f8e569994b6055e115f09245::julieeking_faucet_coin::JULIEEKING_FAUCET_COIN>(&mut v1, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf52cb81aeb0aa35ec076d48f86479971ab2f1c9f8e569994b6055e115f09245::julieeking_faucet_coin::JULIEEKING_FAUCET_COIN>>(0x2::coin::from_balance<0xf52cb81aeb0aa35ec076d48f86479971ab2f1c9f8e569994b6055e115f09245::julieeking_faucet_coin::JULIEEKING_FAUCET_COIN>(v1, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<0xf52cb81aeb0aa35ec076d48f86479971ab2f1c9f8e569994b6055e115f09245::julieeking_faucet_coin::JULIEEKING_FAUCET_COIN>(&mut arg0.pool, v1);
        };
    }

    public fun game_pool(arg0: &Game) : u64 {
        0x2::balance::value<0xf52cb81aeb0aa35ec076d48f86479971ab2f1c9f8e569994b6055e115f09245::julieeking_faucet_coin::JULIEEKING_FAUCET_COIN>(&arg0.pool)
    }

    public fun game_reward(arg0: &Game) : u64 {
        arg0.reward
    }

    public fun game_ticket(arg0: &Game) : u64 {
        arg0.ticket
    }

    public entry fun get_faucet_coin(arg0: &mut 0x2::coin::TreasuryCap<0xf52cb81aeb0aa35ec076d48f86479971ab2f1c9f8e569994b6055e115f09245::julieeking_faucet_coin::JULIEEKING_FAUCET_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0xf52cb81aeb0aa35ec076d48f86479971ab2f1c9f8e569994b6055e115f09245::julieeking_faucet_coin::mint(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    fun get_random_roll(arg0: &mut 0x2::tx_context::TxContext) : u64 {
        rand_u64_range(0, 3, arg0)
    }

    fun get_random_roll_2(arg0: &mut 0x2::tx_context::TxContext) : u64 {
        rand_u64_range(0, 3, arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id     : 0x2::object::new(arg0),
            pool   : 0x2::balance::zero<0xf52cb81aeb0aa35ec076d48f86479971ab2f1c9f8e569994b6055e115f09245::julieeking_faucet_coin::JULIEEKING_FAUCET_COIN>(),
            ticket : 1000,
            reward : 2000,
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun play(arg0: &mut Game, arg1: 0x2::coin::Coin<0xf52cb81aeb0aa35ec076d48f86479971ab2f1c9f8e569994b6055e115f09245::julieeking_faucet_coin::JULIEEKING_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xf52cb81aeb0aa35ec076d48f86479971ab2f1c9f8e569994b6055e115f09245::julieeking_faucet_coin::JULIEEKING_FAUCET_COIN>(&arg0.pool) >= arg0.reward - arg0.ticket, 1);
        let v0 = 0x2::coin::value<0xf52cb81aeb0aa35ec076d48f86479971ab2f1c9f8e569994b6055e115f09245::julieeking_faucet_coin::JULIEEKING_FAUCET_COIN>(&arg1);
        assert!(v0 >= arg0.ticket, 2);
        let v1 = 0x2::coin::into_balance<0xf52cb81aeb0aa35ec076d48f86479971ab2f1c9f8e569994b6055e115f09245::julieeking_faucet_coin::JULIEEKING_FAUCET_COIN>(arg1);
        if (v0 > arg0.ticket) {
            0x2::balance::join<0xf52cb81aeb0aa35ec076d48f86479971ab2f1c9f8e569994b6055e115f09245::julieeking_faucet_coin::JULIEEKING_FAUCET_COIN>(&mut arg0.pool, 0x2::balance::split<0xf52cb81aeb0aa35ec076d48f86479971ab2f1c9f8e569994b6055e115f09245::julieeking_faucet_coin::JULIEEKING_FAUCET_COIN>(&mut v1, arg0.ticket));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf52cb81aeb0aa35ec076d48f86479971ab2f1c9f8e569994b6055e115f09245::julieeking_faucet_coin::JULIEEKING_FAUCET_COIN>>(0x2::coin::from_balance<0xf52cb81aeb0aa35ec076d48f86479971ab2f1c9f8e569994b6055e115f09245::julieeking_faucet_coin::JULIEEKING_FAUCET_COIN>(v1, arg2), 0x2::tx_context::sender(arg2));
        } else {
            0x2::balance::join<0xf52cb81aeb0aa35ec076d48f86479971ab2f1c9f8e569994b6055e115f09245::julieeking_faucet_coin::JULIEEKING_FAUCET_COIN>(&mut arg0.pool, v1);
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
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf52cb81aeb0aa35ec076d48f86479971ab2f1c9f8e569994b6055e115f09245::julieeking_faucet_coin::JULIEEKING_FAUCET_COIN>>(0x2::coin::from_balance<0xf52cb81aeb0aa35ec076d48f86479971ab2f1c9f8e569994b6055e115f09245::julieeking_faucet_coin::JULIEEKING_FAUCET_COIN>(0x2::balance::split<0xf52cb81aeb0aa35ec076d48f86479971ab2f1c9f8e569994b6055e115f09245::julieeking_faucet_coin::JULIEEKING_FAUCET_COIN>(&mut arg0.pool, arg0.reward), arg2), 0x2::tx_context::sender(arg2));
        };
        let v6 = GameResult{
            your_roll : v2,
            npc_roll  : v3,
            result    : v4,
            is_winner : v5,
        };
        0x2::event::emit<GameResult>(v6);
    }

    public fun rand_u64_range(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        rand_u64_range_with_seed(seed(arg2), arg0, arg1)
    }

    fun rand_u64_range_with_seed(arg0: vector<u8>, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > arg1, 101);
        rand_u64_with_seed(arg0) % (arg2 - arg1) + arg1
    }

    fun rand_u64_with_seed(arg0: vector<u8>) : u64 {
        bytes_to_u64(arg0)
    }

    fun seed(arg0: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x2::object::new(arg0);
        0x2::object::delete(v0);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x2::tx_context::TxContext>(arg0));
        0x1::vector::append<u8>(&mut v1, 0x2::object::uid_to_bytes(&v0));
        0x1::hash::sha3_256(v1)
    }

    public entry fun set_reward(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.reward = arg2;
    }

    public entry fun set_ticket(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.ticket = arg2;
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf52cb81aeb0aa35ec076d48f86479971ab2f1c9f8e569994b6055e115f09245::julieeking_faucet_coin::JULIEEKING_FAUCET_COIN>>(0x2::coin::from_balance<0xf52cb81aeb0aa35ec076d48f86479971ab2f1c9f8e569994b6055e115f09245::julieeking_faucet_coin::JULIEEKING_FAUCET_COIN>(0x2::balance::split<0xf52cb81aeb0aa35ec076d48f86479971ab2f1c9f8e569994b6055e115f09245::julieeking_faucet_coin::JULIEEKING_FAUCET_COIN>(&mut arg1.pool, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

