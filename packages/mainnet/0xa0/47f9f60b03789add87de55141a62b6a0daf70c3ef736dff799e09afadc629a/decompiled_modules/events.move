module 0xa047f9f60b03789add87de55141a62b6a0daf70c3ef736dff799e09afadc629a::events {
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

