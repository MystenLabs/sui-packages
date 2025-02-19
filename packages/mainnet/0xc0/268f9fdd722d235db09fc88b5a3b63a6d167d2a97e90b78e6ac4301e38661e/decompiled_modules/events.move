module 0xc0268f9fdd722d235db09fc88b5a3b63a6d167d2a97e90b78e6ac4301e38661e::events {
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

