module 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::cetus {
    struct CetusAdapter has drop {
        dummy_field: bool,
    }

    public fun a_to_b<T0, T1, T2, T3>(arg0: &0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::AgentPass, arg1: &0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry::Registry, arg2: 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::Swap<T0, T1, T2>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &0x2::clock::Clock) : 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::Swap<T0, T1, T3> {
        let v0 = CetusAdapter{dummy_field: false};
        let (v1, v2, v3) = 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::lend<CetusAdapter, T0, T1, T2>(arg0, arg1, arg2, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4), v0);
        let v4 = v2;
        let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg3, arg4, true, true, 0x2::balance::value<T2>(&v4), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price() + 1, arg5);
        let v8 = v7;
        0x2::balance::destroy_zero<T2>(v5);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg3, arg4, 0x2::balance::split<T2>(&mut v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v8)), 0x2::balance::zero<T3>(), v8);
        let v9 = CetusAdapter{dummy_field: false};
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::repay<CetusAdapter, T0, T1, T2, T3>(arg0, v1, v3, v4, v6, v9)
    }

    public fun b_to_a<T0, T1, T2, T3>(arg0: &0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::AgentPass, arg1: &0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry::Registry, arg2: 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::Swap<T0, T1, T3>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &0x2::clock::Clock) : 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::Swap<T0, T1, T2> {
        let v0 = CetusAdapter{dummy_field: false};
        let (v1, v2, v3) = 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::lend<CetusAdapter, T0, T1, T3>(arg0, arg1, arg2, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4), v0);
        let v4 = v2;
        let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg3, arg4, false, true, 0x2::balance::value<T3>(&v4), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price() - 1, arg5);
        let v8 = v7;
        0x2::balance::destroy_zero<T3>(v6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg3, arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v8)), v8);
        let v9 = CetusAdapter{dummy_field: false};
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::repay<CetusAdapter, T0, T1, T3, T2>(arg0, v1, v3, v4, v5, v9)
    }

    // decompiled from Move bytecode v7
}

