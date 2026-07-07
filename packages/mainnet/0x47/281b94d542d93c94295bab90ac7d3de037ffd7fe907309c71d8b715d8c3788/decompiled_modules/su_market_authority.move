module 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_market_authority {
    struct MarketCap has store, key {
        id: 0x2::object::UID,
        market: 0x2::object::ID,
        oracle: 0x2::object::ID,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : MarketCap {
        MarketCap{
            id     : 0x2::object::new(arg2),
            market : arg0,
            oracle : arg1,
        }
    }

    public(friend) fun assert_market(arg0: &MarketCap, arg1: 0x2::object::ID) {
        assert!(arg0.market == arg1, 31);
    }

    public(friend) fun assert_oracle(arg0: &MarketCap, arg1: 0x2::object::ID) {
        assert!(arg0.oracle == arg1, 37);
    }

    public fun destroy_market_cap(arg0: MarketCap) {
        let MarketCap {
            id     : v0,
            market : v1,
            oracle : _,
        } = arg0;
        0x2::object::delete(v0);
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::events::market_cap_destroyed(v1);
    }

    // decompiled from Move bytecode v7
}

