module 0x3132baacfff5c54eec3346cd80cdaadffe4d12fb8b25a614c97f7fb7ee0cba27::lbiyou_game {
    struct GameOutcome has copy, drop {
        player_guess: u64,
        machine_result: u64,
        outcome: 0x1::string::String,
    }

    public fun play(arg0: &mut 0x2::coin::TreasuryCap<0x5ab9138caf5feda50e25691b9748c0a53338e5e4d00ff6ffbe3ea7ac5afe45d5::lbiyou_faucet::LBIYOU_FAUCET>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == 0 || arg1 == 1, 1);
        let v0 = random_result(arg2);
        let v1 = arg1 == v0;
        let v2 = if (v1) {
            0x1::string::utf8(b"you win the game")
        } else {
            0x1::string::utf8(b"game over")
        };
        let v3 = GameOutcome{
            player_guess   : arg1,
            machine_result : v0,
            outcome        : v2,
        };
        if (v1) {
            0x5ab9138caf5feda50e25691b9748c0a53338e5e4d00ff6ffbe3ea7ac5afe45d5::lbiyou_faucet::mint(arg0, 1, 0x2::tx_context::sender(arg3), arg3);
        };
        0x2::event::emit<GameOutcome>(v3);
    }

    fun random_result(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) % 2
    }

    // decompiled from Move bytecode v6
}

