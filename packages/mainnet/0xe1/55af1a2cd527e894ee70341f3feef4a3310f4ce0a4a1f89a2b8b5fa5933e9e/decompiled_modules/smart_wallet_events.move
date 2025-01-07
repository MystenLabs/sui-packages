module 0xe155af1a2cd527e894ee70341f3feef4a3310f4ce0a4a1f89a2b8b5fa5933e9e::smart_wallet_events {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BetEvent<phantom T0> has copy, drop, store {
        player_address: address,
        bet_size: u64,
        payout_amount: u64,
        timestamp: u64,
    }

    public fun EmitBetEvent<T0>(arg0: &AdminCap, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = BetEvent<T0>{
            player_address : arg1,
            bet_size       : arg2,
            payout_amount  : arg3,
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

