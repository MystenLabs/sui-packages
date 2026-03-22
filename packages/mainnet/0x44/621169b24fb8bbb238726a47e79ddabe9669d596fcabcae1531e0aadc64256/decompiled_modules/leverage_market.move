module 0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_market {
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

    public(friend) fun emode_group(arg0: &LeverageMarket) : u8 {
        arg0.emode_group
    }

    public(friend) fun ensure_leverage_on_going(arg0: &LeverageMarket) {
        assert!(arg0.leverage_on_going, 0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_error::leverage_not_on_going());
    }

    public(friend) fun ensure_no_leverage_on_going(arg0: &LeverageMarket) {
        assert!(!arg0.leverage_on_going, 0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_error::leverage_on_going());
    }

    public(friend) fun ensure_supporting_market<T0>(arg0: &LeverageMarket, arg1: &0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::market::Market<T0>) {
        assert!(arg0.supported_market_id == 0x2::object::id<0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::market::Market<T0>>(arg1), 0x44621169b24fb8bbb238726a47e79ddabe9669d596fcabcae1531e0aadc64256::leverage_error::market_not_supported());
    }

    public(friend) fun mark_leverage_finished(arg0: &mut LeverageMarket) {
        ensure_leverage_on_going(arg0);
        arg0.leverage_on_going = false;
    }

    public(friend) fun mark_leverage_ongoing(arg0: &mut LeverageMarket) {
        ensure_no_leverage_on_going(arg0);
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

