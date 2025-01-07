module 0x63edc8039c7194ca8c823411bc3f2aff7d6c88a3c1db460ed93fa5645c85a1ea::game {
    struct GameEvent has copy, drop {
        input_number: u64,
        game_number: u64,
        output: 0x1::string::String,
    }

    public fun random(arg0: &0x2::clock::Clock) : u64 {
        ((0x2::clock::timestamp_ms(arg0) % 10) as u64)
    }

    public fun start(arg0: u64, arg1: &0x2::clock::Clock) {
        assert!(arg0 < 10, 2);
        let v0 = random(arg1);
        if (v0 % 2 == 0) {
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

    // decompiled from Move bytecode v6
}

