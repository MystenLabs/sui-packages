module 0xfceec0c9e4a087f53772170b6ce964af7be9cd63cf2d2c466aa82bc6e3202760::events {
    struct Event<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    struct DepositEventV1 has copy, drop {
        user: address,
        amount: u64,
    }

    struct WithdrawEventV1 has copy, drop {
        user: address,
        amount: u64,
    }

    fun emit<T0: copy + drop>(arg0: T0) {
        let v0 = Event<T0>{pos0: arg0};
        0x2::event::emit<Event<T0>>(v0);
    }

    public(friend) fun emit_deposit_event(arg0: address, arg1: u64) {
        let v0 = DepositEventV1{
            user   : arg0,
            amount : arg1,
        };
        emit<DepositEventV1>(v0);
    }

    public(friend) fun emit_withdraw_event(arg0: address, arg1: u64) {
        let v0 = WithdrawEventV1{
            user   : arg0,
            amount : arg1,
        };
        emit<WithdrawEventV1>(v0);
    }

    // decompiled from Move bytecode v7
}

