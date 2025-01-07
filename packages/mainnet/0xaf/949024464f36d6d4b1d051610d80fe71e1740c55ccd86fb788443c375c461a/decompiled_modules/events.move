module 0xaf949024464f36d6d4b1d051610d80fe71e1740c55ccd86fb788443c375c461a::events {
    struct TransferWithTaxEvent has copy, drop {
        sender: address,
        recipient: address,
        amount: u64,
        tax_amount: u64,
        timestamp: u64,
    }

    struct LiquidityAddedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        provider: address,
        sqsq_amount: u64,
        sui_amount: u64,
        timestamp: u64,
    }

    struct LiquidityRemovedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        provider: address,
        sqsq_amount: u64,
        sui_amount: u64,
        timestamp: u64,
    }

    struct SwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        token_in_amount: u64,
        token_out_amount: u64,
        is_sui_to_sqsq: bool,
        price_impact: u64,
        timestamp: u64,
    }

    public fun emit_liquidity_event(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = LiquidityAddedEvent{
            pool_id     : arg0,
            provider    : arg1,
            sqsq_amount : arg2,
            sui_amount  : arg3,
            timestamp   : arg4,
        };
        0x2::event::emit<LiquidityAddedEvent>(v0);
    }

    public fun emit_remove_liquidity_event(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = LiquidityRemovedEvent{
            pool_id     : arg0,
            provider    : arg1,
            sqsq_amount : arg2,
            sui_amount  : arg3,
            timestamp   : arg4,
        };
        0x2::event::emit<LiquidityRemovedEvent>(v0);
    }

    public fun emit_swap_event(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: u64) {
        let v0 = SwapEvent{
            pool_id          : arg0,
            sender           : arg1,
            token_in_amount  : arg2,
            token_out_amount : arg3,
            is_sui_to_sqsq   : arg4,
            price_impact     : arg5,
            timestamp        : arg6,
        };
        0x2::event::emit<SwapEvent>(v0);
    }

    public fun emit_transfer_event(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = TransferWithTaxEvent{
            sender     : arg0,
            recipient  : arg1,
            amount     : arg2,
            tax_amount : arg3,
            timestamp  : arg4,
        };
        0x2::event::emit<TransferWithTaxEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

