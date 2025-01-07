module 0x898f87e55e4cb51758f6bec2df4c59f5ae2b12b345c764799e62809ea12351fc::blue_game {
    struct GamingResultEvent has copy, drop {
        is_win: bool,
        your_choice: 0x1::string::String,
        croal99_choice: 0x1::string::String,
        result: 0x1::string::String,
    }

    struct RewardPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x5f461a5c2285387449600b09c5dda42d514f1a9608ea4a9555bf564789a451e::faucet_coin::FAUCET_COIN>,
    }

    fun get_random_choice(arg0: &0x2::clock::Clock) : u8 {
        ((0x2::clock::timestamp_ms(arg0) % 3) as u8)
    }

    public entry fun init_pool(arg0: 0x2::coin::Coin<0x5f461a5c2285387449600b09c5dda42d514f1a9608ea4a9555bf564789a451e::faucet_coin::FAUCET_COIN>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::ascii::string(b"reward");
        0x1::debug::print<0x1::ascii::String>(&v0);
        let v1 = RewardPool{
            id      : 0x2::object::new(arg1),
            balance : 0x2::coin::into_balance<0x5f461a5c2285387449600b09c5dda42d514f1a9608ea4a9555bf564789a451e::faucet_coin::FAUCET_COIN>(arg0),
        };
        0x2::transfer::share_object<RewardPool>(v1);
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
        let v0 = 0x1::ascii::string(b"play");
        0x1::debug::print<0x1::ascii::String>(&v0);
        assert!(arg0 < 3, 1);
        0x1::debug::print<u8>(&arg0);
        let v1 = get_random_choice(arg1);
        0x1::debug::print<u8>(&v1);
        let (v2, v3) = if (arg0 == 0 && v1 == 1 || arg0 == 1 && v1 == 2 || arg0 == 2 && v1 == 0) {
            (true, 0x1::string::utf8(b"You win"))
        } else {
            let (v4, v5) = if (arg0 == v1) {
                (0x1::string::utf8(b"Draw"), false)
            } else {
                (0x1::string::utf8(b"You Lose"), false)
            };
            (v5, v4)
        };
        let v6 = v3;
        0x1::debug::print<0x1::string::String>(&v6);
        if (v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x5f461a5c2285387449600b09c5dda42d514f1a9608ea4a9555bf564789a451e::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0x5f461a5c2285387449600b09c5dda42d514f1a9608ea4a9555bf564789a451e::faucet_coin::FAUCET_COIN>(0x2::balance::split<0x5f461a5c2285387449600b09c5dda42d514f1a9608ea4a9555bf564789a451e::faucet_coin::FAUCET_COIN>(&mut arg2.balance, 1), arg3), 0x2::tx_context::sender(arg3));
        };
        let v7 = GamingResultEvent{
            is_win         : v2,
            your_choice    : map_choice_to_string(arg0),
            croal99_choice : map_choice_to_string(v1),
            result         : v6,
        };
        0x2::event::emit<GamingResultEvent>(v7);
    }

    // decompiled from Move bytecode v6
}

