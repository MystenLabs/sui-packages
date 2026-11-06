module 0xed86e532ca4eb5344013d8ad89b3ecf6b1027f455dd81f20e1d9360fa7b98d22::ferra_clmm {
    public fun flash_a2b<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg2: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::config::GlobalConfig, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T1>, 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::FlashSwapReceipt<T0, T1>) {
        let v0 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::open_loan<T0>(arg0);
        let (v1, v2, v3) = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::flash_swap<T0, T1>(arg2, arg1, true, true, v0, 4295048016, arg3);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        assert!(0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::swap_pay_amount<T0, T1>(&v4) == v0, 2);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>>(arg1), true, 0x2::balance::value<T1>(&v5));
        (v5, v4)
    }

    public fun flash_a2b_limit<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg2: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: u128, arg5: bool) : (0x2::balance::Balance<T1>, 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::FlashSwapReceipt<T0, T1>) {
        assert!(arg5, 2);
        let v0 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::open_loan<T0>(arg0);
        let (v1, v2, v3) = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::flash_swap<T0, T1>(arg2, arg1, true, true, v0, arg4, arg3);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        assert!(0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::swap_pay_amount<T0, T1>(&v4) == v0, 2);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>>(arg1), true, 0x2::balance::value<T1>(&v5));
        (v5, v4)
    }

    public fun flash_b2a<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T1>, arg1: &mut 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg2: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::config::GlobalConfig, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::FlashSwapReceipt<T0, T1>) {
        let v0 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::open_loan<T1>(arg0);
        let (v1, v2, v3) = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::flash_swap<T0, T1>(arg2, arg1, false, true, v0, 79226673515401279992447579055, arg3);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T1>(v2);
        assert!(0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::swap_pay_amount<T0, T1>(&v4) == v0, 2);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T1>(arg0, 0x2::object::id<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>>(arg1), false, 0x2::balance::value<T0>(&v5));
        (v5, v4)
    }

    public fun flash_b2a_limit<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T1>, arg1: &mut 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg2: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: u128, arg5: bool) : (0x2::balance::Balance<T0>, 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::FlashSwapReceipt<T0, T1>) {
        assert!(arg5, 2);
        let v0 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::open_loan<T1>(arg0);
        let (v1, v2, v3) = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::flash_swap<T0, T1>(arg2, arg1, false, true, v0, arg4, arg3);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T1>(v2);
        assert!(0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::swap_pay_amount<T0, T1>(&v4) == v0, 2);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T1>(arg0, 0x2::object::id<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>>(arg1), false, 0x2::balance::value<T0>(&v5));
        (v5, v4)
    }

    public fun repay_a2b<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg2: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::config::GlobalConfig, arg3: 0x2::balance::Balance<T0>, arg4: 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::FlashSwapReceipt<T0, T1>) : 0x2::balance::Balance<T0> {
        0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::repay_flash_swap<T0, T1>(arg2, arg1, 0x2::balance::split<T0>(&mut arg3, 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::close_loan<T0>(arg0, &mut arg3)), 0x2::balance::zero<T1>(), arg4);
        arg3
    }

    public fun repay_b2a<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T1>, arg1: &mut 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg2: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::config::GlobalConfig, arg3: 0x2::balance::Balance<T1>, arg4: 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::FlashSwapReceipt<T0, T1>) : 0x2::balance::Balance<T1> {
        0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::repay_flash_swap<T0, T1>(arg2, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::close_loan<T1>(arg0, &mut arg3)), arg4);
        arg3
    }

    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T1, T2>, arg2: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<T1>) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg4);
        assert!(v0 > 0, 1);
        let (v1, v2, v3) = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::flash_swap<T1, T2>(arg2, arg1, true, true, v0, 4295048016, arg3);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::repay_flash_swap<T1, T2>(arg2, arg1, 0x2::balance::split<T1>(&mut arg4, 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::swap_pay_amount<T1, T2>(&v4)), 0x2::balance::zero<T2>(), v4);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T1, T2>>(arg1), true, 0x2::balance::value<T2>(&v5));
        (v5, arg4)
    }

    public fun swap_a2b_limit<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T1, T2>, arg2: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<T1>, arg5: u128, arg6: bool) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        assert!(arg6, 2);
        let v0 = 0x2::balance::value<T1>(&arg4);
        assert!(v0 > 0, 1);
        let (v1, v2, v3) = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::flash_swap<T1, T2>(arg2, arg1, true, true, v0, arg5, arg3);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let v6 = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::swap_pay_amount<T1, T2>(&v4);
        assert!(v6 == v0, 2);
        0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::repay_flash_swap<T1, T2>(arg2, arg1, 0x2::balance::split<T1>(&mut arg4, v6), 0x2::balance::zero<T2>(), v4);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T1, T2>>(arg1), true, 0x2::balance::value<T2>(&v5));
        (v5, arg4)
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T1, T2>, arg2: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<T2>) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let v0 = 0x2::balance::value<T2>(&arg4);
        assert!(v0 > 0, 1);
        let (v1, v2, v3) = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::flash_swap<T1, T2>(arg2, arg1, false, true, v0, 79226673515401279992447579055, arg3);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T2>(v2);
        0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::repay_flash_swap<T1, T2>(arg2, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut arg4, 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::swap_pay_amount<T1, T2>(&v4)), v4);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T1, T2>>(arg1), false, 0x2::balance::value<T1>(&v5));
        (v5, arg4)
    }

    public fun swap_b2a_limit<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T1, T2>, arg2: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<T2>, arg5: u128, arg6: bool) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        assert!(arg6, 2);
        let v0 = 0x2::balance::value<T2>(&arg4);
        assert!(v0 > 0, 1);
        let (v1, v2, v3) = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::flash_swap<T1, T2>(arg2, arg1, false, true, v0, arg5, arg3);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T2>(v2);
        let v6 = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::swap_pay_amount<T1, T2>(&v4);
        assert!(v6 == v0, 2);
        0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::repay_flash_swap<T1, T2>(arg2, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut arg4, v6), v4);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T1, T2>>(arg1), false, 0x2::balance::value<T1>(&v5));
        (v5, arg4)
    }

    // decompiled from Move bytecode v7
}

