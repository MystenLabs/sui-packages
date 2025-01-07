module 0x76ac9f9e72a24687854316056fbe97bf790f5d5727e7e8fe94a36bdd4dcd84c8::lazy_forever_game {
    struct GamingResultEvent has copy, drop {
        is_win: bool,
        your_choice: 0x1::string::String,
        computer_choice: 0x1::string::String,
        result: 0x1::string::String,
    }

    fun get_random_choice(arg0: &0x2::clock::Clock) : u8 {
        ((0x2::clock::timestamp_ms(arg0) % 3) as u8)
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

    public fun play(arg0: u8, arg1: &mut 0x2::coin::TreasuryCap<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_faucet::LAZY_FOREVER_FAUCET>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 < 3, 1);
        let v0 = get_random_choice(arg2);
        let (v1, v2) = if (arg0 == 0 && v0 == 1 || arg0 == 1 && v0 == 2 || arg0 == 2 && v0 == 0) {
            (0x1::string::utf8(b"Win"), true)
        } else if (arg0 == v0) {
            (0x1::string::utf8(b"Draw"), false)
        } else {
            (0x1::string::utf8(b"Lose"), false)
        };
        if (v2) {
            0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_faucet::mint(arg1, 0x2::tx_context::sender(arg3), arg3);
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

