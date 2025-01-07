module 0x5793992e953674c6983526575f633c0f95814d2b851ec921cb8164d1200ca421::gametest {
    struct GameEvent has copy, drop {
        input_number: u64,
        game_number: u64,
        output: 0x1::string::String,
    }

    public fun game_start(arg0: u64, arg1: &0x2::clock::Clock) {
        assert!(arg0 < 100, 1);
        let v0 = random(arg1);
        if (v0 == arg0) {
            let v1 = GameEvent{
                input_number : arg0,
                game_number  : v0,
                output       : 0x1::string::utf8(b"big win!!!"),
            };
            0x2::event::emit<GameEvent>(v1);
        } else if (v0 > 50) {
            let v2 = GameEvent{
                input_number : arg0,
                game_number  : v0,
                output       : 0x1::string::utf8(b"win"),
            };
            0x2::event::emit<GameEvent>(v2);
        } else {
            let v3 = GameEvent{
                input_number : arg0,
                game_number  : v0,
                output       : 0x1::string::utf8(b"try again"),
            };
            0x2::event::emit<GameEvent>(v3);
        };
    }

    fun random(arg0: &0x2::clock::Clock) : u64 {
        ((0x2::clock::timestamp_ms(arg0) % 100) as u64)
    }

    // decompiled from Move bytecode v6
}

