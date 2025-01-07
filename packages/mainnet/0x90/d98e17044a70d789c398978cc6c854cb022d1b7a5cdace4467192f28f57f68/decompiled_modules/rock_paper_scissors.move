module 0x90d98e17044a70d789c398978cc6c854cb022d1b7a5cdace4467192f28f57f68::rock_paper_scissors {
    struct GamingResultEvent has copy, drop {
        is_win: bool,
        your_choice: 0x1::string::String,
        computer_choice: 0x1::string::String,
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
        let v1 = if (arg0 == 0 && v0 == 1) {
            true
        } else if (arg0 == 1 && v0 == 2) {
            true
        } else {
            arg0 == 2 && v0 == 0
        };
        let (v2, v3) = if (v1) {
            (0x1::string::utf8(b"Win"), true)
        } else if (arg0 == v0) {
            (0x1::string::utf8(b"Draw"), false)
        } else {
            (0x1::string::utf8(b"Lose"), false)
        };
        let v4 = GamingResultEvent{
            is_win          : v3,
            your_choice     : map_choice_to_string(arg0),
            computer_choice : map_choice_to_string(v0),
            result          : v2,
        };
        0x2::event::emit<GamingResultEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

