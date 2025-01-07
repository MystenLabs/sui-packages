module 0x5ee52833a4ef05e8eabe54d2029303330672dad4b8755ec2805196ffd19efd59::flowx_clmm {
    struct FlowxClmmSwapEvent has copy, drop, store {
        pool: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x5ee52833a4ef05e8eabe54d2029303330672dad4b8755ec2805196ffd19efd59::config::Config, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg1, arg2);
        let v1 = 0x2::coin::value<T0>(&arg3);
        let (v2, v3, v4) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(v0, true, true, v1, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_sqrt_price() + 1, arg4, arg5, arg6);
        let v5 = v3;
        0x2::balance::destroy_zero<T0>(v2);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(v0, v4, 0x2::coin::into_balance<T0>(arg3), 0x2::balance::zero<T1>(), arg4, arg6);
        let (v6, v7) = 0x5ee52833a4ef05e8eabe54d2029303330672dad4b8755ec2805196ffd19efd59::config::pay_fee<T1>(arg0, 0x2::coin::from_balance<T1>(v5, arg6), arg6);
        let v8 = FlowxClmmSwapEvent{
            pool         : 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>>(v0),
            amount_in    : v1,
            amount_out   : 0x2::balance::value<T1>(&v5) - v7,
            a2b          : true,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<FlowxClmmSwapEvent>(v8);
        v6
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x5ee52833a4ef05e8eabe54d2029303330672dad4b8755ec2805196ffd19efd59::config::Config, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg1, arg2);
        let v1 = 0x2::coin::value<T1>(&arg3);
        let (v2, v3, v4) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(v0, false, true, v1, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_sqrt_price() - 1, arg4, arg5, arg6);
        let v5 = v2;
        0x2::balance::destroy_zero<T1>(v3);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(v0, v4, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg3), arg4, arg6);
        let (v6, v7) = 0x5ee52833a4ef05e8eabe54d2029303330672dad4b8755ec2805196ffd19efd59::config::pay_fee<T0>(arg0, 0x2::coin::from_balance<T0>(v5, arg6), arg6);
        let v8 = FlowxClmmSwapEvent{
            pool         : 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>>(v0),
            amount_in    : v1,
            amount_out   : 0x2::balance::value<T0>(&v5) - v7,
            a2b          : false,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<FlowxClmmSwapEvent>(v8);
        v6
    }

    // decompiled from Move bytecode v6
}

