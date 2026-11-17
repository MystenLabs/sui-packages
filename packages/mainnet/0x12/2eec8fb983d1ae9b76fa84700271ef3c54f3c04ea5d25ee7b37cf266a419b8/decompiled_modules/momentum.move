module 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::momentum {
    struct MomentumAdapter has drop {
        dummy_field: bool,
    }

    public fun x_to_y<T0, T1, T2, T3>(arg0: &0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::AgentPass, arg1: &0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry::Registry, arg2: 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::Swap<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::Swap<T0, T1, T3> {
        let v0 = MomentumAdapter{dummy_field: false};
        let (v1, v2, v3) = 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::lend<MomentumAdapter, T0, T1, T2>(arg0, arg1, arg2, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg3), v0);
        let v4 = v2;
        let (v5, v6, v7) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T2, T3>(arg3, true, true, 0x2::balance::value<T2>(&v4), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price() + 1, arg5, arg4, arg6);
        let v8 = v7;
        0x2::balance::destroy_zero<T2>(v5);
        let (v9, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v8);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T2, T3>(arg3, v8, 0x2::balance::split<T2>(&mut v4, v9), 0x2::balance::zero<T3>(), arg4, arg6);
        let v11 = MomentumAdapter{dummy_field: false};
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::repay<MomentumAdapter, T0, T1, T2, T3>(arg0, v1, v3, v4, v6, v11)
    }

    public fun y_to_x<T0, T1, T2, T3>(arg0: &0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::AgentPass, arg1: &0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry::Registry, arg2: 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::Swap<T0, T1, T3>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::Swap<T0, T1, T2> {
        let v0 = MomentumAdapter{dummy_field: false};
        let (v1, v2, v3) = 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::lend<MomentumAdapter, T0, T1, T3>(arg0, arg1, arg2, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg3), v0);
        let v4 = v2;
        let (v5, v6, v7) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T2, T3>(arg3, false, true, 0x2::balance::value<T3>(&v4), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price() - 1, arg5, arg4, arg6);
        let v8 = v7;
        0x2::balance::destroy_zero<T3>(v6);
        let (_, v10) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v8);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T2, T3>(arg3, v8, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v4, v10), arg4, arg6);
        let v11 = MomentumAdapter{dummy_field: false};
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::repay<MomentumAdapter, T0, T1, T3, T2>(arg0, v1, v3, v4, v5, v11)
    }

    // decompiled from Move bytecode v7
}

