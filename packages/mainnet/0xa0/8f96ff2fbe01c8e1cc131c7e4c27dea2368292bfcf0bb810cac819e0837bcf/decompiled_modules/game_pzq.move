module 0xa08f96ff2fbe01c8e1cc131c7e4c27dea2368292bfcf0bb810cac819e0837bcf::game_pzq {
    struct GameOut has copy, drop {
        player_guess: u64,
        machine_result: u64,
        outcome: 0x1::string::String,
    }

    public fun playGame(arg0: &mut 0x2::coin::TreasuryCap<0xa08f96ff2fbe01c8e1cc131c7e4c27dea2368292bfcf0bb810cac819e0837bcf::coinfacet::COINFACET>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == 0 || arg1 == 1, 1);
        let v0 = random_result(arg2);
        let v1 = arg1 == v0;
        let v2 = if (v1) {
            0x1::string::utf8(b"you win this game")
        } else {
            0x1::string::utf8(b"You lost this game")
        };
        let v3 = GameOut{
            player_guess   : arg1,
            machine_result : v0,
            outcome        : v2,
        };
        if (v1) {
            0xa08f96ff2fbe01c8e1cc131c7e4c27dea2368292bfcf0bb810cac819e0837bcf::coinfacet::mint(arg0, arg3);
        };
        0x2::event::emit<GameOut>(v3);
    }

    fun random_result(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) % 2
    }

    // decompiled from Move bytecode v6
}

