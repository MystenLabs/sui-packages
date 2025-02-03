module 0xd1faa211b60e445f13e738395eac809fa9702c9515dcca443ea2899ce751fc72::kriya_clmm {
    struct KriyaClmmSwapEvent has copy, drop, store {
        pool: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0xd1faa211b60e445f13e738395eac809fa9702c9515dcca443ea2899ce751fc72::setting::Config, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let (v1, v2, v3) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg1, true, true, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg4, arg3, arg5);
        let v4 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg1, v3, 0x2::coin::into_balance<T0>(arg2), 0x2::balance::zero<T1>(), arg3, arg5);
        let (v5, v6) = 0xd1faa211b60e445f13e738395eac809fa9702c9515dcca443ea2899ce751fc72::setting::pay_fee<T1>(arg0, 0x2::coin::from_balance<T1>(v4, arg5), arg5);
        let v7 = KriyaClmmSwapEvent{
            pool         : 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>>(arg1),
            amount_in    : v0,
            amount_out   : 0x2::balance::value<T1>(&v4) - v6,
            a2b          : true,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<KriyaClmmSwapEvent>(v7);
        v5
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0xd1faa211b60e445f13e738395eac809fa9702c9515dcca443ea2899ce751fc72::setting::Config, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg2);
        let (v1, v2, v3) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg1, false, true, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg4, arg3, arg5);
        let v4 = v1;
        0x2::balance::destroy_zero<T1>(v2);
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg1, v3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg2), arg3, arg5);
        let (v5, v6) = 0xd1faa211b60e445f13e738395eac809fa9702c9515dcca443ea2899ce751fc72::setting::pay_fee<T0>(arg0, 0x2::coin::from_balance<T0>(v4, arg5), arg5);
        let v7 = KriyaClmmSwapEvent{
            pool         : 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>>(arg1),
            amount_in    : v0,
            amount_out   : 0x2::balance::value<T0>(&v4) - v6,
            a2b          : false,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<KriyaClmmSwapEvent>(v7);
        v5
    }

    // decompiled from Move bytecode v6
}

