module 0xe2c9bbf4bd8da9f66a95cca911084a4d3b29157f9c131810b789d55447027570::kael777_game {
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
            0x1::string::utf8(b"kael777_rock")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"kael777_paper")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"kael777_scissors")
        } else {
            0x1::string::utf8(b"Invalid")
        }
    }

    public entry fun pick_random_by_tx_hash(arg0: &0x2::tx_context::TxContext) : u8 {
        let v0 = 0x2::bcs::new(*0x2::tx_context::digest(arg0));
        ((0x2::bcs::peel_u64(&mut v0) % 3) as u8)
    }

    public entry fun play(arg0: u8, arg1: &0x2::clock::Clock) {
        assert!(arg0 < 3, 1);
        let v0 = get_random_choice(arg1);
        let (v1, v2) = if (arg0 == 0 && v0 == 2 || arg0 == 1 && v0 == 0 || arg0 == 2 && v0 == 1) {
            (0x1::string::utf8(b"you Win kael777"), true)
        } else if (arg0 == v0) {
            (0x1::string::utf8(b"you Draw kael777"), false)
        } else {
            (0x1::string::utf8(b"you Lose kael777"), false)
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

