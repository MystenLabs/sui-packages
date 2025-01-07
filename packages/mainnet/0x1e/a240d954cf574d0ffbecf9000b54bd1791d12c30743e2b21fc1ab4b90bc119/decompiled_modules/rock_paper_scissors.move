module 0x1ea240d954cf574d0ffbecf9000b54bd1791d12c30743e2b21fc1ab4b90bc119::rock_paper_scissors {
    struct GamingResultEvent has copy, drop {
        is_win: bool,
        your_choice: vector<u8>,
        computer_choice: vector<u8>,
        result: vector<u8>,
    }

    fun get_random_choice(arg0: u64) : u8 {
        ((arg0 % 3) as u8)
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

    public fun play(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 < 3, 1);
        let v0 = get_random_choice(0x2::tx_context::epoch_timestamp_ms(arg1));
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

    // decompiled from Move bytecode v6
}

