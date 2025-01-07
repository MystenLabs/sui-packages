module 0x1e2c780dd84009a33205489c634319da3dba3664d41cac2d7a622e793bc8328c::game {
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
                output       : 0x1::string::utf8(b"lose..."),
            };
            0x2::event::emit<GameEvent>(v2);
        };
    }

    // decompiled from Move bytecode v6
}

