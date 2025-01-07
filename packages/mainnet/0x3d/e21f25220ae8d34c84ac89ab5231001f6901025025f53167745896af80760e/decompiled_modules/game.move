module 0x3de21f25220ae8d34c84ac89ab5231001f6901025025f53167745896af80760e::game {
    struct GameResultEvent has copy, drop {
        user_guess: 0x1::string::String,
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
        assert!(arg0 < 2, 0);
        let v0 = if (arg0 == 0) {
            0x1::string::utf8(x"e4bda0e79a84e78c9ce6b58befbc9ae581b6e695b0")
        } else {
            0x1::string::utf8(x"e4bda0e79a84e78c9ce6b58befbc9ae5a587e695b0")
        };
        let v1 = get_random(arg1);
        let v2 = if (v1 % 2 == arg0) {
            0x1::string::utf8(x"e4bda0e8b5a2e4ba86f09f9881")
        } else {
            0x1::string::utf8(x"e4bda0e8be93e4ba86f09f98ad")
        };
        let v3 = GameResultEvent{
            user_guess    : v0,
            random_number : v1,
            result        : v2,
        };
        0x2::event::emit<GameResultEvent>(v3);
    }

    public entry fun test_get_random(arg0: &0x2::clock::Clock) {
        let v0 = RandomResultEvent{random_result: 0x2::clock::timestamp_ms(arg0) % 10};
        0x2::event::emit<RandomResultEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

