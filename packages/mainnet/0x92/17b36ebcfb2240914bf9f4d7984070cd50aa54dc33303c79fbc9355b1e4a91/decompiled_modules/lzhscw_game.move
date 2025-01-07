module 0x9217b36ebcfb2240914bf9f4d7984070cd50aa54dc33303c79fbc9355b1e4a91::lzhscw_game {
    struct LZHSCW_GAME has drop {
        dummy_field: bool,
    }

    struct GamingResultEvent has copy, drop {
        is_win: bool,
        your_choice: 0x1::string::String,
        computer_choice0: 0x1::string::String,
        computer_choice1: 0x1::string::String,
        computer_choice2: 0x1::string::String,
        result: 0x1::string::String,
    }

    fun get_random_choice_lzhscw(arg0: &0x2::clock::Clock) : u8 {
        ((0x2::clock::timestamp_ms(arg0) % 6) as u8)
    }

    fun init(arg0: LZHSCW_GAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LZHSCW_GAME>(arg0, 1, b"LZHSCW_GAME", b"scw", b"deploy by lzhscw", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LZHSCW_GAME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LZHSCW_GAME>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun map_bottom_computer_choice_to_string_lzhscw(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"   ")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"   ")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"  o")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"o o")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"o o")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"o o")
        } else {
            0x1::string::utf8(b"Invalid")
        }
    }

    fun map_choice_to_string_lzhscw(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"small")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"big")
        } else {
            0x1::string::utf8(b"Invalid")
        }
    }

    fun map_middle_computer_choice_to_string_lzhscw(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b" o ")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"o o")
        } else if (arg0 == 2) {
            0x1::string::utf8(b" o ")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"   ")
        } else if (arg0 == 4) {
            0x1::string::utf8(b" o ")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"o o")
        } else {
            0x1::string::utf8(b"Invalid")
        }
    }

    fun map_top_computer_choice_to_string_lzhscw(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"   ")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"   ")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"o  ")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"o o")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"o o")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"o o")
        } else {
            0x1::string::utf8(b"Invalid")
        }
    }

    public fun play_lzhscw(arg0: u8, arg1: &0x2::clock::Clock, arg2: &mut 0x2::coin::TreasuryCap<LZHSCW_GAME>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 < 2, 1);
        let v0 = get_random_choice_lzhscw(arg1);
        let (v1, v2) = if (arg0 == 0 && v0 == 0 || arg0 == 0 && v0 == 1 || arg0 == 0 && v0 == 2) {
            (0x1::string::utf8(b"Win"), true)
        } else {
            (0x1::string::utf8(b"Lose"), false)
        };
        let v3 = GamingResultEvent{
            is_win           : v2,
            your_choice      : map_choice_to_string_lzhscw(arg0),
            computer_choice0 : map_top_computer_choice_to_string_lzhscw(v0),
            computer_choice1 : map_middle_computer_choice_to_string_lzhscw(v0),
            computer_choice2 : map_bottom_computer_choice_to_string_lzhscw(v0),
            result           : v1,
        };
        0x2::event::emit<GamingResultEvent>(v3);
        if (v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<LZHSCW_GAME>>(0x2::coin::mint<LZHSCW_GAME>(arg2, 100, arg3), 0x2::tx_context::sender(arg3));
        };
    }

    // decompiled from Move bytecode v6
}

