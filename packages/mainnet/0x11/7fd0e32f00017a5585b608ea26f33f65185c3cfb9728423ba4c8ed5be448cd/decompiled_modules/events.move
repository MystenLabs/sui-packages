module 0x117fd0e32f00017a5585b608ea26f33f65185c3cfb9728423ba4c8ed5be448cd::events {
    struct SwapOrderCreated has copy, drop {
        cctp_nonce: u64,
        sender: address,
        amount: u64,
        output_token: address,
        min_output: u64,
        recipient: address,
        created_at: u64,
    }

    struct SwapOrderCancelled has copy, drop {
        cctp_nonce: u64,
        cancelled_by: address,
    }

    public(friend) fun emit_swap_order_cancelled(arg0: u64, arg1: address) {
        let v0 = SwapOrderCancelled{
            cctp_nonce   : arg0,
            cancelled_by : arg1,
        };
        0x2::event::emit<SwapOrderCancelled>(v0);
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

