module 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session {
    struct MarketSession has copy, drop, store {
        pos0: u16,
    }

    public(friend) fun from_u16(arg0: u16) : MarketSession {
        assert!(arg0 < 5, 13906834217293053953);
        MarketSession{pos0: arg0}
    }

    public fun is_closed(arg0: &MarketSession) : bool {
        arg0.pos0 == 4
    }

    public fun is_over_night(arg0: &MarketSession) : bool {
        arg0.pos0 == 3
    }

    public fun is_post_market(arg0: &MarketSession) : bool {
        arg0.pos0 == 2
    }

    public fun is_pre_market(arg0: &MarketSession) : bool {
        arg0.pos0 == 1
    }

    public fun is_regular(arg0: &MarketSession) : bool {
        arg0.pos0 == 0
    }

    // decompiled from Move bytecode v6
}

