module 0xd7d58dd3824c820f64ec79d4ba3dcac65ac4237f96066eeef4d676ca248e74a8::antigone {
    struct GamingResultEvent has copy, drop {
        is_win: bool,
        your_choice: 0x1::string::String,
        antigone_choice: 0x1::string::String,
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
        let (v1, v2) = if (arg0 == 0 && v0 == 0 || arg0 == 1 && v0 == 1 || arg0 == 2 && v0 == 2) {
            (0x1::string::utf8(b"Congratulations ,we have great rapport!"), true)
        } else {
            (0x1::string::utf8(b"I'm sorry, we still need to work on our rapport."), false)
        };
        let v3 = GamingResultEvent{
            is_win          : v2,
            your_choice     : map_choice_to_string(arg0),
            antigone_choice : map_choice_to_string(v0),
            result          : v1,
        };
        0x2::event::emit<GamingResultEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

