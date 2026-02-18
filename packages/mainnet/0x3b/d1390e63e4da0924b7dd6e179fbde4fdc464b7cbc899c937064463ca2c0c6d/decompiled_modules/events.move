module 0x3bd1390e63e4da0924b7dd6e179fbde4fdc464b7cbc899c937064463ca2c0c6d::events {
    struct SwapOrderReceived has copy, drop {
        cctp_nonce: u64,
        output_token: address,
        min_output: u64,
        recipient: address,
    }

    struct OrderFulfilled has copy, drop {
        cctp_nonce: u64,
        usdc_amount: u64,
        output_amount: u64,
        output_token_hash: address,
        recipient: address,
        fulfilled_by: address,
    }

    struct FallbackWithdrawn has copy, drop {
        cctp_nonce: u64,
        usdc_amount: u64,
        recipient: address,
    }

    public(friend) fun emit_fallback_withdrawn(arg0: u64, arg1: u64, arg2: address) {
        let v0 = FallbackWithdrawn{
            cctp_nonce  : arg0,
            usdc_amount : arg1,
            recipient   : arg2,
        };
        0x2::event::emit<FallbackWithdrawn>(v0);
    }

    public(friend) fun emit_order_fulfilled(arg0: u64, arg1: u64, arg2: u64, arg3: address, arg4: address, arg5: address) {
        let v0 = OrderFulfilled{
            cctp_nonce        : arg0,
            usdc_amount       : arg1,
            output_amount     : arg2,
            output_token_hash : arg3,
            recipient         : arg4,
            fulfilled_by      : arg5,
        };
        0x2::event::emit<OrderFulfilled>(v0);
    }

    public(friend) fun emit_swap_order_received(arg0: u64, arg1: address, arg2: u64, arg3: address) {
        let v0 = SwapOrderReceived{
            cctp_nonce   : arg0,
            output_token : arg1,
            min_output   : arg2,
            recipient    : arg3,
        };
        0x2::event::emit<SwapOrderReceived>(v0);
    }

    // decompiled from Move bytecode v6
}

