module 0x83e0022e96e0914516fd83fcb19d37efa0ed5aae2a81e9b15723a538fd209128::events {
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

