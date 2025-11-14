module 0xd3facfe140fc40d4d170aae42c12b1d8d014df094f84301c5bbe6b513bb4577::momentum {
    public fun swap_a2b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, true, true, 0x2::coin::value<T0>(&arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price(), arg4, arg3, arg5);
        let v3 = v1;
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v2, 0x2::coin::into_balance<T0>(arg0), 0x2::balance::zero<T1>(), arg3, arg5);
        assert!(0x2::balance::value<T1>(&v3) >= arg1, 2);
        0xd3facfe140fc40d4d170aae42c12b1d8d014df094f84301c5bbe6b513bb4577::bbag::transfer_or_destroy_balance<T0>(v0, arg5);
        0x2::coin::from_balance<T1>(v3, arg5)
    }

    public fun swap_b2a<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: u64, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, false, true, 0x2::coin::value<T1>(&arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price(), arg4, arg3, arg5);
        let v3 = v0;
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg0), arg3, arg5);
        assert!(0x2::balance::value<T0>(&v3) >= arg1, 2);
        0xd3facfe140fc40d4d170aae42c12b1d8d014df094f84301c5bbe6b513bb4577::bbag::transfer_or_destroy_balance<T1>(v1, arg5);
        0x2::coin::from_balance<T0>(v3, arg5)
    }

    // decompiled from Move bytecode v6
}

