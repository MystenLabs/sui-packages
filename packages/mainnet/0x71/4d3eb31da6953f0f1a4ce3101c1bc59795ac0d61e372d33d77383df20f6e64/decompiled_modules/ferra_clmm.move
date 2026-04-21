module 0x714d3eb31da6953f0f1a4ce3101c1bc59795ac0d61e372d33d77383df20f6e64::ferra_clmm {
    fun destroy_or_transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T0>(arg0, arg1);
        if (0x2::coin::value<T0>(&v0) == 0) {
            0x2::coin::destroy_zero<T0>(v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun swap_a2b<T0, T1>(arg0: &0x91dd844df4f20026f6c6a4c44d0c87a960316e2e3f8c8a0e55e1532a05a86ab2::router::HopReceipt, arg1: 0x2::coin::Coin<T0>, arg2: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::config::GlobalConfig, arg3: &mut 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::flash_swap<T0, T1>(arg2, arg3, true, true, 0x2::coin::value<T0>(&arg1), 4295048017, arg4);
        let v3 = v2;
        let v4 = v0;
        let v5 = 0x2::coin::into_balance<T0>(arg1);
        0x2::balance::join<T0>(&mut v4, 0x2::balance::split<T0>(&mut v5, 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::swap_pay_amount<T0, T1>(&v3)));
        destroy_or_transfer_balance<T0>(v5, arg5);
        0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::repay_flash_swap<T0, T1>(arg2, arg3, v4, 0x2::balance::zero<T1>(), v3);
        0x2::coin::from_balance<T1>(v1, arg5)
    }

    public fun swap_b2a<T0, T1>(arg0: &0x91dd844df4f20026f6c6a4c44d0c87a960316e2e3f8c8a0e55e1532a05a86ab2::router::HopReceipt, arg1: 0x2::coin::Coin<T1>, arg2: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::config::GlobalConfig, arg3: &mut 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::flash_swap<T0, T1>(arg2, arg3, false, true, 0x2::coin::value<T1>(&arg1), 79226673515401279992447579055, arg4);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::coin::into_balance<T1>(arg1);
        0x2::balance::join<T1>(&mut v4, 0x2::balance::split<T1>(&mut v5, 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::swap_pay_amount<T0, T1>(&v3)));
        destroy_or_transfer_balance<T1>(v5, arg5);
        0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::balance::zero<T0>(), v4, v3);
        0x2::coin::from_balance<T0>(v0, arg5)
    }

    // decompiled from Move bytecode v7
}

