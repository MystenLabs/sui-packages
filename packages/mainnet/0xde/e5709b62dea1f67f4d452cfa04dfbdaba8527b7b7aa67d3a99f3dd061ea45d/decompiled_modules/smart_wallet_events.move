module 0xdee5709b62dea1f67f4d452cfa04dfbdaba8527b7b7aa67d3a99f3dd061ea45d::smart_wallet_events {
    struct BetEvent<phantom T0> has copy, drop, store {
        player_address: address,
        bet_size: u64,
        payout_amount: u64,
        pnl: u64,
    }

    public fun EmitBetEvent<T0>(arg0: address, arg1: u64, arg2: u64) {
        let v0 = BetEvent<T0>{
            player_address : arg0,
            bet_size       : arg1,
            payout_amount  : arg2,
            pnl            : arg1 - arg2,
        };
        0x2::event::emit<BetEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

