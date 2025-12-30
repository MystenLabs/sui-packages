module 0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::events {
    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct LiquidityAdded has copy, drop {
        pool_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
    }

    struct LiquidityRemoved has copy, drop {
        pool_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
    }

    struct Swapped has copy, drop {
        pool_id: 0x2::object::ID,
        math: 0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::math::PoolMath,
        x_to_y: bool,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
    }

    public(friend) fun emit_liquidity_added(arg0: &0x2::object::UID, arg1: u64, arg2: u64) {
        let v0 = LiquidityAdded{
            pool_id  : *0x2::object::uid_as_inner(arg0),
            amount_x : arg1,
            amount_y : arg2,
        };
        0x2::event::emit<LiquidityAdded>(v0);
    }

    public(friend) fun emit_liquidity_removed(arg0: &0x2::object::UID, arg1: u64, arg2: u64) {
        let v0 = LiquidityRemoved{
            pool_id  : *0x2::object::uid_as_inner(arg0),
            amount_x : arg1,
            amount_y : arg2,
        };
        0x2::event::emit<LiquidityRemoved>(v0);
    }

    public(friend) fun emit_pool_created(arg0: 0x2::object::ID) {
        let v0 = PoolCreated{pool_id: arg0};
        0x2::event::emit<PoolCreated>(v0);
    }

    public(friend) fun emit_swapped(arg0: &0x2::object::UID, arg1: 0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::math::PoolMath, arg2: bool, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = Swapped{
            pool_id    : *0x2::object::uid_as_inner(arg0),
            math       : arg1,
            x_to_y     : arg2,
            amount_in  : arg3,
            amount_out : arg4,
            fee_amount : arg5,
        };
        0x2::event::emit<Swapped>(v0);
    }

    // decompiled from Move bytecode v6
}

