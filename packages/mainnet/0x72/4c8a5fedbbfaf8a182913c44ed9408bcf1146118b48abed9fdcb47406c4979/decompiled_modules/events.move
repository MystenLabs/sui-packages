module 0x724c8a5fedbbfaf8a182913c44ed9408bcf1146118b48abed9fdcb47406c4979::events {
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
        protocol_fee: u64,
        solver_fee: u64,
        affiliate_fee: u64,
    }

    struct FallbackWithdrawn has copy, drop {
        src_eid: u32,
        cctp_nonce: u64,
        usdc_amount: u64,
        recipient: address,
        quote_id: u64,
    }

    struct FeesAccrued has copy, drop {
        protocol_fee_recipient: address,
        protocol_fee: u64,
        solver_fee_recipient: address,
        solver_fee: u64,
        affiliate_fee_recipient: address,
        affiliate_fee: u64,
    }

    struct OrderFulfilledDirect has copy, drop {
        usdc_amount: u64,
        recipient: address,
        protocol_fee: u64,
        solver_fee: u64,
        affiliate_fee: u64,
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

    public(friend) fun emit_fees_accrued(arg0: address, arg1: u64, arg2: address, arg3: u64, arg4: address, arg5: u64) {
        let v0 = FeesAccrued{
            protocol_fee_recipient  : arg0,
            protocol_fee            : arg1,
            solver_fee_recipient    : arg2,
            solver_fee              : arg3,
            affiliate_fee_recipient : arg4,
            affiliate_fee           : arg5,
        };
        0x2::event::emit<FeesAccrued>(v0);
    }

    public(friend) fun emit_order_fulfilled(arg0: u32, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: address, arg6: address, arg7: u64, arg8: u64, arg9: u64, arg10: u64) {
        let v0 = OrderFulfilled{
            src_eid           : arg0,
            cctp_nonce        : arg1,
            usdc_amount       : arg2,
            output_amount     : arg3,
            output_token_hash : arg4,
            recipient         : arg5,
            fulfilled_by      : arg6,
            quote_id          : arg7,
            protocol_fee      : arg8,
            solver_fee        : arg9,
            affiliate_fee     : arg10,
        };
        0x2::event::emit<OrderFulfilled>(v0);
    }

    public(friend) fun emit_order_fulfilled_direct(arg0: u64, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = OrderFulfilledDirect{
            usdc_amount   : arg0,
            recipient     : arg1,
            protocol_fee  : arg2,
            solver_fee    : arg3,
            affiliate_fee : arg4,
        };
        0x2::event::emit<OrderFulfilledDirect>(v0);
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

