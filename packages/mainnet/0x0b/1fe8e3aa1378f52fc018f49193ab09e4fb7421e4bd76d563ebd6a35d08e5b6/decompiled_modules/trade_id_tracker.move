module 0xb1fe8e3aa1378f52fc018f49193ab09e4fb7421e4bd76d563ebd6a35d08e5b6::trade_id_tracker {
    struct TradeIdTracker has store, key {
        id: 0x2::object::UID,
        value: u256,
    }

    public fun current(arg0: &TradeIdTracker) : u256 {
        arg0.value
    }

    public(friend) fun decrement(arg0: &mut TradeIdTracker) : u256 {
        assert!(arg0.value > 0, 0);
        arg0.value = arg0.value - 1;
        arg0.value
    }

    public(friend) fun increment(arg0: &mut TradeIdTracker) : u256 {
        assert!(arg0.value < 115792089237316195423570985008687907853269984665640564039457584007913129639935, 0);
        arg0.value = arg0.value + 1;
        arg0.value
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TradeIdTracker{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::share_object<TradeIdTracker>(v0);
    }

    public(friend) fun reset(arg0: &mut TradeIdTracker) {
        arg0.value = 0;
    }

    // decompiled from Move bytecode v6
}

