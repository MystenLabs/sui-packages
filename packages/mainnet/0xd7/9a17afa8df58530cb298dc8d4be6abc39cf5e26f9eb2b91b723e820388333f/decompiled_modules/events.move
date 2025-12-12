module 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::events {
    struct PoolCreated<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        coin_a_amount: u64,
        coin_b_amount: u64,
        creator: address,
        fee_bps: u64,
        timestamp: u64,
    }

    struct SwapExecuted<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        timestamp: u64,
    }

    struct LiquidityAdded<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        provider: address,
        coin_a_amount: u64,
        coin_b_amount: u64,
        lp_tokens_minted: u64,
        timestamp: u64,
    }

    struct LiquidityRemoved<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        provider: address,
        coin_a_amount: u64,
        coin_b_amount: u64,
        lp_tokens_burned: u64,
        timestamp: u64,
    }

    struct PoolPaused has copy, drop {
        pool_id: 0x2::object::ID,
        admin: address,
        timestamp: u64,
    }

    struct PoolUnPaused has copy, drop {
        pool_id: 0x2::object::ID,
        admin: address,
        timestamp: u64,
    }

    public fun emit_liquidity_added<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = LiquidityAdded<T0, T1>{
            pool_id          : arg0,
            provider         : arg1,
            coin_a_amount    : arg2,
            coin_b_amount    : arg3,
            lp_tokens_minted : arg4,
            timestamp        : arg5,
        };
        0x2::event::emit<LiquidityAdded<T0, T1>>(v0);
    }

    public fun emit_liquidity_removed<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = LiquidityRemoved<T0, T1>{
            pool_id          : arg0,
            provider         : arg1,
            coin_a_amount    : arg2,
            coin_b_amount    : arg3,
            lp_tokens_burned : arg4,
            timestamp        : arg5,
        };
        0x2::event::emit<LiquidityRemoved<T0, T1>>(v0);
    }

    public fun emit_pool_created<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: address, arg4: u64, arg5: u64) {
        let v0 = PoolCreated<T0, T1>{
            pool_id       : arg0,
            coin_a_amount : arg1,
            coin_b_amount : arg2,
            creator       : arg3,
            fee_bps       : arg4,
            timestamp     : arg5,
        };
        0x2::event::emit<PoolCreated<T0, T1>>(v0);
    }

    public fun emit_pool_paused(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = PoolPaused{
            pool_id   : arg0,
            admin     : arg1,
            timestamp : arg2,
        };
        0x2::event::emit<PoolPaused>(v0);
    }

    public fun emit_pool_unpaused(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = PoolUnPaused{
            pool_id   : arg0,
            admin     : arg1,
            timestamp : arg2,
        };
        0x2::event::emit<PoolUnPaused>(v0);
    }

    public fun emit_swap_executed<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = SwapExecuted<T0, T1>{
            pool_id    : arg0,
            sender     : arg1,
            amount_in  : arg2,
            amount_out : arg3,
            fee_amount : arg4,
            timestamp  : arg5,
        };
        0x2::event::emit<SwapExecuted<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v6
}

