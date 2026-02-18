module 0x8e99fadf9a35f13664254c9b252f8c398cd8f5e28536c9fdd4609c678e496282::events {
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

    // decompiled from Move bytecode v6
}

