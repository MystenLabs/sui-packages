module 0xb0ffa99b4b91e301ed7acb4482e5091e0ff4c3c8beba467ae65e980d188fa7ac::query {
    struct QuerySupraPrice has copy, drop {
        pair: u32,
        value: u128,
        decimal: u16,
        timestamp: u128,
        round: u64,
    }

    public fun query(arg0: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg1: u32) {
        let v0 = 0x1::vector::empty<u32>();
        0x1::vector::push_back<u32>(&mut v0, arg1);
        let v1 = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_prices(arg0, v0);
        let (v2, v3, v4, v5, v6) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::extract_price(0x1::vector::borrow<0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::Price>(&v1, 0));
        let v7 = QuerySupraPrice{
            pair      : v2,
            value     : v3,
            decimal   : v4,
            timestamp : v5,
            round     : v6,
        };
        0x2::event::emit<QuerySupraPrice>(v7);
    }

    // decompiled from Move bytecode v6
}

