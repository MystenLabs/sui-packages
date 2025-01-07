module 0x8d29e46cdbb9f8ae14b3f5619ca31ee0deb85f4685afcf0eb2aab2e3b94d8066::rock_paper_scissors {
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
            0x1::string::utf8(b"vklo1 rock")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"vklo1 paper")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"vklo1 scissors")
        } else {
            0x1::string::utf8(b"Invalid")
        }
    }

    public entry fun play(arg0: u8, arg1: &0x2::clock::Clock) {
        assert!(arg0 < 3, 1);
        let v0 = get_random_choice(arg1);
        let (v1, v2) = if (arg0 == 0 && v0 == 1 || arg0 == 1 && v0 == 2 || arg0 == 2 && v0 == 0) {
            (0x1::string::utf8(b"vklo1 is Win"), true)
        } else if (arg0 == v0) {
            (0x1::string::utf8(b"vklo1 is Draw"), false)
        } else {
            (0x1::string::utf8(b"vklo1 is Lose"), false)
        };
        let v3 = GamingResultEvent{
            is_win          : v2,
            your_choice     : map_choice_to_string(arg0),
            computer_choice : map_choice_to_string(v0),
            result          : v1,
        };
        0x2::event::emit<GamingResultEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

