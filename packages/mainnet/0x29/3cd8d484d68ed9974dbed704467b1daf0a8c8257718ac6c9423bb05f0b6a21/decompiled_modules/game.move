module 0x293cd8d484d68ed9974dbed704467b1daf0a8c8257718ac6c9423bb05f0b6a21::game {
    struct GameEvent has copy, drop {
        input_number: u64,
        game_number: u64,
        output: 0x1::string::String,
    }

    public fun random(arg0: &0x2::clock::Clock) : u64 {
        ((0x2::clock::timestamp_ms(arg0) % 6) as u64)
    }

    public fun start(arg0: u64, arg1: &0x2::clock::Clock) {
        assert!(arg0 < 6, 0);
        let v0 = random(arg1);
        if (v0 == arg0) {
            let v1 = GameEvent{
                input_number : arg0,
                game_number  : v0,
                output       : 0x1::string::utf8(b"Win"),
            };
            0x2::event::emit<GameEvent>(v1);
        } else if (v0 == 0) {
            let v2 = GameEvent{
                input_number : arg0,
                game_number  : v0,
                output       : 0x1::string::utf8(b"Win"),
            };
            0x2::event::emit<GameEvent>(v2);
        } else {
            let v3 = GameEvent{
                input_number : arg0,
                game_number  : v0,
                output       : 0x1::string::utf8(b"lose..."),
            };
            0x2::event::emit<GameEvent>(v3);
        };
    }

    // decompiled from Move bytecode v6
}

