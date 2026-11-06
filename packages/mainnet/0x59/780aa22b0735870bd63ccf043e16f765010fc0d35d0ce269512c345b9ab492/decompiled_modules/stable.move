module 0x59780aa22b0735870bd63ccf043e16f765010fc0d35d0ce269512c345b9ab492::stable {
    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg2: 0x2::balance::Balance<T1>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        let v0 = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::borrow_pool<T1, T2, 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::Stable>(arg1);
        let v1 = 0x2::object::id<0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::LiquidityPool<T1, T2, 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::Stable>>(v0);
        let (v2, v3) = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::swap<T1, T2, 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::Stable>(arg1, 0x2::coin::from_balance<T1>(arg2, arg3), 0, 0x2::coin::zero<T2>(arg3), 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::router::get_amount_out<T1, T2, 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::Stable>(v0, 0x2::balance::value<T1>(&arg2), false), arg3);
        let v4 = v3;
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, v1, true, 0x2::coin::value<T2>(&v4));
        (0x2::coin::into_balance<T2>(v4), 0x2::coin::into_balance<T1>(v2))
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg2: 0x2::balance::Balance<T2>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let v0 = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::borrow_pool<T1, T2, 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::Stable>(arg1);
        let v1 = 0x2::object::id<0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::LiquidityPool<T1, T2, 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::Stable>>(v0);
        let (v2, v3) = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::swap<T1, T2, 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::Stable>(arg1, 0x2::coin::zero<T1>(arg3), 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::router::get_amount_out<T1, T2, 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::Stable>(v0, 0x2::balance::value<T2>(&arg2), true), 0x2::coin::from_balance<T2>(arg2, arg3), 0, arg3);
        let v4 = v2;
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, v1, false, 0x2::coin::value<T1>(&v4));
        (0x2::coin::into_balance<T1>(v4), 0x2::coin::into_balance<T2>(v3))
    }

    // decompiled from Move bytecode v7
}

