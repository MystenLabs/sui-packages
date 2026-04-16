module 0x6e211b3dd1ad55f988924125d815c30ee5b83566a183fd9128ff4e29f7799cae::clmm {
    public fun bluefin_swap_a_to_b<T0, T1, T2, T3>(arg0: &mut 0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::Session<T0, T1>, arg1: u64, arg2: u64, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: 0x2::coin::Coin<T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T2, T3>(arg6, arg3, arg4, 0x2::coin::into_balance<T2>(arg5), 0x2::balance::zero<T3>(), true, true, arg2, 0, 4295048017);
        let v2 = 0x2::coin::from_balance<T3>(v1, arg7);
        let v3 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg4);
        refund_and_record<T0, T1, T2, T3>(arg0, arg1, 5, 0x2::object::id_to_address(&v3), arg2, 0x2::coin::from_balance<T2>(v0, arg7), &v2);
        v2
    }

    public fun bluefin_swap_b_to_a<T0, T1, T2, T3>(arg0: &mut 0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::Session<T0, T1>, arg1: u64, arg2: u64, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: 0x2::coin::Coin<T3>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T2, T3>(arg6, arg3, arg4, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<T3>(arg5), false, true, arg2, 0, 79226673515401279992447579050);
        let v2 = 0x2::coin::from_balance<T2>(v0, arg7);
        let v3 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg4);
        refund_and_record<T0, T1, T3, T2>(arg0, arg1, 5, 0x2::object::id_to_address(&v3), arg2, 0x2::coin::from_balance<T3>(v1, arg7), &v2);
        v2
    }

    public fun ferra_clmm_flash_swap_a_to_b<T0, T1, T2, T3>(arg0: &mut 0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::Session<T0, T1>, arg1: u64, arg2: u64, arg3: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::config::GlobalConfig, arg4: &mut 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T2, T3>, arg5: 0x2::coin::Coin<T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        let (v0, v1, v2) = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::flash_swap<T2, T3>(arg3, arg4, true, true, arg2, 4295048017, arg6);
        let v3 = v0;
        0x2::balance::join<T2>(&mut v3, 0x2::coin::into_balance<T2>(arg5));
        0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::repay_flash_swap<T2, T3>(arg3, arg4, v3, 0x2::balance::zero<T3>(), v2);
        let v4 = 0x2::coin::from_balance<T3>(v1, arg7);
        let v5 = 0x2::object::id<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T2, T3>>(arg4);
        record_output<T0, T1, T2, T3>(arg0, arg1, 9, 0x2::object::id_to_address(&v5), arg2, &v4);
        v4
    }

    public fun ferra_clmm_flash_swap_b_to_a<T0, T1, T2, T3>(arg0: &mut 0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::Session<T0, T1>, arg1: u64, arg2: u64, arg3: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::config::GlobalConfig, arg4: &mut 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T2, T3>, arg5: 0x2::coin::Coin<T3>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let (v0, v1, v2) = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::flash_swap<T2, T3>(arg3, arg4, false, true, arg2, 79226673515401279992447579050, arg6);
        let v3 = v1;
        0x2::balance::join<T3>(&mut v3, 0x2::coin::into_balance<T3>(arg5));
        0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::repay_flash_swap<T2, T3>(arg3, arg4, 0x2::balance::zero<T2>(), v3, v2);
        let v4 = 0x2::coin::from_balance<T2>(v0, arg7);
        let v5 = 0x2::object::id<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T2, T3>>(arg4);
        record_output<T0, T1, T3, T2>(arg0, arg1, 9, 0x2::object::id_to_address(&v5), arg2, &v4);
        v4
    }

    public fun flowx_v3_swap_exact_x_to_y<T0, T1, T2, T3>(arg0: &mut 0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::Session<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg4: u64, arg5: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg6: 0x2::coin::Coin<T2>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T2, T3>(arg3, arg4);
        let v1 = 0x2::coin::from_balance<T3>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_x_to_y<T2, T3>(v0, arg6, 0, arg5, arg7, arg8), arg8);
        let v2 = 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T2, T3>>(v0);
        record_output<T0, T1, T2, T3>(arg0, arg1, 1, 0x2::object::id_to_address(&v2), arg2, &v1);
        v1
    }

    public fun flowx_v3_swap_exact_y_to_x<T0, T1, T2, T3>(arg0: &mut 0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::Session<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg4: u64, arg5: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg6: 0x2::coin::Coin<T3>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T2, T3>(arg3, arg4);
        let v1 = 0x2::coin::from_balance<T2>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_y_to_x<T2, T3>(v0, arg6, 0, arg5, arg7, arg8), arg8);
        let v2 = 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T2, T3>>(v0);
        record_output<T0, T1, T3, T2>(arg0, arg1, 1, 0x2::object::id_to_address(&v2), arg2, &v1);
        v1
    }

    public fun kriya_flash_swap_a_to_b<T0, T1, T2, T3>(arg0: &mut 0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::Session<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T2, T3>, arg4: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg5: 0x2::coin::Coin<T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        let (v0, v1, v2) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T2, T3>(arg3, true, true, arg2, 4295048017, arg6, arg4, arg7);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, _) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::swap_receipt_debts(&v3);
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T2, T3>(arg3, v3, 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut arg5, v4, arg7)), 0x2::balance::zero<T3>(), arg4, arg7);
        let v6 = 0x2::coin::from_balance<T3>(v1, arg7);
        let v7 = 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T2, T3>>(arg3);
        refund_and_record<T0, T1, T2, T3>(arg0, arg1, 12, 0x2::object::id_to_address(&v7), arg2, arg5, &v6);
        v6
    }

    public fun kriya_flash_swap_b_to_a<T0, T1, T2, T3>(arg0: &mut 0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::Session<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T2, T3>, arg4: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg5: 0x2::coin::Coin<T3>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let (v0, v1, v2) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T2, T3>(arg3, false, true, arg2, 79226673515401279992447579050, arg6, arg4, arg7);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (_, v5) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::swap_receipt_debts(&v3);
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T2, T3>(arg3, v3, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<T3>(0x2::coin::split<T3>(&mut arg5, v5, arg7)), arg4, arg7);
        let v6 = 0x2::coin::from_balance<T2>(v0, arg7);
        let v7 = 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T2, T3>>(arg3);
        refund_and_record<T0, T1, T3, T2>(arg0, arg1, 12, 0x2::object::id_to_address(&v7), arg2, arg5, &v6);
        v6
    }

    public fun momentum_flash_swap_a_to_b<T0, T1, T2, T3>(arg0: &mut 0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::Session<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: 0x2::coin::Coin<T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T2, T3>(arg3, true, true, arg2, 4295048017, arg6, arg4, arg7);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T2, T3>(arg3, v3, 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut arg5, v4, arg7)), 0x2::balance::zero<T3>(), arg4, arg7);
        let v6 = 0x2::coin::from_balance<T3>(v1, arg7);
        let v7 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg3);
        refund_and_record<T0, T1, T2, T3>(arg0, arg1, 13, 0x2::object::id_to_address(&v7), arg2, arg5, &v6);
        v6
    }

    public fun momentum_flash_swap_b_to_a<T0, T1, T2, T3>(arg0: &mut 0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::Session<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: 0x2::coin::Coin<T3>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T2, T3>(arg3, false, true, arg2, 79226673515401279992447579050, arg6, arg4, arg7);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (_, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T2, T3>(arg3, v3, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<T3>(0x2::coin::split<T3>(&mut arg5, v5, arg7)), arg4, arg7);
        let v6 = 0x2::coin::from_balance<T2>(v0, arg7);
        let v7 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg3);
        refund_and_record<T0, T1, T3, T2>(arg0, arg1, 13, 0x2::object::id_to_address(&v7), arg2, arg5, &v6);
        v6
    }

    fun record_output<T0, T1, T2, T3>(arg0: &mut 0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::Session<T0, T1>, arg1: u64, arg2: u8, arg3: address, arg4: u64, arg5: &0x2::coin::Coin<T3>) {
        0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::record_leg<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::value<T3>(arg5));
    }

    fun refund_and_record<T0, T1, T2, T3>(arg0: &mut 0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::Session<T0, T1>, arg1: u64, arg2: u8, arg3: address, arg4: u64, arg5: 0x2::coin::Coin<T2>, arg6: &0x2::coin::Coin<T3>) {
        0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::refund_aux<T0, T1, T2>(arg0, arg5);
        record_output<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg6);
    }

    public fun turbos_swap_a_to_b<T0, T1, T2, T3, T4>(arg0: &mut 0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::Session<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: 0x2::coin::Coin<T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T2>>();
        0x1::vector::push_back<0x2::coin::Coin<T2>>(&mut v0, arg5);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T2, T3, T4>(arg3, v0, arg2, 0, 4295048017, true, 0x2::tx_context::sender(arg7), 18446744073709551615, arg6, arg4, arg7);
        let v3 = v1;
        let v4 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>>(arg3);
        refund_and_record<T0, T1, T2, T3>(arg0, arg1, 7, 0x2::object::id_to_address(&v4), arg2, v2, &v3);
        v3
    }

    public fun turbos_swap_b_to_a<T0, T1, T2, T3, T4>(arg0: &mut 0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::Session<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: 0x2::coin::Coin<T3>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T3>>();
        0x1::vector::push_back<0x2::coin::Coin<T3>>(&mut v0, arg5);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T2, T3, T4>(arg3, v0, arg2, 0, 79226673515401279992447579050, true, 0x2::tx_context::sender(arg7), 18446744073709551615, arg6, arg4, arg7);
        let v3 = v1;
        let v4 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>>(arg3);
        refund_and_record<T0, T1, T3, T2>(arg0, arg1, 7, 0x2::object::id_to_address(&v4), arg2, v2, &v3);
        v3
    }

    // decompiled from Move bytecode v6
}

