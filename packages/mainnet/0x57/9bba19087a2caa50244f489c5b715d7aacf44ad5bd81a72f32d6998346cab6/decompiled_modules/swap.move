module 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::swap {
    struct EventSwapExecuted<phantom T0, phantom T1> has copy, drop {
        trade_id: u128,
        rfq_account_id: 0x2::object::ID,
        nonce_lane_id: 0x2::object::ID,
        nonce_value: u64,
        input: u64,
        output: u64,
    }

    public(friend) fun emit_swap_event<T0, T1>(arg0: u128, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = EventSwapExecuted<T0, T1>{
            trade_id       : arg0,
            rfq_account_id : arg1,
            nonce_lane_id  : arg2,
            nonce_value    : arg3,
            input          : arg4,
            output         : arg5,
        };
        0x2::event::emit<EventSwapExecuted<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v6
}

