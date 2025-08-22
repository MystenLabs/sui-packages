module 0x81960fc8b5740b161eb9c5b8db631b97878cdeb7676c9d5acb5ccade9276c233::event {
    struct PurchaseEvent has copy, drop {
        user: address,
        amount: u64,
        sui_price: u64,
        x_amount: u64,
        y_amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        user: address,
        amount: u64,
        free_amount: u64,
        x_amount: u64,
        y_amount: u64,
        sui_price: u64,
    }

    public fun purchase_event(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = PurchaseEvent{
            user      : arg0,
            amount    : arg1,
            sui_price : arg2,
            x_amount  : arg3,
            y_amount  : arg4,
        };
        0x2::event::emit<PurchaseEvent>(v0);
    }

    public fun withdraw_event(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = WithdrawEvent{
            user        : arg0,
            amount      : arg1,
            free_amount : arg2,
            x_amount    : arg3,
            y_amount    : arg4,
            sui_price   : arg5,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

