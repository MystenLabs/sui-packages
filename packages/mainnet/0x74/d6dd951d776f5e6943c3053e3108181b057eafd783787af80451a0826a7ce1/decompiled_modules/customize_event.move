module 0x74d6dd951d776f5e6943c3053e3108181b057eafd783787af80451a0826a7ce1::customize_event {
    struct PurchaseEvent has copy, drop {
        user: address,
        y_amount: u64,
        game_type: u8,
    }

    public fun purchase_event(arg0: address, arg1: u64, arg2: u8) {
        let v0 = PurchaseEvent{
            user      : arg0,
            y_amount  : arg1,
            game_type : arg2,
        };
        0x2::event::emit<PurchaseEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

