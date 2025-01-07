module 0x25158046b72d620d70d85fe4511e367caa27ac77d49faacda06abd82f67c785e::vv1133_game {
    struct GameOutcome has copy, drop {
        player_guess: u64,
        machine_result: u64,
        bets_amount: u64,
        outcome: 0x1::string::String,
    }

    public fun play(arg0: &mut 0x2::coin::TreasuryCap<0xd5cb8233cba492b0429d66461a50cb997792a8d848758e42bb993b2d1fc74073::vv1133_faucet::VV1133_FAUCET>, arg1: 0x2::coin::Coin<0xd5cb8233cba492b0429d66461a50cb997792a8d848758e42bb993b2d1fc74073::vv1133_faucet::VV1133_FAUCET>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == 0 || arg2 == 1, 1);
        let v0 = 0x2::coin::value<0xd5cb8233cba492b0429d66461a50cb997792a8d848758e42bb993b2d1fc74073::vv1133_faucet::VV1133_FAUCET>(&arg1);
        let v1 = random_result(arg3);
        let v2 = arg2 == v1;
        let v3 = if (v2) {
            0x1::string::utf8(b"vv1133_game WIN")
        } else {
            0x1::string::utf8(b"vv1133_game LOSE")
        };
        let v4 = GameOutcome{
            player_guess   : arg2,
            machine_result : v1,
            bets_amount    : v0,
            outcome        : v3,
        };
        if (v2) {
            0xd5cb8233cba492b0429d66461a50cb997792a8d848758e42bb993b2d1fc74073::vv1133_faucet::mint(arg0, v0 * 2, 0x2::tx_context::sender(arg4), arg4);
        };
        0x2::coin::burn<0xd5cb8233cba492b0429d66461a50cb997792a8d848758e42bb993b2d1fc74073::vv1133_faucet::VV1133_FAUCET>(arg0, arg1);
        0x2::event::emit<GameOutcome>(v4);
    }

    fun random_result(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) % 2
    }

    // decompiled from Move bytecode v6
}

