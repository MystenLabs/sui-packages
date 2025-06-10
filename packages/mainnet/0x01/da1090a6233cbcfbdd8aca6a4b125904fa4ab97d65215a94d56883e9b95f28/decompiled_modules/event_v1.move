module 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::event_v1 {
    struct CreatePoolEvent has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct AddLiquidityEvent has copy, drop {
        pool_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
        lp_amount: u64,
    }

    struct RemoveLiquidityEvent has copy, drop {
        pool_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
        lp_amount: u64,
    }

    struct SwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        math: 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::math_v1::PoolMath,
        x_to_y: bool,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
    }

    public(friend) fun emit_add_liquidity_event(arg0: &0x2::object::UID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = AddLiquidityEvent{
            pool_id   : *0x2::object::uid_as_inner(arg0),
            amount_x  : arg1,
            amount_y  : arg2,
            lp_amount : arg3,
        };
        0x2::event::emit<AddLiquidityEvent>(v0);
    }

    public(friend) fun emit_create_pool_event(arg0: 0x2::object::ID) {
        let v0 = CreatePoolEvent{pool_id: arg0};
        0x2::event::emit<CreatePoolEvent>(v0);
    }

    public(friend) fun emit_remove_liquidity_event(arg0: &0x2::object::UID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = RemoveLiquidityEvent{
            pool_id   : *0x2::object::uid_as_inner(arg0),
            amount_x  : arg1,
            amount_y  : arg2,
            lp_amount : arg3,
        };
        0x2::event::emit<RemoveLiquidityEvent>(v0);
    }

    public(friend) fun emit_swap_event(arg0: &0x2::object::UID, arg1: 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::math_v1::PoolMath, arg2: bool, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = SwapEvent{
            pool_id    : *0x2::object::uid_as_inner(arg0),
            math       : arg1,
            x_to_y     : arg2,
            amount_in  : arg3,
            amount_out : arg4,
            fee_amount : arg5,
        };
        0x2::event::emit<SwapEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

