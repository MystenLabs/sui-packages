module 0xa9f8f348f18a0c790bcc4c61cb909183272b72e96ccd985848cff5074ec1a03a::vv1133_game {
    struct GameOutcome has copy, drop {
        player_guess: u64,
        machine_result: u64,
        outcome: 0x1::string::String,
    }

    public fun play(arg0: &mut 0x2::coin::TreasuryCap<0xd5cb8233cba492b0429d66461a50cb997792a8d848758e42bb993b2d1fc74073::vv1133_faucet::VV1133_FAUCET>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == 0 || arg1 == 1, 1);
        let v0 = random_result(arg2);
        let v1 = arg1 == v0;
        let v2 = if (v1) {
            0x1::string::utf8(b"vv1133_game WIN")
        } else {
            0x1::string::utf8(b"vv1133_game LOSE")
        };
        let v3 = GameOutcome{
            player_guess   : arg1,
            machine_result : v0,
            outcome        : v2,
        };
        if (v1) {
            0xd5cb8233cba492b0429d66461a50cb997792a8d848758e42bb993b2d1fc74073::vv1133_faucet::mint(arg0, 100, 0x2::tx_context::sender(arg3), arg3);
        };
        0x2::event::emit<GameOutcome>(v3);
    }

    fun random_result(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) % 2
    }

    // decompiled from Move bytecode v6
}

