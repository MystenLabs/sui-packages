module 0x6115440f048ac8247804bd3a5c049ec4733576202c19e757c489cfa96c6ad6::game {
    struct GameEvent has copy, drop {
        input_number: u64,
        game_number: u64,
        output: 0x1::string::String,
    }

    public entry fun game_start(arg0: u64, arg1: &0x2::clock::Clock) {
        assert!(arg0 < 3, 255);
        let v0 = 0x2::clock::timestamp_ms(arg1) % 3;
        let v1 = if (v0 == arg0 && v0 == 0) {
            0x1::string::utf8(b"WTF? Winning the jackpot!")
        } else if (v0 == arg0) {
            0x1::string::utf8(b"Good! You win!")
        } else {
            0x1::string::utf8(b"Emm, you lose...")
        };
        let v2 = GameEvent{
            input_number : arg0,
            game_number  : v0,
            output       : v1,
        };
        0x2::event::emit<GameEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

