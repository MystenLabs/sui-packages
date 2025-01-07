module 0x9de30a7dd77012b2bdc05d1fad38bb61c5f7040d2de71514e80eb4f7a49111::a_sky_person_game_210 {
    struct GameEvent has copy, drop {
        input_number: u64,
        game_number: u64,
        output: 0x1::string::String,
    }

    public fun random(arg0: &0x2::clock::Clock) : u64 {
        let v0 = ((0x2::clock::timestamp_ms(arg0) % 3) as u64);
        0x1::debug::print<u64>(&v0);
        v0
    }

    public fun start(arg0: u64, arg1: &0x2::clock::Clock) {
        assert!(arg0 < 3, 255);
        let v0 = random(arg1);
        let v1 = if (v0 == arg0 && v0 == 0) {
            0x1::string::utf8(b"WTF? Winning the jackpot! a sky person.")
        } else if (v0 == arg0) {
            0x1::string::utf8(b"Good! You win! a sky person.")
        } else {
            0x1::string::utf8(b"Emm, you lose...! a sky person.")
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

