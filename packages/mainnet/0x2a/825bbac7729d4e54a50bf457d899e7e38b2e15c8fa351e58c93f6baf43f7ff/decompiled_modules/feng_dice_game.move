module 0x2a825bbac7729d4e54a50bf457d899e7e38b2e15c8fa351e58c93f6baf43f7ff::feng_dice_game {
    struct FGResultEvent has copy, drop {
        win_flag: bool,
        your_guess: 0x1::string::String,
        lottery_num: u8,
        remark: 0x1::string::String,
    }

    fun map_guess_to_string(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"SMALL")
        } else {
            0x1::string::utf8(b"BIG")
        }
    }

    public fun play(arg0: u8, arg1: &0x2::clock::Clock) {
        assert!(arg0 < 2, 1);
        let v0 = start_lottery(arg1);
        let (v1, v2) = if (arg0 == 0 && v0 <= 2 || arg0 == 1 && v0 > 2) {
            (0x1::string::utf8(b"You Win"), true)
        } else {
            (0x1::string::utf8(b"Sorry, Yor Lose"), false)
        };
        let v3 = FGResultEvent{
            win_flag    : v2,
            your_guess  : map_guess_to_string(arg0),
            lottery_num : v0 + 1,
            remark      : v1,
        };
        0x2::event::emit<FGResultEvent>(v3);
    }

    fun start_lottery(arg0: &0x2::clock::Clock) : u8 {
        ((0x2::clock::timestamp_ms(arg0) % 6) as u8)
    }

    // decompiled from Move bytecode v6
}

