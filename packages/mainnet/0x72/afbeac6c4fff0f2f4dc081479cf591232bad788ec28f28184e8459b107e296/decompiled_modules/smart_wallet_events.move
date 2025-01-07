module 0x72afbeac6c4fff0f2f4dc081479cf591232bad788ec28f28184e8459b107e296::smart_wallet_events {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BetEvent<phantom T0> has copy, drop, store {
        player_address: address,
        bet_size: u64,
        payout_amount: u64,
        pnl: u64,
        timestamp: u64,
    }

    public fun EmitBetEvent<T0>(arg0: &AdminCap, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = BetEvent<T0>{
            player_address : arg1,
            bet_size       : arg2,
            payout_amount  : arg3,
            pnl            : arg2 - arg3,
            timestamp      : arg4,
        };
        0x2::event::emit<BetEvent<T0>>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

