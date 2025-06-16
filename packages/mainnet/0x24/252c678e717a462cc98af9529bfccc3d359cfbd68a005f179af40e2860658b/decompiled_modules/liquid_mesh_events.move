module 0x24252c678e717a462cc98af9529bfccc3d359cfbd68a005f179af40e2860658b::liquid_mesh_events {
    struct Commission has copy, drop {
        rate: u16,
        direction: bool,
        amount: u64,
        recipient: address,
        token_type: 0x1::ascii::String,
    }

    struct HopLog has copy, drop {
        dex: 0x1::string::String,
        token_in: 0x1::ascii::String,
        token_out: 0x1::ascii::String,
        amount_in: u64,
        amount_out: u64,
    }

    struct SwapLog has copy, drop {
        order_id: u64,
        user: address,
        amount_in: u64,
        expect_amount_out: u64,
        min_return: u64,
        amount_out: u64,
        token_in: 0x1::ascii::String,
        token_out: 0x1::ascii::String,
    }

    public fun emit_commission(arg0: u16, arg1: bool, arg2: u64, arg3: address, arg4: 0x1::ascii::String) {
        let v0 = Commission{
            rate       : arg0,
            direction  : arg1,
            amount     : arg2,
            recipient  : arg3,
            token_type : arg4,
        };
        0x2::event::emit<Commission>(v0);
    }

    public fun emit_hop_log(arg0: 0x1::string::String, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: u64, arg4: u64) {
        let v0 = HopLog{
            dex        : arg0,
            token_in   : arg1,
            token_out  : arg2,
            amount_in  : arg3,
            amount_out : arg4,
        };
        0x2::event::emit<HopLog>(v0);
    }

    public fun emit_swap_log(arg0: u64, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String) {
        let v0 = SwapLog{
            order_id          : arg0,
            user              : arg1,
            amount_in         : arg2,
            expect_amount_out : arg3,
            min_return        : arg4,
            amount_out        : arg5,
            token_in          : arg6,
            token_out         : arg7,
        };
        0x2::event::emit<SwapLog>(v0);
    }

    // decompiled from Move bytecode v6
}

