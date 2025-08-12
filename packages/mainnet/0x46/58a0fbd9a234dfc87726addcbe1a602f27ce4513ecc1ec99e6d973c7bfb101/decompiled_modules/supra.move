module 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::supra {
    struct SupraPrice has copy, drop {
        pair: u32,
        price: u128,
        decimal: u16,
        timestamp: u128,
        round: u64,
    }

    public fun retrieve_price(arg0: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg1: u32) : (u128, u16, u128) {
        let (v0, v1, v2, v3) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg0, arg1);
        let v4 = SupraPrice{
            pair      : arg1,
            price     : v0,
            decimal   : v1,
            timestamp : v2,
            round     : v3,
        };
        0x2::event::emit<SupraPrice>(v4);
        (v0, v1, v2)
    }

    // decompiled from Move bytecode v6
}

