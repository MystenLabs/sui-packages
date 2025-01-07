module 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::event {
    struct GamePlay has copy, drop {
        game: u64,
        player: address,
        wager: u64,
        payout: u64,
        result: u64,
        profit: u64,
        xluck: u64,
    }

    public fun EmitGamePlay(arg0: u64, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = GamePlay{
            game   : arg0,
            player : arg1,
            wager  : arg2,
            payout : arg3,
            result : arg4,
            profit : arg5,
            xluck  : arg6,
        };
        0x2::event::emit<GamePlay>(v0);
    }

    // decompiled from Move bytecode v6
}

