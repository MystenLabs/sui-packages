module 0xb031cb2ec4c1c8046cce25c06da44613c47f8798c4c83b8f65e38e744d25b37f::turbos {
    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg1);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg0, v0, 0x2::coin::value<T0>(&arg1), 0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), true, 0x2::tx_context::sender(arg4), 0x2::clock::timestamp_ms(arg2) + 18000, arg2, arg3, arg4);
        let v3 = v1;
        0x2::coin::value<T1>(&v3);
        0xb031cb2ec4c1c8046cce25c06da44613c47f8798c4c83b8f65e38e744d25b37f::utils::transfer_or_destroy_coin<T0>(v2, arg4);
        v3
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, arg1);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg0, v0, 0x2::coin::value<T1>(&arg1), 0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), true, 0x2::tx_context::sender(arg4), 0x2::clock::timestamp_ms(arg2) + 18000, arg2, arg3, arg4);
        let v3 = v1;
        0x2::coin::value<T0>(&v3);
        0xb031cb2ec4c1c8046cce25c06da44613c47f8798c4c83b8f65e38e744d25b37f::utils::transfer_or_destroy_coin<T1>(v2, arg4);
        v3
    }

    // decompiled from Move bytecode v6
}

