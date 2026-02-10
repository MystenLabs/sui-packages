module 0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_market {
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

    public fun ensure_leverage_on_going(arg0: &LeverageMarket) {
        assert!(arg0.leverage_on_going, 0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_error::leverage_not_on_going());
    }

    public fun ensure_no_leverage_on_going(arg0: &LeverageMarket) {
        assert!(!arg0.leverage_on_going, 0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_error::leverage_on_going());
    }

    public fun ensure_supporting_market<T0>(arg0: &LeverageMarket, arg1: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>) {
        assert!(arg0.supported_market_id == 0x2::object::id<0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>>(arg1), 0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_error::market_not_supported());
    }

    public(friend) fun mark_leverage_finished(arg0: &mut LeverageMarket) {
        assert!(arg0.leverage_on_going, 13906834444926320639);
        arg0.leverage_on_going = false;
    }

    public(friend) fun mark_leverage_ongoing(arg0: &mut LeverageMarket) {
        assert!(!arg0.leverage_on_going, 13906834423451484159);
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

