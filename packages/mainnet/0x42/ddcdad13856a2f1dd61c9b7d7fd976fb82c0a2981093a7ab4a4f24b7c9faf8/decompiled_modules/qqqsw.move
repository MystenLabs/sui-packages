module 0x42ddcdad13856a2f1dd61c9b7d7fd976fb82c0a2981093a7ab4a4f24b7c9faf8::qqqsw {
    struct GamingResultEvent has copy, drop {
        is_win: bool,
        your_choice: 0x1::string::String,
        qqqsw_choice: 0x1::string::String,
        result: 0x1::string::String,
    }

    fun get_random_choice(arg0: &0x2::clock::Clock) : u8 {
        ((0x2::clock::timestamp_ms(arg0) % 3) as u8)
    }

    fun map_choice_to_string(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"rock")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"paper")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"scissors")
        } else {
            0x1::string::utf8(b"Invalid")
        }
    }

    public fun play(arg0: u8, arg1: &0x2::clock::Clock) {
        assert!(arg0 < 3, 1);
        let v0 = get_random_choice(arg1);
        let (v1, v2) = if (arg0 == 0 && v0 == 1 || arg0 == 1 && v0 == 2 || arg0 == 2 && v0 == 0) {
            (0x1::string::utf8(b"Win"), true)
        } else if (arg0 == v0) {
            (0x1::string::utf8(b"Draw"), false)
        } else {
            (0x1::string::utf8(b"Lose"), false)
        };
        let v3 = GamingResultEvent{
            is_win       : v2,
            your_choice  : map_choice_to_string(arg0),
            qqqsw_choice : map_choice_to_string(v0),
            result       : v1,
        };
        0x2::event::emit<GamingResultEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

