module 0xa8dee2dce7c9fb78b88f05c0b4137bc26ac55e4e906779071416721c47622b4c::m4sk93_game {
    struct GameResult has copy, drop {
        result: 0x1::string::String,
    }

    struct Game has key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<0xe799e4d1324db8877c827cb4ca78dc065a8f9ef70fbe705e4c8c37250e195982::m4sk93_faucet_coin::M4SK93_FAUCET_COIN>,
        ticket: u64,
        reward: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit(arg0: &mut Game, arg1: 0x2::coin::Coin<0xe799e4d1324db8877c827cb4ca78dc065a8f9ef70fbe705e4c8c37250e195982::m4sk93_faucet_coin::M4SK93_FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xe799e4d1324db8877c827cb4ca78dc065a8f9ef70fbe705e4c8c37250e195982::m4sk93_faucet_coin::M4SK93_FAUCET_COIN>(&arg1);
        assert!(v0 >= arg2, 2);
        let v1 = 0x2::coin::into_balance<0xe799e4d1324db8877c827cb4ca78dc065a8f9ef70fbe705e4c8c37250e195982::m4sk93_faucet_coin::M4SK93_FAUCET_COIN>(arg1);
        if (v0 > arg2) {
            0x2::balance::join<0xe799e4d1324db8877c827cb4ca78dc065a8f9ef70fbe705e4c8c37250e195982::m4sk93_faucet_coin::M4SK93_FAUCET_COIN>(&mut arg0.pool, 0x2::balance::split<0xe799e4d1324db8877c827cb4ca78dc065a8f9ef70fbe705e4c8c37250e195982::m4sk93_faucet_coin::M4SK93_FAUCET_COIN>(&mut v1, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xe799e4d1324db8877c827cb4ca78dc065a8f9ef70fbe705e4c8c37250e195982::m4sk93_faucet_coin::M4SK93_FAUCET_COIN>>(0x2::coin::from_balance<0xe799e4d1324db8877c827cb4ca78dc065a8f9ef70fbe705e4c8c37250e195982::m4sk93_faucet_coin::M4SK93_FAUCET_COIN>(v1, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<0xe799e4d1324db8877c827cb4ca78dc065a8f9ef70fbe705e4c8c37250e195982::m4sk93_faucet_coin::M4SK93_FAUCET_COIN>(&mut arg0.pool, v1);
        };
    }

    public fun game_pool(arg0: &Game) : u64 {
        0x2::balance::value<0xe799e4d1324db8877c827cb4ca78dc065a8f9ef70fbe705e4c8c37250e195982::m4sk93_faucet_coin::M4SK93_FAUCET_COIN>(&arg0.pool)
    }

    public entry fun get_faucet_coin(arg0: &mut 0x2::coin::TreasuryCap<0xe799e4d1324db8877c827cb4ca78dc065a8f9ef70fbe705e4c8c37250e195982::m4sk93_faucet_coin::M4SK93_FAUCET_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0xe799e4d1324db8877c827cb4ca78dc065a8f9ef70fbe705e4c8c37250e195982::m4sk93_faucet_coin::mint(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    fun get_random_choice(arg0: &0x2::clock::Clock) : u8 {
        ((0x2::clock::timestamp_ms(arg0) % 2) as u8)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id     : 0x2::object::new(arg0),
            pool   : 0x2::balance::zero<0xe799e4d1324db8877c827cb4ca78dc065a8f9ef70fbe705e4c8c37250e195982::m4sk93_faucet_coin::M4SK93_FAUCET_COIN>(),
            ticket : 100000000,
            reward : 200000000,
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun play(arg0: u8, arg1: &mut Game, arg2: 0x2::coin::Coin<0xe799e4d1324db8877c827cb4ca78dc065a8f9ef70fbe705e4c8c37250e195982::m4sk93_faucet_coin::M4SK93_FAUCET_COIN>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xe799e4d1324db8877c827cb4ca78dc065a8f9ef70fbe705e4c8c37250e195982::m4sk93_faucet_coin::M4SK93_FAUCET_COIN>(&arg1.pool) >= arg1.reward - arg1.ticket, 1);
        let v0 = 0x2::coin::value<0xe799e4d1324db8877c827cb4ca78dc065a8f9ef70fbe705e4c8c37250e195982::m4sk93_faucet_coin::M4SK93_FAUCET_COIN>(&arg2);
        assert!(v0 >= arg1.ticket, 2);
        let v1 = 0x2::coin::into_balance<0xe799e4d1324db8877c827cb4ca78dc065a8f9ef70fbe705e4c8c37250e195982::m4sk93_faucet_coin::M4SK93_FAUCET_COIN>(arg2);
        if (v0 > arg1.ticket) {
            0x2::balance::join<0xe799e4d1324db8877c827cb4ca78dc065a8f9ef70fbe705e4c8c37250e195982::m4sk93_faucet_coin::M4SK93_FAUCET_COIN>(&mut arg1.pool, 0x2::balance::split<0xe799e4d1324db8877c827cb4ca78dc065a8f9ef70fbe705e4c8c37250e195982::m4sk93_faucet_coin::M4SK93_FAUCET_COIN>(&mut v1, arg1.ticket));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xe799e4d1324db8877c827cb4ca78dc065a8f9ef70fbe705e4c8c37250e195982::m4sk93_faucet_coin::M4SK93_FAUCET_COIN>>(0x2::coin::from_balance<0xe799e4d1324db8877c827cb4ca78dc065a8f9ef70fbe705e4c8c37250e195982::m4sk93_faucet_coin::M4SK93_FAUCET_COIN>(v1, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<0xe799e4d1324db8877c827cb4ca78dc065a8f9ef70fbe705e4c8c37250e195982::m4sk93_faucet_coin::M4SK93_FAUCET_COIN>(&mut arg1.pool, v1);
        };
        let (v2, v3) = if (arg0 % 2 == get_random_choice(arg3)) {
            (0x1::string::utf8(b"Win"), true)
        } else {
            (0x1::string::utf8(b"Lose"), false)
        };
        if (v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xe799e4d1324db8877c827cb4ca78dc065a8f9ef70fbe705e4c8c37250e195982::m4sk93_faucet_coin::M4SK93_FAUCET_COIN>>(0x2::coin::from_balance<0xe799e4d1324db8877c827cb4ca78dc065a8f9ef70fbe705e4c8c37250e195982::m4sk93_faucet_coin::M4SK93_FAUCET_COIN>(0x2::balance::split<0xe799e4d1324db8877c827cb4ca78dc065a8f9ef70fbe705e4c8c37250e195982::m4sk93_faucet_coin::M4SK93_FAUCET_COIN>(&mut arg1.pool, arg1.reward), arg4), 0x2::tx_context::sender(arg4));
        };
        let v4 = GameResult{result: v2};
        0x2::event::emit<GameResult>(v4);
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe799e4d1324db8877c827cb4ca78dc065a8f9ef70fbe705e4c8c37250e195982::m4sk93_faucet_coin::M4SK93_FAUCET_COIN>>(0x2::coin::from_balance<0xe799e4d1324db8877c827cb4ca78dc065a8f9ef70fbe705e4c8c37250e195982::m4sk93_faucet_coin::M4SK93_FAUCET_COIN>(0x2::balance::split<0xe799e4d1324db8877c827cb4ca78dc065a8f9ef70fbe705e4c8c37250e195982::m4sk93_faucet_coin::M4SK93_FAUCET_COIN>(&mut arg1.pool, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

