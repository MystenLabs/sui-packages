module 0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::trade_id_tracker {
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

