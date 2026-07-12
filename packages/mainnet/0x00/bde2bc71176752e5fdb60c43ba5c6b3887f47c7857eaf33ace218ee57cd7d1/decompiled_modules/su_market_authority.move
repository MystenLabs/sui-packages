module 0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::su_market_authority {
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
        0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::events::market_cap_destroyed(v1);
    }

    // decompiled from Move bytecode v7
}

