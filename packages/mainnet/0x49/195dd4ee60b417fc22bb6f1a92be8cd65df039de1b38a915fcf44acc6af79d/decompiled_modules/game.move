module 0x49195dd4ee60b417fc22bb6f1a92be8cd65df039de1b38a915fcf44acc6af79d::game {
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
            0x1::string::utf8(b"limitcool say: you win")
        } else {
            0x1::string::utf8(b"limitcool say: you loss")
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

