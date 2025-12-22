module 0x7a34ea79d67d84f66efbe6e534e36d0f8033f8ae7ce43b01e88ed776ae77f39f::liquid_mesh_pos_slip_events {
    struct PositiveSlippageEvent has copy, drop, store {
        order_id: u64,
        user: address,
        recipient: address,
        expect_amount_out: u64,
        actual_amount_out: u64,
        fee: u64,
        rate: u16,
        limit: u16,
        coin_type: 0x1::ascii::String,
    }

    public fun emit_positive_slippage(arg0: u64, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u16, arg7: u16, arg8: 0x1::ascii::String) {
        let v0 = PositiveSlippageEvent{
            order_id          : arg0,
            user              : arg1,
            recipient         : arg2,
            expect_amount_out : arg3,
            actual_amount_out : arg4,
            fee               : arg5,
            rate              : arg6,
            limit             : arg7,
            coin_type         : arg8,
        };
        0x2::event::emit<PositiveSlippageEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

