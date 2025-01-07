module 0xa410b728a0d3bce3bec64cf532a781eb9a8a75b898da3438cf5ad847d8c9aae2::game {
    struct GameResultEvent has copy, drop {
        user_guess: 0x1::string::String,
        random_number: u64,
        result: 0x1::string::String,
    }

    fun get_random(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) % 10
    }

    public entry fun play(arg0: u64, arg1: &0x2::clock::Clock) {
        assert!(arg0 < 2, 0);
        let v0 = if (arg0 == 0) {
            0x1::string::utf8(b"even")
        } else {
            0x1::string::utf8(b"odd")
        };
        let v1 = get_random(arg1);
        let v2 = if (v1 % 2 == arg0) {
            0x1::string::utf8(b"You win")
        } else {
            0x1::string::utf8(b"You lose")
        };
        let v3 = GameResultEvent{
            user_guess    : v0,
            random_number : v1,
            result        : v2,
        };
        0x2::event::emit<GameResultEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

