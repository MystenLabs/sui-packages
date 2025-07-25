module 0x4dfaa01e9fcc00ab2cd4f4b4dbb46ec502dfaf882ad1d8aa26d973949df41c7c::events {
    struct BuyEvent<phantom T0, phantom T1> has copy, drop {
        recipient: address,
        amount_in: u64,
        amount_out: u64,
    }

    struct SellEvent<phantom T0, phantom T1> has copy, drop {
        recipient: address,
        amount_in: u64,
        amount_out: u64,
    }

    struct OrderCompletedEvent has copy, drop {
        order_id: 0x1::ascii::String,
    }

    public(friend) fun emit_buy_event<T0, T1>(arg0: address, arg1: u64, arg2: u64) {
        let v0 = BuyEvent<T0, T1>{
            recipient  : arg0,
            amount_in  : arg1,
            amount_out : arg2,
        };
        0x2::event::emit<BuyEvent<T0, T1>>(v0);
    }

    public(friend) fun emit_order_completed_event(arg0: 0x1::ascii::String) {
        let v0 = OrderCompletedEvent{order_id: arg0};
        0x2::event::emit<OrderCompletedEvent>(v0);
    }

    public(friend) fun emit_sell_event<T0, T1>(arg0: address, arg1: u64, arg2: u64) {
        let v0 = SellEvent<T0, T1>{
            recipient  : arg0,
            amount_in  : arg1,
            amount_out : arg2,
        };
        0x2::event::emit<SellEvent<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v6
}

