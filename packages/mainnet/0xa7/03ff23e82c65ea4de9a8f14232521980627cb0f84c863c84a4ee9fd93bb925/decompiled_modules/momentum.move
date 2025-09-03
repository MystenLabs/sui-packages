module 0xa703ff23e82c65ea4de9a8f14232521980627cb0f84c863c84a4ee9fd93bb925::momentum {
    public fun swap<T0, T1>(arg0: &mut 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::SwapContext, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg2) {
            swap_a2b<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::SwapContext, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: u64, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::take_balance<T0>(arg0, arg2);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v2, v3, v4) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, true, true, v1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price(), arg4, arg3, arg5);
        let v5 = v3;
        let v6 = v2;
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v4, v0, 0x2::balance::zero<T1>(), arg3, arg5);
        let v7 = 0x2::balance::value<T0>(&v6);
        if (arg2 == 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::max_amount_in()) {
            0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::transfer_balance<T0>(v6, 0x2::tx_context::sender(arg5), arg5);
        } else {
            0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::merge_balance<T0>(arg0, v6);
        };
        0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::merge_balance<T1>(arg0, v5);
        0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::emit_swap_event<T0, T1>(arg0, b"MOMENTUM", 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1), v1 - v7, 0x2::balance::value<T1>(&v5), v7);
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::SwapContext, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: u64, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::take_balance<T1>(arg0, arg2);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v2, v3, v4) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, false, true, v1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price(), arg4, arg3, arg5);
        let v5 = v3;
        let v6 = v2;
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v4, 0x2::balance::zero<T0>(), v0, arg3, arg5);
        let v7 = 0x2::balance::value<T1>(&v5);
        if (arg2 == 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::max_amount_in()) {
            0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::transfer_balance<T1>(v5, 0x2::tx_context::sender(arg5), arg5);
        } else {
            0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::merge_balance<T1>(arg0, v5);
        };
        0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::merge_balance<T0>(arg0, v6);
        0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::emit_swap_event<T1, T0>(arg0, b"MOMENTUM", 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1), v1 - v7, 0x2::balance::value<T0>(&v6), v7);
    }

    // decompiled from Move bytecode v6
}

