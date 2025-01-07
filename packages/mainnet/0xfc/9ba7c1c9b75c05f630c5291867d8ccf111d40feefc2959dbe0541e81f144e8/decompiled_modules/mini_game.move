module 0xfc9ba7c1c9b75c05f630c5291867d8ccf111d40feefc2959dbe0541e81f144e8::mini_game {
    struct GmaingResultEvent has copy, drop {
        is_win: bool,
        your_points: u8,
        computer_points: u8,
        result: 0x1::string::String,
    }

    fun get_random_points(arg0: &0x2::clock::Clock) : u8 {
        ((0x2::clock::timestamp_ms(arg0) % 10) as u8)
    }

    public fun play(arg0: u8, arg1: &0x2::clock::Clock) {
        assert!(arg0 < 10, 1);
        let v0 = get_random_points(arg1);
        let (v1, v2) = if (arg0 + v0 == 14) {
            (0x1::string::utf8(b"Win"), true)
        } else {
            (0x1::string::utf8(b"Lose"), false)
        };
        let v3 = GmaingResultEvent{
            is_win          : v2,
            your_points     : arg0,
            computer_points : v0,
            result          : v1,
        };
        0x2::event::emit<GmaingResultEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

