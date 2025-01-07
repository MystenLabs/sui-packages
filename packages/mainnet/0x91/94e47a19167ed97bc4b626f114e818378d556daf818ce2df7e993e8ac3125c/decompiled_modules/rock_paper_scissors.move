module 0x9194e47a19167ed97bc4b626f114e818378d556daf818ce2df7e993e8ac3125c::rock_paper_scissors {
    struct GamingResultEvent has copy, drop {
        is_win: bool,
        your_choice: vector<u8>,
        computer_choice: vector<u8>,
        result: vector<u8>,
    }

    fun get_random_choice(arg0: &0x2::clock::Clock) : u8 {
        ((0x2::clock::timestamp_ms(arg0) % 7) as u8)
    }

    public entry fun get_result(arg0: u8, arg1: &0x2::clock::Clock) {
        assert!(arg0 < 3, 1);
        let v0 = get_random_choice(arg1);
        let (v1, v2) = if (arg0 == 0 && v0 == 1 || arg0 == 1 && v0 == 2 || arg0 == 2 && v0 == 0) {
            (b"Win", true)
        } else if (arg0 == v0) {
            (b"Draw", false)
        } else {
            (b"Lose", false)
        };
        let v3 = GamingResultEvent{
            is_win          : v2,
            your_choice     : map_choice_to_string(arg0),
            computer_choice : map_choice_to_string(v0),
            result          : v1,
        };
        0x2::event::emit<GamingResultEvent>(v3);
    }

    fun map_choice_to_string(arg0: u8) : vector<u8> {
        if (arg0 == 0) {
            b"rock"
        } else if (arg0 == 1) {
            b"paper"
        } else if (arg0 == 2) {
            b"scissors"
        } else {
            b"Invalid"
        }
    }

    // decompiled from Move bytecode v6
}

