module 0x4151af44dc721a991bf6836753c0bc1b3b168326dad8361414f40ad74d4f5d88::flowx_clmm {
    struct FlowxClmmSwapEvent has copy, drop, store {
        pool: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    struct SwapStepEvent has copy, drop, store {
        sqrt_price_next: u128,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
    }

    struct AmountYDeltaEvent has copy, drop, store {
        result: u64,
    }

    struct NextSqrtPriceFromAmountXEvent has copy, drop, store {
        result: u128,
    }

    struct NextSqrtPriceFromAmountYEvent has copy, drop, store {
        result: u128,
    }

    struct NextSqrtPriceFromInputEvent has copy, drop, store {
        result: u128,
    }

    struct NextSqrtPriceFromOutputEvent has copy, drop, store {
        result: u128,
    }

    public entry fun get_amount_x_delta(arg0: u128, arg1: u128, arg2: u128, arg3: bool) {
        let v0 = AmountYDeltaEvent{result: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::sqrt_price_math::get_amount_x_delta(arg0, arg1, arg2, arg3)};
        0x2::event::emit<AmountYDeltaEvent>(v0);
    }

    public entry fun get_amount_y_delta(arg0: u128, arg1: u128, arg2: u128, arg3: bool) {
        let v0 = AmountYDeltaEvent{result: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::sqrt_price_math::get_amount_y_delta(arg0, arg1, arg2, arg3)};
        0x2::event::emit<AmountYDeltaEvent>(v0);
    }

    public entry fun get_next_sqrt_price_from_amount_x_rouding_up(arg0: u128, arg1: u128, arg2: u64, arg3: bool) {
        let v0 = NextSqrtPriceFromAmountXEvent{result: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::sqrt_price_math::get_next_sqrt_price_from_amount_x_rouding_up(arg0, arg1, arg2, arg3)};
        0x2::event::emit<NextSqrtPriceFromAmountXEvent>(v0);
    }

    public entry fun get_next_sqrt_price_from_amount_y_rouding_down(arg0: u128, arg1: u128, arg2: u64, arg3: bool) {
        let v0 = NextSqrtPriceFromAmountYEvent{result: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::sqrt_price_math::get_next_sqrt_price_from_amount_y_rouding_down(arg0, arg1, arg2, arg3)};
        0x2::event::emit<NextSqrtPriceFromAmountYEvent>(v0);
    }

    public entry fun get_next_sqrt_price_from_input(arg0: u128, arg1: u128, arg2: u64, arg3: bool) {
        let v0 = NextSqrtPriceFromInputEvent{result: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::sqrt_price_math::get_next_sqrt_price_from_input(arg0, arg1, arg2, arg3)};
        0x2::event::emit<NextSqrtPriceFromInputEvent>(v0);
    }

    public entry fun get_next_sqrt_price_from_output(arg0: u128, arg1: u128, arg2: u64, arg3: bool) {
        let v0 = NextSqrtPriceFromOutputEvent{result: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::sqrt_price_math::get_next_sqrt_price_from_output(arg0, arg1, arg2, arg3)};
        0x2::event::emit<NextSqrtPriceFromOutputEvent>(v0);
    }

    public entry fun compute_swap_step(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: u64, arg5: bool) {
        let (v0, v1, v2, v3) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_math::compute_swap_step(arg0, arg1, arg2, arg3, arg4, arg5);
        let v4 = SwapStepEvent{
            sqrt_price_next : v0,
            amount_in       : v1,
            amount_out      : v2,
            fee_amount      : v3,
        };
        0x2::event::emit<SwapStepEvent>(v4);
    }

    public entry fun swap_a2b<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg0, arg1);
        let v1 = 0x2::coin::value<T0>(&arg2);
        let (v2, v3, v4) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(v0, true, true, v1, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_sqrt_price() + 1, arg3, arg4, arg5);
        let v5 = v3;
        let v6 = FlowxClmmSwapEvent{
            pool         : 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>>(v0),
            amount_in    : v1,
            amount_out   : 0x2::balance::value<T1>(&v5),
            a2b          : true,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<FlowxClmmSwapEvent>(v6);
        0x2::balance::destroy_zero<T0>(v2);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(v0, v4, 0x2::coin::into_balance<T0>(arg2), 0x2::balance::zero<T1>(), arg3, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg5), 0x2::tx_context::sender(arg5));
    }

    public entry fun swap_b2a<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg0, arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let (v2, v3, v4) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(v0, false, true, v1, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_sqrt_price() - 1, arg3, arg4, arg5);
        let v5 = v2;
        let v6 = FlowxClmmSwapEvent{
            pool         : 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>>(v0),
            amount_in    : v1,
            amount_out   : 0x2::balance::value<T0>(&v5),
            a2b          : false,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<FlowxClmmSwapEvent>(v6);
        0x2::balance::destroy_zero<T1>(v3);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(v0, v4, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg2), arg3, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg5), 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

