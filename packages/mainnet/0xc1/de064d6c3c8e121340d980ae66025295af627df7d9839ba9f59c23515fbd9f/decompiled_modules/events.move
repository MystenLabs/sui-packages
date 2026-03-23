module 0xc1de064d6c3c8e121340d980ae66025295af627df7d9839ba9f59c23515fbd9f::events {
    struct SwapOrderCreated has copy, drop {
        cctp_nonce: u64,
        sender: address,
        usdc_burn_amount: u64,
        output_token: address,
        min_output: u64,
        recipient: address,
        created_at: u64,
        dst_eid: u32,
        mode: u8,
        quote_id: u64,
        solver_fee_usdc: u64,
        solver_address: address,
        affiliate_fee_usdc: u64,
        affiliate_address: address,
        input_token: address,
        input_amount: u64,
    }

    struct DestinationUpdated has copy, drop {
        dst_eid: u32,
        cctp_domain: u32,
        mint_recipient: address,
        active: bool,
    }

    struct EmergencyCctpRecover has copy, drop {
        new_mint_recipient: address,
    }

    struct Paused has copy, drop {
        paused: bool,
    }

    public(friend) fun emit_destination_updated(arg0: u32, arg1: u32, arg2: address, arg3: bool) {
        let v0 = DestinationUpdated{
            dst_eid        : arg0,
            cctp_domain    : arg1,
            mint_recipient : arg2,
            active         : arg3,
        };
        0x2::event::emit<DestinationUpdated>(v0);
    }

    public(friend) fun emit_emergency_cctp_recover(arg0: address) {
        let v0 = EmergencyCctpRecover{new_mint_recipient: arg0};
        0x2::event::emit<EmergencyCctpRecover>(v0);
    }

    public(friend) fun emit_paused(arg0: bool) {
        let v0 = Paused{paused: arg0};
        0x2::event::emit<Paused>(v0);
    }

    public(friend) fun emit_swap_order_created(arg0: u64, arg1: address, arg2: u64, arg3: address, arg4: u64, arg5: address, arg6: u64, arg7: u32, arg8: u8, arg9: u64, arg10: u64, arg11: address, arg12: u64, arg13: address, arg14: address, arg15: u64) {
        let v0 = SwapOrderCreated{
            cctp_nonce         : arg0,
            sender             : arg1,
            usdc_burn_amount   : arg2,
            output_token       : arg3,
            min_output         : arg4,
            recipient          : arg5,
            created_at         : arg6,
            dst_eid            : arg7,
            mode               : arg8,
            quote_id           : arg9,
            solver_fee_usdc    : arg10,
            solver_address     : arg11,
            affiliate_fee_usdc : arg12,
            affiliate_address  : arg13,
            input_token        : arg14,
            input_amount       : arg15,
        };
        0x2::event::emit<SwapOrderCreated>(v0);
    }

    // decompiled from Move bytecode v6
}

