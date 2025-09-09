module 0x6eed7ba483e3940a9c7b36e5e117c84f6a39c49d84d29946565b85f21c0b85f4::event {
    struct DepositEvent has copy, drop {
        vault: 0x2::object::ID,
        amount: u64,
    }

    public(friend) fun emit_deposit_event(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = DepositEvent{
            vault  : arg0,
            amount : arg1,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

