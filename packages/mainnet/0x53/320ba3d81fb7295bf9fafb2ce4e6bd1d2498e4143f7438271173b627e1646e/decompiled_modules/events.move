module 0x53320ba3d81fb7295bf9fafb2ce4e6bd1d2498e4143f7438271173b627e1646e::events {
    struct SwapCompletedEvent has copy, drop {
        swapper: address,
        type_in: 0x1::ascii::String,
        amount_in: u64,
        type_out: 0x1::ascii::String,
        amount_out: u64,
    }

    public(friend) fun emit_swap_completed_event(arg0: vector<u8>, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = SwapCompletedEvent{
            swapper    : 0x2::tx_context::sender(arg4),
            type_in    : 0x1::ascii::string(arg0),
            amount_in  : arg1,
            type_out   : 0x1::ascii::string(arg2),
            amount_out : arg3,
        };
        0x2::event::emit<SwapCompletedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

