module 0x3e65e78df172810e2803428a3f51d96155212a79eee0f5b4533a1e0a8ce83db6::customize_event {
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

