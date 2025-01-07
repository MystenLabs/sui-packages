module 0x70c49d53991a1f95dc5acaec7fbe77a8e4faba371a8945184243a2612dde49ae::gunksdgame {
    struct GameEvent has copy, drop {
        input_number: u64,
        game_number: u64,
        output: 0x1::string::String,
    }

    public fun game_start(arg0: u64, arg1: &0x2::clock::Clock) {
        assert!(arg0 < 3, 255);
        let v0 = random(arg1);
        let v1 = if (v0 == arg0 && v0 == 0) {
            0x1::string::utf8(b"WTF? ")
        } else if (v0 == arg0) {
            0x1::string::utf8(b"Good! You win!")
        } else {
            0x1::string::utf8(b" you lose...")
        };
        let v2 = GameEvent{
            input_number : arg0,
            game_number  : v0,
            output       : v1,
        };
        0x2::event::emit<GameEvent>(v2);
    }

    public fun random(arg0: &0x2::clock::Clock) : u64 {
        let v0 = ((0x2::clock::timestamp_ms(arg0) % 3) as u64);
        0x1::debug::print<u64>(&v0);
        v0
    }

    // decompiled from Move bytecode v6
}

