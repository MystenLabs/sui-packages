module 0xac3380e8c2a79ef5a2d55dfa1760482908d4695a64cf63d5cd44c7d65f3d3a14::game {
    struct GameEvent has copy, drop {
        input_number: u64,
        game_number: u64,
        output: 0x1::string::String,
    }

    public fun game_start(arg0: u64, arg1: &0x2::clock::Clock) {
        assert!(arg0 < 10, 255);
        let v0 = random(arg1);
        if (v0 == arg0) {
            let v1 = GameEvent{
                input_number : arg0,
                game_number  : v0,
                output       : 0x1::string::utf8(b"Win"),
            };
            0x2::event::emit<GameEvent>(v1);
        } else {
            let v2 = GameEvent{
                input_number : arg0,
                game_number  : v0,
                output       : 0x1::string::utf8(b"Lose"),
            };
            0x2::event::emit<GameEvent>(v2);
        };
    }

    public fun random(arg0: &0x2::clock::Clock) : u64 {
        let v0 = ((0x2::clock::timestamp_ms(arg0) % 10) as u64);
        0x1::debug::print<u64>(&v0);
        v0
    }

    // decompiled from Move bytecode v6
}

