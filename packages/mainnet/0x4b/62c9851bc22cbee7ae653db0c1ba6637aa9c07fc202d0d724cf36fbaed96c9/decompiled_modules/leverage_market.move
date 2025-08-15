module 0x4b62c9851bc22cbee7ae653db0c1ba6637aa9c07fc202d0d724cf36fbaed96c9::leverage_market {
    struct LeverageMarket has store, key {
        id: 0x2::object::UID,
        leverage_on_going: bool,
        supported_market_id: 0x2::object::ID,
    }

    struct NewLeverageMarketEvent has copy, drop {
        creator: address,
        supported_market_id: 0x2::object::ID,
    }

    public fun is_leverate_on_going(arg0: &LeverageMarket) : bool {
        arg0.leverage_on_going
    }

    public fun is_supporting_market(arg0: &LeverageMarket, arg1: 0x2::object::ID) : bool {
        arg0.supported_market_id == arg1
    }

    public(friend) fun mark_leverage_finished(arg0: &mut LeverageMarket) {
        assert!(arg0.leverage_on_going, 13906834341847105535);
        arg0.leverage_on_going = false;
    }

    public(friend) fun mark_leverage_ongoing(arg0: &mut LeverageMarket) {
        assert!(!arg0.leverage_on_going, 13906834320372269055);
        arg0.leverage_on_going = true;
    }

    public(friend) fun new_market(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : LeverageMarket {
        let v0 = LeverageMarket{
            id                  : 0x2::object::new(arg1),
            leverage_on_going   : false,
            supported_market_id : arg0,
        };
        let v1 = NewLeverageMarketEvent{
            creator             : 0x2::tx_context::sender(arg1),
            supported_market_id : arg0,
        };
        0x2::event::emit<NewLeverageMarketEvent>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

