module 0x6c46888d7d4f0c97fb401be204c7ce080daa025ff3ed561cdf7632f7c0287460::customize_event {
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

