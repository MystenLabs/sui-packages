module 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::flow_x_clmm_protocol {
    public(friend) fun swap<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::dex_utils::check_amounts<T0, T1>(&arg1, &arg2);
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0x2::balance::zero<T1>();
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::balance::join<T1>(&mut v1, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_x_to_y<T0, T1>(arg0, arg1, 4295048016, arg3, arg4, arg5));
            0x2::coin::destroy_zero<T1>(arg2);
        } else {
            0x2::balance::join<T0>(&mut v0, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_y_to_x<T0, T1>(arg0, arg2, 79226673515401279992447579055, arg3, arg4, arg5));
            0x2::coin::destroy_zero<T0>(arg1);
        };
        (0x2::coin::from_balance<T0>(v0, arg5), 0x2::coin::from_balance<T1>(v1, arg5))
    }

    public(friend) fun get_required_coin_amount<T0>(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, 0x2::sui::SUI>, arg1: u64) : u64 {
        let (_, v1, _, _) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_math::compute_swap_step(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, 0x2::sui::SUI>(arg0), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, 0x2::sui::SUI>(arg0), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::liquidity<T0, 0x2::sui::SUI>(arg0), arg1, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_fee_rate<T0, 0x2::sui::SUI>(arg0), false);
        v1
    }

    // decompiled from Move bytecode v6
}

