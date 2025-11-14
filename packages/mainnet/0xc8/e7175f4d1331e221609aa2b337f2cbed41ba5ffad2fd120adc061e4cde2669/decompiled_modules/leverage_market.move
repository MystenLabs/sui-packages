module 0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_market {
    struct LeverageMarket has store, key {
        id: 0x2::object::UID,
        leverage_on_going: bool,
        supported_market_id: 0x2::object::ID,
        emode_group: u8,
    }

    struct NewLeverageMarketEvent has copy, drop {
        creator: address,
        supported_market_id: 0x2::object::ID,
    }

    public fun emode_group(arg0: &LeverageMarket) : u8 {
        arg0.emode_group
    }

    public fun ensure_supporting_market<T0>(arg0: &LeverageMarket, arg1: &0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::Market<T0>) {
        assert!(arg0.supported_market_id == 0x2::object::id<0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::Market<T0>>(arg1), 0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_error::market_not_supported());
    }

    public fun is_leverate_on_going(arg0: &LeverageMarket) : bool {
        arg0.leverage_on_going
    }

    public(friend) fun mark_leverage_finished(arg0: &mut LeverageMarket) {
        assert!(arg0.leverage_on_going, 13906834427746451455);
        arg0.leverage_on_going = false;
    }

    public(friend) fun mark_leverage_ongoing(arg0: &mut LeverageMarket) {
        assert!(!arg0.leverage_on_going, 13906834406271614975);
        arg0.leverage_on_going = true;
    }

    public(friend) fun new_market(arg0: 0x2::object::ID, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : LeverageMarket {
        let v0 = LeverageMarket{
            id                  : 0x2::object::new(arg2),
            leverage_on_going   : false,
            supported_market_id : arg0,
            emode_group         : arg1,
        };
        let v1 = NewLeverageMarketEvent{
            creator             : 0x2::tx_context::sender(arg2),
            supported_market_id : arg0,
        };
        0x2::event::emit<NewLeverageMarketEvent>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

