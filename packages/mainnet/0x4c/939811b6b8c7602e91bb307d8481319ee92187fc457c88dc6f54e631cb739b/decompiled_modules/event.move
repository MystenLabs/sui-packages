module 0x4c939811b6b8c7602e91bb307d8481319ee92187fc457c88dc6f54e631cb739b::event {
    struct PurchaseEvent has copy, drop {
        user: address,
        amount: u64,
        static_power: u64,
        x_amount: u64,
        y_amount: u64,
    }

    public fun purchase_event(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = PurchaseEvent{
            user         : arg0,
            amount       : arg1,
            static_power : arg2,
            x_amount     : arg3,
            y_amount     : arg4,
        };
        0x2::event::emit<PurchaseEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

