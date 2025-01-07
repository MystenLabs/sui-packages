module 0x9d0546da0d1ff569ff9cac280d817016cf5be1b22070b4be7be9fcdf334f2336::mygame {
    struct GameResult has copy, drop {
        your_number: u64,
        computer_number: u64,
        result: 0x1::string::String,
    }

    public fun get_random(arg0: u64, arg1: &0x2::clock::Clock) : u64 {
        let v0 = ((0x2::clock::timestamp_ms(arg1) % arg0) as u64);
        0x1::debug::print<u64>(&v0);
        v0
    }

    public fun play(arg0: u64, arg1: &0x2::clock::Clock) {
        assert!(arg0 < 10, 0);
        let v0 = get_random(9, arg1);
        let v1 = if (arg0 == v0) {
            0x1::string::utf8(b"ping")
        } else if (arg0 > v0) {
            0x1::string::utf8(b"you win")
        } else {
            0x1::string::utf8(b"you lose")
        };
        let v2 = GameResult{
            your_number     : arg0,
            computer_number : v0,
            result          : v1,
        };
        0x2::event::emit<GameResult>(v2);
    }

    // decompiled from Move bytecode v6
}

