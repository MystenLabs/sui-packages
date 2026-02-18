module 0x9d4d9aac7fa7e3ff9b2edf3b46b90855d013d1f2b3e57211ac8435370206397f::events {
    struct SwapOrderCreated has copy, drop {
        cctp_nonce: u64,
        sender: address,
        amount: u64,
        output_token: address,
        min_output: u64,
        recipient: address,
        created_at: u64,
    }

    public(friend) fun emit_swap_order_created(arg0: u64, arg1: address, arg2: u64, arg3: address, arg4: u64, arg5: address, arg6: u64) {
        let v0 = SwapOrderCreated{
            cctp_nonce   : arg0,
            sender       : arg1,
            amount       : arg2,
            output_token : arg3,
            min_output   : arg4,
            recipient    : arg5,
            created_at   : arg6,
        };
        0x2::event::emit<SwapOrderCreated>(v0);
    }

    // decompiled from Move bytecode v6
}

