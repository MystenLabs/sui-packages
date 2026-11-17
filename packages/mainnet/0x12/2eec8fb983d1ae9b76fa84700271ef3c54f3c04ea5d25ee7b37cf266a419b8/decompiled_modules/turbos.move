module 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::turbos {
    struct TurbosAdapter has drop {
        dummy_field: bool,
    }

    public fun a_to_b<T0, T1, T2, T3, T4>(arg0: &0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::AgentPass, arg1: &0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry::Registry, arg2: 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::Swap<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::Swap<T0, T1, T3> {
        let v0 = TurbosAdapter{dummy_field: false};
        let (v1, v2, v3) = 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::lend<TurbosAdapter, T0, T1, T2>(arg0, arg1, arg2, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>>(arg3), v0);
        let v4 = v2;
        let v5 = 0x1::vector::empty<0x2::coin::Coin<T2>>();
        0x1::vector::push_back<0x2::coin::Coin<T2>>(&mut v5, 0x2::coin::from_balance<T2>(v4, arg6));
        let (v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T2, T3, T4>(arg3, v5, 0x2::balance::value<T2>(&v4), 0, 4295048016 + 1, true, 0x2::object::id_address<0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::AgentPass>(arg0), 0x2::clock::timestamp_ms(arg5), arg5, arg4, arg6);
        let v8 = TurbosAdapter{dummy_field: false};
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::repay<TurbosAdapter, T0, T1, T2, T3>(arg0, v1, v3, 0x2::coin::into_balance<T2>(v7), 0x2::coin::into_balance<T3>(v6), v8)
    }

    public fun b_to_a<T0, T1, T2, T3, T4>(arg0: &0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::AgentPass, arg1: &0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry::Registry, arg2: 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::Swap<T0, T1, T3>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::Swap<T0, T1, T2> {
        let v0 = TurbosAdapter{dummy_field: false};
        let (v1, v2, v3) = 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::lend<TurbosAdapter, T0, T1, T3>(arg0, arg1, arg2, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>>(arg3), v0);
        let v4 = v2;
        let v5 = 0x1::vector::empty<0x2::coin::Coin<T3>>();
        0x1::vector::push_back<0x2::coin::Coin<T3>>(&mut v5, 0x2::coin::from_balance<T3>(v4, arg6));
        let (v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T2, T3, T4>(arg3, v5, 0x2::balance::value<T3>(&v4), 0, 79226673515401279992447579055 - 1, true, 0x2::object::id_address<0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::AgentPass>(arg0), 0x2::clock::timestamp_ms(arg5), arg5, arg4, arg6);
        let v8 = TurbosAdapter{dummy_field: false};
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::repay<TurbosAdapter, T0, T1, T3, T2>(arg0, v1, v3, 0x2::coin::into_balance<T3>(v7), 0x2::coin::into_balance<T2>(v6), v8)
    }

    // decompiled from Move bytecode v7
}

