module 0x8e4271ce4eab9f469f47e511004d19a309780a045aba09d418d7848c00ad10f8::events {
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
        usdc_mint_amount: u64,
        output_amount: u64,
        output_token: address,
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
        usdc_mint_amount: u64,
        recipient: address,
        quote_id: u64,
    }

    struct AcceptedSourceUpdated has copy, drop {
        src_eid: u32,
        accepted: bool,
    }

    struct ProtocolFeeSet has copy, drop {
        fee_bps: u16,
    }

    struct ProtocolFeeRecipientSet has copy, drop {
        recipient: address,
    }

    struct EmergencyWithdraw has copy, drop {
        token: address,
        amount: u64,
        recipient: address,
    }

    struct FeesAccrued has copy, drop {
        protocol_fee_recipient: address,
        protocol_fee: u64,
        solver_fee_recipient: address,
        solver_fee: u64,
        affiliate_fee_recipient: address,
        affiliate_fee: u64,
    }

    struct FeesWithdrawn has copy, drop {
        recipient: address,
        amount: u64,
    }

    public(friend) fun emit_accepted_source_updated(arg0: u32, arg1: bool) {
        let v0 = AcceptedSourceUpdated{
            src_eid  : arg0,
            accepted : arg1,
        };
        0x2::event::emit<AcceptedSourceUpdated>(v0);
    }

    public(friend) fun emit_emergency_withdraw(arg0: address, arg1: u64, arg2: address) {
        let v0 = EmergencyWithdraw{
            token     : arg0,
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<EmergencyWithdraw>(v0);
    }

    public(friend) fun emit_fallback_withdrawn(arg0: u32, arg1: u64, arg2: u64, arg3: address, arg4: u64) {
        let v0 = FallbackWithdrawn{
            src_eid          : arg0,
            cctp_nonce       : arg1,
            usdc_mint_amount : arg2,
            recipient        : arg3,
            quote_id         : arg4,
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

    public(friend) fun emit_fees_withdrawn(arg0: address, arg1: u64) {
        let v0 = FeesWithdrawn{
            recipient : arg0,
            amount    : arg1,
        };
        0x2::event::emit<FeesWithdrawn>(v0);
    }

    public(friend) fun emit_order_fulfilled(arg0: u32, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: address, arg6: address, arg7: u64, arg8: u64, arg9: u64, arg10: u64) {
        let v0 = OrderFulfilled{
            src_eid          : arg0,
            cctp_nonce       : arg1,
            usdc_mint_amount : arg2,
            output_amount    : arg3,
            output_token     : arg4,
            recipient        : arg5,
            fulfilled_by     : arg6,
            quote_id         : arg7,
            protocol_fee     : arg8,
            solver_fee       : arg9,
            affiliate_fee    : arg10,
        };
        0x2::event::emit<OrderFulfilled>(v0);
    }

    public(friend) fun emit_protocol_fee_recipient_set(arg0: address) {
        let v0 = ProtocolFeeRecipientSet{recipient: arg0};
        0x2::event::emit<ProtocolFeeRecipientSet>(v0);
    }

    public(friend) fun emit_protocol_fee_set(arg0: u16) {
        let v0 = ProtocolFeeSet{fee_bps: arg0};
        0x2::event::emit<ProtocolFeeSet>(v0);
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

