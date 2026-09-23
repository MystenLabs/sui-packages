module 0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::events {
    struct SwapQuote has copy, drop {
        source: u8,
        pool_id: 0x2::object::ID,
        x2y: bool,
        by_amount_in: bool,
        amount: u64,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        is_exceed: bool,
    }

    public fun emit_swap_quote(arg0: u8, arg1: 0x2::object::ID, arg2: bool, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool) {
        let v0 = SwapQuote{
            source       : arg0,
            pool_id      : arg1,
            x2y          : arg2,
            by_amount_in : arg3,
            amount       : arg4,
            amount_in    : arg5,
            amount_out   : arg6,
            fee_amount   : arg7,
            is_exceed    : arg8,
        };
        0x2::event::emit<SwapQuote>(v0);
    }

    public fun source_bluefin() : u8 {
        1
    }

    public fun source_cetus() : u8 {
        0
    }

    public fun source_flowx() : u8 {
        4
    }

    public fun source_magma() : u8 {
        5
    }

    public fun source_momentum() : u8 {
        3
    }

    public fun source_turbos() : u8 {
        2
    }

    // decompiled from Move bytecode v7
}

