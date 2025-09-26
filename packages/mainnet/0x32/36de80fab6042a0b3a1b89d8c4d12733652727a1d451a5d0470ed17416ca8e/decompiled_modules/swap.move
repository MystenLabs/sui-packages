module 0x3236de80fab6042a0b3a1b89d8c4d12733652727a1d451a5d0470ed17416ca8e::swap {
    struct EventSwapExecuted<phantom T0, phantom T1> has copy, drop {
        trade_id: u128,
        rfq_account_id: 0x2::object::ID,
        protected_margin_account_id: 0x2::object::ID,
        nonce: u128,
        input: u64,
        output: u64,
    }

    public fun emit_swap_event<T0, T1>(arg0: u128, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u128, arg4: u64, arg5: u64) {
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

