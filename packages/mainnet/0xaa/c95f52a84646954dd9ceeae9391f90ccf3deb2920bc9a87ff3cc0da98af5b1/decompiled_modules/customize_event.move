module 0xaac95f52a84646954dd9ceeae9391f90ccf3deb2920bc9a87ff3cc0da98af5b1::customize_event {
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

