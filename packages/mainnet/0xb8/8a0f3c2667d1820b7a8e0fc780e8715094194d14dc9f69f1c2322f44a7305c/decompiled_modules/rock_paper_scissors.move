module 0xb88a0f3c2667d1820b7a8e0fc780e8715094194d14dc9f69f1c2322f44a7305c::rock_paper_scissors {
    struct GamingResultEvent has copy, drop {
        is_win: bool,
        your_choice: 0x1::string::String,
        computer_choice: 0x1::string::String,
        result: 0x1::string::String,
    }

    struct RewardPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_faucet_coin::TUTUSTACK_FAUCET_COIN>,
    }

    fun get_random_choice(arg0: &0x2::clock::Clock) : u8 {
        ((0x2::clock::timestamp_ms(arg0) % 3) as u8)
    }

    public entry fun init_pool(arg0: 0x2::coin::Coin<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_faucet_coin::TUTUSTACK_FAUCET_COIN>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardPool{
            id      : 0x2::object::new(arg1),
            balance : 0x2::coin::into_balance<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_faucet_coin::TUTUSTACK_FAUCET_COIN>(arg0),
        };
        0x2::transfer::share_object<RewardPool>(v0);
    }

    fun map_choice_to_string(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"rock")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"paper")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"scissors")
        } else {
            0x1::string::utf8(b"Invalid")
        }
    }

    public fun play(arg0: u8, arg1: &0x2::clock::Clock, arg2: &mut RewardPool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 < 3, 1);
        let v0 = get_random_choice(arg1);
        let (v1, v2) = if (arg0 == 0 && v0 == 1 || arg0 == 1 && v0 == 2 || arg0 == 2 && v0 == 0) {
            (0x1::string::utf8(b"win"), true)
        } else if (arg0 == v0) {
            (0x1::string::utf8(b"Draw"), false)
        } else {
            (0x1::string::utf8(b"Lose"), false)
        };
        if (v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_faucet_coin::TUTUSTACK_FAUCET_COIN>>(0x2::coin::from_balance<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_faucet_coin::TUTUSTACK_FAUCET_COIN>(0x2::balance::split<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_faucet_coin::TUTUSTACK_FAUCET_COIN>(&mut arg2.balance, 1), arg3), 0x2::tx_context::sender(arg3));
        };
        let v3 = GamingResultEvent{
            is_win          : v2,
            your_choice     : map_choice_to_string(arg0),
            computer_choice : map_choice_to_string(v0),
            result          : v1,
        };
        0x2::event::emit<GamingResultEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

