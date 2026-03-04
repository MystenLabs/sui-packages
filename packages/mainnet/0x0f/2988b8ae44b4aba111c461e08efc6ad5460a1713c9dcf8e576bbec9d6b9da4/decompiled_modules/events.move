module 0xf2988b8ae44b4aba111c461e08efc6ad5460a1713c9dcf8e576bbec9d6b9da4::events {
    struct SwapOrderCreated has copy, drop {
        cctp_nonce: u64,
        sender: address,
        amount: u64,
        output_token: address,
        min_output: u64,
        recipient: address,
        created_at: u64,
        dst_eid: u32,
        quote_id: u64,
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

    public(friend) fun emit_swap_order_created(arg0: u64, arg1: address, arg2: u64, arg3: address, arg4: u64, arg5: address, arg6: u64, arg7: u32, arg8: u64) {
        let v0 = SwapOrderCreated{
            cctp_nonce   : arg0,
            sender       : arg1,
            amount       : arg2,
            output_token : arg3,
            min_output   : arg4,
            recipient    : arg5,
            created_at   : arg6,
            dst_eid      : arg7,
            quote_id     : arg8,
        };
        0x2::event::emit<SwapOrderCreated>(v0);
    }

    // decompiled from Move bytecode v6
}

