module 0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::swap {
    struct EventSwapExecuted<phantom T0, phantom T1> has copy, drop {
        trade_id: u128,
        rfq_account_id: 0x2::object::ID,
        protected_margin_account_id: 0x2::object::ID,
        nonce: u128,
        input: u64,
        output: u64,
    }

    public(friend) fun emit_swap_event<T0, T1>(arg0: u128, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u128, arg4: u64, arg5: u64) {
        let v0 = EventSwapExecuted<T0, T1>{
            trade_id                    : arg0,
            rfq_account_id              : arg1,
            protected_margin_account_id : arg2,
            nonce                       : arg3,
            input                       : arg4,
            output                      : arg5,
        };
        0x2::event::emit<EventSwapExecuted<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v6
}

