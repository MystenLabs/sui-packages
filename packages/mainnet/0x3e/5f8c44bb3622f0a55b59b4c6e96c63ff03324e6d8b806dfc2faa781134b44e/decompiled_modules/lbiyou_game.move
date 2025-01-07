module 0x3e5f8c44bb3622f0a55b59b4c6e96c63ff03324e6d8b806dfc2faa781134b44e::lbiyou_game {
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
            0x1::string::utf8(b"lbiyou_rock")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"lbiyou_paper")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"lbiyou_scissors")
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
            (0x1::string::utf8(b"you Win lbiyou"), true)
        } else if (arg0 == v0) {
            (0x1::string::utf8(b"you Draw lbiyou"), false)
        } else {
            (0x1::string::utf8(b"you Lose lbiyou"), false)
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

