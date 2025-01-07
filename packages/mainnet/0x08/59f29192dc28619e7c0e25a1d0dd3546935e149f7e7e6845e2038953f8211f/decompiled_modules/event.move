module 0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::event {
    struct Deposit<phantom T0> has copy, drop {
        depositor: address,
        value: u64,
    }

    public(friend) fun deposit<T0>(arg0: address, arg1: u64) {
        let v0 = Deposit<T0>{
            depositor : arg0,
            value     : arg1,
        };
        0x2::event::emit<Deposit<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

