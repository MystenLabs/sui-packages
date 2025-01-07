module 0x33ad0b7ab58947bdff38575d4c4fd54a8a5b5fb8a344b0cbe6f4c8c5d8a0a8e7::game {
    struct GameResultEvent has copy, drop {
        user_guess: u64,
        random_number: u64,
        result: 0x1::string::String,
    }

    struct RandomResultEvent has copy, drop {
        random_result: u64,
    }

    fun get_random(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) % 10
    }

    public entry fun play(arg0: u64, arg1: &0x2::clock::Clock) {
        assert!(arg0 < 10, 0);
        let v0 = get_random(arg1);
        let v1 = if (v0 == arg0) {
            0x1::string::utf8(b"you win")
        } else {
            0x1::string::utf8(b"you loss")
        };
        let v2 = GameResultEvent{
            user_guess    : arg0,
            random_number : v0,
            result        : v1,
        };
        0x2::event::emit<GameResultEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

