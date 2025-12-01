module 0x7438a2f45d1b5548df81e714cbe5bbcb77c0dd25198373acfae368634279d221::ping_pong {
    struct PingPong has copy, drop {
        from: address,
        amount: u64,
    }

    public fun ping(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = PingPong{
            from   : 0x2::tx_context::sender(arg1),
            amount : 0x2::coin::value<0x2::sui::SUI>(&arg0),
        };
        0x2::event::emit<PingPong>(v0);
        arg0
    }

    // decompiled from Move bytecode v6
}

