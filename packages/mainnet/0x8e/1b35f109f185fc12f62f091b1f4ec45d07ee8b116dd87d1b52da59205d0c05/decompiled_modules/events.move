module 0x8e1b35f109f185fc12f62f091b1f4ec45d07ee8b116dd87d1b52da59205d0c05::events {
    struct SwapOrderReceived has copy, drop {
        src_eid: u32,
        cctp_nonce: u64,
        output_token: address,
        min_output: u64,
        recipient: address,
        quote_id: u64,
    }

    struct OrderFulfilled has copy, drop {
        src_eid: u32,
        cctp_nonce: u64,
        usdc_amount: u64,
        output_amount: u64,
        output_token_hash: address,
        recipient: address,
        fulfilled_by: address,
        quote_id: u64,
    }

    struct FallbackWithdrawn has copy, drop {
        src_eid: u32,
        cctp_nonce: u64,
        usdc_amount: u64,
        recipient: address,
        quote_id: u64,
    }

    public(friend) fun emit_fallback_withdrawn(arg0: u32, arg1: u64, arg2: u64, arg3: address, arg4: u64) {
        let v0 = FallbackWithdrawn{
            src_eid     : arg0,
            cctp_nonce  : arg1,
            usdc_amount : arg2,
            recipient   : arg3,
            quote_id    : arg4,
        };
        0x2::event::emit<FallbackWithdrawn>(v0);
    }

    public(friend) fun emit_order_fulfilled(arg0: u32, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: address, arg6: address, arg7: u64) {
        let v0 = OrderFulfilled{
            src_eid           : arg0,
            cctp_nonce        : arg1,
            usdc_amount       : arg2,
            output_amount     : arg3,
            output_token_hash : arg4,
            recipient         : arg5,
            fulfilled_by      : arg6,
            quote_id          : arg7,
        };
        0x2::event::emit<OrderFulfilled>(v0);
    }

    public(friend) fun emit_swap_order_received(arg0: u32, arg1: u64, arg2: address, arg3: u64, arg4: address, arg5: u64) {
        let v0 = SwapOrderReceived{
            src_eid      : arg0,
            cctp_nonce   : arg1,
            output_token : arg2,
            min_output   : arg3,
            recipient    : arg4,
            quote_id     : arg5,
        };
        0x2::event::emit<SwapOrderReceived>(v0);
    }

    // decompiled from Move bytecode v6
}

