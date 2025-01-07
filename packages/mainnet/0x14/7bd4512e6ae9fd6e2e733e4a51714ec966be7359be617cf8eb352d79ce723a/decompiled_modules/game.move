module 0x147bd4512e6ae9fd6e2e733e4a51714ec966be7359be617cf8eb352d79ce723a::game {
    struct GResultEvent has copy, drop {
        result: 0x1::string::String,
        is_win: bool,
        your_choice: u8,
        computer_choice: u8,
    }

    struct RewardPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::faucet_coin::FAUCET_COIN>,
    }

    public entry fun init_pool(arg0: 0x2::coin::Coin<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::faucet_coin::FAUCET_COIN>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardPool{
            id      : 0x2::object::new(arg1),
            balance : 0x2::coin::into_balance<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::faucet_coin::FAUCET_COIN>(arg0),
        };
        0x2::transfer::share_object<RewardPool>(v0);
    }

    public fun play(arg0: u8, arg1: &0x2::clock::Clock, arg2: &mut RewardPool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 < 3, 1);
        let v0 = random_choice(arg1);
        let (v1, v2) = if (v0 > arg0) {
            (0x1::string::utf8(b"Lose"), false)
        } else if (v0 == arg0) {
            (0x1::string::utf8(b"Draw"), false)
        } else {
            (0x1::string::utf8(b"Win"), true)
        };
        if (v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::faucet_coin::FAUCET_COIN>(0x2::balance::split<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::faucet_coin::FAUCET_COIN>(&mut arg2.balance, 1), arg3), 0x2::tx_context::sender(arg3));
        };
        let v3 = GResultEvent{
            result          : v1,
            is_win          : v2,
            your_choice     : arg0,
            computer_choice : v0,
        };
        0x2::event::emit<GResultEvent>(v3);
    }

    fun random_choice(arg0: &0x2::clock::Clock) : u8 {
        ((0x2::clock::timestamp_ms(arg0) % 3) as u8)
    }

    // decompiled from Move bytecode v6
}

