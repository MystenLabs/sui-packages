module 0xe11222d024af83247e1f7e5d5f60f36ed68a8d352d374dc4b855e0f427efedf0::game {
    struct GameResultEvent has copy, drop {
        user_choice: u64,
        random_choice: u64,
        result: 0x1::string::String,
    }

    fun determine_result(arg0: u64, arg1: u64) : 0x1::string::String {
        if (arg0 == arg1) {
            0x1::string::utf8(b"draw")
        } else if (arg0 == 0 && arg1 == 1 || arg0 == 1 && arg1 == 2 || arg0 == 2 && arg1 == 0) {
            0x1::string::utf8(b"you win")
        } else {
            0x1::string::utf8(b"you lose")
        }
    }

    fun get_random_choice(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) % 3
    }

    public entry fun play(arg0: u64, arg1: &0x2::clock::Clock) {
        assert!(arg0 < 3, 0);
        let v0 = get_random_choice(arg1);
        let v1 = GameResultEvent{
            user_choice   : arg0,
            random_choice : v0,
            result        : determine_result(arg0, v0),
        };
        0x2::event::emit<GameResultEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

