module 0x3d8deafe1a7ddf0a8b8ea8711d1d74f83d8fab26b9413b1149942025366eb69a::leverage_market {
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
        assert!(arg0.leverage_on_going, 13906834350437040127);
        arg0.leverage_on_going = false;
    }

    public(friend) fun mark_leverage_ongoing(arg0: &mut LeverageMarket) {
        assert!(!arg0.leverage_on_going, 13906834328962203647);
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

