module 0x92135cb00cf54054852a3ffa7731223a29c02bf4ba115665e2b50d5de081c7c1::events {
    struct SwapOrderReceived has copy, drop {
        src_eid: u32,
        cctp_nonce: u64,
        output_token: address,
        min_output: u64,
        recipient: address,
    }

    struct OrderFulfilled has copy, drop {
        src_eid: u32,
        cctp_nonce: u64,
        usdc_amount: u64,
        output_amount: u64,
        output_token_hash: address,
        recipient: address,
        fulfilled_by: address,
    }

    struct FallbackWithdrawn has copy, drop {
        src_eid: u32,
        cctp_nonce: u64,
        usdc_amount: u64,
        recipient: address,
    }

    public(friend) fun emit_fallback_withdrawn(arg0: u32, arg1: u64, arg2: u64, arg3: address) {
        let v0 = FallbackWithdrawn{
            src_eid     : arg0,
            cctp_nonce  : arg1,
            usdc_amount : arg2,
            recipient   : arg3,
        };
        0x2::event::emit<FallbackWithdrawn>(v0);
    }

    public(friend) fun emit_order_fulfilled(arg0: u32, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: address, arg6: address) {
        let v0 = OrderFulfilled{
            src_eid           : arg0,
            cctp_nonce        : arg1,
            usdc_amount       : arg2,
            output_amount     : arg3,
            output_token_hash : arg4,
            recipient         : arg5,
            fulfilled_by      : arg6,
        };
        0x2::event::emit<OrderFulfilled>(v0);
    }

    public(friend) fun emit_swap_order_received(arg0: u32, arg1: u64, arg2: address, arg3: u64, arg4: address) {
        let v0 = SwapOrderReceived{
            src_eid      : arg0,
            cctp_nonce   : arg1,
            output_token : arg2,
            min_output   : arg3,
            recipient    : arg4,
        };
        0x2::event::emit<SwapOrderReceived>(v0);
    }

    // decompiled from Move bytecode v6
}

